#!/bin/bash

fileprofiles="profiles.lst"
if [ ! -f $fileprofiles ]; then
    fileprofiles="$HOME/profiles.lst"
    if [[ ! -e "$fileprofiles" ]]
    then
    echo "File $fileprofiles not found!"
    
    $DEFAULT_PROFILE_NICKNAME="Jorge"
    echo "Add user nickname: [ $DEFAULT_PROFILE_NICKNAME ]"
    read PROFILE_NICKNAME
    if [ "$PROFILE_NICKNAME" = "" ]
    then
    PROFILE_NICKNAME="$DEFAULT_PROFILE_NICKNAME"
    fi
    
    $DEFAULT_PROFILE_FULLNAME="Jorge Ulises Useche Cuellar"
    echo "Add user fullname: [ $DEFAULT_PROFILE_FULLNAME ]"
    read PROFILE_FULLNAME
    if [ "$PROFILE_FULLNAME" = "" ]
    then
    PROFILE_FULLNAME="$DEFAULT_PROFILE_FULLNAME"
    fi
    
    $DEFAULT_PROFILE_EMAIL="naturalmentejorge@gmail.com"
    echo "Add user git email: [ $DEFAULT_PROFILE_EMAIL ]"
    read PROFILE_EMAIL
    if [ "$PROFILE_EMAIL" = "" ]
    then
    PROFILE_EMAIL="$DEFAULT_PROFILE_EMAIL"
    fi
    
    tee "$file" << EOF
# put dot comma separated values @see https://github.com/juusechec/git-profile/blob/master/profiles.lst
$PROFILE_NICKNAME;$PROFILE_FULLNAME;$PROFILE_EMAIL
EOF
    echo "Modificated $fileprofiles."
    fi
fi

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
done < "$fileprofiles"
