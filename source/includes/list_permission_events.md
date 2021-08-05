## List Permission Events

Retrieves a list of all system defined permission events.

> Sample request:

```http--raw
GET /api/0.11/permission/events HTTP/1.1
X-BCoT-Timestamp: 20180217T165054Z
Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180217/ctn1_request, Signature=138e50e836dec8c78d48a46bd04c03434ff994b2cf59d929dff324e958f2c096
Host: sandbox.catenis.io
Connection: close
User-Agent: Paw/3.1.5 (Macintosh; OS X/10.13.3) GCDHTTPRequest
```

```shell
curl "https://sandbox.catenis.io/api/0.11/permission/events" \
     -H 'X-BCoT-Timestamp: 20180217T170003Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180217/ctn1_request, Signature=d1f7556572b5f038563e997644a9682690c87fab6388ccbb16221ab4b72b3a56'
```

```html--javascript
<script src="CatenisAPIClientJS.min.js"></script>

<script language="JavaScript">
var deviceId = 'dnN3Ea43bhMTHtTvpytS';

var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'sandbox'
});

ctnApiClient.listPermissionEvents(function (err, data) {
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

ctnApiClient.listPermissionEvents(function (err, data) {
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
    $data = $ctnApiClient->listPermissionEvents();

    // Process returned data
    forEach($data as $eventName => $description) {
        echo 'Event name: ' . $eventName . '; event description: ' . $description . PHP_EOL;
    }
}
catch (CatenisException $ex) {
    // Process exception
}
```

```rust
use catenis_api_client::{
    CatenisClient, ClientOptions, Environment, Result,
};

fn main() -> Result<()> {
    let device_credentials = (
        "dnN3Ea43bhMTHtTvpytS",
        concat!(
        "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f",
        "202122232425262728292a2b2c2d2e2f303132333435363738393a3b3c3d3e3f",
        ),
    ).into();

    let mut ctn_client = CatenisClient::new_with_options(
        Some(device_credentials),
        &[
            ClientOptions::Environment(Environment::Sandbox),
        ],
    )?;

    let result = ctn_client.list_permission_events()?;

    for (event, description) in result {
        println!("Event name: {}; event description: {}", event.to_string(), description);
    }

    Ok(())
}
```

### Accessibility

Private

### Request

GET /permission/events

### Parameters

This request does not take any parameters.

> Sample response:

```json
{
  "status": "success",
  "data": {
    "receive-notify-new-msg": "Receive notification of new message from a device",
    "receive-notify-msg-read": "Receive notification of message read by a device",
    "send-read-msg-confirm": "Send read message confirmation to a device",
    "receive-msg": "Receive message from a device",
    "disclose-main-props": "Disclose device's main properties (name, product unique ID) to a device",
    "disclose-identity-info": "Disclose device's basic identification information to a device"
  }
}
```

### Success response

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `status` | String | The value **`success`**, indicating that the request was successful. |
| `data` | Object | The actual data returned in response to the API request. In this particular case, it is an object that works as a dictionary where its properties are the permission event names, and their respective values the permission event description. |
| &nbsp;&nbsp;`<event_name>` | String | The description of the permission event whose name is this property's name. |

<aside class="notice">
The <code>&lt;event_name></code> term above represents one or more property of the returned <code>data</code> object whose name correspond to the name of one of the system defined permission events.
</aside>

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |
