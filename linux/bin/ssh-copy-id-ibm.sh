#!/bin/sh
# Append ssh pub key to IBM restricted shells, like hmc and vios
# Suppose entry exist on .ssh/config
scp $1:.ssh/authorized_keys2 ~/.ssh/tmp_key_$1
cat ~/.ssh/id_rsa.pub >> ~/.ssh/tmp_key_$1
scp ~/.ssh/tmp_key_$1 $1:.ssh/authorized_keys2

