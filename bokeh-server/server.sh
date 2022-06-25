#!/usr/bin/bash

bokeh serve /home/nicholas/repro/sliders.py --use-xheaders --address 0.0.0.0 --port 5006 --allow-websocket-origin="*"
