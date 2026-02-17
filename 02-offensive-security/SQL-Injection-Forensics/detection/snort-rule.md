# SNORT IDS RULES FOR SQL INJECTION DETECTION

## Detect basic SQLi probes
alert tcp any any -> $HTTP_SERVERS $HTTP_PORTS (msg:"SQL Injection - Always True Probe"; content:"1=1"; http_uri; sid:1000001; rev:1;)
#### Explanation:
When u see this from any computer, any port going to web servers on web ports (80, 443) looking for "1=1" in traffic particularly in the web address. Rule's ID is 1000001

## Detect UNION-based SQLi
alert tcp any any -> $HTTP_SERVERS $HTTP_PORTS (msg:"SQL Injection - UNION SELECT"; content:"union"; http_uri; content:"select"; http_uri; within:20; sid:1000002; rev:1;)
#### Explanation:
Looking for BOTH "union" AND "select" within 20 characters of each other

## Detect information_schema access
alert tcp any any -> $HTTP_SERVERS $HTTP_PORTS (msg:"SQL Injection - Information Schema Access"; content:"information_schema"; http_uri; sid:1000003; rev:1;)

## Detect comment usage in SQLi
alert tcp any any -> $HTTP_SERVERS $HTTP_PORTS (msg:"SQL Injection - Comment Character"; content:"--"; http_uri; sid:1000004; rev:1;)

## Comprehensive SQLi rule
alert tcp any any -> $HTTP_SERVERS $HTTP_PORTS (msg:"SQL Injection - Multiple Techniques"; content:"select"; http_uri; content:"from"; http_uri; within:15; content:"'"; http_uri; sid:1000005; rev:1;)
