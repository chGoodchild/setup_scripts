#! /bin/bash

# This is not a setup script.

# This script renames files of the form ddmmyyyy to yyyymmdd so that
# they can be displayed in accending or decending order according to
# their date/file name...

for file in *.mp4; do

    days=${file:0:2}
    echo "part 1 = " $days

    months=${file:2:2}
    echo "part 2 = " $months

    years=${file:4:4}    
    echo "part 3 = " $years


    newName=$years$months$days
    echo "Output: " $newName

    mv "$file" ${file/${file:0:8}/$newName}


done
