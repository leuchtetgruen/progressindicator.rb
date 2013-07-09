ProgressIndicator.rb
====================

ProgressIndicator.rb is a component for ruby that allows you to give feedback about the progress of your script/task to your user.
This can be done using several subclasses. There are subclasses for

* Displaying progress on the terminal using the curses lib (curses)
* Displaying progress on the terminal using simple strings (cli)
* Displaying progress on a remote computer using websockets and a javascript library (all included in this package)

See example.rb for further info on how to use the progress indicator. 

See example.sh and index.html for info on how to use the progress indicator over a websocket.

For sending data over a websocket this project uses this piece of code <https://github.com/gimite/web-socket-ruby/>