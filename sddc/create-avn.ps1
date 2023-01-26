

Validate

$ curl 'https://sfo-vcf01.rainpole.io/v1/avns/validations' -i -X POST \
-H 'Content-Type: application/json' \
-H 'Accept: application/json' \
-H 'Authorization: Bearer etYWRta....' \
-d '{
"edgeClusterId" : "52309268-2a1f-4c2c-b8ea-3dd78b6d5677",
"avns" : [ {
"name" : "sfo-m01-seg01",
"regionType" : "REGION_A",
"subnet" : "192.168.20.0",
"subnetMask" : "255.255.255.0",
"gateway" : "192.168.20.1",
"mtu" : 9000,
"routerName" : "sfo-m01-seg01-t0-gw01"
}, {
"name" : "xreg-m01-seg01",
"regionType" : "X_REGION",
"subnet" : "192.168.30.0",
"subnetMask" : "255.255.255.0",
"gateway" : "192.168.30.1",
"mtu" : 9000,
"routerName" : "xreg-m01-seg01-t0-gw01"
} ]
}'

Create

$ curl 'https://sfo-vcf01.rainpole.io/v1/avns' -i -X POST \
    -H 'Content-Type: application/json' \
    -H 'Accept: application/json' \
    -H 'Authorization: Bearer etYWRta....' \
    -d '{
  "edgeClusterId" : "52309268-2a1f-4c2c-b8ea-3dd78b6d5677",
  "avns" : [ {
    "name" : "sfo-m01-seg01",
    "regionType" : "REGION_A",
    "subnet" : "192.168.20.0",
    "subnetMask" : "255.255.255.0",
    "gateway" : "192.168.20.1",
    "mtu" : 9000,
    "routerName" : "sfo-m01-seg01-t0-gw01"
  }, {
    "name" : "xreg-m01-seg01",
    "regionType" : "X_REGION",
    "subnet" : "192.168.30.0",
    "subnetMask" : "255.255.255.0",
    "gateway" : "192.168.30.1",
    "mtu" : 9000,
    "routerName" : "xreg-m01-seg01-t0-gw01"
  } ]
}'