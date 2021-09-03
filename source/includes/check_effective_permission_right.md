## Check Effective Permission Right

Checks the effective permission right that is currently applied to a given virtual device for a specified permission event.

The virtual device issuing the request acts as the controlling device. Thus the permission right returned is for the
pair composed of the permission event specified in the API request and the virtual device issuing the request.

<aside class="notice">
For more information about Catenis Enterprise permission rights, please refer to the <a href="#permission-rights">Permission rights</a> section above.
</aside>

> Sample request:

```http--raw
GET /api/0.6/permission/events/receive-msg/rights/dv3htgvK7hjnKx3617Re HTTP/1.1
X-BCoT-Timestamp: 20180219T104640Z
Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180219/ctn1_request, Signature=0753e60d70a02448386d6485ab6d7ca34b1faa851bf71b6219256ae5059dfa09
Host: sandbox.catenis.io
Connection: close
User-Agent: Paw/3.1.5 (Macintosh; OS X/10.13.3) GCDHTTPRequest
```

```shell
curl "https://sandbox.catenis.io/api/0.6/permission/events/receive-msg/rights/dv3htgvK7hjnKx3617Re" \
     -H 'X-BCoT-Timestamp: 20180219T104602Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180219/ctn1_request, Signature=521537ae60e0cc6099c459220702aad51d68c7c6d82328d6df3d3dc122de8683'
```

```html--javascript
<script src="CatenisAPIClientJS.min.js"></script>

<script language="JavaScript">
var deviceId = 'dnN3Ea43bhMTHtTvpytS';

var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'sandbox'
});

var checkDeviceId = 'dv3htgvK7hjnKx3617Re';

ctnApiClient.checkEffectivePermissionRight('receive_msg', checkDeviceId, false, function (err, data) {
    if (err) {
        // Process error
    }
    else {
        // Process returned data
        var deviceId = Object.keys(data)[0];

        console.log('Effective right for device', deviceId, ':', data[deviceId]);
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

var checkDeviceId = 'dv3htgvK7hjnKx3617Re';

ctnApiClient.checkEffectivePermissionRight('receive_msg', checkDeviceId, false, function (err, data) {
    if (err) {
        // Process error
    }
    else {
        // Process returned data
        var deviceId = Object.keys(data)[0];

        console.log('Effective right for device', deviceId, ':', data[deviceId]);
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

$checkDeviceId = 'dv3htgvK7hjnKx3617Re';

try {
    $data = $ctnApiClient->checkEffectivePermissionRight('receive-msg', $checkDeviceId);

    // Process returned data
    $deviceId = array_keys(get_object_vars($data))[0];
    echo 'Effective right for device ' . $deviceId . ': ' . $data->$deviceId . PHP_EOL;
}
catch (CatenisException $ex) {
    // Process exception
}
```

### Request

GET /permission/events/`:eventName`/rights/`:deviceId`

### Parameters

<!-- Note: we are not using the native markdown list feature for the second level items because the generated
        HTML has no space to the following first level item -->
- URL parameters:
<ul class="parameterList">
  <li>`eventName`: The name of the permission event the permission right set for which should be retrieved.</li>
  <li>`deviceId`: The ID of the virtual device the permission right applied to which should be retrieved. Should be a device ID unless `isProdUniqueId` is set. The special value `self` can be used in place of the device ID of the virtual device issuing the request.</li>
</ul>

- Query string parameters:
<ul class="parameterList">
  <li>`isProdUniqueId`: *(optional, default: __`false`__)* Indicates whether the supplied ID is a product unique ID.</li>
</ul>

> Sample response:

```json
{
  "status": "success",
  "data": {
    "dv3htgvK7hjnKx3617Re": "allow"
  }
}
```

### Success response

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `status` | String | The value **`success`**, indicating that the request was successful. |
| `data` | Object | The actual data returned in response to the API request. In this particular case, it is an object that works as a dictionary where its single property is the device ID of the device for which the effective permission right is being checked, and its value is the permission right itself. |
| &nbsp;&nbsp;`<check_device_ID>` | String | The permission right that is currently in effective for the virtual device the device ID of which is this property's name. |

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_110">Invalid device<br><a href="#error_msg_130">Invalid parameters |
| 500 | <a href="#error_msg_100">Internal server error |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time |
