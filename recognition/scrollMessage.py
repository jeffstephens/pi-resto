from sense_hat import SenseHat
import sys

sense = SenseHat()
sense.show_message(sys.stdin.read())
