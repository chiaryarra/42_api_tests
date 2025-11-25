import requests
from openpyxl import Workbook
import time
TOKEN = "f9ebac859372c7c29789ea2f7251200c016bd218b26857aa55cdb143919f93d2"
headers = {"Authorization": f"Bearer {TOKEN}"}

wb = Workbook()
ws = wb.active
ws.append(["user_login", "project_name", "status", "final_mark", "marked_at"])

with open("new_campus_42rio_users.txt") as file:
	for line in file:
		login, user_id = line.strip().split(",")
		url = f"https://api.intra.42.fr/v2/users/{user_id}/projects_users?per_page=100"
		response = requests.get(url, headers=headers).json()
		print(f"Saving: {login} ({user_id})")
		time.sleep(1)
		for project in response:
			if 21 in project.get("cursus_ids", []):
				ws.append([login, project["project"]["name"], project["status"], project["final_mark"], project["marked_at"],])

wb.save("projects_42rio.xlsx")

