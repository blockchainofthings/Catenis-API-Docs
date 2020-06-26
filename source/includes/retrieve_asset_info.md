## Retrieve Asset Info

Gets information about a given asset.

<aside class="notice">
Only the virtual device that issued the asset or a virtual device that currently holds an amount of the asset
can retrieve information about that asset.
</aside>

> Sample request:

```http--raw
GET /api/0.10/assets/aQjlzShmrnEZeeYBZihc HTTP/1.1
X-BCoT-Timestamp: 20180417T143840Z
Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180417/ctn1_request, Signature=d73532614d4e46fb4e9be59255a660b540a122322aa7800fcb8a0ea4c3a0e40a
Host: sandbox.catenis.io
Connection: close
User-Agent: Paw/3.1.5 (Macintosh; OS X/10.13.4) GCDHTTPRequest
```

```shell
curl "https://sandbox.catenis.io/api/0.10/assets/aQjlzShmrnEZeeYBZihc" \
     -H 'X-BCoT-Timestamp: 20180417T143900Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180417/ctn1_request, Signature=b6501dab96c6838807817c63d9e75f5020806c5a4a0075558a7ff3477b468a1a'
```

```html--javascript
<script src="CatenisAPIClientJS.min.js"></script>

<script language="JavaScript">
var deviceId = 'dnN3Ea43bhMTHtTvpytS';

var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'sandbox'
});

var assetId = 'aQjlzShmrnEZeeYBZihc';

ctnApiClient.retrieveAssetInfo(assetId,
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            console.log('Asset info:', data);
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

ctnApiClient.retrieveAssetInfo(assetId,
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            console.log('Asset info:', data);
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
    $data = $ctnApiClient->retrieveAssetInfo($assetId);

    // Process returned data
    echo 'Asset info:' . print_r($data, true);
}
catch (CatenisException $ex) {
    // Process exception
}
```

### Accessibility

Private

### Request

GET /assets/`:assetId`

### Parameters

<!-- Note: we are not using the native markdown list feature for the second level items because the generated
        HTML has no space to the following first level item -->
- URL parameters:
<ul class="parameterList">
  <li>`assetId`: The ID of the asset to retrieve information.</li>
</ul>

> Sample response:

```json
{
  "status": "success",
  "data": {
    "assetId": "aQjlzShmrnEZeeYBZihc",
    "name": "XYZ001",
    "description": "Testing asset #1",
    "canReissue": true,
    "decimalPlaces": 2,
    "issuer": {
      "deviceId": "dnN3Ea43bhMTHtTvpytS",
      "name": "deviceB",
      "prodUniqueId": "XYZABC001"
    },
    "totalExistentBalance": 1650
  }
}
```

### Success response

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `status` | String | The value **`success`**, indicating that the request was successful. |
| `data` | Object | The actual data returned in response to the API request. |
| &nbsp;&nbsp;`assetId` | String | The ID of the asset. |
| &nbsp;&nbsp;`name` | String | The name of the asset. |
| &nbsp;&nbsp;`description` | String | The description of the asset. |
| &nbsp;&nbsp;`canReissue` | Boolean | Indicates whether more units of this asset can be issued. |
| &nbsp;&nbsp;`decimalPlaces` | Number | The maximum number of decimal places that can be used to specify a fractional amount of this asset. |
| &nbsp;&nbsp;`issuer` | Object | The virtual device that originally issued this asset — the *issuing device*. |
| &nbsp;&nbsp;&nbsp;&nbsp;`deviceId` | String | The device ID of the issuing device. |
| &nbsp;&nbsp;&nbsp;&nbsp;`name` | String | *(only returned if issuing device has this data, and the virtual device issuing the request has the necessary permission right)* The name of the issuing device. |
| &nbsp;&nbsp;&nbsp;&nbsp;`prodUniqueId` | String | *(only returned if issuing device has this data, and the virtual device issuing the request has the necessary permission right)* The product unique ID of the issuing device. |
| &nbsp;&nbsp;`totalExistentBalance` | Number | The current total balance of the asset in existence. |

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_80">Device is deleted</a><br><a href="#error_msg_90">Device is not active</a><br><a href="#error_msg_105">Invalid asset ID</a><br><a href="#error_msg_130">Invalid parameters</a> |
| 403 | <a href="#error_msg_187">No permission to retrieve asset info</a> |
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |
