#!/usr/bin/python
#
# Python ffmpeg frontend for iPod-compatible video ripping
# By John Dong <jdong@ubuntu.com>
# Licensed under the GPL
#
import sys
import os
from optparse import OptionParser
import time

class VideoInfo:
   def __init__(self,w=640,h=480):
      self.w=w
      self.h=h
   def scale(self,max_width,max_height):
      if self.w > max_width:
         r=float(max_width)/self.w
         self.w=max_width
         self.h=int(self.h * r)
      if self.h > max_height:
         r=float(max_height)/self.h
         self.h=max_height
         self.w=int(self.w * r)
      if self.w % 2: self.w -= 1
      if self.h % 2: self.h -= 1
   def __repr__(self):
      return "<VideoInfo: %sx%s>"%(self.w, self.h)
class UnsupportedCodecError: pass
class AVEncoder:
   def __init__(self,input_file,output_file, maps=None):
      self.vcodec="h264"
      self.acodec="aac"
      self.twopass=True
      self.vbitrate=200
      self.abitrate=96
      self.resolution=parseVideoInfo(input_file,maps)
      self.threads=1
      self.input_file=input_file
      self.output_file=output_file
      self.maps=maps
   def doscale(self,to_low):
      if to_low:
         self.resolution.scale(320,240)
      else:
         self.resolution.scale(640,480)
   def getvParams(self):
      if self.vcodec == 'h264':
         return "-v 1 -vcodec h264 -b %sk -bt 175k -refs 2 -loop 1 -deblockalpha 0 -deblockbeta 0 -parti4x4 1 -partp8x8 1 -partb8x8 1 -brdo 1 -me_range 21 -chroma 1 -bf 0 -level 30 -g 300 -keyint_min 30 -sc_threshold 40 -rc_eq 'blurCplx^(1-qComp)' -qcomp 0.7 -qmax 51 -qdiff 4 -i_qfactor 0.71428572 -b_qfactor 0.76923078 -maxrate 1500k -bufsize 244k -cmp 1 -s %sx%s" % (self.vbitrate, self.resolution.w, self.resolution.h)
      elif self.vcodec == 'xvid':
         return "-vcodec xvid -maxrate 2500k -b %sk -qmin 3 -qmax 5 -bufsize 4096k -g 300 -s %sx%s" % (self.vbitrate, self.resolution.w, self.resolution.h)
      elif self.vcodec == 'mpeg4':
         return "-vcodec mpeg4 -maxrate 2500k -b %sk -qmin 3 -qmax 5 -bufsize 4096k -g 300 -s %sx%s" % (self.vbitrate, self.resolution.w, self.resolution.h)
      else:
         raise UnsupportedCodecError, "Unsupported video codec "+self.vcodec
   def getaParams(self):
      if self.acodec == "aac":
         return "-acodec aac -ab %sk -ar 48000 -ac 2" % self.abitrate
      else:
         raise UnsupportedCodecError, "Unsupported audio codec "+self.acodec
   def getCommands(self):
      def getmaps(self,video_only=False):
         m=self.maps
         if not m:
            m=[0,1]
         if video_only:
            return " -map 0.%s " % m[0]
         else:
            return reduce(str.__add__,[" -map 0.%s " % i for i in m])
      cmds=[]
      if self.twopass:
         cmds= ['ffmpeg -y -i "%s" -f mp4 -pass 1 -subq 1 -threads %s -an %s %s /dev/null' % (self.input_file, self.threads, self.getvParams(), getmaps(self,True)),
               'ffmpeg -y -i "%s" -f mp4 -pass 2 -subq 6 -threads %s %s %s %s "%s"' % (self.input_file, self.threads, self.getvParams(), self.getaParams(), getmaps(self), ".tmp.mp4"),
               'rm -f ffmpeg2pass-0.log x264_2pass.log']
      else:
         cmds= ['ffmpeg -y -i "%s" -f mp4 -threads %s -subq 6 %s %s %s "%s"' % (self.input_file, self.threads, self.getvParams(), self.getaParams(), getmaps(self), ".tmp.mp4")]
      cmds+=['rm -f .tmp.new.mp4', 
            'MP4Box -add .tmp.mp4 .tmp.new.m4v',
            'mv .tmp.new.m4v "%s"' % self.output_file,
            'rm -f .tmp.mp4', 'rm -f .tmp.new.m4v']
      return cmds
def parseVideoInfo(input_file, want_maps=None):
   def trunc_numeral(expr):
      if expr.isdigit(): return expr
      for index in range(len(expr)):
         if not expr[index].isdigit():
            if index == 0:
               break
            else:
               return expr[:index]
      raise ValueError, "Could not determine stream number from: %s" % expr
   output=os.popen('ffmpeg -i "%s" 2>&1' % input_file).readlines()
   vstreams={}
   astreams={}
   for line in output:
      if line.strip().startswith("Stream"):
         streamno=int(trunc_numeral(line.split()[1][:-1].split('.')[-1])) #Gets the stream number, i.e. Stream #0.X
         if line.split(':')[1].strip() == "Video": #Video stream --parse out VideoInfo
            try:
               (w,h)=[int(i) for i in line.split(',')[2].split("x")]
               vstreams[streamno]= VideoInfo(w,h)
            except ValueError: pass
            except IndexError: pass
         else:
            #Audio Stream, just split out string descriptor of audio
            astreams[streamno]= line.split(':')[2].strip()
   if not vstreams or not astreams:
      print "Could not find at least one video and one audio stream"
      print "Sorry, I do not support this kind of file."
      raise UnknownCodecError
   if want_maps:
      try:
         astreams[want_maps[1]] # Just try to access to see if it's a valid stream
         return vstreams[want_maps[0]]
      except KeyError:
         raise "Unable to find wanted video/audio stream. Sure your --maps arguments exist, and/or your video file is valid?"
   else:
      if len(vstreams) > 1 or len(astreams) > 1:
         print "====WARNING===="
         print "Video Streams:"
         for key in vstreams.keys():
            print "   %s:   %s" % (key, vstreams[key])
         print "Audio Streams:"
         for key in astreams.keys():
            print "   %s:   %s" % (key, astreams[key])
         print "There are multiple video or audio streams (LISTED ABOVE) in your source file."
         print "This could be because your source file has audio tracks in several languages,"
         print "Or your file is just plain weird."
         print
         print "Either way, by default this script will most likely choose the"
         print "FIRST video stream (0) and the FIRST audio stream (1)"
         print "If this is not the behavior you want, then use the -m (--map) option"
         print "to override. For example, if you want Video Stream 0 and Audio Stream 2,"
         print "you would use --map 0,2"
         print "==============="
         print "Press CTRL+C to abort... Will continue in 15 seconds..."
         time.sleep(15)
      return vstreams[0]


def numcpus():
   return int(os.popen('cat /proc/cpuinfo  | grep "^processor" | wc -l').read()[:-1])



parser=OptionParser()
parser.add_option("-i","--input", help="Source file to encode" , action="store",type="string",dest="input")
parser.add_option("--sd","--320","--standard-definition",help="Encode to Standard Definition (that is, 320xNNN, native iPod screen resolution) [DEFAULT]", action="store_true", dest="hd", default=False)
parser.add_option("--hd","--640","--high-definition",help="Encode to High Definition (that is, 640xNNN, maximum iPod-supported resolution", action="store_false", dest="hd", default=True)
parser.add_option("-c", "--codec", help="Video Codec: h264 [DEFAULT], xvid, or mpeg4.", action="store", dest="codec")
parser.add_option("-o","--output", help="Output file, with file extension.",  action="store",type="string", dest="output")
parser.add_option("-m","--map", help="Specify video and audio stream to encode. For example, --map 0,2 maps Video Stream 0 and Audio Stream 2 to the output file. This program will warn you when this is necessary to use", action="store", dest="maps")
parser.add_option("-b", "--vbitrate", help="Video Bitrate, in kbit/s. (default: 200)", action="store", dest="vbitrate", default=str("200"))
parser.add_option("-p", "--passes", help="Number of passes. (Default: 2)", action="store",dest="passes")
parser.add_option("-t", "--threads", help="Number of threads. (Default: CPUs*1.5)", action="store",dest="threads")
parser.add_option("-s","--simulate","--dry-run",help="Simulate (print out commands, but don't run)", action="store_true", dest="simulate", default=False)
parser.usage = "%prog -i input -o output [other_options]\n\
      With no other options will create 2-pass 320xNNN h.264 @ 200kbit/s"

(options, args) = parser.parse_args()
if not (options.input and options.output):
   parser.print_help()
   sys.exit(-1)
if options.maps:
   try:
      options.maps=[int(i) for i in options.maps.split(',')]
   except:
      print "Invalid -m/--maps. Should be a comma-separated list of two numbers. (i.e. --maps 0,1)"
      sys.exit(-5)
enc=AVEncoder(options.input,options.output,options.maps)
enc.doscale(options.hd)
if(options.threads):
   enc.threads=int(options.threads)
else:
   enc.threads=int(numcpus()*1.5)
enc.vbitrate=int(options.vbitrate)
if(options.passes):
   try:
      enc.twopass = (int(options.passes) == 2)
   except: pass
if options.codec:
   enc.vcodec=options.codec
for command in enc.getCommands():
   if options.simulate:
      print command
   elif os.system(command) != 0:
      print "Encode step FAILED: ",command
      sys.exit(-2)
if not options.simulate:
   print "Job finished successfully!"
   print "Output:",options.output
