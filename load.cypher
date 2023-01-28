LOAD CSV WITH HEADERS FROM "file:///resolution_info.csv" AS row FIELDTERMINATOR '\t'
CREATE (r:Resolution {
    title: row.title, 
    resolution: row.resolution,
    note: row.note,
    vote_date: row.vote_date
    }); 
CREATE INDEX FOR (r:Resolution) ON (r.resolution);

LOAD CSV WITH HEADERS FROM "file:///country.csv" AS row FIELDTERMINATOR '\t'
CREATE (c:Country {
    country: row.country, 
    country_abb: row.country_abb
    }); 
CREATE INDEX FOR (c:Country) ON (c.country_abb);

LOAD CSV WITH HEADERS FROM "file:///vote_result.csv" AS row FIELDTERMINATOR '\t'
MATCH (country:Country { country_abb: row.country_abb}),(resolution:Resolution { resolution: row.resolution})
CREATE (country)-[:VOTE { vote: row.vote }]->(resolution);
