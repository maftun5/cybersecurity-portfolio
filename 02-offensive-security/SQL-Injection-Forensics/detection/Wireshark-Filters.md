# Wireshark Filters for SQL Injection Detection

## Filter 1: Find SQL Injection Payloads in HTTP
http.request.uri matches ".*(select|union|insert|delete|drop|update|1=1|\'|--|#).*"
##### Simplified:
Show any web request where the URL contains SQL keywords

## Filter 2: Find Always-True Conditions
http.request.uri contains "1=1" or http.request.uri contains "1=2"
##### Simplified:
Find any web request with '1=1' or '1=2' in it

## Filter 3: Find Comments Used in SQL
http.request.uri contains "--" or http.request.uri contains "#"
##### Simplified:
Find SQL comment characters, that attackers often use to ignore the rest of the original query

## Filter 4: Find UNION Attacks
http.request.uri contains "union" and http.request.uri contains "select"
##### Simplified:
Find UNION SELECT attacks

## Filter 5: Find Information Schema Queries
http.request.uri contains "information_schema"
##### Simplified:
information_schema is built-in MySQL database that stores all table names. Only attackers want to access it

## Filter 6: Full SQL Injection Detection (Combined)
http.request.uri matches ".*(select.*from|union.*select|information_schema|1=1|1=2|\'.*or.*\'.*=\'.*|--|#).*"
##### Simplified:
Show ANYTHING that looks like SQL injection
