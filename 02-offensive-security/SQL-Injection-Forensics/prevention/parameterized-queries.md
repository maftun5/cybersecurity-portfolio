# SQL Injection Prevention

## In the lab
The attacker could execute SQL because the application directly inserted user input into the query string

## But with parametrized query
User input is treated as a Value, not part of the SQL command

## In Python

#### SQLite
cursor.execute("SELECT * FROM users WHERE userid = ?", (userid,))

Full here: [secure-code](./secure-code.py)

#### MySQL
cursor.execute("SELECT * FROM users WHERE userid = %s", (userid,))

## Additional Defense Layers

### Input Validation
It checks user input before it reaches the database by allowing only certain defined characters.
[code](./input-validation.py)

### Least Privilege
Database user has minimum necessary permissions.
