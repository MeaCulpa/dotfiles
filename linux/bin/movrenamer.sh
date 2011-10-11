#!/bin/sh
ls -1 | sed "s/.*\(S[0-9][0-9]E[0-9][0-9]\).*/& $1_\1.mkv/g" | xargs -n 2 mv

