import os
import random
import string

def generate_random_word(length=5):
    """Generate a random lowercase word of given length."""
    return ''.join(random.choices(string.ascii_lowercase, k=length))

def generate_random_password(length=12):
    """Generate a random alphanumeric gibberish password."""
    chars = string.ascii_letters + string.digits
    return ''.join(random.choices(chars, k=length))

def create_ctf_files(output_dir="documents", num_files=10, min_words=50, max_words=300, special_password="D0fZZfMZYdm"):
    """
    Create text files for wc CTF challenge:
    - Every file contains a line with "password:<something>".
    - Exactly one file (random) has 100–110 words and contains the real password.
    """
    os.makedirs(output_dir, exist_ok=True)

    # Pick which file will contain the real password
    password_file_index = random.randint(1, num_files)
    
    for i in range(1, num_files + 1):
        if i == password_file_index:
            # Force word count between 100–110
            word_count = random.randint(100, 110)
            words = [generate_random_word(random.randint(3, 8)) for _ in range(word_count - 1)]
            words.insert(random.randint(0, len(words)), f"password:{special_password}")
        else:
            # Make sure it's NOT between 100–110
            while True:
                word_count = random.randint(min_words, max_words)
                if not (100 <= word_count <= 110):
                    break
            words = [generate_random_word(random.randint(3, 8)) for _ in range(word_count - 1)]
            words.insert(random.randint(0, len(words)), f"password:{generate_random_password()}")
        
        filename = os.path.join(output_dir, f"file{i}.txt")
        with open(filename, "w") as f:
            f.write(" ".join(words))
        
        if i == password_file_index:
            print(f"🔑 Created {filename} with {word_count} words (REAL PASSWORD FILE)")
        else:
            print(f"✅ Created {filename} with {word_count} words")

# Example usage
create_ctf_files()
