## Read Message

Retrieves the contents of a message that had been previously recorded on the blockchain.

<aside class="notice">
Logged messages can only be read by the virtual device that logged it.
</aside>

<aside class="notice">
Sent messages can only be read by the virtual device that sent it — the <i>target device</i>.
</aside>

> Sample request:

```http--raw
GET /api/0.9/messages/oDWPuD5kjCsEiNEEWwrW?encoding=utf8 HTTP/1.1
X-BCoT-Timestamp: 20180215T112048Z
Authorization: CTN1-HMAC-SHA256 Credential=dmM2Dz32agLSGsSuoxsR/20180215/ctn1_request, Signature=10b1299fdf935544b44e3e1e8de7d3f3df03df9ddc35db0127d5ab0cafa36cbb
Host: sandbox.catenis.io
Connection: close
User-Agent: Paw/3.1.5 (Macintosh; OS X/10.13.3) GCDHTTPRequest
```

```shell
curl "https://sandbox.catenis.io/api/0.9/messages/oDWPuD5kjCsEiNEEWwrW?encoding=utf8" \
     -H 'X-BCoT-Timestamp: 20180215T112120Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=dmM2Dz32agLSGsSuoxsR/20180215/ctn1_request, Signature=84ddc0f0e3a3cadab6011b18962912bdf62bfcd2234e0984513a1856fd88c1c1'
```

```html--javascript
<script src="CatenisAPIClientJS.min.js"></script>

<script language="JavaScript">
var deviceId = 'dnN3Ea43bhMTHtTvpytS';

var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'sandbox'
});

var messageId = 'oDWPuD5kjCsEiNEEWwrW';

ctnApiClient.readMessage(messageId, 'utf8', function (err, data) {
    if (err) {
        // Process error
    }
    else {
        // Process returned data
        console.log('Read message:', data.msgData.message);

        if (data.msgInfo.action === 'send') {
            console.log('Message sent from:', data.msgInfo.from);
        }
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

var messageId = 'oDWPuD5kjCsEiNEEWwrW';

ctnApiClient.readMessage(messageId, 'utf8', function (err, data) {
    if (err) {
        // Process error
    }
    else {
        // Process returned data
        console.log('Read message:', data.message);

        if (data.action === 'send') {
            console.log('Message sent from:', data.from);
        }
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

$messageId = 'oDWPuD5kjCsEiNEEWwrW';

try {
    $data = $ctnApiClient->readMessage($messageId, 'utf8');

    // Process returned data
    echo 'Read message: ' . $data->message . PHP_EOL;

    if ($data->action === 'send') {
        echo 'Message sent from: ' . print_r($data->from, true);
    }
}
catch (CatenisException $ex) {
    // Process exception
}
```

### Request

GET /messages/`:messageId`

### Parameters

<!-- Note: we are not using the native markdown list feature for the second level items because the generated
        HTML has no space to the following first level item -->
- URL parameters:
<ul class="parameterList">
  <li>`messageId`: The ID of the message to read.</li>
</ul>

- Query string parameters:
<ul class="parameterList">
  <li>`encoding`: *(optional, default: __`utf8`__)* The encoding to be used for the contents of the message. Valid values: `utf8`, `base64`, `hex`.</li>
  <li>`continuationToken`: *(optional)* Indicates that this is a continuation call and that the following message data chunk should be returned. It should be filled with the value returned in the `continuationToken` field of the response to the request used to retrieve the previous message data chunk, or the request to the <a href="#retrieve-message-progress">Retrieve Message Progress</a> API method.</li>
  <li>`dataChunkSize`: *(optional)* Size, in bytes, of the largest message data chunk that should be returned. This is effectively used to signal that the message should be read in chunks. It must be an integer value between 1,024 (1 KB) and 15,728,640 (15 MB).</li>
  <li>`async`: *(optional, default: __`false`__)* A boolean value indicating whether processing — retrieval of message from the blockchain — should be done asynchronously.</li>
</ul>

<aside class="notice">
The size of the message data chunk set via the <code>dataChunkSize</code> parameter refers to the <b>plain, unencoded</b> message's
 contents; the actual number of bytes returned depends on the selected encoding — value of the <code>encoding</code> parameter.
 In particular, if <code><b>hex</b></code> encoding is used, the number of bytes returned is twice the number of bytes of
 the plain message's contents. If <code><b>base64</b></code> is used instead, the increase in size is around 33% — every
 3 bytes become 4.
</aside>

<aside class="notice">
Parameters <code>dataChunkSize</code> and <code>async</code> are only taken into consideration, and thus only need to be passed, for the initial call to this API method to read a given message — <code>continuationToken</code> parameter not passed.
</aside>

<aside class="notice">
To avoid a possible timeout while waiting for Catenis Enterprise to process the message, especially when reading large
 messages, one can choose to do the processing asynchronously — <code>async</code> parameter set to <code><b>true</b></code>.
 In that case, the request will return a <b>cached message ID</b>, which should be used to retrieve the processing
 outcome by calling the <a href="#retrieve-message-progress">Retrieve Message Progress</a> API method.
</aside>

<aside class="warning">
Catenis Enterprise restricts the size of the largest message that can be read in a single call to 15 MB. When
 that limit is exceeded, a <a href="#error_msg_149">[400] - Message too large for reading at once</a> error is returned.
 To work around that restriction when reading a large message, one must choose to read the message in chunks instead.
</aside>

> Sample response:

```json
{
  "status": "success",
  "data": {
    "msgInfo": {
      "action": "send",
      "from": {
        "deviceId": "dv3htgvK7hjnKx3617Re",
        "name": "Catenis device #1"
      }
    },
    "msgData": "This is only a test"
  }
}
```

### Success response

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `status` | String | The value **`success`**, indicating that the request was successful. |
| `data` | Object | The actual data returned in response to the API request. |
| &nbsp;&nbsp;`msgInfo` | Object | *(only returned along with the `msgData` field if not reading the message in chunks or for the first message data chunk returned)* Info about the read message. |
| &nbsp;&nbsp;&nbsp;&nbsp;`action` | String | Action originally performed on the message. Possible values: `log`, `send`. The value `log` indicates that this is a logged message, and the value `send` indicates that this is a sent message. |
| &nbsp;&nbsp;&nbsp;&nbsp;`from` | Object | *(only returned for sent messages)* Identifies the virtual device that sent the message — the *origin device*. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`deviceId` | String | The device ID of the origin device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`name` | String | *(only returned if origin device has this data, and the virtual device issuing the request has the necessary permission right)* The name of the origin device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`prodUniqueId` | String | *(only returned if origin device has this data, and the virtual device issuing the request has the necessary permission right)* The product unique ID of the origin device. |
| &nbsp;&nbsp;`msgData` | String | *(always returned except when `cachedMessageId` field is returned)* The contents of the message formatted using the specified encoding. When reading the message in chunks, this corresponds to a message data chunk. In that case, additional calls to this API method might be necessary to read the whole message's contents. |
| &nbsp;&nbsp;`continuationToken` | String | *(only returned along with the `msgData` field if the whole message's contents have not yet been returned)* Token to be used when requesting the following message data chunk. |
| &nbsp;&nbsp;`cachedMessageId` | String | *(only returned as a response to the initial call to this API method to read a given message asynchronously — `async` parameter set to __`true`__)* Cached message ID. |

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_120">Invalid message ID</a><br><a href="#error_msg_125">Invalid or unexpected continuation token</a><br><a href="#error_msg_130">Invalid parameters</a><br><a href="#error_msg_142">Message already read</a><br><a href="#error_msg_146">Message expired</a><br><a href="#error_msg_148">Message not available</a><br><a href="#error_msg_149">Message too large for reading at once</a> |
| 403 | <a href="#error_msg_180">No permission to read message</a> |
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |
