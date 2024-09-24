import subprocess
import os
import time

def run_flask():
    # Get the current directory of this script
    current_dir = os.path.dirname(os.path.abspath(__file__))
    # Path to your Flask app
    flask_app_path = os.path.join(current_dir, 'server.py')  # Update with your actual filename

    # Start the Flask app
    process = subprocess.Popen(['python', flask_app_path], cwd=current_dir)
    time.sleep(1)  # Optional: wait a moment for the server to start
    return process

if __name__ == "__main__":
    run_flask()
