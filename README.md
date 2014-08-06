REST API using SAP node-rfc
===========================

Example how to create REST API for time recording, out SAP BAPIs or remote function modules (RFCs), using node-rfc, node,
express and gulp as a build tool. 

## Prerequisites
You should have `node` and `npm` installed. Also, a global installation of gulp (via `npm install -g gulp`) is required.
After that, run `npm install`.

## Building
The source code of this api is written in coffeescript and the documentation is written in the blueprint format, so for
the code and documentation generation gulp is quite handy. To generate documentation, use `gulp doc` and to generate
js code from the coffeescript code use `gulp coffee`. Also, you'll need an sapnwrfc.json file in which the connection information for your SAP systems resides. The system which shall be loaded has to have the name `I64`.

Example of such a file:

```json
{
  "I64": {
    "user": "user",
    "passwd": "password",
    "ashost": "<ip here>",
    "saprouter": "<router path>",
    "sysnr": "00",
    "client": "800",
    "lang": "EN"
  }
}
```

## Running
For development usage (with live api auto reloading and a
separate server for the documentation html) run `gulp dev`. For production usage, simply run `gulp`. __Attention__:
For all those services, `sudo` might be required (due to the usage of port 80 and 443). 
