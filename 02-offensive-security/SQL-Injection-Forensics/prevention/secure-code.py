import sqlite3

def secure_login(username):
    # Create database connection
    conn = sqlite3.connect('users.db')
    cursor = conn.cursor()

    # Use a parameterized query with ? placeholder
    query = "SELECT * FROM users WHERE username = ?"
    
    print(f"Query template: {query}")
    print(f"Data: {username}")
    print("(The data stays separate from the query)")

    # Execute with the data as a SEPARATE parameter
    cursor.execute(query, (username,))
    
    result = cursor.fetchall()
    conn.close()
    return result

# Test with normal user
print("--- NORMAL LOGIN ---")
user_input = "alice"
result = secure_login(user_input)
# Output:
# Query template: SELECT * FROM users WHERE username = ?
# Data: alice
# Works fine

print("\n--- ATTACKER TRYING SQL INJECTION ---")
attacker_input = "alice' OR '1'='1"
result = secure_login(attacker_input)
# Output:
# Query template: SELECT * FROM users WHERE username = ?
# Data: alice' OR '1'='1
# SAFE! Database looks for username EXACTLY: "alice' OR '1'='1" (which doesn't exist)
