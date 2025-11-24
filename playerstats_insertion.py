# 11_playerstats.py
import random
OUT="playerstats_inserts.sql"
rows=[]
target = 2000
random.seed(42)
count = 0
while count < target:
    pid = random.randint(1,2000)
    mid = random.randint(1,300)
    # generate plausible stats
    runs = random.randint(0,120) if random.random() < 0.6 else 0
    balls = max(0, int(runs * random.uniform(0.8,1.6))) if runs>0 else 0
    fours = min(runs//4, random.randint(0,12))
    sixes = min(runs//6, random.randint(0,8))
    wickets = random.randint(0,5) if random.random() < 0.3 else 0
    overs = round(random.uniform(0,10),1) if wickets>0 else 0.0
    catches = random.randint(0,2) if random.random() < 0.2 else 0
    rows.append((pid, mid, runs, balls, fours, sixes, wickets, overs, catches))
    count += 1

with open(OUT,'w',encoding='utf-8') as f:
    cols="(player_id,match_id,runs_scored,balls_faced,fours,sixes,wickets_taken,overs_bowled,catches)"
    batch=500
    for s in range(0,len(rows),batch):
        chunk=rows[s:s+batch]
        vals=[ "(" + ",".join(str(x) if not isinstance(x,str) else "'" + x.replace("'","''") + "'" for x in r) + ")" for r in chunk ]
        f.write(f"INSERT INTO PlayerStats {cols} VALUES\n")
        f.write(",\n".join(vals)+";\n\n")
print("Wrote", OUT)
