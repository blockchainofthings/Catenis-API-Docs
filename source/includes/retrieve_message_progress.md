## Retrieve Message Progress

Retrieves the current status of the asynchronous processing of a message.

<aside class="notice">
Alternatively, instead of calling this API method, one may choose to receive a <a href="#final-progress-of-message-processing-final-msg-progress">final-msg-progress</a> notification event.
</aside>

> Sample request:

```http--raw
GET /api/0.7/messages/hfHtyPCS68toB9FjA8rM/progress HTTP/1.1
X-BCoT-Timestamp: 20190318T212628Z
Authorization: CTN1-HMAC-SHA256 Credential=dL8zaQDcyNvxRW3FqsJd/20190318/ctn1_request, Signature=d98b79672098eeea5f261e102d213168f757c3234a3ee28a2192b5acd739e664
Host: sandbox.catenis.io
Connection: close
User-Agent: Paw/3.1.8 (Macintosh; OS X/10.14.3) GCDHTTPRequest
```

```shell
curl "https://sandbox.catenis.io/api/0.7/messages/hfHtyPCS68toB9FjA8rM/progress" \
     -H 'X-BCoT-Timestamp: 20190318T212739Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=dL8zaQDcyNvxRW3FqsJd/20190318/ctn1_request, Signature=3ee6e3c7fe58319e4b53a7342a38af2a923908bbe1da5864f5f800d7330abdc1'
```

```html--javascript
<script src="CatenisAPIClientJS.min.js"></script>

<script language="JavaScript">
var deviceId = 'dnN3Ea43bhMTHtTvpytS';

var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'sandbox'
});

var cachedMessageId = 'hfHtyPCS68toB9FjA8rM';

ctnApiClient.retrieveMessageProgress(cachedMessageId,
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            console.log('Number of bytes processed so far:', data.progress.bytesProcessed);
                
            if (data.progress.done) {
                if (data.progress.success) {
                    // Get result
                    console.log('Asynchronous processing result:', data.result);
                }
                else {
                    // Process error
                    console.error('Asynchronous processing error: [', data.progress.error.code, ' ] -', data.progress.error.message);
                }
            }
            else {
                // Asynchronous processing not done yet. Continue pooling
            }
        }
});</script>
```

```javascript--node
var CtnApiClient = require('catenis-api-client');

var deviceId = 'dnN3Ea43bhMTHtTvpytS';

var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'sandbox'
});

var cachedMessageId = 'hfHtyPCS68toB9FjA8rM';

ctnApiClient.retrieveMessageProgress(cachedMessageId,
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            console.log('Number of bytes processed so far:', data.progress.bytesProcessed);
                
            if (data.progress.done) {
                if (data.progress.success) {
                    // Get result
                    console.log('Asynchronous processing result:', data.result);
                }
                else {
                    // Process error
                    console.error('Asynchronous processing error: [', data.progress.error.code, ' ] -', data.progress.error.message);
                }
            }
            else {
                // Asynchronous processing not done yet. Continue pooling
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

$cachedMessageId = 'hfHtyPCS68toB9FjA8rM';

try {
    $data = $ctnApiClient->retrieveMessageProgress($cachedMessageId);

    // Process returned data
    echo 'Number of bytes processed so far: ' . $data->progress->bytesProcessed . PHP_EOL;

    if ($data->progress->done) {
        if ($data->progress->success) {
            // Get result
            echo 'Asynchronous processing result: ' . $data->result . PHP_EOL;
        }
        else {
            // Process error
            echo 'Asynchronous processing error: [' . $data->progress->error->code . '] - '
                . $data->progress->error->message . PHP_EOL;
        }
    } else {
        // Asynchronous processing not done yet. Continue pooling
    }
} catch (\Catenis\Exception\CatenisException $ex) {
    // Process exception
}
```

### Request

GET /messages/`:messageId`/progress

### Parameters

<!-- Note: we are not using the native markdown list feature for the second level items because the generated
        HTML has no space to the following first level item -->
- URL parameters:
<ul class="parameterList">
  <li>`ephemeralMessageId`: ID of ephemeral message — either a provisional or a cached message — for which to return processing progress.</li>
</ul>

<aside class="notice">
<b>Provisional message IDs</b> are returned by the <a href="#log-message">Log Message</a> and <a href="#send-message">Send Message</a>
 API methods when processing the message asynchronously. <b>Cached message IDs</b>, on the other hand, are returned by the <a href="#read-message">Read Message</a>
 API method when processing the message asynchronously.
</aside>

> Sample response:

```json
{
  "status": "success",
  "data": {
    "action": "read",
    "progress": {
      "bytesProcessed": 28,
      "done": true,
      "success": true,
      "finishDate": "2019-03-13T14:09:10.121Z"
    },
    "result": {
      "messageId": "mt7ZYbBYpM3zcgAf3H8X",
      "continuationToken": "kjXP2CZaSdkTKCi2jDi2"
    }
  }
}
```

### Success response

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `status` | String | The value **`success`**, indicating that the request was successful. |
| `data` | Object | The actual data returned in response to the API request. |
| &nbsp;&nbsp;`action` | String | The action that was to be performed on the message. One of: `log`, `send`, or `read`. |
| &nbsp;&nbsp;`progress` | Object | Current processing status. |
| &nbsp;&nbsp;&nbsp;&nbsp;`bytesProcessed` | Number | Total number of bytes of message that had already been processed. |
| &nbsp;&nbsp;&nbsp;&nbsp;`done` | Boolean | Indicates whether processing has been finished. |
| &nbsp;&nbsp;&nbsp;&nbsp;`success` | Boolean | *(only returned if processing has already been finished)* Indicates whether message has been successfully processed. |
| &nbsp;&nbsp;&nbsp;&nbsp;`error` | Object | *(only returned if processing finished with error)* Error information. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`code` | Number | Numeric code — equivalent to an HTML status code — of the error that took place while processing the message. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`message` | String | Text describing the error that took place while processing the message. |
| &nbsp;&nbsp;&nbsp;&nbsp;`finishDate` | String | *(only returned if processing has already been finished)* <a href="https://en.wikipedia.org/wiki/ISO_8601" target="_blank">ISO 8601</a> formatted date and time when processing was finalized. |
| &nbsp;&nbsp;`result` | Object | *(only returned if processing finished successfully)* Result of processing. |
| &nbsp;&nbsp;&nbsp;&nbsp;`messageId` | String | ID of the Catenis message. When logging or sending — `action` equals to __`log`__ or __`send`__—, it is the ID of the resulting message. When reading — `action` equals to __`read`__—, it references the message being read. |
| &nbsp;&nbsp;&nbsp;&nbsp;`continuationToken` | String | *(only returned if reading message — `action` equals to __`read`__)* The token that should be used to complete the read of the message. |

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_80">Device is deleted</a><br><a href="#error_msg_90">Device is not active</a><br><a href="#error_msg_127">Invalid or expired ephemeral message</a><br><a href="#error_msg_207">Progress not available</a> |
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |
