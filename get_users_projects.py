import requests
import csv
import time
import sys

token = sys.argv[1]
file_path = sys.argv[2]
headers = {"Authorization": f"Bearer {token}"}

with open("projects_42rio.csv", "w", newline="", encoding="utf-8") as csvfile:
	writer = csv.writer(csvfile)
	writer.writerow(["user_login", "project_name", "status", "final_mark", "marked_at"])

	with open(file_path, "r") as file:
		for line in file:
			login, user_id = line.strip().split(",")
			url = f"https://api.intra.42.fr/v2/users/{user_id}/projects_users?per_page=100"
			response = requests.get(url, headers=headers).json()
			print(f"Saving: {login} ({user_id})")
			time.sleep(1)
			for project in response:
				if 21 in project.get("cursus_ids", []):
					writer.writerow([login, project["project"]["name"], project["status"], project["final_mark"], project["marked_at"],])


