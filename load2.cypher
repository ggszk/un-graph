LOAD CSV WITH HEADERS FROM "file:///country.csv" AS row FIELDTERMINATOR '\t'
CREATE (c:Country {
    country: row.country, 
    country_abb: row.country_abb
    }); 
CREATE INDEX FOR (c:Country) ON (c.country_abb);

LOAD CSV WITH HEADERS FROM "file:///agree.csv" AS row FIELDTERMINATOR '\t'
MATCH (country_x:Country { country_abb: row.country_abb_x}),(country_y:Country { country_abb: row.country_abb_y})
CREATE (country_x)-[:AGREE { count: toInteger(row.agree) }]->(country_y);

LOAD CSV WITH HEADERS FROM "file:///agree.csv" AS row FIELDTERMINATOR '\t'
MATCH (country_x:Country { country_abb: row.country_abb_x}),(country_y:Country { country_abb: row.country_abb_y})  WHERE row.agree = '10'
CREATE (country_x)-[:AGREE { count: toInteger(row.agree) }]->(country_y);

