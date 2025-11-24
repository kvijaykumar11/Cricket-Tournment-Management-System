# 05_players.py

from faker import Faker
import random
from datetime import date, timedelta
fake = Faker(); Faker.seed(42); random.seed(42)
OUT="players_inserts.sql"
NUM=2000
roles=['Batsman','Bowler','All-rounder','Wicket-keeper']
bat_styles=['Right-hand','Left-hand']
bowl_styles=['Right-arm fast','Left-arm fast','Right-arm offbreak','Legbreak','Medium pace', None]

rows=[]
for i in range(1,NUM+1):
    dob = fake.date_of_birth(minimum_age=17, maximum_age=45)
    role = random.choice(roles)
    bowl = random.choice(bowl_styles)
    bat = random.choice(bat_styles)
    team_id = random.randint(1,100)
    rows.append((i, fake.name()[:100], dob.strftime('%Y-%m-%d'), role[:50],
                 (bowl[:50] if bowl else ''), bat[:50], team_id))

with open(OUT,'w',encoding='utf-8') as f:
    cols="(player_id,player_name,dob,role,bowling_style,batting_style,team_id)"
    batch=500
    for s in range(0,len(rows),batch):
        chunk=rows[s:s+batch]
        vals=[ "(" + ",".join("'" + str(x).replace("'","''") + "'" if isinstance(x,str) else (str(x) if x!=" " else "NULL") for x in r) + ")" for r in chunk ]
        f.write(f"INSERT INTO Players {cols} VALUES\n")
        f.write(",\n".join(vals)+";\n\n")
print("Wrote", OUT)
