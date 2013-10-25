#!/bin/bash

#### This file is depreciated. Please use send_speech.py

# This should change based on language.
# lang=es or something.
# Multiple results
#URL="http://www.google.com/speech-api/v1/recognize?lang=en&client=chromium&maxresults=6"

USER_DIR=$HOME/.leopold
while read line           
do           
    export "$line"           
done <$USER_DIR/UserInfo

URL="https://www.google.com/speech-api/v1/recognize?lang=$LANGUAGE&client=chromium"

if [ -z "$1" ];then
    echo ""
    exit 1
fi

wget -qO- --post-file "$1" --header 'Content-type: audio/x-flac; rate=16000' "$URL" > result.json

RESULT="$(cat result.json | sed 's/^[^[]*\[{\"utterance\":\"\([^\"]*\)\".*/\1/')"

echo "$RESULT"
