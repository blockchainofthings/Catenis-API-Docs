## Transfer Asset

Transfers an amount of an asset to a device.

> Sample request:

```http--raw
POST /api/0.13/assets/aQjlzShmrnEZeeYBZihc/transfer/ HTTP/1.1
X-BCoT-Timestamp: 20180417T132059Z
Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180417/ctn1_request, Signature=44e21bb5c895eceafce0910a27d0879e3be7dcff278c07a01597f09e6c0bb317
Content-Type: application/json; charset=utf-8
Host: sandbox.catenis.io
Connection: close
User-Agent: Paw/3.1.5 (Macintosh; OS X/10.13.4) GCDHTTPRequest
Content-Length: 64

{"amount":54.25,"receivingDevice":{"id":"dv3htgvK7hjnKx3617Re"}}
```

```shell
curl -X "POST" "https://sandbox.catenis.io/api/0.13/assets/aQjlzShmrnEZeeYBZihc/transfer/" \
     -H 'X-BCoT-Timestamp: 20180417T132027Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180417/ctn1_request, Signature=17bb4e914bd10aa517d15df1c985f0e9604a660a3a146219e16a1c94a8f7bf93' \
     -H 'Content-Type: application/json; charset=utf-8' \
     -d $'{
  "amount": 54.25,
  "receivingDevice": {
    "id": "dv3htgvK7hjnKx3617Re"
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

var assetId = 'aQjlzShmrnEZeeYBZihc';
var receivingDevice = {
    id: 'dv3htgvK7hjnKx3617Re'
};

ctnApiClient.transferAsset(assetId, 54.25, receivingDevice,
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            console.log('Remaining asset balance:', data.remainingBalance);
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

var assetId = 'aQjlzShmrnEZeeYBZihc';
var receivingDevice = {
    id: 'dv3htgvK7hjnKx3617Re'
};

ctnApiClient.transferAsset(assetId, 54.25, receivingDevice,
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            console.log('Remaining asset balance:', data.remainingBalance);
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

$assetId = 'aQjlzShmrnEZeeYBZihc';
$receivingDevice = [
   'id' => 'dv3htgvK7hjnKx3617Re'
];

try {
    $data = $ctnApiClient->transferAsset($assetId, 54.25, $receivingDevice);

    // Process returned data
    echo 'Remaining asset balance: ' . $data->remainingBalance . PHP_EOL;
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

    let asset_id = "aQjlzShmrnEZeeYBZihc";
    let receiving_device = DeviceId {
        id: String::from("dv3htgvK7hjnKx3617Re"),
        is_prod_unique_id: None,
    };

    let result = ctn_client.transfer_asset(
        asset_id,
        54.25,
        receiving_device,
    )?;

    println!("Remaining asset balance: {}", result.remaining_balance);

    Ok(())
}
```

### Accessibility

Private

### Request

POST /assets/`:assetId`/transfer

### Parameters

<!-- Note: we are not using the native markdown list feature for the second level items because the generated
        HTML has no space to the following first level item -->
- URL parameters:
<ul class="parameterList">
  <li>`assetId`: The ID of the asset to transfer an amount of it.</li>
</ul>

* Request body:

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `amount` | Number | The amount of asset to transfer. |
| `receivingDevice` | Object | Virtual device to which the asset is to be transferred. |
| &nbsp;&nbsp;`id` | String | The ID of the receiving device. Should be a device ID unless `isProdUniqueId` is set. |
| &nbsp;&nbsp;`isProdUniqueId` | Boolean | *(optional, default: __`false`__)* Indicates whether the supplied ID is a product unique ID. |

> Sample response:

```json
{
  "status": "success",
  "data": {
    "remainingBalance": 1145.75
  }
}
```

### Success response

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `status` | String | The value **`success`**, indicating that the request was successful. |
| `data` | Object | The actual data returned in response to the API request. |
| &nbsp;&nbsp;`remainingBalance` | Number | Total balance of the asset still held by the device that issued the request after the transfer. |

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_5">Amount to transfer is too large</a><br><a href="#error_msg_95">Insufficient balance to transfer asset</a><br><a href="#error_msg_105">Invalid asset ID</a><br><a href="#error_msg_130">Invalid parameters: <i>&lt;param_list&gt;</i></a><br><a href="#error_msg_135">Invalid receiving device</a><br><a href="#error_msg_240">Not a regular (fungible) asset</a><br><a href="#error_msg_172">Not enough credits to pay for transfer asset service</a> |
| 403 | <a href="#error_msg_205">No permission to transfer asset to receiving device</a> |
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |
