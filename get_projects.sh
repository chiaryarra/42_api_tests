#!/bin/bash

TOKEN=$1

echo "Getting projects of all common core users from 42rio:"
echo

campus_users=$(bash get_campus_users.sh "$TOKEN")
bash get_users_at_common_core.sh "$TOKEN" "$campus_users" > common_core_users.txt
python3 get_users_projects.py "$TOKEN" common_core_users.txt

echo
echo "Finished!"
