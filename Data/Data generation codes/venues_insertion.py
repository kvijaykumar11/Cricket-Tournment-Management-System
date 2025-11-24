# 03_venues.py
from faker import Faker
import random
fake = Faker(); Faker.seed(42); random.seed(42)
OUT="venues_inserts.sql"
NUM=50
rows=[]
for i in range(1,NUM+1):
    city = fake.city()
    rows.append((i, f"{city} Stadium"[:100], city[:50], fake.country()[:50], random.randint(5000,100000)))

with open(OUT,'w',encoding='utf-8') as f:
    cols="(venue_id,venue_name,city,country,capacity)"
    vals=[ "(" + ",".join("'" + str(x).replace("'","''") + "'" if isinstance(x,str) else str(x) for x in r) + ")" for r in rows ]
    f.write(f"INSERT INTO Venues {cols} VALUES\n")
    f.write(",\n".join(vals)+";\n\n")
print("Wrote", OUT)
