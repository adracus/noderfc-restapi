ActivityRecording
=================

Activity recording app written in express

This app is written in coffeescript. In order to run it, you'll have to compile the
coffeescript into javascript and launch it.

## Setup
You'll need to have node, npm and gulp (globally, via npm) installed. After that, run
`npm install` to fetch the needed packages. To compile
the coffeescript files, run gulp coffee. If you'd like to immediately start a server
with the compiled files, run `gulp watch`. This also restarts the server automatically
if there are changes with the underlying javascript files.
