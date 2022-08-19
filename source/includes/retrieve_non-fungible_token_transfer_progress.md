## Retrieve Non-Fungible Token Transfer Progress

Retrieves the current progress of an asynchronous non-fungible token transfer.

<aside class="notice">
Alternatively, instead of calling this API method, one may choose to receive a <a href="#final-non-fungible-token-transfer-outcome-nf-token-transfer-outcome">nf-token-transfer-outcome</a> notification event.
</aside>

> Sample request:

```http--raw
GET /api/0.12/assets/non-fungible/tokens/ttbG9ia4AjdP5Pm7WaLG/transfer/xBvAEtQmnMH3eQTAbeHx HTTP/1.1
X-BCoT-Timestamp: 20220818T184156Z
Authorization: CTN1-HMAC-SHA256 Credential=d8YpQ7jgPBJEkBrnvp58/20220818/ctn1_request, Signature=c35a6928c680ae2f6674ef9fd6b2743f5783c98185dd8adc8f9cb1d544e0c83b
Host: localhost:3000
Connection: close
User-Agent: Paw/3.3.6 (Macintosh; OS X/12.5.1) GCDHTTPRequest
```

```shell
curl "http://localhost:3000/api/0.12/assets/non-fungible/tokens/ttbG9ia4AjdP5Pm7WaLG/transfer/xBvAEtQmnMH3eQTAbeHx" \
     -H 'X-BCoT-Timestamp: 20220818T184156Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=d8YpQ7jgPBJEkBrnvp58/20220818/ctn1_request, Signature=ef114f4eac5789a69b508c38508dcaf03c20adac1817c2a0a3f2715d04996f3b'
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

GET /assets/non-fungible/tokens/`:tokenId`/transfer/`:transferId`

### Parameters

<!-- Note: we are not using the native markdown list feature for the second level items because the generated
        HTML has no space to the following first level item -->
- URL parameters:
<ul class="parameterList">
  <li>`tokenId`: The ID of the non-fungible token that is being transferred.</li>
  <li>`transferId`: The ID of the non-fungible token transfer the processing progress of which should be retrieved.</li>
</ul>

> Sample response:

```json
{
  "status": "success",
  "data": {
    "progress": {
      "dataManipulation": {
        "bytesRead": 398,
        "bytesWritten": 472
      },
      "done": true,
      "success": true,
      "finishDate": "2022-08-18T18:41:31.933Z"
    }
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
| &nbsp;&nbsp;&nbsp;&nbsp;`dataManipulation` | Object | Progress of the non-fungible token data manipulation: reading and rewriting it after re-encryption (if required). |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`bytesRead` | Number | Number of bytes of non-fungible token data that have been read. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`bytesWritten` | Number | *(only returned if data needed to be re-encrypted)* Number of bytes of non-fungible token data that have been written. |
| &nbsp;&nbsp;&nbsp;&nbsp;`done` | Boolean | Indicates whether the processing has been finished. |
| &nbsp;&nbsp;&nbsp;&nbsp;`success` | Boolean | *(only returned if the processing has already been finished)* Indicates whether the non-fungible token has been successfully transferred. |
| &nbsp;&nbsp;&nbsp;&nbsp;`error` | Object | *(only returned if the processing finished with error)* Information about the error that took place while transferring the non-fungible token. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`code` | Number | Numeric code — equivalent to an HTML status code — of the error. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`message` | String | Text describing the error. |
| &nbsp;&nbsp;&nbsp;&nbsp;`finishDate` | String | ISO 8601 formatted date and time when the non-fungible token transfer has been finalized. |

<aside class="notice">
When transferring a non-fungible token, if that token or any other token currently held by the same bitcoin unspent
 transaction output (UTXO) have a metadata with sensitive properties and/or their contents are encrypted, the data of
 those non-fungible tokens will need to be rewritten so that the encrypted data is re-encrypted with the new
 encryption keys (belonging to the receiving device).
</aside>

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_320">Invalid non-fungible token ID</a><br><a href="#error_msg_380">Invalid non-fungible token transfer ID</a> |
| 403 | <a href="#error_msg_385">No permission to retrieve non-fungible token transfer progress</a> | 
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |
