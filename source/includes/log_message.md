## Log Message

Records a message on the blockchain.

> Sample request:

```http--raw
POST /api/0.5/messages/log HTTP/1.1
X-BCoT-Timestamp: 20180127T173944Z
Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180127/ctn1_request, Signature=35e284726b17533d087f75ebea2bda5792011e503c391132d4e14fdb67fdaf30
Content-Type: application/json; charset=utf-8
Host: beta.catenis.io
Connection: close
User-Agent: Paw/3.1.5 (Macintosh; OS X/10.13.3) GCDHTTPRequest
Content-Length: 95

{"message":"This is only a test","options":{"encoding":"utf8","encrypt":true,"storage":"auto"}}
```

```shell
curl -X "POST" "https://beta.catenis.io/api/0.5/messages/log" \
     -H 'X-BCoT-Timestamp: 20180127T174023Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180127/ctn1_request, Signature=72d51cd708e5a81ee1a50b33c72f98c906084b183a60904cd0ce3f4119659581' \
     -H 'Content-Type: application/json; charset=utf-8' \
     -d $'{
  "message": "This is only a test",
  "options": {
    "encoding": "utf8",
    "encrypt": true,
    "storage": "auto"
  }
}'
```

```html--javascript
<script src="CatenisAPIClientJS.min.js"></script>

<script language="JavaScript">
var deviceId = 'dnN3Ea43bhMTHtTvpytS';

var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'beta'
});

ctnApiClient.logMessage('This is only a test', {
        encoding: 'utf8',
        encrypt: true,
        storage: 'auto'
    },
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            console.log('ID of logged message:', data.messageId);
        }
});
</script>
```

```javascript--node
var CtnApiClient = require('catenis-api-client');

var deviceId = 'dnN3Ea43bhMTHtTvpytS';

var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'beta'
});

ctnApiClient.logMessage('This is only a test', {
        encoding: 'utf8',
        encrypt: true,
        storage: 'auto'
    },
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            console.log('ID of logged message:', data.messageId);
        }
});
```

```cpp
#include "CatenisApiClient.h"

std::string device_id("dnN3Ea43bhMTHtTvpytS");

ctn::CtnApiClient ctnApiClient(device_id, api_access_secret, "catenis.io", "", "beta");

ctn::LogMessageResult data;
ctn::MessageOptions msgOpts("utf8", true, "auto");

try {
    ctnApiClient.logMessage(data, "My message", msgOpts);

    std::cout << "ID of logged message: " << data.messageId << std::endl;
}
catch (ctn::CatenisAPIException &errObject) {
    std::cerr << errObject.getErrorDescription() << std::endl;
}
```

### Request

POST /messages/log

### Parameters

* Request body:

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `message` | String | The message to record. |
| `options` | Object | |
| &nbsp;&nbsp;`encoding` | String | *(optional, default: __`utf8`__)* Value identifying the encoding of the message. Valid options: `utf8`, `base64`, `hex`. |
| &nbsp;&nbsp;`encrypt` | Boolean | *(optional, default: __`true`__)* Indicates whether message should be encrypted before storing it. |
| &nbsp;&nbsp;`storage` | String | *(optional, default: __`auto`__)* Value identifying where the message should be stored. Valid options: `auto`, `embedded`, `external`. The value `embedded` specifies that the message should be stored on the blockchain transaction itself; the value `external` specifies that the message should be stored in an external repository; and the value `auto` is used to specify that the message be embedded whenever possible otherwise it should be stored in the external storage. |

<aside class="notice">
Currently, <a href="https://ipfs.io" target="_blank">IPFS - the InterPlanetary File System</a> is the only external storage made available by Catenis Enterprise.
</aside>

<aside class="warning">
Embedded messages are limited to the following size restriction: 75 bytes for unencrypted messages, and 64 bytes when the message is encrypted.
</aside>

> Sample response:

```json
{
  "status": "success",
  "data": {
    "messageId": "muczbRbcgo3F8XoC6ejE"
  }
}
```

### Success response

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `status` | String | The value **`success`**, indicating that the request was successful. |
| `data` | Object | The actual data returned in response to the API request. |
| &nbsp;&nbsp;`messageId` | String | ID of the logged message. |

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_80">Device is deleted<br><a href="#error_msg_90">Device is not active<br><a href="#error_msg_130">Invalid parameters<br><a href="#error_msg_150">Message too long to be embedded<br><a href="#error_msg_160">No credit to log message |
| 500 | <a href="#error_msg_100">Internal server error |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time |
