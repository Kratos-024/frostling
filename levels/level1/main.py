import random
import string

def random_word(length=8):
    # Generates a random word of given length (letters and digits, can adjust)
    return ''.join(random.choices(string.ascii_letters + string.digits, k=length))

num_words = 1000
words = [random_word() for _ in range(num_words)]

with open("password.txt", "w") as f:
    # Each word twice
    for w in words:
        f.write((w + ' ') * 2 + '\n')
    # Each word three times
    for w in words:
        f.write((w + ' ') * 3 + '\n')
    # Each word four times
    for w in words:
        f.write((w + ' ') * 4 + '\n')
