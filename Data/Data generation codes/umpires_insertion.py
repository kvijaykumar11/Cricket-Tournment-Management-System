# 04_umpires.py

from faker import Faker
import random
fake = Faker(); Faker.seed(42); random.seed(42)
OUT="umpires_inserts.sql"
NUM=100
rows=[]
for i in range(1,NUM+1):
    rows.append((i, fake.name()[:100], fake.country()[:50], random.randint(0,25)))

with open(OUT,'w',encoding='utf-8') as f:
    cols="(umpire_id,umpire_name,nationality,experience_years)"
    vals=[ "(" + ",".join("'" + str(x).replace("'","''") + "'" if isinstance(x,str) else str(x) for x in r) + ")" for r in rows ]
    f.write(f"INSERT INTO Umpires {cols} VALUES\n")
    f.write(",\n".join(vals)+";\n\n")
print("Wrote", OUT)
