## List Owned Assets

Retrieves a list of assets that are currently held by the device.

> Sample request:

```http--raw
GET /api/0.11/assets/owned?limit=200 HTTP/1.1
X-BCoT-Timestamp: 20180417T193253Z
Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180417/ctn1_request, Signature=e1986d68550fe45536e407ec0eba3d0104579106f3486b9aec652ac0f78add43
Host: sandbox.catenis.io
Connection: close
User-Agent: Paw/3.1.5 (Macintosh; OS X/10.13.4) GCDHTTPRequest
```

```shell
curl "https://sandbox.catenis.io/api/0.11/assets/owned?limit=200" \
     -H 'X-BCoT-Timestamp: 20180417T193325Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180417/ctn1_request, Signature=2c6c8a066e7e983ad059854a3209ae7cfd024f1be504d51b5939fc3780dce8ae'
```

```html--javascript
<script src="CatenisAPIClientJS.min.js"></script>

<script language="JavaScript">
var deviceId = 'dnN3Ea43bhMTHtTvpytS';

var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'sandbox'
});

ctnApiClient.listOwnedAssets(200, 0,
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            data.ownedAssets.forEach(function (ownedAsset, idx) {
                console.log('Owned asset #', idx + 1, ':');
                console.log('  - asset ID:', ownedAsset.assetId);
                console.log('  - current asset balance:', ownedAsset.balance.total);
                console.log('  - amount not yet confirmed:', ownedAsset.balance.unconfirmed);
            });

            if (data.hasMore) {
                console.log('Not all owned assets have been returned');
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

ctnApiClient.listOwnedAssets(200, 0,
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            data.ownedAssets.forEach(function (ownedAsset, idx) {
                console.log('Owned asset #', idx + 1, ':');
                console.log('  - asset ID:', ownedAsset.assetId);
                console.log('  - current asset balance:', ownedAsset.balance.total);
                console.log('  - amount not yet confirmed:', ownedAsset.balance.unconfirmed);
            });

            if (data.hasMore) {
                console.log('Not all owned assets have been returned');
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

try {
    $data = $ctnApiClient->listOwnedAssets(200, 0);
    
    // Process returned data
    foreach ($data->ownedAssets as $idx => $ownedAsset) {
        echo 'Owned asset #' . ($idx + 1) . ':' . PHP_EOL;
        echo '  - asset ID: ' . $ownedAsset->assetId . PHP_EOL;
        echo '  - current asset balance: ' . $ownedAsset->balance->total . PHP_EOL;
        echo '  - amount not yet confirmed: ' . $ownedAsset->balance->unconfirmed . PHP_EOL;
    }

    if ($data->hasMore) {
        echo 'Not all owned assets have been returned' . PHP_EOL;
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

    let result = ctn_client.list_owned_assets(
        Some(200),
        Some(0),
    )?;

    for idx in 0..result.owned_assets.len() {
        let owned_asset = &result.owned_assets[idx];

        println!("Owned asset #{}:", idx + 1);
        println!(" - asset ID: {}", owned_asset.asset_id);
        println!(" - current asset balance: {}", owned_asset.balance.total);
        println!(" - amount not yet confirmed: {}", owned_asset.balance.unconfirmed);
    }

    if result.has_more {
        println!("Not all owned assets have been returned");
    }

    Ok(())
}
```

### Accessibility

Private

### Request

GET /assets/owned

### Parameters

<!-- Note: we are not using the native markdown list feature for the second level items because the generated
        HTML has no space to the following first level item -->
- Query string parameters:
<ul class="parameterList">
  <li>`limit`: *(optional, default: __`500`__)* Maximum number of list items that should be returned. Must be a positive integer value not greater than 500.</li>
  <li>`skip`: *(optional, default: __`0`__)* Number of list items that should be skipped (from beginning of list) and not returned. Must be a non-negative (includes zero) integer value.</li>
</ul>

> Sample response:

```json
{
  "status": "success",
  "data": {
    "ownedAssets": [
      {
        "assetId": "aQjlzShmrnEZeeYBZihc",
        "balance": {
          "total": 1145.75,
          "unconfirmed": 0
        }
      },
      {
        "assetId": "asEKmm6pdJomwmajghDy",
        "balance": {
          "total": 300000,
          "unconfirmed": 0
        }
      }
    ],
    "hasMore": false
  }
}
```

### Success response

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `status` | String | The value **`success`**, indicating that the request was successful. |
| `data` | Object | The actual data returned in response to the API request. |
| &nbsp;&nbsp;`ownedAssets` | Array(Object) | The list of owned asset entries returned.  |
| &nbsp;&nbsp;&nbsp;&nbsp;`assetId` | String | The ID of the asset. |
| &nbsp;&nbsp;&nbsp;&nbsp;`balance` | Object | |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`total` | Number | The current balance of that asset held by the device that issues the request. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`unconfirmed` | Number | The amount from the balance that is not yet confirmed. |
| &nbsp;&nbsp;`hasMore` | Boolean | Indicates whether there are more entries that have not been included in the returned list. |

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_130">Invalid parameters</a> |
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |
