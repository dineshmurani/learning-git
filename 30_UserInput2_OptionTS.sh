#!/bin/bash

# user input with -p option to display helpful message
# -s option silent mode and used for password data.
# Type your login information

read -p 'Username: ' user
read -sp 'Password: ' pass

if (( $user == "admin" && $pass == "12345" ))
then
    echo -e "\nSuccessful login"
else
    echo -e "\nUnsuccessful login"
fi
