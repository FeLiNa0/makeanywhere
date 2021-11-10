#!/bin/sh
if ! [ -f "$1/makeanywhere" ]; then
  echo Command makeanywhere not found in directory "$1"
  exit 1
fi

if ! command -v makeanywhere > /dev/null; then
    echo Command makeanywhere not found
    echo Check to make sure makeanywhere is in your PATH "$1"
    exit 1
fi

if ! makeanywhere -h; then
    echo Command makeanywhere found, but failed to run
    exit 1
fi

echo Succesfully installed!
