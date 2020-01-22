## Reissue Asset

Issues an additional amount of an existing asset.

<aside class="notice">
Only the virtual device that issued the initial amount of an asset can issue more units of that same asset, provided that
the asset had been created with the <code>canReissue</code> property set.
</aside>

> Sample request:

```http--raw
POST /api/0.9/assets/aQjlzShmrnEZeeYBZihc/issue/ HTTP/1.1
X-BCoT-Timestamp: 20180417T004201Z
Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180417/ctn1_request, Signature=71d61d674882e0bcfadcda962cf3393b300af6f0cbbc5fb211f1f33d5bbd8b3a
Content-Type: application/json; charset=utf-8
Host: sandbox.catenis.io
Connection: close
User-Agent: Paw/3.1.5 (Macintosh; OS X/10.13.4) GCDHTTPRequest
Content-Length: 60

{"amount":450,"holdingDevice":{"id":"dv3htgvK7hjnKx3617Re"}}
```

```shell
curl -X "POST" "https://sandbox.catenis.io/api/0.9/assets/aQjlzShmrnEZeeYBZihc/issue/" \
     -H 'X-BCoT-Timestamp: 20180417T004241Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180417/ctn1_request, Signature=bfed2a3062c5ee48623ff863d5bc5bedee85189303617be7b01b080c8d9ca950' \
     -H 'Content-Type: application/json; charset=utf-8' \
     -d $'{
  "amount": 450,
  "holdingDevice": {
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
var holdingDevice = {
    id: 'dv3htgvK7hjnKx3617Re'
};

ctnApiClient.reissueAsset(assetId, 450.00, holdingDevice,
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            console.log('Total existent asset balance (after issuance):', data.totalExistentBalance);
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
var holdingDevice = {
    id: 'dv3htgvK7hjnKx3617Re'
};

ctnApiClient.reissueAsset(assetId, 450.00, holdingDevice,
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            console.log('Total existent asset balance (after issuance):', data.totalExistentBalance);
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
$holdingDevice = [
   'id' => 'dv3htgvK7hjnKx3617Re'
];

try {
    $data = $ctnApiClient->reissueAsset($assetId, 450.00, $holdingDevice);

    // Process returned data
    echo 'Total existent asset balance (after issuance): ' . $data->totalExistentBalance . PHP_EOL;
}
catch (CatenisException $ex) {
    // Process exception
}
```

### Request

POST /assets/`:assetId`/issue

### Parameters

<!-- Note: we are not using the native markdown list feature for the second level items because the generated
        HTML has no space to the following first level item -->
- URL parameters:
<ul class="parameterList">
  <li>`assetId`: The ID of the asset to issue more units of it.</li>
</ul>

* Request body:

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `amount` | Number | The amount of asset to issue. |
| `holdingDevice` | Object | *(optional)* Virtual device for which the asset is issued and that shall hold the issued amount. |
| &nbsp;&nbsp;`id` | String | The ID of the holding device. Should be a device ID unless `isProdUniqueId` is set. |
| &nbsp;&nbsp;`isProdUniqueId` | Boolean | *(optional, default: __`false`__)* Indicates whether the supplied ID is a product unique ID. |

<aside class="notice">
If no holding device is specified — <code>holdingDevice</code> parameter not defined —, the device that issues the request
shall hold the issued asset amount.
</aside>

> Sample response:

```json
{
  "status": "success",
  "data": {
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
| &nbsp;&nbsp;`totalExistentBalance` | Number | Total balance of the asset in existence after specified amount has been issued. |

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_3">Amount to issue is too large</a><br><a href="#error_msg_7">Asset cannot be reissued</a><br><a href="#error_msg_80">Device is deleted</a><br><a href="#error_msg_90">Device is not active</a><br><a href="#error_msg_105">Invalid asset ID</a><br><a href="#error_msg_115">Invalid holding device</a><br><a href="#error_msg_130">Invalid parameters</a><br><a href="#error_msg_155">Not enough credits to pay for issue asset service</a> |
| 403 | <a href="#error_msg_185">No permission to reissue asset</a> |
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |
