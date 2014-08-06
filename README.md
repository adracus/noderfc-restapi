REST API using SAP node-rfc
===========================

Example how to create REST API for time recording, out SAP BAPIs or remote function modules (RFCs), using node-rfc, node, express and gulp as a build tool. 

Install 






## Setup
You'll need to have node, npm and gulp (globally, via npm) installed. After that, run
`npm install` to fetch the needed packages. To compile
the coffeescript files, run gulp coffee. If you'd like to immediately start a server
with the compiled files, run `gulp watch`. This also restarts the server automatically
if there are changes with the underlying javascript files.
