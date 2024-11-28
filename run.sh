#!/bin/bash
# Navigate to the project directory
cd #Location to your project

# Start the Flask server in the background
python lib/python/launcher.py &

# Start the Flutter app
flutter run
