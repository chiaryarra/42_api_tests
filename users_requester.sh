#!/bin/bash

# ---- Base Config ----

TOKEN=$1            # Your authorization token must be passed as parameter
CAMPUS_ID=28        # Put your campus id there
PER_PAGE=100

# ----

PAGE=1
RESULTS=1

rm -f "campus_users.txt"
echo "Collecting users from campus $CAMPUS_ID..."
echo 

while [ $RESULTS -gt 0 ]; do
	RESPONSE=$(curl -s -H "Authorization: Bearer $TOKEN" \
	"https://api.intra.42.fr/v2/campus/$CAMPUS_ID/users?per_page=$PER_PAGE&page=$PAGE")

	# Count the itens received
	RESULTS=$(echo "$RESPONSE" | jq length)

	# Break condition
	if [ "$RESULTS" -eq 0 ]; then
		break
	fi

	# Extract only the login and id
	echo "$RESPONSE" | jq -r '.[] | "\(.login),\(.id)"' >> "campus_users.txt"

	PAGE=$((PAGE + 1))
done

echo
echo "Finished!"
