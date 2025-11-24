# 09_sponsors.py

from faker import Faker
import random
fake = Faker(); Faker.seed(42); random.seed(42)
OUT="sponsors_inserts.sql"
NUM=200
rows=[]
for i in range(1,NUM+1):
    name = fake.company()[:100]
    amount = round(random.uniform(1000.0, 2_000_000.0),2)
    tournament_id = random.randint(1,10)
    rows.append((i, name, amount, tournament_id))

with open(OUT,'w',encoding='utf-8') as f:
    cols="(sponsor_id,sponsor_name,amount,tournament_id)"
    batch=100
    for s in range(0,len(rows),batch):
        chunk=rows[s:s+batch]
        vals=[ "(" + ",".join("'" + str(x).replace("'","''") + "'" if isinstance(x,str) else (str(x) if x is not None else "NULL") for x in r) + ")" for r in chunk ]
        f.write(f"INSERT INTO Sponsors {cols} VALUES\n")
        f.write(",\n".join(vals)+";\n\n")
print("Wrote", OUT)
