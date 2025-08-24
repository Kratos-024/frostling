import random
import string

# Function to generate a random alphanumeric string
def random_string(length=10):
    chars = string.ascii_letters + string.digits
    return ''.join(random.choice(chars) for _ in range(length))

# Open the file in write mode
with open("pass.txt", "w") as file:
    for _ in range(1000):
        line = f"level3-password:{random_string()}\n"
        file.write(line)

print("pass.txt created with 1000 lines!")
