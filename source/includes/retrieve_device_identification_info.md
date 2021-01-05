## Retrieve Device Identification Info

Gets the identification information of a given virtual device.

<aside class="success">
The information returned by this API method might help when setting permission rights at upper levels like Catenis node and client.
</aside>

<aside class="warning">
The virtual device issuing the request must have permission right to retrieve identification information for the specified device, otherwise a <a href="#error_msg_190">[403] - No permission to retrieve info</a> error shall be returned.
</aside>

> Sample request:

```http--raw
GET /api/0.10/devices/dv3htgvK7hjnKx3617Re HTTP/1.1
X-BCoT-Timestamp: 20180219T133757Z
Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180219/ctn1_request, Signature=ff2a8f3d8dc232d60208dc28f668351234ed25ead274e820ac081a480a275012
Host: sandbox.catenis.io
Connection: close
User-Agent: Paw/3.1.5 (Macintosh; OS X/10.13.3) GCDHTTPRequest
```

```shell
curl "https://sandbox.catenis.io/api/0.10/devices/dv3htgvK7hjnKx3617Re" \
     -H 'X-BCoT-Timestamp: 20180219T133846Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180219/ctn1_request, Signature=74b0618fe8fe40278b3325cccdac350bed538a5faac86689c3d07e3f1df085f0'
```

```html--javascript
<script src="CatenisAPIClientJS.min.js"></script>

<script language="JavaScript">
var deviceId = 'dnN3Ea43bhMTHtTvpytS';

var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'sandbox'
});

var checkDeviceId = 'dv3htgvK7hjnKx3617Re';

ctnApiClient.retrieveDeviceIdentificationInfo(checkDeviceId, false, function (err, data) {
    if (err) {
        // Process error
    }
    else {
        // Process returned data
        console.log('Device\'s Catenis node ID info:', data.catenisNode);
        console.log('Device\'s client ID info:', data.client);
        console.log('Device\'s own ID info:', data.device);
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

var checkDeviceId = 'dv3htgvK7hjnKx3617Re';

ctnApiClient.retrieveDeviceIdentificationInfo(checkDeviceId, false, function (err, data) {
    if (err) {
        // Process error
    }
    else {
        // Process returned data
        console.log('Device\'s Catenis node ID info:', data.catenisNode);
        console.log('Device\'s client ID info:', data.client);
        console.log('Device\'s own ID info:', data.device);
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

$checkDeviceId = 'dv3htgvK7hjnKx3617Re';

try {
    $data = $ctnApiClient->retrieveDeviceIdentificationInfo($checkDeviceId);
    
    // Process returned data
    echo 'Device\'s Catenis node ID info:' . print_r($data->catenisNode, true);
    echo 'Device\'s client ID info:' . print_r($data->client, true);
    echo 'Device\'s own ID info:' . print_r($data->device, true);
}
catch (CatenisException $ex) {
    // Process exception
}
```

```rust
use catenis_api_client::{
    CatenisClient, ClientOptions, Environment, Result,
    api::*,
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

    let check_device = DeviceId {
        id: String::from("dv3htgvK7hjnKx3617Re"),
        is_prod_unique_id: None,
    };

    let result = ctn_client.retrieve_device_identification_info(
        check_device,
    )?;

    println!("Device's Catenis node ID info: {:?}", result.catenis_node);
    println!("Device's client ID info: {:?}", result.client);
    println!("Device's own ID info: {:?}", result.device);

    Ok(())
}
```

### Accessibility

Private

### Request

GET /devices/`:deviceId`

### Parameters

<!-- Note: we are not using the native markdown list feature for the second level items because the generated
        HTML has no space to the following first level item -->
- URL parameters:
<ul class="parameterList">
  <li>`deviceId`: The ID of the virtual device the identification info of which should be retrieved. Should be a device ID unless `isProdUniqueId` is set. The special value `self` can be used in place of the device ID of the virtual device issuing the request.</li>
</ul>

- Query string parameters:
<ul class="parameterList">
  <li>`isProdUniqueId`: *(optional, default: __`false`__)* Indicates whether the supplied ID is a product unique ID.</li>
</ul>

> Sample response:

```json
{
  "status": "success",
  "data": {
    "catenisNode": {
      "ctnNodeIndex": 0,
      "name": "Catenis Hub",
      "description": "Central Catenis node used to house clients that access the system through the Internet"
    },
    "client": {
      "clientId": "cjNhuvGMUYoepFcRZadP",
      "name": "My test client"
    },
    "device": {
      "deviceId": "dv3htgvK7hjnKx3617Re",
      "name": "Catenis device #1"
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
| &nbsp;&nbsp;`catenisNode` | Object | Information about the Catenis node where the client to which the specified virtual device belongs is defined. |
| &nbsp;&nbsp;&nbsp;&nbsp;`ctnNodeIndex` | Number | The index of the Catenis node. |
| &nbsp;&nbsp;&nbsp;&nbsp;`name` | String | *(only returned if Catenis node has this data)* The name of the Catenis node. |
| &nbsp;&nbsp;&nbsp;&nbsp;`description` | String | *(only returned if Catenis node has this data)* A short description about the Catenis node. |
| &nbsp;&nbsp;`client` | Object | Information about the client to which the specified virtual device belongs. |
| &nbsp;&nbsp;&nbsp;&nbsp;`clientId` | String | The client ID of the client. |
| &nbsp;&nbsp;&nbsp;&nbsp;`name` | String | *(only returned if client has this data)* The name of the client. |
| &nbsp;&nbsp;`device` | Object | Information about the specified virtual device itself. |
| &nbsp;&nbsp;&nbsp;&nbsp;`deviceId` | String | The device ID of the virtual device. |
| &nbsp;&nbsp;&nbsp;&nbsp;`name` | String | *(only returned if virtual device has this data)* The name of the virtual device. |
| &nbsp;&nbsp;&nbsp;&nbsp;`prodUniqueId` | String | *(only returned if virtual device has this data)* The product unique ID of the virtual device. |

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_80">Device is deleted</a><br><a href="#error_msg_90">Device is not active</a><br><a href="#error_msg_110">Invalid device</a><br><a href="#error_msg_130">Invalid parameters</a> |
| 403 | <a href="#error_msg_190">No permission to retrieve info</a> |
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |
