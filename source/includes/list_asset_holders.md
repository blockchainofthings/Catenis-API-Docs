## List Asset Holders

Retrieves a list of virtual devices that currently hold any amount of a given asset.

<aside class="notice">
Only the virtual device that issued the asset can list the holders of that asset.
</aside>

> Sample request:

```http--raw
GET /api/0.6/assets/aQjlzShmrnEZeeYBZihc/holders?limit=200 HTTP/1.1
X-BCoT-Timestamp: 20180417T193524Z
Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180417/ctn1_request, Signature=2a5d3aa86d303ed552b408356ae30174f428fab8c377c1f203812ad0b036cfa4
Host: sandbox.catenis.io
Connection: close
User-Agent: Paw/3.1.5 (Macintosh; OS X/10.13.4) GCDHTTPRequest
```

```shell
curl "https://sandbox.catenis.io/api/0.6/assets/aQjlzShmrnEZeeYBZihc/holders?limit=200" \
     -H 'X-BCoT-Timestamp: 20180417T193542Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180417/ctn1_request, Signature=57ba39226a41800f13f7c985aa6f1ccca98ce6817c15680090e9e18a0ade7e0b'
```

```html--javascript
<script src="CatenisAPIClientJS.min.js"></script>

<script language="JavaScript">
var deviceId = 'dnN3Ea43bhMTHtTvpytS';

var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'sandbox'
});

var assetId = 'aQjlzShmrnEZeeYBZihc';

ctnApiClient.listAssetHolders(assetId, 200, 0,
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            data.assetHolders.forEach(function (assetHolder, idx) {
                console.log('Asset holder #', idx + 1, ':');
                console.log('  - device holding an amount of the asset:', assetHolder.holder);
                console.log('  - amount of asset currently held by device:', assetHolder.balance.total);
                console.log('  - amount not yet confirmed:', assetHolder.balance.unconfirmed);
            });

            if (data.hasMore) {
                console.log('Not all asset holders have been returned');
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

var assetId = 'aQjlzShmrnEZeeYBZihc';

ctnApiClient.listAssetHolders(assetId, 200, 0,
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            data.assetHolders.forEach(function (assetHolder, idx) {
                console.log('Asset holder #', idx + 1, ':');
                console.log('  - device holding an amount of the asset:', assetHolder.holder);
                console.log('  - amount of asset currently held by device:', assetHolder.balance.total);
                console.log('  - amount not yet confirmed:', assetHolder.balance.unconfirmed);
            });

            if (data.hasMore) {
                console.log('Not all asset holders have been returned');
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

$assetId = 'aQjlzShmrnEZeeYBZihc';

try {
    $data = $ctnApiClient->listAssetHolders($assetId, 200, 0);
    
    // Process returned data
    forEach($data->assetHolders as $idx => $assetHolder) {
        echo 'Asset holder #' . ($idx + 1) . ':' . PHP_EOL;
        echo '  - device holding an amount of the asset: ' . print_r($assetHolder->holder, true);
        echo '  - amount of asset currently held by device: ' . $assetHolder->balance->total . PHP_EOL;
        echo '  - amount not yet confirmed: ' . $assetHolder->balance->unconfirmed . PHP_EOL;
    }

    if ($data->hasMore) {
        echo 'Not all asset holders have been returned' . PHP_EOL;
    }
}
catch (CatenisException $ex) {
    // Process exception
}
```

### Request

GET /assets/`:assetId`/holders

### Parameters

<!-- Note: we are not using the native markdown list feature for the second level items because the generated
        HTML has no space to the following first level item -->
- URL parameters:
<ul class="parameterList">
  <li>`assetId`: The ID of the asset to get holders.</li>
</ul>

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
    "assetHolders": [
      {
        "holder": {
          "deviceId": "dnN3Ea43bhMTHtTvpytS",
          "name": "deviceB",
          "prodUniqueId": "XYZABC001"
        },
        "balance": {
          "total": 1145.75,
          "unconfirmed": 0
        }
      },
      {
        "holder": {
          "deviceId": "dv3htgvK7hjnKx3617Re",
          "name": "Catenis device #1"
        },
        "balance": {
          "total": 504.25,
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
| &nbsp;&nbsp;`assetHolders` | Array(Object) | The list of asset holder entries returned.  |
| &nbsp;&nbsp;&nbsp;&nbsp;`holder` | Object | The virtual device that holds an amount of the asset — the *holding device*. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`deviceId` | String | The device ID of the holding device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`name` | String | *(only returned if holding device has this data, and the virtual device issuing the request has the necessary permission right)* The name of the holding device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`prodUniqueId` | String | *(only returned if holding device has this data, and the virtual device issuing the request has the necessary permission right)* The product unique ID of the holding device. |
| &nbsp;&nbsp;&nbsp;&nbsp;`balance` | Object | |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`total` | Number | The current balance of the asset held by this holding device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`unconfirmed` | Number | The amount from the balance that is not yet confirmed. |
| &nbsp;&nbsp;`hasMore` | Boolean | Indicates whether there are more entries that have not been included in the returned list. |

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_105">Invalid asset ID<br><a href="#error_msg_130">Invalid parameters |
| 403 | <a href="#error_msg_177">No permission to list asset holders |
| 500 | <a href="#error_msg_100">Internal server error |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time |
