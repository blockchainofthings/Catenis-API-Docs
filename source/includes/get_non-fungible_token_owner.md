## Get Non-Fungible Token Owner

Identifies the virtual device that currently owns a given non-fungible token.

<aside class="notice">
Only the virtual device that issued the non-fungible token may query for its current owner.
</aside>

> Sample request:

```http--raw
GET /api/0.13/assets/non-fungible/tokens/twy3fNwmZjkRaawcMpmP/owner HTTP/1.1
X-BCoT-Timestamp: 20221121T151617Z
Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20221121/ctn1_request, Signature=3e984242fe184d87e5f069d736659432d46084b4060940bf2097d293acdfdf41
Host: localhost:3000
Connection: close
User-Agent: RapidAPI/4.0.0 (Macintosh; OS X/13.0.1) GCDHTTPRequest
```

```shell
curl "http://localhost:3000/api/0.13/assets/non-fungible/tokens/twy3fNwmZjkRaawcMpmP/owner" \
     -H 'X-BCoT-Timestamp: 20221121T215036Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20221121/ctn1_request, Signature=551664e5235b1ca8dfe10b13077c3d1dc88e0b2fae39d52ad53c8fc267ceb15f'
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

GET assets/non-fungible/tokens/`:tokenId`/owner

### Parameters

<!-- Note: we are not using the native markdown list feature for the second level items because the generated
        HTML has no space to the following first level item -->
- URL parameters:
<ul class="parameterList">
  <li>`tokenId`: The ID of the non-fungible token the owner of which should be identified.</li>
</ul>

> Sample response:

```json
{
  "status": "success",
  "data": {
    "owner": {
      "deviceId": "drc3XdxNtzoucpw9xiRp",
      "name": "TstDev1",
      "prodUniqueId": "ABC123"
    },
    "isConfirmed": true
  }
}
```

### Success response

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `status` | String | The value **`success`**, indicating that the request was successful. |
| `data` | Object | The actual data returned in response to the API request. |
| &nbsp;&nbsp;`owner` | Object | The virtual device that currently owns the non-fungible token — *owning device*. |
| &nbsp;&nbsp;&nbsp;&nbsp;`deviceId` | String | The device ID of the owning device. |
| &nbsp;&nbsp;&nbsp;&nbsp;`name` | String | *(only returned if the owning device has this data, and the virtual device issuing the request has the necessary permission right)* The name of the owning device. |
| &nbsp;&nbsp;&nbsp;&nbsp;`prodUniqueId` | String | *(only returned if the owning device has this data, and the virtual device issuing the request has the necessary permission right)* The product unique ID of the owning device. |
| &nbsp;&nbsp;`isConfirmed` | Boolean | Indicates whether the blockchain transaction used to transfer the non-fungible token has already been confirmed. |

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_320">Invalid non-fungible token ID</a><br><a href="#error_msg_325">Unavailable or inconsistent non-fungible token</a> |
| 403 | <a href="#error_msg_395">No permission to retrieve the identity of the non-fungible token owner</a> |
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |
