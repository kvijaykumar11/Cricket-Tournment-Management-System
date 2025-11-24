# 10_scorecard.py

import random
OUT="scorecard_inserts.sql"
rows=[]
sc_id=0
for m in range(1,301):
    # produce 1 or 2 innings (mostly 2)
    innings = 2 if random.random() < 0.95 else 1
    # batting teams alternate: for simplicity pick team ids randomly (1..100)
    for inn in range(1, innings+1):
        sc_id += 1
        batting_team = random.randint(1,100)
        total_runs = random.randint(50,400)
        wickets = random.randint(0,10)
        overs = round(random.uniform(1.0,50.0),1)
        rows.append((sc_id, m, batting_team, inn, total_runs, wickets, overs))

with open(OUT,'w',encoding='utf-8') as f:
    cols="(scorecard_id,match_id,batting_team_id,innings_no,total_runs,wickets,overs)"
    for s in range(0,len(rows),500):
        chunk=rows[s:s+500]
        vals=[ "(" + ",".join("'" + str(x).replace("'","''") + "'" if isinstance(x,str) else str(x) for x in r) + ")" for r in chunk ]
        f.write(f"INSERT INTO Scorecard {cols} VALUES\n")
        f.write(",\n".join(vals)+";\n\n")
print("Wrote", OUT)
