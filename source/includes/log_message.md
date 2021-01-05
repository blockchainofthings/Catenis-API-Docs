## Log Message

Records a message on the blockchain.

> Sample request:

```http--raw
POST /api/0.8/messages/log HTTP/1.1
X-BCoT-Timestamp: 20180127T173944Z
Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180127/ctn1_request, Signature=35e284726b17533d087f75ebea2bda5792011e503c391132d4e14fdb67fdaf30
Content-Type: application/json; charset=utf-8
Host: sandbox.catenis.io
Connection: close
User-Agent: Paw/3.1.5 (Macintosh; OS X/10.13.3) GCDHTTPRequest
Content-Length: 95

{"message":"This is only a test","options":{"encoding":"utf8","encrypt":true,"storage":"auto"}}
```

```shell
curl -X "POST" "https://sandbox.catenis.io/api/0.8/messages/log" \
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
    environment: 'sandbox'
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
    environment: 'sandbox'
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

```php
<?php
require __DIR__ . '/vendor/autoload.php';

use Catenis\ApiClient;
use Catenis\Exception\CatenisException;

$deviceId = 'dnN3Ea43bhMTHtTvpytS';

$ctnApiClient = new ApiClient($deviceId, $apiAccessSecret, [
    'environment' => 'sandbox'
]);

try {
    $data = $ctnApiClient->logMessage('This is only a test', [
        'encoding' => 'utf8',
        'encrypt' => true,
        'storage' => 'auto'
    ]);

    // Process returned data
    echo 'ID of logged message: ' . $data->messageId . PHP_EOL;
}
catch (CatenisException $ex) {
    // Process exception
}
```

### Request

POST /messages/log

### Parameters

* Request body:

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `message` | String&#124;Object | The message to record. If an object is passed instead, it is expected that the message be passed in chunks. |
| &nbsp;&nbsp;`data` | String | *(optional)* The next message data chunk. The actual message's contents should be comprised of one or more data chunks. |
| &nbsp;&nbsp;`isFinal` | Boolean | *(optional, default: __`true`__)* Indicates whether this is the final message data chunk. |
| &nbsp;&nbsp;`continuationToken` | String | *(optional)* Indicates that this is a continuation message data chunk. It should be filled with the value returned in the `continuationToken` field of the response to the request used to pass the previous message data chunk. |
| `options` | Object | *(optional)* |
| &nbsp;&nbsp;`encoding` | String | *(optional, default: __`utf8`__)* Value identifying the encoding of the message. Valid options: `utf8`, `base64`, `hex`. |
| &nbsp;&nbsp;`encrypt` | Boolean | *(optional, default: __`true`__)* Indicates whether message should be encrypted before storing it. |
| &nbsp;&nbsp;`storage` | String | *(optional, default: __`auto`__)* Value identifying where the message should be stored. Valid options: `auto`, `embedded`, `external`. The value `embedded` specifies that the message should be stored on the blockchain transaction itself; the value `external` specifies that the message should be stored in an external repository; and the value `auto` is used to specify that the message be embedded whenever possible otherwise it should be stored in the external storage. |
| &nbsp;&nbsp;`async` | Boolean | *(optional, default: __`false`__)* Indicates whether processing — storage of message to the blockchain — should be done asynchronously. |

<aside class="notice">
The <code>message.data</code> field can be omitted or have an empty string value to signal that the whole message's contents have
 already been passed. In that case, the proper continuation token must be passed, and <code>message.isFinal</code> must be <code><b>true</b></code>.
</aside>

<aside class="notice">
When message is passed in chunks, options <code>encrypt</code>, <code>storage</code> and <code>async</code> are only taken into consideration, and thus the respective fields only need to be passed, for the final message data chunk.
</aside>

<aside class="notice">
Currently, <a href="https://ipfs.io" target="_blank">IPFS - the InterPlanetary File System</a> is the only external storage made available by Catenis Enterprise.
</aside>

<aside class="notice">
To avoid a possible timeout while waiting for Catenis Enterprise to process the message, especially when logging large
 messages, one may choose to do the processing asynchronously — <code>async</code> option set to <code><b>true</b></code>.
 In that case, the request will return a <b>provisional message ID</b>, which should be used to retrieve the processing
 outcome by calling the <a href="#retrieve-message-progress">Retrieve Message Progress</a> API method.
</aside>

<aside class="warning">
Embedded messages are limited to the following size restriction: 75 bytes for unencrypted messages, and 63 bytes when the message is encrypted.
</aside>

<aside class="warning">
Catenis Enterprise restricts the size of the data that can be sent in a request to no more than 15 MB. When that limit
 is exceeded, a <a href="#error_msg_215">[413] - Request data too large to be processed</a> error is returned. To work around that restriction
 when logging a large message, one must choose to pass the message in chunks instead.
</aside>

<aside class="notice">
The 15 MB limitation referred above applies to the whole data that is sent with the request — the payload — <b>not</b> the size of the message.
 To estimate the size of the largest message that can the passed in a single call, one needs first to discount 256 bytes for the overhead data
 that are sent along with the message, then account for the encoding used to pass the message. In particular, if
 <code><b>base64</b></code> encoding is used — the recommended encoding for messages that may contain any arbitrary binary data —, the actual
 size of the message would be limited to around 11.2 MB.
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
| &nbsp;&nbsp;`continuationToken` | String | *(only returned if passing message in chunks and last message data chunk was not final)* Token to be used when sending the following message data chunk. |
| &nbsp;&nbsp;`messageId` | String | *(only returned after message has been processed)* ID of the logged message. |
| &nbsp;&nbsp;`provisionalMessageId` | String | *(only returned if doing asynchronous processing after the whole message's contents are passed)* ID of provisional message. |

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_80">Device is deleted</a><br><a href="#error_msg_90">Device is not active</a><br><a href="#error_msg_125">Invalid or unexpected continuation token</a><br><a href="#error_msg_130">Invalid parameters</a><br><a href="#error_msg_144">Message already complete</a><br><a href="#error_msg_146">Message expired</a><br><a href="#error_msg_150">Message too long to be embedded</a><br><a href="#error_msg_160">Not enough credits to pay for log message service</a> |
| 413 | <a href="#error_msg_215">Request data too large to be processed</a> |
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |
