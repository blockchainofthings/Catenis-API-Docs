## List Exported Assets

Retrieves a list of issued asset exports that satisfy a given search criteria.

> Sample request:

```http--raw
GET /api/0.11/assets/exported?status=success,error&startDate=2021-08-01 HTTP/1.1
X-BCoT-Timestamp: 20210811T115512Z
Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20210811/ctn1_request, Signature=34abef10e2e75e8a3c2f66f1b40d50a2cb2e6f88ff7baff8e8fbd983a29d1c4b
Host: localhost:3000
Connection: close
User-Agent: Paw/3.2.3 (Macintosh; OS X/11.5.0) GCDHTTPRequest
```

```shell
curl "http://localhost:3000/api/0.11/assets/exported?status=success,error&startDate=2021-08-01" \
     -H 'X-BCoT-Timestamp: 20210811T115534Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20210811/ctn1_request, Signature=258e511f7272407ba344922c0d68a63388018e70bcc2885acf343c415f0caf36'
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

GET /assets/exported

### Parameters

<!-- Note: we are not using the native markdown list feature for the second level items because the generated
        HTML has no space to the following first level item -->
- Query string parameters:
<ul class="parameterList">
  <li>`assetId`: *(optional)* The ID of the exported asset.</li>
  <li>`foreignBlockchain`: *(optional)* The key identifying the foreign blockchain to where the asset has been exported. Valid options: `ethereum`, `binance`, `polygon`.</li>
  <li>`tokenSymbol`: *(optional)* The symbol of the resulting foreign token.</li>
  <li>`status`: *(optional)* A single status or a comma-separated list of statuses to include. Valid options: `pending`, `success`, `error`.</li>
  <li>`negateStatus`: *(optional, default: __`false`__)* Boolean value indicating whether the specified statuses should be excluded instead.</li>
  <li>`startDate`: *(optional)* <a href="https://en.wikipedia.org/wiki/ISO_8601" target="_blank">ISO 8601</a> formatted date and time specifying the inclusive lower bound of the time frame within which the asset has been exported.</li>
  <li>`endDate`: *(optional)* ISO 8601 formatted date and time specifying the inclusive upper bound of the time frame within which the asset has been exported.</li>
  <li>`limit`: *(optional, default: __`500`__)* Maximum number of asset exports that should be returned. Must be a positive integer value not greater than 500.</li>
  <li>`skip`: *(optional, default: __`0`__)* Number of asset exports that should be skipped (from beginning of list of matching asset exports) and not returned. Must be a non-negative (includes zero) integer value.</li>
</ul>

> Sample response:

```json
{
  "status": "success",
  "data": {
    "exportedAssets": [
      {
        "assetId": "aH2AkrrL55GcThhPNa3J",
        "foreignBlockchain": "ethereum",
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
      },
      {
        "assetId": "aCSy24HLjKMbpnvJ8GTx",
        "foreignBlockchain": "ethereum",
        "foreignTransaction": {
          "txid": "0x6299c35ccfa803ab0cb043e8d8ae4be8d7f3432d85f288ebb81e4d624e566b0a",
          "isPending": false,
          "success": true
        },
        "token": {
          "name": "Catenis test token #11",
          "symbol": "CTK11",
          "id": "0x5cE78E7204DD8f7d86142fAaA694d5354b997600"
        },
        "status": "success",
        "date": "2021-08-10T12:57:24.217Z"
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
| &nbsp;&nbsp;`exportedAssets` | Array(Object) | The returned list of issued asset exports that satisfy the search criteria. The list is sorted in ascending order in regard to the returned `date` field.  |
| &nbsp;&nbsp;&nbsp;&nbsp;`assetId` | String | The ID of the exported asset. |
| &nbsp;&nbsp;&nbsp;&nbsp;`foreignBlockchain` | String | The key identifying the foreign blockchain to where the asset has been exported. One of: `ethereum`, `binance`, or `polygon`. |
| &nbsp;&nbsp;&nbsp;&nbsp;`foreignTransaction` | Object | Information about the transaction issued on the foreign blockchain to create the resulting foreign token. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`txid` | String | The ID (or hash) of the foreign blockchain transaction. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`isPending` | Boolean | Indicates whether the foreign blockchain transaction is yet to be executed. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`success` | Boolean | *(only returned after the foreign blockchain transaction is executed)* Indicates whether the foreign blockchain transaction has been successfully executed or not. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`error` | String | *(only returned if the foreign blockchain transaction's execution has failed)* An error message describing what went wrong when executing the transaction. |
| &nbsp;&nbsp;&nbsp;&nbsp;`token` | Object | Information about the resulting foreign token. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`name` | String | The token name. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`symbol` | String | The token symbol. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`id` | String | *(only returned if the asset is successfully export)* The ID (or address) of the token on the foreign blockchain. |
| &nbsp;&nbsp;&nbsp;&nbsp;`status` | String | The current state of the asset export. One of: `pending`, `success`, or `error` |
| &nbsp;&nbsp;&nbsp;&nbsp;`date` | String | ISO 8601formatted date and time when the asset has been exported. |
| &nbsp;&nbsp;`hasMore` | Boolean | Indicates whether there are more asset exports that satisfy the search criteria yet to be returned. |

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_130">Invalid parameters: <i>&lt;param_list&gt;</i></a> |
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |
