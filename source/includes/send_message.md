## Send Message

Records a message on the blockchain directing it to another virtual device.

The virtual device that sends the message is referred to as the *origin device*, and the virtual device to which the message is
sent is referred to as the *target device*.

<aside class="warning">
Depending on the current permission rights setting, it is possible that the sent message is never actually received by the intended target device.
</aside>

> Sample request:

```http--raw
POST /api/0.7/messages/send HTTP/1.1
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
curl -X "POST" "https://sandbox.catenis.io/api/0.7/messages/send" \
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

ctnApiClient.sendMessage('This is only a test', targetDevice, {
        encoding: 'utf8',
        encrypt: true,
        storage: 'auto',
        readConfirmation: true
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

```php
<?php
require __DIR__ . '/vendor/autoload.php';

use Catenis\ApiClient;
use Catenis\Exception\CatenisException;

$deviceId = 'dnN3Ea43bhMTHtTvpytS';

$ctnApiClient = new ApiClient($deviceId, $apiAccessSecret, [
    'environment' => 'sandbox'
]);

$targetDevice = [
  'id' => 'dv3htgvK7hjnKx3617Re'
];

try {
    $data = $ctnApiClient->sendMessage($targetDevice, 'My message to send', [
        'readConfirmation' => true,
        'encoding' => 'utf8',
        'encrypt' => true,
        'storage' => 'auto'
    ]);

    // Process returned data
    echo 'ID of sent message: ' . $data->messageId . PHP_EOL;
}
catch (CatenisException $ex) {
    // Process exception
}
```

```cpp
#include "CatenisApiClient.h"

std::string device_id("dnN3Ea43bhMTHtTvpytS");

ctn::CtnApiClient ctnApiClient(device_id, api_access_secret, "catenis.io", "", "sandbox");

ctn::SendMessageResult data;
ctn::Device targetDevice("dv3htgvK7hjnKx3617Re");
ctn::MessageOptions msgOpts("utf8", true, "auto", true);

try {
    client.sendMessage(data, targetDevice, "My message to send", msgOpts);

    std::cout << "ID of sent message: " << data.messageId << std::endl;
}
catch (ctn::CatenisAPIException &errObject) {
    std::cerr << errObject.getErrorDescription() << std::endl;
}
```

### Request

POST /messages/send

### Parameters

* Request body:

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `message` | String&#124;Object | The message to send. If an object is passed instead, it is expected that the message be passed in chunks. |
| &nbsp;&nbsp;`data` | String | *(optional)* The next message data chunk. The actual message's contents should be comprised of one or more data chunks. |
| &nbsp;&nbsp;`isFinal` | Boolean | *(optional, default: __`true`__)* Indicates whether this is the final message data chunk. |
| &nbsp;&nbsp;`continuationToken` | String | *(optional)* Indicates that this is a continuation message data chunk. It should be filled with the value returned in the `continuationToken` field of the response to the request used to pass the previous message data chunk. |
| `targetDevice` | Object | |
| &nbsp;&nbsp;`id` | String | The ID of the virtual device to which the message is directed. Should be a device ID unless `isProdUniqueId` is set. |
| &nbsp;&nbsp;`isProdUniqueId` | Boolean | *(optional, default: __`false`__)* Indicates whether the supplied ID is a product unique ID. |
| `options` | Object | |
| &nbsp;&nbsp;`encoding` | String | *(optional, default: __`utf8`__)* Value identifying the encoding of the message. Valid options: `utf8`, `base64`, `hex`. |
| &nbsp;&nbsp;`encrypt` | Boolean | *(optional, default: __`true`__)* Indicates whether message should be encrypted before storing it. |
| &nbsp;&nbsp;`storage` | String | *(optional, default: __`auto`__)* Value identifying where the message should be stored. Valid options: `auto`, `embedded`, `external`. The value `embedded` specifies that the message should be stored on the blockchain transaction itself; the value `external` specifies that the message should be stored in an external repository; and the value `auto` is used to specify that the message be embedded whenever possible otherwise it should be stored in the external storage. |
| &nbsp;&nbsp;`readConfirmation` | Boolean | *(optional, default: __`false`__)* Indicates whether message should be sent with read confirmation enabled. This should be used when the origin device intends to be notified when the target device first reads the message. |
| &nbsp;&nbsp;`async` | Boolean | *(optional, default: __`false`__)* Indicates whether processing — storage of message to the blockchain — should be done asynchronously. |

<aside class="notice">
The <code>message.data</code> field can be omitted or have an empty string value to signal that the whole message's contents have
 already been passed. In that case, the proper continuation token must be passed, and <code>message.isFinal</code> must be <code><b>true</b></code>.
</aside>

<aside class="notice">
When message is passed in chunks, options <code>encrypt</code>, <code>storage</code>, <code>readConfirmation</code> and <code>async</code> are only taken into consideration, and thus the respective fields only need to be passed, for the final message data chunk.
</aside>

<aside class="notice">
To avoid a possible timeout while waiting for Catenis Enterprise to process the message, especially when sending large
 messages, one may choose to do the processing asynchronously — <code>async</code> option set to <code><b>true</b></code>.
 In that case, the request will return a <b>provisional message ID</b>, which should be used to retrieve the processing
 outcome by calling the <a href="#retrieve-message-progress">Retrieve Message Progress</a> API method.
</aside>

<aside class="notice">
Currently, <a href="https://ipfs.io" target="_blank">IPFS - the InterPlanetary File System</a> is the only external storage made available by Catenis Enterprise.
</aside>

<aside class="warning">
The <code>readConfirmation</code> option by itself does not guarantee that the origin device will be notified; the current permission rights setting plays a major role in that outcome.
</aside>

<aside class="warning">
Embedded messages are limited to the following size restriction: 75 bytes for unencrypted messages, and 64 bytes when the message is encrypted.
</aside>

<aside class="warning">
Catenis Enterprise restricts the size of the data that can be sent in a request to no more than 10 MB. When that limit
 is exceeded, a <a href="#error_msg_215">[413] - Request data too large to be processed</a> error is returned. To work around that restriction
 when sending a large message, one must choose to pass the message in chunks instead.
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
| &nbsp;&nbsp;`continuationToken` | String | *(only returned if passing message in chunks and last message data chunk was not final)* Token to be used when sending the following message data chunk. |
| &nbsp;&nbsp;`messageId` | String | *(only returned after message has been processed)* ID of the sent message. |
| &nbsp;&nbsp;`provisionalMessageId` | String | *(only returned if doing asynchronous processing after the whole message's contents are passed)* ID of provisional message. |

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_80">Device is deleted</a><br><a href="#error_msg_90">Device is not active</a><br><a href="#error_msg_125">Invalid or unexpected continuation token</a><br><a href="#error_msg_130">Invalid parameters</a><br><a href="#error_msg_140">Invalid target device</a><br><a href="#error_msg_144">Message already complete</a><br><a href="#error_msg_146">Message expired</a><br><a href="#error_msg_150">Message too long to be embedded</a><br><a href="#error_msg_170">Not enough credits to pay for send message service</a> |
| 413 | <a href="#error_msg_215">Request data too large to be processed</a> |
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |
