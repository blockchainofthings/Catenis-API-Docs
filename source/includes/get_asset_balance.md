## Get Asset Balance

Gets the current balance of a given asset held by the device.

> Sample request:

```http--raw
GET /api/0.6/assets/aQjlzShmrnEZeeYBZihc/balance HTTP/1.1
X-BCoT-Timestamp: 20180417T165555Z
Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180417/ctn1_request, Signature=0531b1ce00b03de1ca707db48fd2474328e21fdb6930b8661a4608e8fe735b84
Host: beta.catenis.io
Connection: close
User-Agent: Paw/3.1.5 (Macintosh; OS X/10.13.4) GCDHTTPRequest
```

```shell
curl "https://beta.catenis.io/api/0.6/assets/aQjlzShmrnEZeeYBZihc/balance" \
     -H 'X-BCoT-Timestamp: 20180417T165613Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180417/ctn1_request, Signature=2f85718595bc2633e13b21315babeb00b60327b317e3c56dab3865f2aa29115c'
```

```html--javascript
<script src="CatenisAPIClientJS.min.js"></script>

<script language="JavaScript">
var deviceId = 'dnN3Ea43bhMTHtTvpytS';

var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'beta'
});

var assetId = 'aQjlzShmrnEZeeYBZihc';

ctnApiClient.getAssetBalance(assetId,
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            console.log('Current asset balance:', data.balance.total);
            console.log('Amount not yet confirmed:', data.balance.unconfirmed);
        }
});
</script>
```

```javascript--node
var CtnApiClient = require('catenis-api-client');

var deviceId = 'dnN3Ea43bhMTHtTvpytS';

var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'beta'
});

var assetId = 'aQjlzShmrnEZeeYBZihc';

ctnApiClient.getAssetBalance(assetId,
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            console.log('Current asset balance:', data.balance.total);
            console.log('Amount not yet confirmed:', data.balance.unconfirmed);
        }
});
```

```cpp
#include "CatenisApiClient.h"

std::string device_id("dnN3Ea43bhMTHtTvpytS");

ctn::CtnApiClient ctnApiClient(device_id, api_access_secret, "catenis.io", "", "beta");

// TODO: complete source code

try {
    // TODO: complete source code
}
catch (ctn::CatenisAPIException &errObject) {
    std::cerr << errObject.getErrorDescription() << std::endl;
}
```

### Request

GET /assets/`:assetId`/balance

### Parameters

<!-- Note: we are not using the native markdown list feature for the second level items because the generated
        HTML has no space to the following first level item -->
- URL parameters:
<ul class="parameterList">
  <li>`assetId`: The ID of the asset to get balance.</li>
</ul>

> Sample response:

```json
{
  "status": "success",
  "data": {
    "total": 1145.75,
    "unconfirmed": 0
  }
}
```

### Success response

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `status` | String | The value **`success`**, indicating that the request was successful. |
| `data` | Object | The actual data returned in response to the API request. |
| &nbsp;&nbsp;`total` | Number | The current balance of the asset held by the device that issues the request. |
| &nbsp;&nbsp;`unconfirmed` | Number | The amount from the balance that is not yet confirmed. |

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_80">Device is deleted<br><a href="#error_msg_90">Device is not active<br><a href="#error_msg_105">Invalid asset ID<br><a href="#error_msg_130">Invalid parameters |
| 500 | <a href="#error_msg_100">Internal server error |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time |
