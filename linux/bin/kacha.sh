#!/bin/sh
# take a screenshot with scrot
#usage: kacha
scrot '%Y-%m-%d_%s_scrot.jpg' -e 'mv $f ~/pic/' -d 5 -q 100 -m
ls -lh ~/pic/
