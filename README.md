✅ Step 1: Check if a log directory was provided as an argument
bash
Copy
Edit
if [ -z "$1" ]; then
  echo "Usage: $0 <log-directory>"
  exit 1
fi
🔍 Explanation:
$1: Refers to the first argument passed to the script. This should be the path to the log directory.

-z "$1": Checks if the argument is empty or not provided.

If no argument is passed:

echo: Displays correct usage, showing how to run the script.

exit 1: Exits the script with status 1 (which signals an error).

🧪 Example:
bash
Copy
Edit
./log-archive.sh /var/log    # ✅ Works
./log-archive.sh             # ❌ Shows usage and exits
✅ Step 2: Save the argument into a variable
bash
Copy
Edit
LOG_DIR="$1"
🔍 Explanation:
Stores the value of the first argument (like /var/log) into a variable named LOG_DIR.

Makes the script cleaner and easier to maintain.

✅ Step 3: Check if the provided directory actually exists
bash
Copy
Edit
if [ ! -d "$LOG_DIR" ]; then
  echo "Error: Directory '$LOG_DIR' does not exist."
  exit 1
fi
🔍 Explanation:
-d "$LOG_DIR": Checks whether the directory exists.

! -d: Negates the check — if it doesn't exist, run the code inside.

echo: Outputs an error message.

exit 1: Exits the script because you cannot archive a non-existent directory.

✅ Step 4: Define where the archives will be stored
bash
Copy
Edit
ARCHIVE_DIR="/var/log-archive"
mkdir -p "$ARCHIVE_DIR"
🔍 Explanation:
ARCHIVE_DIR: Set to /var/log-archive — the directory where archives will be stored.

mkdir -p: Creates the directory if it doesn’t already exist.

-p prevents errors if the directory already exists.

🔒 ⚠️ This step requires root permissions unless the script is modified to store in a user-writable directory like $HOME/log-archive.

✅ Step 5: Generate a timestamped archive file name
bash
Copy
Edit
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
ARCHIVE_NAME="logs_archive_${TIMESTAMP}.tar.gz"
ARCHIVE_PATH="${ARCHIVE_DIR}/${ARCHIVE_NAME}"
🔍 Explanation:
date +"%Y%m%d_%H%M%S": Produces a timestamp like 20250713_154501.

ARCHIVE_NAME: Combines logs_archive_ + timestamp + .tar.gz
→ e.g. logs_archive_20250713_154501.tar.gz

ARCHIVE_PATH: Full path for the archive file
→ /var/log-archive/logs_archive_20250713_154501.tar.gz

✅ Step 6: Compress the contents of the log directory
bash
Copy
Edit
tar -czf "$ARCHIVE_PATH" -C "$LOG_DIR" .
🔍 Explanation:
tar: Linux command to create archive files.

Options:

-c: create a new archive

-z: compress it using gzip

-f "$ARCHIVE_PATH": output file name

-C "$LOG_DIR": Changes to that directory before archiving.

.: means "include everything inside this directory"

🧪 So this will:

Compress all files inside $LOG_DIR

Save the archive as: $ARCHIVE_PATH
(e.g., /var/log-archive/logs_archive_20250713_154501.tar.gz)

✅ Step 7: Record the archive operation in a log file
bash
Copy
Edit
LOG_FILE="${ARCHIVE_DIR}/log-archive.log"
echo "[$(date +"%Y-%m-%d %H:%M:%S")] Archived '$LOG_DIR' to '$ARCHIVE_PATH'" >> "$LOG_FILE"
🔍 Explanation:
LOG_FILE: The log where archive operations are recorded.

echo [...] >>: Appends a log entry with timestamp and archive path.

Each time the script runs, it logs the date/time and archive file created.

📝 Example entry in log-archive.log:

csharp
Copy
Edit
[2025-07-13 15:45:01] Archived '/var/log' to '/var/log-archive/logs_archive_20250713_154501.tar.gz'
✅ Step 8: Final success message to the user
bash
Copy
Edit
echo "✅ Logs from '$LOG_DIR' archived to: $ARCHIVE_PATH"
🔍 Explanation:
Gives user a clear success message in the terminal.

Shows where the compressed archive was saved.



project URL: https://roadmap.sh/projects/log-archive-tool
