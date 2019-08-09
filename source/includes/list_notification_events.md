## List Notification Events

Retrieves a list of all system defined notification events.

> Sample request:

```http--raw
GET /api/0.7/notification/events HTTP/1.1
X-BCoT-Timestamp: 20180219T160411Z
Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180219/ctn1_request, Signature=02e8f56a46e2ea8001f94fac04115749606deacd5eee6f553b6d69c5d45ce553
Host: sandbox.catenis.io
Connection: close
User-Agent: Paw/3.1.5 (Macintosh; OS X/10.13.3) GCDHTTPRequest
```

```shell
curl "https://sandbox.catenis.io/api/0.7/notification/events" \
     -H 'X-BCoT-Timestamp: 20180219T160346Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180219/ctn1_request, Signature=7b717edae1c2c60721e2f74d02feb286a2275f615c930d86f5ea9954214bdfaf'
```

```html--javascript
<script src="CatenisAPIClientJS.min.js"></script>

<script language="JavaScript">
var deviceId = 'dnN3Ea43bhMTHtTvpytS';

var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'sandbox'
});

ctnApiClient.listNotificationEvents(function (err, data) {
    if (err) {
        // Process error
    }
    else {
        // Process returned data
        Object.keys(data).forEach(function (eventName) {
            console.log('Event name:', eventName, '; event description:', data[eventName]);
        });
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

ctnApiClient.listNotificationEvents(function (err, data) {
    if (err) {
        // Process error
    }
    else {
        // Process returned data
        Object.keys(data).forEach(function (eventName) {
            console.log('Event name:', eventName, '; event description:', data[eventName]);
        });
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
    $data = $ctnApiClient->listNotificationEvents();

    // Process returned data
    forEach($data as $eventName => $description) {
        echo 'Event name: ' . $eventName . '; event description: ' . $description . PHP_EOL;
    }
}
catch (CatenisException $ex) {
    // Process exception
}
```

### Request

GET /notification/events

### Parameters

This request does not take any parameters.

> Sample response:

```json
{
  "status": "success",
  "data": {
    "new-msg-received": "A new message has been received",
    "sent-msg-read": "Previously sent message has been read by intended receiver (target device)"
  }
}
```

### Success response

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `status` | String | The value **`success`**, indicating that the request was successful. |
| `data` | Object | The actual data returned in response to the API request. In this particular case, it is an object that works as a dictionary where its properties are the notification event names, and their respective values the notification event description. |
| &nbsp;&nbsp;`<event_name>` | String | The description of the notification event whose name is this property's name. |

<aside class="notice">
The <code>&lt;event_name></code> term above represents one or more property of the returned <code>data</code> object whose name correspond to the name of one of the system defined notification events.
</aside>

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |
