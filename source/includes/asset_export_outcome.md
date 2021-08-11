## Asset Export Outcome

Retrieve the current information about the outcome of an asset export.

<aside class="notice">
Only the virtual device that issued the asset export can retrieve information about its outcome.
</aside>

> Sample request:

```http--raw
GET /api/0.11/assets/aH2AkrrL55GcThhPNa3J/export/ethereum HTTP/1.1
X-BCoT-Timestamp: 20210810T195125Z
Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20210810/ctn1_request, Signature=2d30b89906b459b0ebc5c5df6bf12b862b59851530a636c11320d2fd89c5614e
Host: localhost:3000
Connection: close
User-Agent: Paw/3.2.3 (Macintosh; OS X/11.5.0) GCDHTTPRequest
```

```shell
curl "http://localhost:3000/api/0.11/assets/aH2AkrrL55GcThhPNa3J/export/ethereum" \
     -H 'X-BCoT-Timestamp: 20210810T195231Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20210810/ctn1_request, Signature=3fc5a2654f845c15b0fa731094e9ac8b7f0aa1b2f657580c162985e31d3b5438'
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

GET /assets/`:assetId`/export/`:foreignBlockchain`

### Parameters

<!-- Note: we are not using the native markdown list feature for the second level items because the generated
        HTML has no space to the following first level item -->
- URL parameters:
<ul class="parameterList">
  <li>`assetId`: The ID of the asset that was exported.</li>
  <li>`foreignBlockchain`: The key identifying the foreign blockchain. Valid options: `ethereum`, `binance`, `polygon`.</li>
</ul>

> Sample response:

```json
{
  "status": "success",
  "data": {
    "foreignTransaction": {
      "txid": "0x1f14474f441557056055a186ccf6839bd4dfce79e0b134d77084b6ef4274dc1a",
      "isPending": false,
      "success": true
    },
    "token": {
      "name": "Catenis test token #10",
      "symbol": "CTK10",
      "id": "0x537580164Ba9DB2e8C254a38E254ce15d07fDef9"
    },
    "status": "success",
    "date": "2021-08-03T18:41:27.679Z"
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
| &nbsp;&nbsp;`status` | String | The current state of the asset export. One of: `pending`, `success`, or `error` |
| &nbsp;&nbsp;`date` | String | <a href="https://en.wikipedia.org/wiki/ISO_8601" target="_blank">ISO 8601</a> formatted date and time when the asset has been exported. |

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_8">Asset is not yet exported</a><br><a href="#error_msg_105">Invalid asset ID</a><br><a href="#error_msg_130">Invalid parameters: <i>&lt;param_list&gt;</i></a> |
| 403 | <a href="#error_msg_186">No permission to retrieve asset export outcome</a> |
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |
