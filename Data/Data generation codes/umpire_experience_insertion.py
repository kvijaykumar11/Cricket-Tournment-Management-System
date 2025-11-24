# 08_umpire_experience.py

import random
OUT="umpire_experience_inserts.sql"
rows=[]
for u in range(1,101):
    rows.append((u, random.randint(0,25)))

with open(OUT,'w',encoding='utf-8') as f:
    cols="(umpire_id,experience_years)"
    vals=[ "(" + ",".join(str(x) for x in r) + ")" for r in rows ]
    f.write(f"INSERT INTO UmpireExperience {cols} VALUES\n")
    f.write(",\n".join(vals)+";\n\n")
print("Wrote", OUT)
