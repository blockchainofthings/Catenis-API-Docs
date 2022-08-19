## Retrieve Asset Issuance History

Gets a list of asset issuance events for a given asset that took place within a specified time frame.

<aside class="notice">
Only the virtual device that issued the asset can retrieve the issuance history of that asset.
</aside>

> Sample request:

```http--raw
GET /api/0.12/assets/aQjlzShmrnEZeeYBZihc/issuance?startDate=20170101T000000Z&limit=200&skip=0 HTTP/1.1
X-BCoT-Timestamp: 20180417T182853Z
Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180417/ctn1_request, Signature=57d779fbb24593ba4eff574e0c87961a3c39561cb90d99546d5041cdd7e964a9
Host: sandbox.catenis.io
Connection: close
User-Agent: Paw/3.1.5 (Macintosh; OS X/10.13.4) GCDHTTPRequest
```

```shell
curl "https://sandbox.catenis.io/api/0.12/assets/aQjlzShmrnEZeeYBZihc/issuance?startDate=20170101T000000Z&limit=200&skip=0" \
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

    let asset_id = "aQjlzShmrnEZeeYBZihc";

    let result = ctn_client.retrieve_asset_issuance_history(
        asset_id,
        Some("2017-01-01T00:00:00Z".into()),
        None,
        Some(200),
        Some(0),
    )?;

    for idx in 0..result.issuance_events.len() {
        let issuance_event = &result.issuance_events[idx];

        println!("Issuance event #{}:", idx + 1);
        println!(" - asset amount: {}", issuance_event.amount);
        println!(" - device to which issued amount had been assigned: {:?}", issuance_event.holding_device);
        println!(" - date of issuance: {}", issuance_event.date);
    }

    if result.has_more {
        println!("Not all asset issuance events have been returned");
    }

    Ok(())
}
```

### Accessibility

Private

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

> Sample response (regular asset):

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

> Sample response (non-fungible asset):

```json
{
  "status": "success",
  "data": {
    "issuanceEvents": [
      {
        "nfTokenIds": [
          "tTwEvLSN9SnSr95FdYPq",
          "tmNvCvqLssu64tzZDqZa"
        ],
        "holdingDevices": [
          {
            "deviceId": "dnN3Ea43bhMTHtTvpytS",
            "name": "deviceB",
            "prodUniqueId": "XYZABC001"
          },
          {
            "deviceId": "dv3htgvK7hjnKx3617Re",
            "name": "Catenis device #1"
          }
        ],
        "date": "2022-06-14T15:28:51.629Z"
      },
      {
        "nfTokenIds": [
          "tQyJrga3ke65RR23iyr2",
          "tf2rbknDoo9wPsKBkskj",
          "t9yNnxYD6jNk4pogi4fe"
        ],
        "holdingDevices": [
          {
            "deviceId": "dnN3Ea43bhMTHtTvpytS",
            "name": "deviceB",
            "prodUniqueId": "XYZABC001"
          }
        ],
        "date": "2022-08-02T12:26:53.758Z"
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
| &nbsp;&nbsp;&nbsp;&nbsp;`amount` | Number | *(only returned for regular (fungible) assets)* The amount of the asset issued. |
| &nbsp;&nbsp;&nbsp;&nbsp;`nfTokenIds` | Array(String) | *(only returned for non-fungible assets)* List of the IDs of the non-fungible tokens of the asset that have been issued. |
| &nbsp;&nbsp;&nbsp;&nbsp;`holdingDevice` | Object | *(only returned for regular (fungible) assets)* The virtual device to which the issued amount was assigned. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`deviceId` | String | The device ID of the holding device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`name` | String | *(only returned if holding device has this data, and the virtual device issuing the request has the necessary permission right)* The name of the holding device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`prodUniqueId` | String | *(only returned if holding device has this data, and the virtual device issuing the request has the necessary permission right)* The product unique ID of the holding device. |
| &nbsp;&nbsp;&nbsp;&nbsp;`holdingDevices` | Array(Object) | *(only returned for non-fungible assets)* List of the virtual devices to which the issued non-fungible tokens were assigned. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`deviceId` | String | The device ID of the holding device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`name` | String | *(only returned if holding device has this data, and the virtual device issuing the request has the necessary permission right)* The name of the holding device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`prodUniqueId` | String | *(only returned if holding device has this data, and the virtual device issuing the request has the necessary permission right)* The product unique ID of the holding device. |
| &nbsp;&nbsp;&nbsp;&nbsp;`date` | String | ISO 8601 formatted date and time when the asset has been issued. |
| &nbsp;&nbsp;`hasMore` | Boolean | Indicates whether there are more asset issuance events that satisfy the search criteria yet to be returned. |

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_105">Invalid asset ID</a><br><a href="#error_msg_130">Invalid parameters: <i>&lt;param_list&gt;</i></a> |
| 403 | <a href="#error_msg_188">No permission to retrieve asset issuance history</a> |
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |
