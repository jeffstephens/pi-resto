from sense_hat import SenseHat
import sys

sense = SenseHat()
sense.show_message(sys.stdin.read(), scroll_speed=.08, text_colour=[255, 0, 0])
