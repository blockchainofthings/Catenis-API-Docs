## Check Non-Fungible Token Ownership

Verifies if a virtual device is the current owner of a single or multiple non-fungible tokens.

<aside class="warning">
If the virtual device issuing the request is <b>not</b> the issuer of the non-fungible token, it must have permission right to check the non-fungible token ownership status of the specified virtual device, otherwise a <a href="#error_msg_400">[403] - No permission to check non-fungible token ownership</a> error shall be returned.
</aside>

> Sample request:

```http--raw
POST /api/0.13/assets/non-fungible/tokens/ownership HTTP/1.1
X-BCoT-Timestamp: 20221122T124935Z
Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20221122/ctn1_request, Signature=d4746d5da8a92a0d0ef02aa95476ef75d8a9b8d78d47a254c1f92ea63faa556f
Content-Type: application/json; charset=utf-8
Host: localhost:3000
Connection: close
User-Agent: RapidAPI/4.0.0 (Macintosh; OS X/13.0.1) GCDHTTPRequest
Content-Length: 107

{"device":{"id":"drc3XdxNtzoucpw9xiRp"},"nonFungibleTokens":{"id":"aiqXDyh7hhukwxFhR69x","isAssetId":true}}
```

```shell
curl -X "POST" "http://localhost:3000/api/0.13/assets/non-fungible/tokens/ownership" \
     -H 'X-BCoT-Timestamp: 20221122T125108Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20221122/ctn1_request, Signature=0084cca819b1de1a9f034a203ebce8c16bc0077558cdd1bc9761a88e081762b7' \
     -H 'Content-Type: application/json; charset=utf-8' \
     -d $'{
  "device": {
    "id": "drc3XdxNtzoucpw9xiRp"
  },
  "nonFungibleTokens": {
    "id": "aiqXDyh7hhukwxFhR69x",
    "isAssetId": true
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

var checkDeviceId = 'drc3XdxNtzoucpw9xiRp';
var assetId = 'aiqXDyh7hhukwxFhR69x';

ctnApiClient.checkNonFungibleTokenOwnership({
        id: checkDeviceId,
        isProdUniqueId: false
    }, {
        id: assetId,
        isAssetId: true
    },
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            console.log('Non-fungible tokens owned:', data.tokensOwned);
            console.log('Non-fungible tokens not yet confirmed:', data.tokensUnconfirmed);
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

var checkDeviceId = 'drc3XdxNtzoucpw9xiRp';
var assetId = 'aiqXDyh7hhukwxFhR69x';

ctnApiClient.checkNonFungibleTokenOwnership({
        id: checkDeviceId,
        isProdUniqueId: false
    }, {
        id: assetId,
        isAssetId: true
    },
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            console.log('Non-fungible tokens owned:', data.tokensOwned);
            console.log('Non-fungible tokens not yet confirmed:', data.tokensUnconfirmed);
        }
});
```

```php
```

```rust
```

### Accessibility

Private

### Request

POST assets/non-fungible/tokens/ownership

### Parameters

* Request body:

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `device` | Object | The virtual device to check if it has ownership. |
| &nbsp;&nbsp;`id` | String | The ID of the device. Should be a device ID unless `isProdUniqueId` is set. |
| &nbsp;&nbsp;`isProdUniqueId` | Boolean | *(optional, default: __`false`__)* Indicates whether the supplied ID is a product unique ID. |
| `nonFungibleTokens` | Object | The non-fungible tokens to be verified. |
| &nbsp;&nbsp;`id` | String | Either the ID of the single non-fungible token to be verified, or the ID of the non-fungible asset the non-fungible tokens of which should be verified. |
| &nbsp;&nbsp;`isAssetId` | Boolean | *(optional, default: __`false`__)* Indicates whether the specified ID is a non-fungible asset ID. Otherwise, it should be interpreted as a non-fungible token ID. |

> Sample response:

```json
{
  "status": "success",
  "data": {
    "tokensOwned": 4,
    "tokensUnconfirmed": 0
  }
}
```

### Success response

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `status` | String | The value **`success`**, indicating that the request was successful. |
| `data` | Object | The actual data returned in response to the API request. |
| &nbsp;&nbsp;`tokensOwned` | Number | Number of non-fungible tokens, out of those that have been verified, that are owned by the specified virtual device. |
| &nbsp;&nbsp;`tokensUnconfirmed` | Number | Number of non-fungible tokens, out of the owned ones, that are not yet confirmed. |

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_105">Invalid asset ID</a><br><a href="#error_msg_110">Invalid device</a><br><a href="#error_msg_320">Invalid non-fungible token ID</a><br><a href="#error_msg_130">Invalid parameters: <i>&lt;param_list&gt;</i></a><br><a href="#error_msg_300">Not a non-fungible asset</a><br><a href="#error_msg_405">Unavailable or inconsistent non-fungible asset</a><br><a href="#error_msg_325">Unavailable or inconsistent non-fungible token</a> |
| 403 | <a href="#error_msg_400">No permission to check non-fungible token ownership</a> |
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |
