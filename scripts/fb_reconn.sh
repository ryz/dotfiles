#!/bin/bash

cat <<END | nc -w 1 fritz.box 49000 > /dev/null
POST /upnp/control/WANIPConn1 HTTP/1.1
HOST: blah:49000
SOAPACTION: "urn:schemas-upnp-org:service:WANIPConnection:1#ForceTermination"
CONTENT-TYPE: text/xml ; charset="utf-8"
Content-Length: 293

<?xml version="1.0" encoding="utf-8"?>
<s:Envelope s:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
   <s:Body>
      <u:ForceTermination xmlns:u="urn:schemas-upnp-org:service:WANIPConnection:1" />
   </s:Body>
</s:Envelope>
END