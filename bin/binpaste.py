#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
from optparse import OptionParser
from urllib import urlopen, urlencode
from chardet import detect

utf8string = lambda str: unicode(str, detect(str)["encoding"]).encode("utf-8")

parser = OptionParser()

parser.add_option("-u", "--username", dest="username", default="")
parser.add_option("-p", "--password", dest="password", default="")
parser.add_option("-v", "--private", dest="private", default="0", help="default:0. Options: 0=public 1=private")
parser.add_option("-n", "--name", dest="name", default="", help="name of your paste")
parser.add_option("-o", "--option", dest="option", default="paste", help="Default: paste. Options: paste, list, delete, userdetails")
parser.add_option("-f", "--format", dest="format", default="text", help="Default: text. Defines syntax highlight, see http://pastebin.com/api")
parser.add_option("-e", "--expiry", dest="expiry", default="1D", help="default: 1 day. Options: N, 10M, 1H, 1D, 1M (Never, 10 Minutes, 1 Hour, 1 Day, 1 Month)")
parser.add_option("-k", "--devkey", dest="devkey", default="", help="your api_developer_key")

(options, args) = parser.parse_args()

API_USER_KEY = "" # if invalid, paste will be posted as guest
PASTEBIN_URL_POST = "http://pastebin.com/api/api_post.php"
PASTEBIN_URL_LOGIN = "http://pastebin.com/api/api_login.php"
PASTEBIN_URL_RAW = "http://pastebin.com/raw.php?i="


# Get user key
login_data = {
    "api_dev_key": options.devkey,
    "api_user_name": options.username,
    "api_user_password": options.password
}

f = urlopen(PASTEBIN_URL_LOGIN, urlencode(login_data))
API_USER_KEY = f.read()
f.close()

# Post data from sys.stdin.read()
paste_data = {
    "api_option": options.option,
    "api_user_key": API_USER_KEY,
    "api_paste_private": options.private,
    "api_paste_name": options.name,
    "api_paste_expire_date": options.expiry,
    "api_paste_format": options.format,
    "api_dev_key": options.devkey,
    "api_paste_code": utf8string(sys.stdin.read())
}

f = urlopen(PASTEBIN_URL_POST, urlencode(paste_data))
print f.read()
f.close()


