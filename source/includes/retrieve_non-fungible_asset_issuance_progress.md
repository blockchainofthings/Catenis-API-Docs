## Retrieve Non-Fungible Asset Issuance Progress

Retrieves the current progress of an asynchronous non-fungible asset issuance.

<aside class="notice">
Alternatively, instead of calling this API method, one may choose to receive a <a href="#final-non-fungible-asset-issuance-outcome-nf-asset-issuance-outcome">nf-asset-issuance-outcome</a> notification event.
</aside>

> Sample request:

```http--raw
GET /api/0.12/assets/non-fungible/issuance/iwoTJPbnogCktrYpzwQn?retrieveContents HTTP/1.1
X-BCoT-Timestamp: 20220817T143811Z
Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20220817/ctn1_request, Signature=de6a572fa907c591a581c30049c30ec24508a07f17510695b014f060d1adc60c
Host: localhost:3000
Connection: close
User-Agent: Paw/3.3.6 (Macintosh; OS X/12.5.0) GCDHTTPRequest
```

```shell
curl "http://localhost:3000/api/0.12/assets/non-fungible/issuance/iwoTJPbnogCktrYpzwQn?retrieveContents" \
     -H 'X-BCoT-Timestamp: 20220817T143811Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20220817/ctn1_request, Signature=de6a572fa907c591a581c30049c30ec24508a07f17510695b014f060d1adc60c'
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

GET /assets/non-fungible/issuance/`:issuanceId`

### Parameters

<!-- Note: we are not using the native markdown list feature for the second level items because the generated
        HTML has no space to the following first level item -->
- URL parameters:
<ul class="parameterList">
  <li>`issuanceId`: The ID of the non-fungible asset issuance the processing progress of which should be retrieved.</li>
</ul>

> Sample response:

```json
{
  "status": "success",
  "data": {
    "assetId": "ahfTzqgWAXnMR6Z57mcp",
    "progress": {
      "percentProcessed": 100,
      "done": true,
      "success": true,
      "finishDate": "2022-08-17T14:37:59.899Z"
    },
    "result": {
      "nfTokenIds": [
        "ttbG9ia4AjdP5Pm7WaLG"
      ]
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
| &nbsp;&nbsp;`assetId` | String | *(only returned in case of re-issuance)* The ID of the non-fungible asset for which more non-fungible tokens are being issued. |
| &nbsp;&nbsp;`progress` | Object | Current processing status. |
| &nbsp;&nbsp;&nbsp;&nbsp;`percentProcessed` | Number | The percentage of the total processing that has been already completed. |
| &nbsp;&nbsp;&nbsp;&nbsp;`done` | Boolean | Indicates whether the processing has been finished. |
| &nbsp;&nbsp;&nbsp;&nbsp;`success` | Boolean | *(only returned if the processing has already been finished)* Indicates whether the asset issuance has been successfully completed. |
| &nbsp;&nbsp;&nbsp;&nbsp;`error` | Object | *(only returned if the processing finished with error)* Information about the error that took place while processing the asset issuance. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`code` | Number | Numeric code — equivalent to an HTML status code — of the error. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`message` | String | Text describing the error. |
| &nbsp;&nbsp;&nbsp;&nbsp;`finishDate` | String | ISO 8601 formatted date and time when processing has been finalized. |
| &nbsp;&nbsp;`result` | Object | *(only returned if the processing finished successfully)* The result of the asset issuance. |
| &nbsp;&nbsp;&nbsp;&nbsp;`assetId` | String | *(not returned in case of re-issuance)* The ID of the newly created Catenis non-fungible asset. |
| &nbsp;&nbsp;&nbsp;&nbsp;`nfTokenIds` | Array(String) | List of the IDs of the newly issued non-fungible tokens. |

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_305">Invalid non-fungible asset issuance ID</a><br><a href="#error_msg_315">Non-fungible asset issuance data is not yet complete</a> |
| 403 | <a href="#error_msg_310">No permission to retrieve non-fungible asset issuance progress</a> | 
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |
