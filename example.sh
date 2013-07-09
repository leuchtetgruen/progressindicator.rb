#!/bin/sh

killall python
python -m SimpleHTTPServer &
ruby cli_ws_bridge.rb 8080 "./example.rb remote"

# now open http://localhost:8000/ in your browser