import sys
import os
import subprocess
import iterm2
import shlex  # put at the top of the file
from datetime import datetime

LOG_PATH = "/tmp/semantic_open.log"

def log(msg):
    timestamp = datetime.now().isoformat()
    with open(LOG_PATH, "a") as log_file:
        log_file.write(f"[{timestamp}] {msg}\n")

async def main(connection):
    log("=== semantic_open.py invoked ===")
    log(f"sys.argv: {sys.argv}")

    if len(sys.argv) < 2:
        log("ERROR: No file argument provided.")
        return

    raw_path = sys.argv[1]
    log(f"raw file_path: {raw_path}")

    # Manually fix escaped paths from iTerm2 (e.g. '\ ' to ' ')
    file_path = raw_path.replace("\\ ", " ").replace("\\", "")
    log(f"cleaned file_path: {file_path}")

    # Run the 'file' command to detect MIME type
    try:
        result = subprocess.check_output(
            ["file", "--brief", "--mime-type", file_path],
            text=True
        ).strip()
        log(f"file --mime-type output: {result}")
    except subprocess.CalledProcessError as e:
        log(f"ERROR: 'file' command failed with exit code {e.returncode}")
        return
    except FileNotFoundError:
        log("ERROR: 'file' command not found.")
        return

    try:
        app = await iterm2.async_get_app(connection)
        window = app.current_window
        if window is None:
            log("ERROR: No active iTerm2 window.")
            return
        session = window.current_tab.current_session

        if result.startswith("text/"):
            cmd = f"vim {shlex.quote(file_path)}"
            log(f"Action: sending to iTerm2 session: {cmd}")
            await session.async_send_text(f"{cmd}\n")
        else:
            log(f"Action: os.system(open {file_path})")
            subprocess.run(["open", file_path])
    except Exception as e:
        log(f"ERROR during iTerm2 interaction: {e}")

iterm2.run_until_complete(main)
