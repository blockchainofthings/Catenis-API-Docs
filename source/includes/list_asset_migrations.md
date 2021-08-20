## List Asset Migrations

Retrieves a list of issued asset migrations that satisfy a given search criteria.

> Sample request:

```http--raw
GET /api/0.11/assets/migrations?status=pending&negateStatus=true&startDate=2021-08-01 HTTP/1.1
X-BCoT-Timestamp: 20210811T142016Z
Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20210811/ctn1_request, Signature=100242f637f3230f54e94dfcc30f25af4abbdf5c34add071130da94d37574379
Host: localhost:3000
Connection: close
User-Agent: Paw/3.2.4 (Macintosh; OS X/11.5.0) GCDHTTPRequest
```

```shell
curl "http://localhost:3000/api/0.11/assets/migrations?status=pending&negateStatus=true&startDate=2021-08-01" \
     -H 'X-BCoT-Timestamp: 20210811T142047Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20210811/ctn1_request, Signature=418fa567d70d0d8ae0ea38a1bdf068362a8cbfe8ce4c3ecb15f028ea5506169e'
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

GET /assets/migrations

### Parameters

<!-- Note: we are not using the native markdown list feature for the second level items because the generated
        HTML has no space to the following first level item -->
- Query string parameters:
<ul class="parameterList">
  <li>`assetId`: *(optional)* The ID of the asset the amount of which has been migrated.</li>
  <li>`foreignBlockchain`: *(optional)* The key identifying the foreign blockchain to/from where the asset amount has been migrated. Valid options: `ethereum`, `binance`, `polygon`.</li>
  <li>`direction`: *(optional)* The direction of the migration. Valid options: `outward`, `inward`.</li>
  <li>`status`: *(optional)* A single status or a comma-separated list of statuses to include. Valid options: `pending`, `interrupted`, `success`, `error`.</li>
  <li>`negateStatus`: *(optional, default: __`false`__)* Boolean value indicating whether the specified statuses should be excluded instead.</li>
  <li>`startDate`: *(optional)* <a href="https://en.wikipedia.org/wiki/ISO_8601" target="_blank">ISO 8601</a> formatted date and time specifying the inclusive lower bound of the time frame within which the asset amount has been migrated.</li>
  <li>`endDate`: *(optional)* ISO 8601 formatted date and time specifying the inclusive upper bound of the time frame within which the asset amount has been migrated.</li>
  <li>`limit`: *(optional, default: __`500`__)* Maximum number of asset migrations that should be returned. Must be a positive integer value not greater than 500.</li>
  <li>`skip`: *(optional, default: __`0`__)* Number of asset migrations that should be skipped (from beginning of list of matching asset migrations) and not returned. Must be a non-negative (includes zero) integer value.</li>
</ul>

> Sample response:

```json
{
  "status": "success",
  "data": {
    "assetMigrations": [
      {
        "migrationId": "gSLb9FTdGxgSLufuNzhR",
        "assetId": "aH2AkrrL55GcThhPNa3J",
        "foreignBlockchain": "ethereum",
        "direction": "inward",
        "amount": 4,
        "catenisService": {
          "status": "fulfilled",
          "txid": "26d45a275447caf36e0fbcc32f880f37d3aadb37ddceccc39cd8972a7933e3f4"
        },
        "foreignTransaction": {
          "txid": "0x883a4d9e02713b177fdd26b33e871dc765db3c964f2b1ef8e6f97eca24d718ee",
          "isPending": false,
          "success": true
        },
        "status": "success",
        "date": "2021-08-03T19:11:27.804Z"
      },
      {
        "migrationId": "gTQ8Qf5W6kdmdYdEEoD9",
        "assetId": "aCSy24HLjKMbpnvJ8GTx",
        "foreignBlockchain": "ethereum",
        "direction": "outward",
        "amount": 5,
        "catenisService": {
          "status": "fulfilled",
          "txid": "7d6a20ee009ad2bcbf5c799ee4eac594e4447bdb5007250f8ba038de97f63777"
        },
        "foreignTransaction": {
          "txid": "0x92fb47432e50b623441bb3b55dd65bf879183f87ea4913a16e75503c98792df9",
          "isPending": false,
          "success": true
        },
        "status": "success",
        "date": "2021-08-10T13:00:08.656Z"
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
| &nbsp;&nbsp;`assetMigrations` | Array(Object) | The returned list of issued asset migrations that satisfy the search criteria. The list is sorted in ascending order in regard to the returned `date` field.  |
| &nbsp;&nbsp;&nbsp;&nbsp;`migrationId` | String | The ID of the asset migration. |
| &nbsp;&nbsp;&nbsp;&nbsp;`assetId` | String | The ID of the asset the amount of which has been migrated. |
| &nbsp;&nbsp;&nbsp;&nbsp;`foreignBlockchain` | String | The key identifying the foreign blockchain to/from where the asset amount has been migrated. One of: `ethereum`, `binance`, or `polygon`. |
| &nbsp;&nbsp;&nbsp;&nbsp;`direction` | String | The direction of the migration. One of: `outward` or `inward`. |
| &nbsp;&nbsp;&nbsp;&nbsp;`amount` | Number | The migrated asset amount. |
| &nbsp;&nbsp;&nbsp;&nbsp;`catenisService` | Object | Information about the execution of the migrate asset Catenis service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`status` | String | The current state of the service's execution. One of: `awaiting`, `failure`, or `fulfilled`. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`txid` | String | *(only returned if the service is successfully fulfilled)* The ID of the Catenis transaction issued to fulfill the service. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`error` | String | *(only returned if the service's execution has failed)* An error message describing what went wrong when executing the service. |
| &nbsp;&nbsp;&nbsp;&nbsp;`foreignTransaction` | Object | Information about the transaction issued on the foreign blockchain to mint/burn the amount of the foreign token. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`txid` | String | The ID (or hash) of the foreign blockchain transaction. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`isPending` | Boolean | Indicates whether the foreign blockchain transaction is yet to be executed. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`success` | Boolean | Indicates whether the foreign blockchain transaction has been successfully executed or not. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`error` | String | *(only returned if the foreign blockchain transaction's execution has failed)* An error message describing what went wrong when executing the transaction. |
| &nbsp;&nbsp;&nbsp;&nbsp;`status` | String | The current state of the asset migration. One of: `pending`, `interrupted`, `success`, or `error`. |
| &nbsp;&nbsp;&nbsp;&nbsp;`date` | String | ISO 8601 formatted date and time when the asset amount has been migrated. |
| &nbsp;&nbsp;`hasMore` | Boolean | Indicates whether there are more asset migrations that satisfy the search criteria yet to be returned. |

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_130">Invalid parameters: <i>&lt;param_list&gt;</i></a> |
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |
