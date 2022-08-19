## Retrieve Non-Fungible Token Retrieval Progress

Retrieves the current progress of an asynchronous non-fungible token retrieval.

<aside class="notice">
Alternatively, instead of calling this API method, one may choose to receive a <a href="#final-non-fungible-token-retrieval-outcome-nf-token-retrieval-outcome">nf-token-retrieval-outcome</a> notification event.
</aside>

> Sample request:

```http--raw
GET /api/0.12/assets/non-fungible/tokens/t76Yzrbqcjbtehk6Wecf/retrieval/ret28tCLCFaWipyCCEEL HTTP/1.1
X-BCoT-Timestamp: 20220818T135253Z
Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20220818/ctn1_request, Signature=4c6fa9cc139bcb00b625bd31377dff3b7610ef0c3ac37582f94361e7184e2c49
Host: localhost:3000
Connection: close
User-Agent: Paw/3.3.6 (Macintosh; OS X/12.5.1) GCDHTTPRequest
```

```shell
curl "http://localhost:3000/api/0.12/assets/non-fungible/tokens/t76Yzrbqcjbtehk6Wecf/retrieval/ret28tCLCFaWipyCCEEL" \
     -H 'X-BCoT-Timestamp: 20220818T135253Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20220818/ctn1_request, Signature=4c6fa9cc139bcb00b625bd31377dff3b7610ef0c3ac37582f94361e7184e2c49'
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

GET /assets/non-fungible/tokens/`:tokenId`/retrieval/`:retrievalId`

### Parameters

<!-- Note: we are not using the native markdown list feature for the second level items because the generated
        HTML has no space to the following first level item -->
- URL parameters:
<ul class="parameterList">
  <li>`tokenId`: The ID of the non-fungible token whose data is being retrieved.</li>
  <li>`retrievalId`: The ID of the non-fungible token retrieval the processing progress of which should be retrieved.</li>
</ul>

> Sample response:

```json
{
  "status": "success",
  "data": {
    "progress": {
      "bytesRetrieved": 512,
      "done": true,
      "success": true,
      "finishDate": "2022-08-18T13:52:15.864Z"
    },
    "continuationToken": "eQ4YnusDtqm7Mn5Th7aj"
  }
}
```

### Success response

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `status` | String | The value **`success`**, indicating that the request was successful. |
| `data` | Object | The actual data returned in response to the API request. |
| &nbsp;&nbsp;`progress` | Object | Current processing status. |
| &nbsp;&nbsp;&nbsp;&nbsp;`bytesRetrieved` | Number | Number of bytes of non-fungible token data that have been retrieved. |
| &nbsp;&nbsp;&nbsp;&nbsp;`done` | Boolean | Indicates whether the processing has been finished. |
| &nbsp;&nbsp;&nbsp;&nbsp;`success` | Boolean | *(only returned if the processing has already been finished)* Indicates whether all the non-fungible token data has been successfully retrieved. |
| &nbsp;&nbsp;&nbsp;&nbsp;`error` | Object | *(only returned if the processing finished with error)* Information about the error that took place while retrieving the non-fungible token data. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`code` | Number | Numeric code — equivalent to an HTML status code — of the error. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`message` | String | Text describing the error. |
| &nbsp;&nbsp;&nbsp;&nbsp;`finishDate` | String | ISO 8601 formatted date and time when the data retrieval has been finalized. |
| &nbsp;&nbsp;`continuationToken` | String | *(only returned if the processing finished successfully)* The token that should be used to complete the retrieval of the non-fungible token. |

<aside class="notice">
When all the non-fungible token data is successfully retrieved — <code>progress.success</code> property set to <code><b>true</b></code> —,
 use the returned <b>continuation token</b> — <code>continuationToken</code> property — to call the <a href="#retrieve-non-fungible-token">Retrieve Non-Fungible Token</a>
 API method again to receive the retrieved data.
</aside>

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_320">Invalid non-fungible token ID</a><br><a href="#error_msg_355">Invalid non-fungible token retrieval ID</a> |
| 403 | <a href="#error_msg_360">No permission to retrieve non-fungible token retrieval progress</a> | 
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |