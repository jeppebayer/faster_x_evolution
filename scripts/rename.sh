#!/bin/bash

names=/faststorage/project/EcoGenetics/people/Jeppe_Bayer/X_evolution/names.txt
path=/faststorage/project/EcoGenetics/people/Jeppe_Bayer/X_evolution/steps/02_data_preparation

for dir in "$path"/*/*/*; do
    if [ -d "$dir" ]; then
        familynum=$(basename "$(dirname "$dir")")
        samplename=$(basename "$dir")
        newname=$(awk -v samplename="$samplename" -v familynum="$familynum" '$1 == familynum && $2 == samplename {print $3}' "$names")
        if [ -z "$newname" ]; then
            continue
        fi
        mv "$dir" "$(dirname "$dir")"/"$newname"
        for file in $dir; do
            if [[ "$file" == *.bam ]]; then
                filename=$(basename "$file")
                filenamepart=${filename#*"$samplename"_}
                mv "$file" "$(dirname "$file")"/"$newname"_"$filenamepart"
            fi
            if [ -d "$file" ] && [[ ! "$file" == */out ]]; then
                for subfile in "$file"/*; do
                    subfilename=$(basename "$subfile")
                    subfilenamepart=${subfilename#*"$samplename"_}
                    mv "$subfile" "$(dirname "$subfile")"/"$newname"_"$subfilenamepart"
                done
            fi
        done
    fi
done

exit 0