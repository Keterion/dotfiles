#!/bin/bash

ingore=$(cat .gitignore | grep -oP "(?<=!)[^/]+") # gets all the whitelisted things in .gitignore
index=0
possible=()
for f in *; do # all files in .config
  if ! [[ $ingore =~ $f ]]; then # if it isn't whitelisted already
    echo $index:$f;
    ((index++));
    possible+=( "$f" );
  fi
done

indicies="USER INPUT"
read -p "Select indicies to whitelist: " indicies
for i in $indicies; do # appends the files/directories to .gitignore
  echo adding ${possible[$i]} to .gitignore
  if [[ -d ${possible[$i]} ]]; then
    echo "!/${possible[$i]}/" >> .gitignore
  else
    echo "!${possible[$i]}" >> .gitignore
  fi
done
