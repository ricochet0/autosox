#!/bin/bash

# handle filenames with spaces appropriately
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

# count scans
scan_count=0

# name of output directory, you can put a different path here :)
out_dir="spectrograms"

# only care about these types
filetype_patterns="+(*.flac|*.mp3|*.wav|*.ape)"

traverse() {

    local -r path=$1
    echo "==> $(basename  $path)"
    mkdir -p $out_dir/$path

    for entry in $(ls $path); do

        # exclude irrelevant patterns and files already sox-ed
        if [[ $path/$entry == $filetype_patterns ]] && [[ ! -f "$out_dir/$path/$entry.jpg" ]]; then
            # sox it and compress the image
            sox "$path/$entry" -n spectrogram -o "$out_dir/$path/$entry.png"
            ((scan_count++))
            mogrify -strip -quality 80% -sampling-factor 4:4:4 -format jpg "$out_dir/$path/$entry.png"
            rm -f "$out_dir/$path/$entry.png"
        fi

        if [ -d "$path/$entry" ]; then
            traverse "$path"/"$entry" # recursive call on subdir
        fi
    done

}

if [ $# != 1 ]; then
    echo "Need one arg :)"
else
    mkdir -p $out_dir
    traverse $(echo "$1" | sed 's:/*$::') # strip trailing backslashes
    echo -e "\nYou have $scan_count new spectrograms to look at :-)"
fi

IFS=$SAVEIFS
