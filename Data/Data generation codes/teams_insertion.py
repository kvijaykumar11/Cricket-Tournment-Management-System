# 02_teams.py

from faker import Faker
import random
fake = Faker(); Faker.seed(42); random.seed(42)
OUT = "teams_inserts.sql"
NUM = 100
rows=[]
for i in range(1, NUM+1):
    country = fake.country()
    team_name = f"{country} {fake.color_name()}s"
    coach = fake.name()
    ranking = random.randint(1,200)
    rows.append((i, team_name[:100], country[:50], coach[:100], ranking))

with open(OUT,'w',encoding='utf-8') as f:
    cols="(team_id,team_name,country,coach_name,ranking)"
    for i in range(0,len(rows),1000):
        chunk=rows[i:i+1000]
        vals=[ "(" + ",".join("'" + str(x).replace("'","''") + "'" if isinstance(x,str) else str(x) for x in r) + ")" for r in chunk ]
        f.write(f"INSERT INTO Teams {cols} VALUES\n")
        f.write(",\n".join(vals)+";\n\n")
print("Wrote", OUT)
