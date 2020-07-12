#!/bin/sh
# A simple entrypoint script - it:
# 1 - prints a welcome message
# 2 - prints the length of args
# 3 - executes the arguments passed in. 
# Naturally it can be customised...to perform checks, start various services, etc.,
# One good use case for the entrypoint would be to pass in a specific script and port to run. in this case a 'master' script like master.q could start on e.g. port 5000 and a set of worker scripts worker-1.q, worker-2.q etc., could run on 5001, 5002...

cd ~/Sites/OHR400Dashboard && git pull

# install any updated python dependencies defined in OHR400Dashboard Repo
python3 -m pip install -r ~/Sites/OHR400Dashboard/requirements.txt

# install kx developer
# cd
# sudo apt update
# sudo apt install -y unzip
# unzip ~/developer.zip
# rm ~/developer.zip
# mv developer-1.3.1-linux developer



echo "Welcome to KDB+ on Docker"

echo "\nFAS Scripts:\n"
ls | grep .q | grep FAS
echo ""

echo $#
exec "$@"
