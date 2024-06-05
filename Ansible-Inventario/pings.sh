#!/bin/bash
PING="$(which ping)"
for servers in `cat ping.txt`;
do
$PING -c 5 $servers
done
