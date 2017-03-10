import sys, json

resultJson = json.loads(sys.stdin.read())

# exit immediately if recognition failed
if resultJson["status"]["msg"] != "Success":
	print "Recognition failed."
	sys.exit(2)

songName = resultJson["metadata"]["music"][0]["title"]
songArtist = resultJson["metadata"]["music"][0]["artists"][0]["name"]

print "'%s' - %s" % (songName, songArtist)
