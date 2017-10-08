#!/bin/bash

rm -f /%app_name/tmp/pids/server.pid

if [ "$DEBUG_MODE" = "1" ] ; then
  bundle exec rdebug-ide --host 127.0.0.1 --port 1234 --dispatcher-port 26162 -- bin/rails s -b 0.0.0.0 -p 3000 -e development
else
  bin/rails s -p 3000 -b '127.0.0.1' -e development
fi
