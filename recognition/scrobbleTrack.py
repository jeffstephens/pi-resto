import os, sys, json, pylast, calendar
from datetime import datetime

resultJson = json.loads(sys.stdin.read())
# exit immediately if recognition failed
if resultJson["status"]["msg"] != "Success":
	print "Recognition failed."
	sys.exit(2)

# load Last.fm auth details into environment variables
apiKey = os.environ["LASTFM_API_KEY"]
apiSecret = os.environ["LASTFM_API_SECRET"]
username = os.environ["LASTFM_USERNAME"]
password = os.environ["LASTFM_PASSWORD"]
passwordHash = pylast.md5(password)

if not apiKey:
	print "No Last.fm API Key was found."
	sys.exit(3)

if not apiSecret:
	print "No Last.fm API Secret was found."
	sys.exit(3)

if not username:
	print "No Last.fm username was found."
	sys.exit(3)

if not password:
	print "No Last.fm password was found."
	sys.exit(3)

# load song details from JSON object
songName = resultJson["metadata"]["music"][0]["title"]
songArtist = resultJson["metadata"]["music"][0]["artists"][0]["name"]

network = pylast.LastFMNetwork(api_key=apiKey, api_secret=apiSecret,
                               username=username, password_hash=passwordHash)

d = datetime.utcnow()
unixtime = calendar.timegm(d.utctimetuple())
network.scrobble(songArtist, songName, unixtime)

