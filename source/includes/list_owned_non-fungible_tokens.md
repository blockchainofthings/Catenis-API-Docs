## List Owned Non-Fungible Tokens

Retrieve a list of the non-fungible tokens of a given non-fungible asset that are currently owned by the virtual device
 issuing the request.

> Sample request:

```http--raw
GET /api/0.13/assets/non-fungible/aiqXDyh7hhukwxFhR69x/tokens/owned?limit=200 HTTP/1.1
X-BCoT-Timestamp: 20221122T182951Z
Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20221122/ctn1_request, Signature=912d31a2288ccf6805736f85eb938779de346e8ab17a61493e04d240d5f1daca
Host: localhost:3000
Connection: close
User-Agent: RapidAPI/4.0.0 (Macintosh; OS X/13.0.1) GCDHTTPRequest
```

```shell
curl "http://localhost:3000/api/0.13/assets/non-fungible/aiqXDyh7hhukwxFhR69x/tokens/owned?limit=200" \
     -H 'X-BCoT-Timestamp: 20221122T183009Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20221122/ctn1_request, Signature=b8b005834cc420892664b393d6255f459e9eac3470190923addbc06692951a82'
```

```html--javascript
<script src="CatenisAPIClientJS.min.js"></script>

<script language="JavaScript">
var deviceId = 'dnN3Ea43bhMTHtTvpytS';

var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'sandbox'
});

var assetId = 'aiqXDyh7hhukwxFhR69x';

ctnApiClient.listOwnedNonFungibleTokens(assetId, 200, 0,
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            console.log('Owned non-fungible tokens:', data.ownedNFTokens);
    
            if (data.hasMore) {
                console.log('Not all owned non-fungible tokens have been returned');
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

var assetId = 'ahfTzqgWAXnMR6Z57mcp';

ctnApiClient.listOwnedNonFungibleTokens(assetId, 200, 0,
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            console.log('Owned non-fungible tokens:', data.ownedNFTokens);
    
            if (data.hasMore) {
                console.log('Not all owned non-fungible tokens have been returned');
            }
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

GET assets/non-fungible/`:assetId`/tokens/owned

### Parameters

<!-- Note: we are not using the native markdown list feature for the second level items because the generated
        HTML has no space to the following first level item -->
- URL parameters:
<ul class="parameterList">
  <li>`assetId`: The ID of the non-fungible asset the non-fungible tokens of which that are currently owned by the virtual device issuing the request should be retrieved.</li>
</ul>

- Query string parameters:
<ul class="parameterList">
  <li>`limit`: *(optional, default: __`500`__)* A numeric value representing the maximum number of list items that should be returned. Must be a positive integer value not greater than 500. </li>
  <li>`skip`: *(optional, default: __`0`__)* A numeric value representing the number of list items that should be skipped (from beginning of list) and not returned. Must be a non-negative (includes zero) integer value. </li>
</ul>

> Sample response:

```json
{
  "status": "success",
  "data": {
    "ownedNFTokens": [
      {
        "tokenId": "tN2ax6ebWQLr6ECRuoyS",
        "isConfirmed": true
      },
      {
        "tokenId": "twy3fNwmZjkRaawcMpmP",
        "isConfirmed": true
      },
      {
        "tokenId": "tWFsWnaxQa6kHz5Wcqkw",
        "isConfirmed": true
      },
      {
        "tokenId": "t45bMckekRanrZnTYGsw",
        "isConfirmed": true
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
| &nbsp;&nbsp;`ownedNFTokens` | Array(Object) | The returned list of owned non-fungible tokens. |
| &nbsp;&nbsp;&nbsp;&nbsp;`tokenId` | String | The ID of the non-fungible token. |
| &nbsp;&nbsp;&nbsp;&nbsp;`isConfirmed` | Boolean | Indicates whether the blockchain transaction used to transfer the non-fungible token has already been confirmed. |
| &nbsp;&nbsp;`hasMore` | Boolean | Indicates whether there are more entries that have not been included in the returned list. |

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_105">Invalid asset ID</a><br><a href="#error_msg_130">Invalid parameters: <i>&lt;param_list&gt;</i></a><br><a href="#error_msg_300">Not a non-fungible asset</a> |
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |
