## Retrieve Non-Fungible Token

Retrieves the data associated with a non-fungible token.

<aside class="notice">
The non-fungible token data comprises the non-fungible token's metadata and its contents. The metadata defines the
 properties of the non-fungible token, and includes standard properties, like <b>name</b> and <b>description</b>, as
 well as user-defined, custom properties. The medata also includes a reference to the non-fungible token's contents as
 a URL.
</aside>

> Sample request:

```http--raw
GET /api/0.12/assets/non-fungible/tokens/t76Yzrbqcjbtehk6Wecf?retrieveContents=true&contentsEncoding=utf8&dataChunkSize=1024 HTTP/1.1
X-BCoT-Timestamp: 20220818T125045Z
Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20220818/ctn1_request, Signature=dfc497904304fa61e360940464b4d5a00006297578c1b40abffaf2393fd2fae0
Host: localhost:3000
Connection: close
User-Agent: Paw/3.3.6 (Macintosh; OS X/12.5.1) GCDHTTPRequest
```

```shell
curl "http://localhost:3000/api/0.12/assets/non-fungible/tokens/t76Yzrbqcjbtehk6Wecf?retrieveContents=true&contentsEncoding=utf8&dataChunkSize=1024" \
     -H 'X-BCoT-Timestamp: 20220818T125045Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20220818/ctn1_request, Signature=dfc497904304fa61e360940464b4d5a00006297578c1b40abffaf2393fd2fae0'
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

GET /assets/non-fungible/tokens/`:tokenId`

### Parameters

<!-- Note: we are not using the native markdown list feature for the second level items because the generated
        HTML has no space to the following first level item -->
- URL parameters:
<ul class="parameterList">
  <li>`tokenId`: The ID of the non-fungible token the data of which should be retrieved.</li>
</ul>

- Query string parameters:
<ul class="parameterList">
  <li>`retrieveContents`: *(optional, default: __`true`__; should be omitted in a continuation call)* A boolean value indicating whether the contents of the non-fungible token should be retrieved or not. </li>
  <li>`contentsOnly`: *(optional, default: __`false`__; should be omitted in a continuation call)* A boolean value indicating whether only the contents of the non-fungible token should be retrieved. </li>
  <li>`contentsEncoding`: *(optional, default: __`base64`__; should be omitted in a continuation call)* The encoding with which the retrieved chunk of non-fungible token contents data will be encoded. Valid values: `utf8`, `base64`, `hex`. </li>
  <li>`dataChunkSize`: *(optional; should be omitted in a continuation call)* Numeric value representing the size, in bytes, of the largest chunk of non-fungible token contents data that should be returned.</li>
  <li>`async`: *(optional, default: __`false`__; should be omitted in a continuation call)* A boolean value indicating whether the processing should be done asynchronously.</li>
  <li>`continuationToken`: *(optional; should be included only in a continuation call)* This signals a continuation call of the non-fungible token retrieval. It should be filled with the continuation token returned by the previous call.</li>
</ul>

<aside class="notice">
When retrieving the contents of a non-fungible token — <code>retrieveContents</code> parameter set to <code><b>true</b></code> —,
 it is a good practice to limit the size of the chunk of contents data that is returned — using the <code>dataChunkSize</code>
 parameter. In that case, if the contents of the non-fungible token is larger than that size, a <b>continuation token</b>
 is returned along with the non-fungible token data. Then, this API method should be called again, passing the received
 continuation token, to retrieve the remainder of the non-fungible token’s contents. That process should be repeated
 until no more continuation token is returned (and the whole contents is retrieved).
</aside>

<aside class="warning">
The parameters <code>contentsOnly</code>, <code>contentsEncoding</code>, and <code>dataChunkSize</code> should only be
 specified when retrieving the contents of the non-fungible token — <code>retrieveContents</code> parameter set to <code><b>true</b></code>.
</aside>

<aside class="warning">
The value of the <code>dataChunkSize</code> parameter must be between 1,024 (1 KiB) and 15,728,640 (15 MiB).
</aside>

<aside class="notice">
To avoid a possible timeout while waiting for Catenis to process a non-fungible token retrieval, especially when the
 non-fungible token being retrieved has a large amount of data, one may choose to do the processing asynchronously
 — <code>async</code> parameter set to <code><b>true</b></code>. In that case, the call will return immediately with a
 <b>token retrieval ID</b>, which should then be used to retrieve the non-fungible token retrieval progress by calling
 the <a href="#retrieve-non-fungible-token-retrieval-progress">Retrieve Non-Fungible Token Retrieval Progress</a> API
 method.
</aside>

> Sample response:

```json
{
  "status": "success",
  "data": {
    "nonFungibleToken": {
      "assetId": "ahfTzqgWAXnMR6Z57mcp",
      "metadata": {
        "name": "NFA9 NFT 2",
        "description": "Second token of Catenis non-fungible asset #9",
        "contentsEncrypted": true,
        "contentsURL": "http://localhost:8080/ipfs/QmR5RGXM3KJrYoe958UXuaL2TXt24ga53xKZvqaY2pDeZ1"
      },
      "contents": {
        "data": "Here is the contents of the second token of Catenis non-fungible asset #9 (part #1); and here is the last part of the contents of the second token of Catenis non-fungible asset #9."
      }
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
| &nbsp;&nbsp;`continuationToken` | String | *(only returned if there is more data to be retrieved)* The continuation token to be used in the next continuation call. |
| &nbsp;&nbsp;`tokenRetrievalId` | String | *(only returned for the initial call when doing processing asynchronously)* The token retrieval ID. Used for retrieving the progress of an asynchronous non-fungible token retrieval. |
| &nbsp;&nbsp;`nonFungibleToken` | Object | *(__not__ returned for the initial call when doing processing asynchronously)* The retrieved non-fungible token data. |
| &nbsp;&nbsp;&nbsp;&nbsp;`assetId` | String | *(not returned for a continuation call)* The ID of the non-fungible asset to which the non-fungible token belongs. |
| &nbsp;&nbsp;&nbsp;&nbsp;`metadata` | Object | *(not returned for a continuation call)* The non-fungible token metadata. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`name` | String | The name of the non-fungible token. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`description` | String | *(only returned if present)* A description of the non-fungible token. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`contentsEncrypted` | String | Indicates whether the stored contents is encrypted. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`contentsURL` | String | URL pointing to the non-fungible token's contents stored on IPFS. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`custom` | Object | *(only returned if present)* User defined, custom properties of the non-fungible token. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`sensitiveProps` | Object | *(only returned if present)* User defined, sensitive properties of the non-fungible token. Sensitive properties are stored in an encrypted form. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_`<prop_name>`_ | * | A custom, sensitive property identified by _`prop_name`_. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_`<prop_name>`_ | * | A custom property identified by _`prop_name`_. |
| &nbsp;&nbsp;&nbsp;&nbsp;`contents` | Object | The retrieved non-fungible token contents data. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`data` | String | The text encoded non-fungible token contents data. |

<aside class="notice">
Note that the actual non-fungible token's contents may comprise several chunks of data — returned by successive calls.
 In that case, the returned data chunks must be concatenated to reveal the whole contents of the non-fungible token. 
</aside>

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_320">Invalid non-fungible token ID</a><br><a href="#error_msg_340">Invalid or unexpected non-fungible token retrieval continuation token</a><br><a href="#error_msg_330">Non-fungible token data retrieval not yet done</a><br><a href="#error_msg_335">Retrieved non-fungible token data already delivered</a><br><a href="#error_msg_345">Retrieved non-fungible token data expired</a><br><a href="#error_msg_325">Unavailable or inconsistent non-fungible token</a> |
| 403 | <a href="#error_msg_350">No permission to retrieve non-fungible token</a> | 
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |
