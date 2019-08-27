## Retrieve Asset Issuance History

Gets a list of asset issuance events for a given asset that took place within a specified time frame.

<aside class="notice">
Only the virtual device that issued the asset can retrieve the issuance history of that asset.
</aside>

> Sample request:

```http--raw
GET /api/0.8/assets/aQjlzShmrnEZeeYBZihc/issuance?startDate=20170101T000000Z&limit=200&skip=0 HTTP/1.1
X-BCoT-Timestamp: 20180417T182853Z
Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180417/ctn1_request, Signature=57d779fbb24593ba4eff574e0c87961a3c39561cb90d99546d5041cdd7e964a9
Host: sandbox.catenis.io
Connection: close
User-Agent: Paw/3.1.5 (Macintosh; OS X/10.13.4) GCDHTTPRequest
```

```shell
curl "https://sandbox.catenis.io/api/0.8/assets/aQjlzShmrnEZeeYBZihc/issuance?startDate=20170101T000000Z&limit=200&skip=0" \
     -H 'X-BCoT-Timestamp: 20180417T182836Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180417/ctn1_request, Signature=4990e4df2d0d73d01cd251dab65b6f4d2f702b43eb517d88c5ff3038d0bbd1f6'
```

```html--javascript
<script src="CatenisAPIClientJS.min.js"></script>

<script language="JavaScript">
var deviceId = 'dnN3Ea43bhMTHtTvpytS';

var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'sandbox'
});

var assetId = 'aQjlzShmrnEZeeYBZihc';

ctnApiClient.retrieveAssetIssuanceHistory(assetId, '20170101T000000Z', null, 200, 0,
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            data.issuanceEvents.forEach(function (issuanceEvent, idx) {
                console.log('Issuance event #', idx + 1, ':');
                console.log('  - issued amount:', issuanceEvent.amount);
                console.log('  - device to which issued amount had been assigned:', issuanceEvent.holdingDevice);
                console.log('  - date of issuance:', issuanceEvent.date);
            });

            if (data.hasMore) {
                console.log('Not all asset issuance events have been returned');
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

ctnApiClient.retrieveAssetIssuanceHistory(assetId, '20170101T000000Z', null, 200, 0,
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            data.issuanceEvents.forEach(function (issuanceEvent, idx) {
                console.log('Issuance event #', idx + 1, ':');
                console.log('  - issued amount:', issuanceEvent.amount);
                console.log('  - device to which issued amount had been assigned:', issuanceEvent.holdingDevice);
                console.log('  - date of issuance:', issuanceEvent.date);
            });

            if (data.hasMore) {
                console.log('Not all asset issuance events have been returned');
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
    $data = $ctnApiClient->retrieveAssetIssuanceHistory($assetId, '20170101T000000Z', null, 200, 0);
    
    // Process returned data
    forEach($data->issuanceEvents as $idx => $issuanceEvent) {
        echo 'Issuance event #', ($idx + 1) . ':' . PHP_EOL;
        echo '  - issued amount: ' . $issuanceEvent->amount . PHP_EOL;
        echo '  - device to which issued amount had been assigned: ' . print_r($issuanceEvent->holdingDevice, true);
        echo '  - date of issuance: ' . $issuanceEvent->date . PHP_EOL;
    }

    if ($data->hasMore) {
        echo 'Not all asset issuance events have been returned' . PHP_EOL;
    }
}
catch (CatenisException $ex) {
    // Process exception
}
```

### Request

GET /assets/`:assetId`/issuance

### Parameters

<!-- Note: we are not using the native markdown list feature for the second level items because the generated
        HTML has no space to the following first level item -->
- URL parameters:
<ul class="parameterList">
  <li>`assetId`: The ID of the asset to retrieve the issuance history.</li>
</ul>

<!-- Note: we are not using the native markdown list feature for the second level items because the generated
        HTML has no space to the following first level item -->
- Query string parameters:
<ul class="parameterList">
  <li>`startDate`: *(optional)* <a href="https://en.wikipedia.org/wiki/ISO_8601" target="_blank">ISO 8601</a> formatted date and time specifying the inclusive lower bound of the time frame within which amounts of the asset have been issued.</li>
  <li>`endDate`: *(optional)* ISO 8601 formatted date and time specifying the inclusive upper bound of the time frame within which amounts of the asset have been issued.</li>
  <li>`limit`: *(optional, default: __`500`__)* Maximum number of asset issuance events that should be returned. Must be a positive integer value not greater than 500.</li>
  <li>`skip`: *(optional, default: __`0`__)* Number of asset issuance events that should be skipped (from beginning of list of matching events) and not returned. Must be a non-negative (includes zero) integer value.</li>
</ul>

> Sample response:

```json
{
  "status": "success",
  "data": {
    "issuanceEvents": [
      {
        "amount": 1200,
        "holdingDevice": {
          "deviceId": "dnN3Ea43bhMTHtTvpytS",
          "name": "deviceB",
          "prodUniqueId": "XYZABC001"
        },
        "date": "2018-03-27T21:43:15.050Z"
      },
      {
        "amount": 450,
        "holdingDevice": {
          "deviceId": "dv3htgvK7hjnKx3617Re",
          "name": "Catenis device #1"
        },
        "date": "2018-03-28T12:20:31.738Z"
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
| &nbsp;&nbsp;`issuanceEvents` | Array(Object) | The list of asset issuance events returned. The events are sorted in ascending order in regard to the returned `date` field.  |
| &nbsp;&nbsp;&nbsp;&nbsp;`amount` | Number | The amount of the asset issued. |
| &nbsp;&nbsp;&nbsp;&nbsp;`holdingDevice` | Object | The virtual device to which the issued amount was assigned. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`deviceId` | String | The device ID of the holding device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`name` | String | *(only returned if holding device has this data, and the virtual device issuing the request has the necessary permission right)* The name of the holding device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`prodUniqueId` | String | *(only returned if holding device has this data, and the virtual device issuing the request has the necessary permission right)* The product unique ID of the holding device. |
| &nbsp;&nbsp;`hasMore` | Boolean | Indicates whether there are more asset issuance events that satisfy the search criteria yet to be returned. |

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_80">Device is deleted</a><br><a href="#error_msg_90">Device is not active</a><br><a href="#error_msg_105">Invalid asset ID</a><br><a href="#error_msg_130">Invalid parameters</a> |
| 403 | <a href="#error_msg_188">No permission to retrieve asset issuance history</a> |
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |
