# 07_match_umpires.py

import random
OUT="match_umpires_inserts.sql"
matches = list(range(1,301))
umpires = list(range(1,101))
rows=[]
roles = ['On-field','Third-umpire','TV-umpire','Reserve']
random.seed(42)
for m in matches:
    count = random.choice([2,3,3])
    chosen = random.sample(umpires, count)
    for u in chosen:
        rows.append((m, u, random.choice(roles)))

with open(OUT,'w',encoding='utf-8') as f:
    cols="(match_id,umpire_id,role)"
    for s in range(0,len(rows),500):
        chunk=rows[s:s+500]
        vals=[ "(" + ",".join(str(x) if isinstance(x,int) else "'" + x.replace("'","''") + "'" for x in r) + ")" for r in chunk ]
        f.write(f"INSERT INTO Match_Umpires {cols} VALUES\n")
        f.write(",\n".join(vals)+";\n\n")
print("Wrote", OUT)
