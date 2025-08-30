import os
import tarfile
import stat

# --- Configuration ---
# The password for the level, which the script will print
PASSWORD = "AtBsNLlVEwSs"

# --- Create the directory structure ---
# This makes the path diagnostic_kit/bin/
os.makedirs("diagnostic_kit/bin", exist_ok=True)

# --- Create the non-executable script ---
script_path = "diagnostic_kit/bin/run_diagnostic"
with open(script_path, "w") as f:
    # Use a shebang to indicate it's a bash script
    # The echo command prints the password to standard output
    f.write(f"#!/bin/bash\necho '{PASSWORD}'\n")

# --- Set its permissions to be NON-executable ---
# This sets the permissions to 644 (-rw-r--r--)
# The user can read it, but cannot execute it.
os.chmod(script_path, stat.S_IRUSR | stat.S_IWUSR | stat.S_IRGRP | stat.S_IROTH)
print(f"Created script at '{script_path}' with non-executable permissions.")

# --- Create the final tarball ---
# This packages the 'diagnostic_kit' directory and everything inside it
with tarfile.open("diagnostic_kit.tar", "w") as tar:
    tar.add("diagnostic_kit")

print("Successfully created 'diagnostic_kit.tar'")

# --- Optional: Clean up the temporary directory ---
# Uncomment the lines below if you want to automatically remove the
# 'diagnostic_kit' directory after creating the .tar file.
# import shutil
# shutil.rmtree('diagnostic_kit')
# print("Cleaned up temporary 'diagnostic_kit' directory.")

