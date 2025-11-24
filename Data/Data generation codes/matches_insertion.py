# 06_matches.py

from faker import Faker
import random
fake = Faker(); Faker.seed(42); random.seed(42)
OUT="matches_inserts.sql"
NUM=300
tournaments = list(range(1,11))
teams = list(range(1,101))
venues = list(range(1,51))
rows=[]
match_types=['Group','Quarter','Semi','Final','Friendly']
for i in range(1,NUM+1):
    tournament_id = random.choice(tournaments)
    t_start = fake.date_between(start_date='-2y', end_date='today')
    # choose two distinct teams
    t1 = random.choice(teams)
    t2 = t1
    while t2 == t1:
        t2 = random.choice(teams)
    venue_id = random.choice(venues)
    match_date = fake.date_between(start_date=t_start, end_date=t_start.replace(year=t_start.year+1))
    winner = random.choice([None]*2 + [t1,t2])  # some nulls
    mom = ''
    if winner:
        # pick a player ID; try a few times - but since players reference team IDs we skip heavy checking
        mom = random.randint(1,2000)
    rows.append((i, tournament_id, t1, t2, venue_id, match_date.strftime('%Y-%m-%d'),
                 (winner if winner else 'NULL'), (mom if mom else 'NULL'), random.choice(match_types)))

with open(OUT,'w',encoding='utf-8') as f:
    cols="(match_id,tournament_id,team1_id,team2_id,venue_id,match_date,winner_team_id,man_of_the_match_id,match_type)"
    batch=100
    for s in range(0,len(rows),batch):
        chunk=rows[s:s+batch]
        vals=[]
        for r in chunk:
            formatted=[]
            for v in r:
                if v=='NULL':
                    formatted.append("NULL")
                elif isinstance(v,str):
                    formatted.append("'" + v.replace("'","''") + "'")
                else:
                    formatted.append(str(v))
            vals.append("("+",".join(formatted)+")")
        f.write(f"INSERT INTO Matches {cols} VALUES\n")
        f.write(",\n".join(vals)+";\n\n")
print("Wrote", OUT)
