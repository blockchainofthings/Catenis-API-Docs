## List Issued Assets

Retrieves a list of assets that have been issued by the device.

> Sample request:

```http--raw
GET /api/0.13/assets/issued?limit=200 HTTP/1.1
X-BCoT-Timestamp: 20180417T193403Z
Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180417/ctn1_request, Signature=ba41de81d939995b7cf76c03a4bc5861bf2176b7622348648c64fbb6f38dbc3a
Host: sandbox.catenis.io
Connection: close
User-Agent: Paw/3.1.5 (Macintosh; OS X/10.13.4) GCDHTTPRequest
```

```shell
curl "https://sandbox.catenis.io/api/0.13/assets/issued?limit=200" \
     -H 'X-BCoT-Timestamp: 20180417T193421Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180417/ctn1_request, Signature=eb1e37742272ef732dae3d85cd0d75b32731b6d85d20d501d7969d55ca998849'
```

```html--javascript
<script src="CatenisAPIClientJS.min.js"></script>

<script language="JavaScript">
var deviceId = 'dnN3Ea43bhMTHtTvpytS';

var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'sandbox'
});

ctnApiClient.listIssuedAssets(200, 0,
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            data.issuedAssets.forEach(function (issuedAsset, idx) {
                console.log('Issued asset #', idx + 1, ':');
                console.log('  - asset ID:', issuedAsset.assetId);
                console.log('  - total existent balance:', issuedAsset.totalExistentBalance);
            });

            if (data.hasMore) {
                console.log('Not all issued assets have been returned');
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

ctnApiClient.listIssuedAssets(200, 0,
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            data.issuedAssets.forEach(function (issuedAsset, idx) {
                console.log('Issued asset #', idx + 1, ':');
                console.log('  - asset ID:', issuedAsset.assetId);
                console.log('  - total existent balance:', issuedAsset.totalExistentBalance);
            });

            if (data.hasMore) {
                console.log('Not all issued assets have been returned');
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
    $data = $ctnApiClient->listIssuedAssets(200, 0);
    
    // Process returned data
    forEach($data->issuedAssets as $idx => $issuedAsset) {
        echo 'Issued asset #' . ($idx + 1) . ':' . PHP_EOL;
        echo '  - asset ID: ' . $issuedAsset->assetId . PHP_EOL;
        echo '  - total existent balance: ' . $issuedAsset->totalExistentBalance . PHP_EOL;
    }

    if ($data->hasMore) {
        echo 'Not all issued assets have been returned' . PHP_EOL;
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

    let result = ctn_client.list_issued_assets(
        Some(200),
        Some(0),
    )?;

    for idx in 0..result.issued_assets.len() {
        let issued_asset = &result.issued_assets[idx];

        println!("Issued asset #{}:", idx + 1);
        println!(" - asset ID: {}", issued_asset.asset_id);
        println!(" - total existent balance: {}", issued_asset.total_existent_balance);
    }

    if result.has_more {
        println!("Not all issued assets have been returned");
    }

    Ok(())
}
```

### Accessibility

Private

### Request

GET /assets/issued

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
    "issuedAssets": [
      {
        "assetId": "aQjlzShmrnEZeeYBZihc",
        "totalExistentBalance": 1650
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
| &nbsp;&nbsp;`issuedAssets` | Array(Object) | The list of issued asset entries returned.  |
| &nbsp;&nbsp;&nbsp;&nbsp;`assetId` | String | The ID of the asset. |
| &nbsp;&nbsp;&nbsp;&nbsp;`totalExistentBalance` | Number | The current total balance of that asset in existence. |
| &nbsp;&nbsp;`hasMore` | Boolean | Indicates whether there are more entries that have not been included in the returned list. |

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_130">Invalid parameters: <i>&lt;param_list&gt;</i></a> |
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |
