# 12_pointstable.py
import random
OUT="pointstable_inserts.sql"
rows=[]
random.seed(42)
for t in range(1,11):  # tournaments
    team_ids = random.sample(range(1,101), 10)
    for tid in team_ids:
        mp = random.randint(0,20)
        wins = random.randint(0, mp)
        losses = mp - wins - random.randint(0, min(2, mp-wins))
        ties = max(0, mp - wins - losses)
        pts = wins*2 + ties
        nrr = round(random.uniform(-3.0, 3.0), 2)
        rows.append((t, tid, mp, wins, losses, ties, pts, nrr))

with open(OUT,'w',encoding='utf-8') as f:
    cols="(tournament_id,team_id,matched_played,wins,losses,ties,points,net_run_rate)"
    vals=[ "(" + ",".join("'" + str(x).replace("'","''") + "'" if isinstance(x,str) else str(x) for x in r) + ")" for r in rows ]
    f.write(f"INSERT INTO PointsTable {cols} VALUES\n")
    f.write(",\n".join(vals)+";\n\n")
print("Wrote", OUT)
