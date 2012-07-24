#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
from optparse import OptionParser
from urllib import urlopen, urlencode

parser = OptionParser()

parser.add_option("-u", "--username", dest="username", default="MeaCulpa")
parser.add_option("-f", "--format", dest="format", default="text", help="defines data format e.g, php")
parser.add_option("-e", "--expiry", dest="expiry", default="d", help="valid options are d, m, f (day, month, forever)")

(options, args) = parser.parse_args()

PASTEBIN_URL = 'http://pastebin.mozilla.org/'

pastebin_data = {
    'code2': sys.stdin.read(),
    'expiry': options.expiry,
    'format': options.format,
    'parent_pid': '',
    'paste': 'Send',
    'poster': options.username
}

#print PASTEBIN_URL + urlencode(pastebin_data)
print urlopen(PASTEBIN_URL, urlencode(pastebin_data)).geturl()

