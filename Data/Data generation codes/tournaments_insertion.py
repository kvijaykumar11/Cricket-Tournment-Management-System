# 01_tournaments.py

from faker import Faker
import random, os
Faker.seed(42); random.seed(42)
fake = Faker()

OUT = "tournaments_inserts.sql"
NUM = 10

rows = []
for i in range(1, NUM+1):
    start = fake.date_between(start_date='-2y', end_date='today')
    end = fake.date_between(start_date=start, end_date=start.replace(year=start.year+1))
    tname = f"{fake.city()} Cup {2025 - (i % 3)}"
    fmt = random.choice(['ODI','T20','Test'])
    host = fake.country()
    rows.append((i, tname, fmt, start.strftime('%Y-%m-%d'), end.strftime('%Y-%m-%d'), host))

# write batched INSERTs
with open(OUT, 'w', encoding='utf-8') as f:
    batch=50
    cols = "(tournament_id,tournament_name,format,start_date,end_date,host_country)"
    for s in range(0, len(rows), batch):
        chunk = rows[s:s+batch]
        vals = []
        for r in chunk:
            vals.append("("+ ",".join("'" + str(x).replace("'", "''") + "'" if isinstance(x,str) else (str(x) if x!="" else "NULL") for x in r) +")")
        f.write(f"INSERT INTO Tournament {cols} VALUES\n")
        f.write(",\n".join(vals)+";\n\n")
print("Wrote", OUT)
