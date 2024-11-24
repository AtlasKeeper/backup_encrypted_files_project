#!/bin/bash

# This checks if the number of arguments is correct
# If the number of arguments is incorrect ( $# != 2) print error message and exit
if [[ $# != 2 ]]
then
  echo "backup.sh target_directory_name destination_directory_name"
  exit
fi

# This checks if argument 1 and argument 2 are valid directory paths
if [[ ! -d $1 ]] || [[ ! -d $2 ]]
then
  echo "Invalid directory path provided"
  exit
fi

# [TASK 1]
targetDirectory=$1 
destinationDirectory=$2

# [TASK 2]
echo "Target directory: $targetDirectory"
echo "Destination directory: $destinationDirectory"

# [TASK 3]
currentTS=$(date +%s)

# [TASK 4]
backupFileName="backup-${currentTS}.tar.gz"

# We're going to:
  # 1: Go into the target directory
  # 2: Create the backup file
  # 3: Move the backup file to the destination directory

# To make things easier, we will define some useful variables...

# [TASK 5]
origAbsPath=$(cd "$targetDirectory" && pwd)

# [TASK 6]
cd "$destinationDirectory" || exit
destDirAbsPath=$(pwd)

# [TASK 7]
cd "$origAbsPath" || exit


# [TASK 8]
yesterdayTS=$((currentTS - 86400))

declare -a toBackup

for file in $(find "$origAbsPath" -type f) # [TASK 9]
do
  # [TASK 10]
  fileTS=$(stat -c %Y "$file")
  if (( fileTS > yesterdayTS ))
  then
    # [TASK 11]
    toBackup+=("$file")
  fi
done

# [TASK 12]
if [[ ${#toBackup[@]} -gt 0 ]]
then
  tar -czf "$destDirAbsPath/$backupFileName" "${toBackup[@]}"
  echo "Backup successful! File saved as $destDirAbsPath/$backupFileName"
else
  echo "No files modified in the last 24 hours. Backup not created."
fi

# [TASK 13]
echo "Backup script execution completed."
# Congratulations! You completed the final project for this course!
