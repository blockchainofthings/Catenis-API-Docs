## Asset Migration Outcome

Retrieve the current information about the outcome of an asset migration.

<aside class="notice">
Only the virtual device that issued the asset migration can retrieve information about its outcome.
</aside>

> Sample request:

```http--raw
GET /api/0.11/assets/migrations/gq8x3efLpEXTkGQchHTb HTTP/1.1
X-BCoT-Timestamp: 20210810T211045Z
Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20210810/ctn1_request, Signature=60c4f0069c227fca8780ecb263cac1b98f40d15416a21c54cd6c1498644a7915
Host: localhost:3000
Connection: close
User-Agent: Paw/3.2.3 (Macintosh; OS X/11.5.0) GCDHTTPRequest
```

```shell
curl "http://localhost:3000/api/0.11/assets/migrations/gq8x3efLpEXTkGQchHTb" \
     -H 'X-BCoT-Timestamp: 20210810T211101Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20210810/ctn1_request, Signature=97a742d0245a5b078bccaed62724d725826ba87d92ae0a6d160abe26ab0958af'
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

GET /assets/migrations/`:migrationId`

### Parameters

<!-- Note: we are not using the native markdown list feature for the second level items because the generated
        HTML has no space to the following first level item -->
- URL parameters:
<ul class="parameterList">
  <li>`migrationId`: The ID of the asset migration.</li>
</ul>

> Sample response:

```json
{
  "status": "success",
  "data": {
    "assetId": "aH2AkrrL55GcThhPNa3J",
    "foreignBlockchain": "ethereum",
    "direction": "outward",
    "amount": 10,
    "catenisService": {
      "status": "fulfilled",
      "txid": "61fcb4feb64ecf3b39b4bb6d64eb9cc68a58ba1d892f981ef568d07b7aa11fdf"
    },
    "foreignTransaction": {
      "txid": "0x212ab54f136a6fc1deae9ec217ef2d0417615178777131e8bb6958447fd20fe7",
      "isPending": false,
      "success": true
    },
    "status": "success",
    "date": "2021-08-03T18:51:55.591Z"
  }
}
```

### Success response

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `status` | String | The value **`success`**, indicating that the request was successful. |
| `data` | Object | The actual data returned in response to the API request. |
| &nbsp;&nbsp;`assetId` | String | The ID of the asset the amount of which has been migrated. |
| &nbsp;&nbsp;`foreignBlockchain` | String | The key identifying the foreign blockchain to/from where the asset amount has been migrated. One of: `ethereum`, `binance`, or `polygon`. |
| &nbsp;&nbsp;`direction` | String | The direction of the migration. One of: `outward` or `inward`. |
| &nbsp;&nbsp;`amount` | Number | The migrated asset amount. |
| &nbsp;&nbsp;`catenisService` | Object | Information about the execution of the migrate asset Catenis service. |
| &nbsp;&nbsp;&nbsp;&nbsp;`status` | String | The current state of the service's execution. One of: `awaiting`, `failure`, or `fulfilled`. |
| &nbsp;&nbsp;&nbsp;&nbsp;`txid` | String | *(only returned if the service is successfully fulfilled)* The ID of the Catenis transaction issued to fulfill the service. |
| &nbsp;&nbsp;&nbsp;&nbsp;`error` | String | *(only returned if the service's execution has failed)* An error message describing what went wrong when executing the service. |
| &nbsp;&nbsp;`foreignTransaction` | Object | Information about the transaction issued on the foreign blockchain to mint/burn the amount of the foreign token. |
| &nbsp;&nbsp;&nbsp;&nbsp;`txid` | String | The ID (or hash) of the foreign blockchain transaction. |
| &nbsp;&nbsp;&nbsp;&nbsp;`isPending` | Boolean | Indicates that the foreign blockchain transaction is yet to be executed. |
| &nbsp;&nbsp;&nbsp;&nbsp;`success` | Boolean | *(only returned after the foreign blockchain transaction is executed)* Indicates whether the foreign blockchain transaction has been successfully executed or not. |
| &nbsp;&nbsp;&nbsp;&nbsp;`error` | String | *(only returned if the foreign blockchain transaction's execution has failed)* An error message describing what went wrong when executing the transaction. |
| &nbsp;&nbsp;`status` | String | The current state of the asset migration. One of: `pending`, `interrupted`, `success`, or `error`. |
| &nbsp;&nbsp;`date` | String | <a href="https://en.wikipedia.org/wiki/ISO_8601" target="_blank">ISO 8601</a> formatted date and time when the asset amount has been migrated. |

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_107">Invalid asset migration ID</a><br><a href="#error_msg_130">Invalid parameters: <i>&lt;param_list&gt;</i></a> |
| 403 | <a href="#error_msg_189">No permission to retrieve asset migration outcome</a> |
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |
