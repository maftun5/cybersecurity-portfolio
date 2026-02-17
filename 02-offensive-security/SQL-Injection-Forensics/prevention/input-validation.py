import re

def validate_userid(userid):
    # Only allow letters, numbers, and underscore
    if re.match("^[a-zA-Z0-9_]+$", userid):
        return True
    return False

# Use it before the database query
if validate_userid(user_input):
    cursor.execute("SELECT * FROM users WHERE userid = ?", (user_input,))
else:
    return "Invalid input format"
