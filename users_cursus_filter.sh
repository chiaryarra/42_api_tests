#! /bin/bash

TOKEN=$1
CAMPUS_USERS="campus_users.txt"

echo "Collecting users that are from cursus 21 (42 cursus)..."
echo 
while read login div user_id; do
	# Making a GET request on all the user cursus
	response=$(curl -s -H "Authorization: Bearer $TOKEN" "https://api.intra.42.fr/v2/users/$user_id/cursus_users")

	is_cursus_21=$(echo "$response" | jq 'any(.cursus_id == 21)')
	sleep 1
	if [ "$is_cursus_21" = "true" ]; then
		echo "$login $div $user_id" >> "campus_and_cursus_users.txt"
	fi

done < "$CAMPUS_USERS"

echo
echo "Finished!"
