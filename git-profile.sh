#!/bin/bash

while IFS='' read -r line || [[ -n "$line" ]]; do
    #echo "Text read from file: $line"
    profile=$(echo $line | tr ";" "\n")
    nickname=$(echo "$profile" | head -1)
    if [ "$nickname" == "$1" ]
    then
      fullname=$(echo "$profile" | head -2 | tail -1)
      email=$(echo "$profile" | tail -1)
      echo "I'm $fullname, but I like to be called $nickname. Send me and email to: $email"
      git config --local user.name "$fullname"
      git config --local user.email "$email"
      echo "Your git is ready to commit!"
      break
    fi
done < "profiles.lst"
