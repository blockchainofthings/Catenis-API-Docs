## Send Message

Records a message on the blockchain directing it to another virtual device.

The virtual device that sends the message is referred to as the *origin device*, and the virtual device to which the message is
sent is referred to as the *target device*.

<aside class="warning">
Depending on the current permission rights setting, it is possible that the sent message is never actually received by the intended target device.
</aside>

> Sample request:

```http--raw
POST /api/0.5/messages/send HTTP/1.1
X-BCoT-Timestamp: 20180207T201833Z
Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180207/ctn1_request, Signature=fc1c92fbdb248e2d0aa363babd2d4b32342e29a93a2782fb76bd4e3a45ce3488
Content-Type: application/json; charset=utf-8
Host: sandbox.catenis.io
Connection: close
User-Agent: Paw/3.1.5 (Macintosh; OS X/10.13.3) GCDHTTPRequest
Content-Length: 187

{"targetDevice":{"id":"dv3htgvK7hjnKx3617Re","isProdUniqueId":false},"message":"This is only a test","options":{"readConfirmation":true,"encoding":"utf8","encrypt":true,"storage":"auto"}}
```

```shell
curl -X "POST" "https://sandbox.catenis.io/api/0.5/messages/send" \
     -H 'X-BCoT-Timestamp: 20180207T201727Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180207/ctn1_request, Signature=3a8a28c50ce40cac7586df4231a7bee4ad6d08de3b289f96984c4458bf86c370' \
     -H 'Content-Type: application/json; charset=utf-8' \
     -d $'{
  "message": "This is only a test",
  "options": {
    "storage": "auto",
    "encoding": "utf8",
    "readConfirmation": true,
    "encrypt": true
  },
  "targetDevice": {
    "id": "dv3htgvK7hjnKx3617Re",
    "isProdUniqueId": false
  }
}'
```

```html--javascript
<script src="CatenisAPIClientJS.min.js"></script>

<script language="JavaScript">
var deviceId = 'dnN3Ea43bhMTHtTvpytS';

var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'sandbox'
});

var targetDevice = {
    id: 'dv3htgvK7hjnKx3617Re'
}

ctnApiClient.sendMessage(targetDevice, 'This is only a test', {
        readConfirmation: true,
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
            console.log('ID of sent message:', data.messageId);
        }
});
</script>
```

```javascript--node
var CtnApiClient = require('catenis-api-client');

var deviceId = 'dnN3Ea43bhMTHtTvpytS';

var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'sandbox'
});

var targetDevice = {
    id: 'dv3htgvK7hjnKx3617Re'
}

ctnApiClient.sendMessage(targetDevice, 'This is only a test', {
        readConfirmation: true,
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
            console.log('ID of sent message:', data.messageId);
        }
});
```

### Request

POST /messages/send

### Parameters

* Request body:

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `targetDevice` | Object | |
| &nbsp;&nbsp;`id` | String | The ID of the virtual device to which the message is directed. Should be a device ID unless `isProdUniqueId` is set. |
| &nbsp;&nbsp;`isProdUniqueId` | Boolean | *(optional, default: __`false`__)* Indicates whether the supplied ID is a product unique ID. |
| `message` | String | The message to send. |
| `options` | Object | |
| &nbsp;&nbsp;`readConfirmation` | Boolean | *(optional, default: __`false`__)* Indicates whether message should be sent with read confirmation enabled. This should be used when the origin device intends to be notified when the target device first reads the message. |
| &nbsp;&nbsp;`encoding` | String | *(optional, default: __`utf8`__)* Value identifying the encoding of the message. Valid options: `utf8`, `base64`, `hex`. |
| &nbsp;&nbsp;`encrypt` | Boolean | *(optional, default: __`true`__)* Indicates whether message should be encrypted before storing it. |
| &nbsp;&nbsp;`storage` | String | *(optional, default: __`auto`__)* Value identifying where the message should be stored. Valid options: `auto`, `embedded`, `external`. The value `embedded` specifies that the message should be stored on the blockchain transaction itself; the value `external` specifies that the message should be stored in an external repository; and the value `auto` is used to specify that the message be embedded whenever possible otherwise it should be stored in the external storage. |

<aside class="warning">
The <code>readConfirmation</code> option by itself does not guarantee that the origin device will be notified; the current permission rights setting plays a major role in that outcome.
</aside>

<aside class="notice">
Currently, <a href="https://ipfs.io" target="_blank">IPFS - the InterPlanetary File System</a> is the only external storage made available by Catenis Enterprise.
</aside>

<aside class="warning">
Embedded messages are limited to the following size restriction: 75 bytes for unencrypted messages, and 64 bytes when the message is encrypted.
</aside>

> Sample respose:

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
| &nbsp;&nbsp;`messageId` | String | ID of the sent message. |

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_80">Device is deleted<br><a href="#error_msg_90">Device is not active<br><a href="#error_msg_130">Invalid parameters<br><a href="#error_msg_140">Invalid target device<br><a href="#error_msg_150">Message too long to be embedded<br><a href="#error_msg_170">Not enough credits to pay for send message service |
| 500 | <a href="#error_msg_100">Internal server error |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time |
