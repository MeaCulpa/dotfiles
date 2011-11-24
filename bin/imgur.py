#!usr/bin/python
with open(__import__("sys").stdin.read(), "r+b") as fi: content = __import__("base64").b64encode(fi.read()); 
fw = __import__("urllib2").urlopen("http://api.imgur.com/2/upload", __import__("urllib").urlencode({"key" : "aac27f6e7d01c86f407764ea3d221684", "image" : content,})); 
print (__import__("re").search("\<original\>(.*)\<\/original\>", fw.read())).group(1); fw.close();

