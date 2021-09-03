## Issue Asset

Issues an amount of a new asset.

> Sample request:

```http--raw
POST /api/0.6/assets/issue/ HTTP/1.1
X-BCoT-Timestamp: 20180416T192026Z
Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180416/ctn1_request, Signature=ca4df849242d5b66c45d24c3dd2f8810f7063f4bf1df1555aa95d18405b7b5dd
Content-Type: application/json; charset=utf-8
Host: sandbox.catenis.io
Connection: close
User-Agent: Paw/3.1.5 (Macintosh; OS X/10.13.4) GCDHTTPRequest
Content-Length: 114

{"assetInfo":{"name":"XYZ001","description":"Testing asset #1","canReissue":true,"decimalPlaces":2},"amount":1200}
```

```shell
curl -X "POST" "https://sandbox.catenis.io/api/0.6/assets/issue/" \
     -H 'X-BCoT-Timestamp: 20180416T191501Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180416/ctn1_request, Signature=fd75cb18eb60c6afa8c5be53dadf1937b08c131d39b20fce19badb285bdb79cc' \
     -H 'Content-Type: application/json; charset=utf-8' \
     -d $'{
  "amount": 1200,
  "assetInfo": {
    "decimalPlaces": 2,
    "name": "XYZ001",
    "description": "Testing asset #1",
    "canReissue": true
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

ctnApiClient.issueAsset({
        name: 'XYZ001'
        description: 'Testing asset #1'
        canReissue: true
        decimalPlaces: 2
    }, 1200.00, null,
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            console.log('ID of newly issued asset:', data.assetId);
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

ctnApiClient.issueAsset({
        name: 'XYZ001'
        description: 'Testing asset #1'
        canReissue: true
        decimalPlaces: 2
    }, 1200.00, null,
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            console.log('ID of newly issued asset:', data.assetId);
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
    $data = $ctnApiClient->issueAsset([
        'name' => 'XYZ001',
        'description' => 'Testing asset #1',
        'canReissue' => true,
        'decimalPlaces' => 2
    ], 1200.00, null);

    // Process returned data
    echo 'ID of newly issued asset: ' . $data->assetId . PHP_EOL;
}
catch (CatenisException $ex) {
    // Process exception
}
```

### Request

POST /assets/issue

### Parameters

* Request body:

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `assetInfo` | Object | |
| &nbsp;&nbsp;`name` | String | The name of the asset to create. |
| &nbsp;&nbsp;`description` | String | *(optional)* A description of the asset to create. |
| &nbsp;&nbsp;`canReissue` | Boolean | Indicates whether more units of this asset can be issued at another time. |
| &nbsp;&nbsp;`decimalPlaces` | Number | The maximum number of decimal places that can be used to specify a fractional amount of this asset. Must be an integer value between 0 and 7. |
| `amount` | Number | The amount of asset to issue. |
| `holdingDevice` | Object | *(optional)* Virtual device for which the asset is issued and that shall hold the issued amount. |
| &nbsp;&nbsp;`id` | String | The ID of the holding device. Should be a device ID unless `isProdUniqueId` is set. |
| &nbsp;&nbsp;`isProdUniqueId` | Boolean | *(optional, default: __`false`__)* Indicates whether the supplied ID is a product unique ID. |

<aside class="notice">
If no description is specified — <code>description</code> parameter not defined —, the default description <b>"General
purpose Catenis smart asset"</b> is used for the asset.
</aside>

<aside class="notice">
If no holding device is specified — <code>holdingDevice</code> parameter not defined —, the device that issues the request
shall hold the issued asset amount.
</aside>

> Sample response:

```json
{
  "status": "success",
  "data": {
    "assetId": "aQjlzShmrnEZeeYBZihc"
  }
}
```

### Success response

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `status` | String | The value **`success`**, indicating that the request was successful. |
| `data` | Object | The actual data returned in response to the API request. |
| &nbsp;&nbsp;`assetId` | String | ID of the newlly issued asset. |

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_3">Amount to issue is too large<br><a href="#error_msg_115">Invalid holding device<br><a href="#error_msg_130">Invalid parameters<br><a href="#error_msg_155">Not enough credits to pay for issue asset service |
| 403 | <a href="#error_msg_175">No permission to assign issued asset to holding device |
| 500 | <a href="#error_msg_100">Internal server error |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time |
