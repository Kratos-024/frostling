import os

# Directory paths for each file
files = {
    'fake_pass1.txt': 'This is not the flag',
    'fake_pass2.txt': 'Wrong file, try again',
    'decoy.txt': 'Nothing here',
    'real_password.txt': 'FLAG',
    'junk.txt': 'Random content'
}

for file_path, content in files.items():
    dir_name = os.path.dirname(file_path)
    with open(file_path, 'w') as f:
        f.write(content)
