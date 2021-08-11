## Export Asset

Export an asset to a foreign blockchain, by creating a new (ERC-20 compliant) token on that blockchain.

<aside class="notice">
Only the virtual device that issued the asset can export it.
</aside>

<aside class="notice">
This method requires that an amount of the foreign blockchain's native coin be spent to pay for the execution of the
 issued foreign blockchain transaction. That amount is taken from the virtual device's client foreign blockchain asset
 export admin account, and it is the end user's responsibility to fund it (via Catenis's client admin UI).
</aside>

> Sample request:

```http--raw
POST /api/0.11/assets/aH2AkrrL55GcThhPNa3J/export/ethereum HTTP/1.1
X-BCoT-Timestamp: 20210809T144134Z
Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20210809/ctn1_request, Signature=87ed19ecefc670d61d4d85c0da80b608fc102a060e45c3d5caa5057eefc33d13
Content-Type: application/json; charset=utf-8
Host: localhost:3000
Connection: close
User-Agent: Paw/3.2.3 (Macintosh; OS X/11.5.0) GCDHTTPRequest
Content-Length: 60

{"token":{"name":"Catenis test token #10","symbol":"CTK10"}}
```

```shell
curl -X "POST" "http://localhost:3000/api/0.11/assets/aH2AkrrL55GcThhPNa3J/export/ethereum" \
     -H 'X-BCoT-Timestamp: 20210809T144203Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20210809/ctn1_request, Signature=989280734b7ebf40057ec305d02af8d2d899f78cddcfca1ff4d30c652a3b8dc6' \
     -H 'Content-Type: application/json; charset=utf-8' \
     -d $'{
  "token": {
    "name": "Catenis test token #10",
    "symbol": "CTK10"
  }
}'
```

```html--javascript
```

```javascript--node
```

```php
```

```rust
```

### Accessibility

Private

### Request

POST /assets/`:assetId`/export/`:foreignBlockchain`

### Parameters

<!-- Note: we are not using the native markdown list feature for the second level items because the generated
        HTML has no space to the following first level item -->
- URL parameters:
<ul class="parameterList">
  <li>`assetId`: The ID of the asset to export.</li>
  <li>`foreignBlockchain`: The key identifying the foreign blockchain. Valid options: `ethereum`, `binance`, `polygon`.</li>
</ul>

* Request body:

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `token` | Object | |
| &nbsp;&nbsp;`name` | String | The name of the token to be created on the foreign blockchain. |
| &nbsp;&nbsp;`symbol` | String | The symbol of the token to be created on the foreign blockchain. |
| `options` | Object | *(optional)* |
| &nbsp;&nbsp;`consumptionProfile` | String | *(optional)* Name of the foreign blockchain's native coin consumption profile to use. Valid options: `fastest`, `fast`, `average`, `slow`. |
| &nbsp;&nbsp;`estimateOnly` | Boolean | *(optional, default: __`false`__)* Indicates that no asset export should be done. Instead, only the estimated price (in the foreign blockchain's native coin) to fulfill the operation should be returned. |

<aside class="notice">
If the <code>options.consumptionProfile</code> property is not specified, the value currently set (via Catenis's client
 admin UI) for the virtual device's client foreign blockchain consumption profile is used.
</aside>

> Sample response:

```json
{
  "status": "success",
  "data": {
    "foreignTransaction": {
      "txid": "0x1f14474f441557056055a186ccf6839bd4dfce79e0b134d77084b6ef4274dc1a",
      "isPending": true
    },
    "token": {
      "name": "Catenis test token #10",
      "symbol": "CTK10"
    },
    "status": "pending",
    "date": "2021-08-03T18:41:11.781Z"
  }
}
```

### Success response

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `status` | String | The value **`success`**, indicating that the request was successful. |
| `data` | Object | The actual data returned in response to the API request. |
| &nbsp;&nbsp;`foreignTransaction` | Object | Information about the transaction issued on the foreign blockchain to create the resulting foreign token. |
| &nbsp;&nbsp;&nbsp;&nbsp;`txid` | String | The ID (or hash) of the foreign blockchain transaction. |
| &nbsp;&nbsp;&nbsp;&nbsp;`isPending` | Boolean | Indicates that the foreign blockchain transaction is yet to be executed. |
| &nbsp;&nbsp;&nbsp;&nbsp;`success` | Boolean | *(only returned after the foreign blockchain transaction is executed)* Indicates whether the foreign blockchain transaction has been successfully executed or not. |
| &nbsp;&nbsp;&nbsp;&nbsp;`error` | String | *(only returned if the foreign blockchain transaction's execution has failed)* An error message describing what went wrong when executing the transaction. |
| &nbsp;&nbsp;`token` | Object | Information about the resulting foreign token. |
| &nbsp;&nbsp;&nbsp;&nbsp;`name` | String | The token name. |
| &nbsp;&nbsp;&nbsp;&nbsp;`symbol` | String | The token symbol. |
| &nbsp;&nbsp;&nbsp;&nbsp;`id` | String | *(only returned if the asset is successfully export)* The ID (or address) of the token on the foreign blockchain. |
| &nbsp;&nbsp;`status` | String | The current state of the asset export. One of: `pending`, `success`, or `error`. |
| &nbsp;&nbsp;`date` | String | <a href="https://en.wikipedia.org/wiki/ISO_8601" target="_blank">ISO 8601</a> formatted date and time when the asset has been exported. |

> Sample response (estimate only):

```json
{
  "status": "success",
  "data": {
    "estimatedPrice": "0.05850782"
  }
}
```

### Success response (estimate only)

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `status` | String | The value **`success`**, indicating that the request was successful. |
| `data` | Object | The actual data returned in response to the API request. |
| &nbsp;&nbsp;`estimatedPrice` | String | A text value representing the price, in the foreign blockchain's native coin, required to execute the foreign blockchain transaction. |

<aside class="notice">
Note that the estimated price is <b>volatile</b>, and it will vary depending on the current foreign blockchain fee
 market. Thus it is possible that, when the asset is finally exported, the actual price charged will be <b>different</b>
 than the returned value.
</aside>

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_6">Asset already exported</a><br><a href="#error_msg_80">Discarded concurrent foreign token smart contract call</a><br><a href="#error_msg_90">Foreign blockchain funds not enough to cover transaction execution price (<i>&lt;value&gt;</i>)</a><br><a href="#error_msg_105">Invalid asset ID</a><br><a href="#error_msg_130">Invalid parameters: <i>&lt;param_list&gt;</i></a><br><a href="#error_msg_230">Unexpected error calling foreign token smart contract</a> |
| 403 | <a href="#error_msg_176">No permission to export asset</a> |
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |
