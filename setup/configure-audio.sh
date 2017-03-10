#!/bin/bash

# set alsamixer mic capture level to 10 (that seems decent in tests)
amixer -c 1 cset numid=6,iface=MIXER,name='Mic Capture Volume' 10
sudo alsactl store 1
