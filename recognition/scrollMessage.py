from sense_hat import SenseHat
import sys

sense = SenseHat()
sense.show_message(sys.stdin.read(), scroll_speed=.05, text_colour=[128, 0, 128])
