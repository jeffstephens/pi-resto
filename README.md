# Pi-resto!

My ReadyTalk Pi Day 2017 Project: Pi-resto identifies the song that's playing and scrobbles it to
[Last.fm](https://www.last.fm/).

Check out my [blog post about the project](https://blog.jeffastephens.com/2017/04/22/pi-resto-pi-day-2017.html).

![Scrolling Message](https://github.com/jeffstephens/pi-resto/raw/master/samples/scroll-example.gif)

## Components

Each major component of this project is broken up into its own Bash or Python script. The whole pipeline is orchestrated
by `recognition/makeitso.sh`.

By default (no arguments), it will capture an audio sample to identify. You can optionally pass a filename as the only
argument and recognition will be performed on that file instead.

### Audio Recording

Audio recording is accomplished via the `alsa-utils` program `arecord`.

> Note: There is a bug in the latest version of Raspbian Jessie (from Debian upstream) on ARM devices, where `arecord`
> will not behave well. To remedy this, follow
> [these instructions](http://blog.nagimov.com/alsa-utils-arecord-bug-lots-of-wav-files-ignoring-duration-parameter/) to
> revert to an older version where the bug isn't present.

Audio recording is handled by `recognition/capture-audio.sh`. A 10-second sample is captured and saved to `/tmp` on
disk, to be used in the next step of the pipeline.

### Audio Recognition

Audio recognition is outsourced to the ACRCloud service. You can sign up for a free trial and continue to use their
more limited free tier once it expires. I found the Web API to be the easiest to get started with, and they provide
code examples for most popular languages in [this Git repository](https://github.com/acrcloud/webapi_example).

Audio recognition is handled by `recognition/identify-audio.py`, which takes a single argument - the filepath to the
recording to identify.

### Last.fm Scrobbling

Tracks are scrobbled to Last.fm after they're recognized, using the `pylast` library. Last.fm API and account
credentials are expected in `setup/lastfm_creds.sh`, and it's recommended you make a separate Last.fm account to
scrobble under.

Scrobbling is handled by `recognition/scrobbleTrack.py`.

### Sense HAT Message Scrolling

The artist and track name (or an error message) are scrolled across the 8x8 LED array of the
[Sense HAT](https://www.raspberrypi.org/products/sense-hat/) using the provided `SenseHat` library.

## Sample Files

There is an example audio recording and JSON response from the ACRCloud service in `samples/`.

## Sources

* http://www.g7smy.co.uk/2013/08/recording-sound-on-the-raspberry-pi/
* http://blog.nagimov.com/alsa-utils-arecord-bug-lots-of-wav-files-ignoring-duration-parameter/
* https://github.com/acrcloud/webapi_example
