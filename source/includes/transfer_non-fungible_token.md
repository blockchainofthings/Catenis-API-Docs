## Transfer Non-Fungible Token

Transfers a non-fungible token to a virtual device.

> Sample request:

```http--raw
POST /api/0.13/assets/non-fungible/tokens/ttbG9ia4AjdP5Pm7WaLG/transfer HTTP/1.1
X-BCoT-Timestamp: 20220818T143907Z
Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20220818/ctn1_request, Signature=025ddf3aa2246de4e67f61635e68b52fb7f042ad8be780866690f4760430124e
Content-Type: application/json; charset=utf-8
Host: localhost:3000
Connection: close
User-Agent: Paw/3.3.6 (Macintosh; OS X/12.5.1) GCDHTTPRequest
Content-Length: 49

{"receivingDevice":{"id":"d8YpQ7jgPBJEkBrnvp58"}}
```

```shell
curl -X "POST" "http://localhost:3000/api/0.13/assets/non-fungible/tokens/ttbG9ia4AjdP5Pm7WaLG/transfer" \
     -H 'X-BCoT-Timestamp: 20220818T143907Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20220818/ctn1_request, Signature=025ddf3aa2246de4e67f61635e68b52fb7f042ad8be780866690f4760430124e' \
     -H 'Content-Type: application/json; charset=utf-8' \
     -d $'{
  "receivingDevice": {
    "id": "d8YpQ7jgPBJEkBrnvp58"
  }
}'
```

```html--javascript
<script src="CatenisAPIClientJS.min.js"></script>

<script language="JavaScript">
var deviceId = 'dnN3Ea43bhMTHtTvpytS';

var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'sandbox'
});

var tokenId = 'ttbG9ia4AjdP5Pm7WaLG';
var receivingDevice = {
    id: 'd8YpQ7jgPBJEkBrnvp58'
};

ctnApiClient.transferNonFungibleToken(tokenId, receivingDevice,
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Display result
            console.log('Non-fungible token successfully transferred');
        }
});
</script>
```

```javascript--node
var CtnApiClient = require('catenis-api-client');

var deviceId = 'dnN3Ea43bhMTHtTvpytS';

var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'sandbox'
});

var tokenId = 'ttbG9ia4AjdP5Pm7WaLG';
var receivingDevice = {
    id: 'd8YpQ7jgPBJEkBrnvp58'
};

ctnApiClient.transferNonFungibleToken(tokenId, receivingDevice,
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Display result
            console.log('Non-fungible token successfully transferred');
        }
});
```

```php
<?php
require __DIR__ . '/vendor/autoload.php';

use Catenis\ApiClient;
use Catenis\Exception\CatenisException;

$deviceId = 'dnN3Ea43bhMTHtTvpytS';

$ctnApiClient = new ApiClient($deviceId, $apiAccessSecret, [
    'environment' => 'sandbox'
]);

$tokenId = 'ttbG9ia4AjdP5Pm7WaLG';
$receivingDevice = [
    'id' => 'd8YpQ7jgPBJEkBrnvp58'
];

try {
    $ctnApiClient->transferNonFungibleToken($tokenId, $receivingDevice);

    // Display result
    echo 'Non-fungible token successfully transferred' . PHP_EOL;
} catch (\Catenis\Exception\CatenisException $ex) {
    // Process exception
}
```

```rust
use catenis_api_client::{
    CatenisClient, ClientOptions, Environment, Result,
    api::*,
};

fn main() -> Result<()> {
    let device_credentials = (
        "dnN3Ea43bhMTHtTvpytS",
        concat!(
        "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f",
        "202122232425262728292a2b2c2d2e2f303132333435363738393a3b3c3d3e3f",
        ),
    ).into();

    let mut ctn_client = CatenisClient::new_with_options(
        Some(device_credentials),
        &[
            ClientOptions::Environment(Environment::Sandbox),
        ],
    )?;

    let token_id = "ttbG9ia4AjdP5Pm7WaLG";
    let receiving_device = DeviceId {
        id: String::from("d8YpQ7jgPBJEkBrnvp58"),
        is_prod_unique_id: None,
    };
  
    ctn_client.transfer_non_fungible_token(token_id, receiving_device, None)?;
  
    println!("Non-fungible token successfully transferred");
  
    Ok(())
}
```

### Accessibility

Private

### Request

POST /assets/non-fungible/tokens/`:tokenId`/transfer

### Parameters

<!-- Note: we are not using the native markdown list feature for the second level items because the generated
        HTML has no space to the following first level item -->
- URL parameters:
<ul class="parameterList">
  <li>`tokenId`: The ID of the non-fungible token to transfer.</li>
</ul>

* Request body:

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `receivingDevice` | Object | Virtual device to which the non-fungible token is to be transferred. |
| &nbsp;&nbsp;`id` | String | The ID of the receiving device. Should be a device ID unless `isProdUniqueId` is set. |
| &nbsp;&nbsp;`isProdUniqueId` | Boolean | *(optional, default: __`false`__)* Indicates whether the supplied ID is a product unique ID. |
| `async` | Boolean | *(optional, default: __`false`__)* Indicates whether processing should be done asynchronously. |

<aside class="notice">
When transferring a non-fungible token, if that token or any other token currently held by the same bitcoin unspent
 transaction output (UTXO) have a metadata with sensitive properties and/or their contents are encrypted, the data of
 those non-fungible tokens will need to be rewritten so that the encrypted data is re-encrypted with the new
 encryption keys (belonging to the receiving device).
</aside>

<aside class="notice">
To avoid a possible timeout while waiting for Catenis to process a non-fungible token transfer, especially when a large
 amount of non-fungible token data needs to be rewritten (see notice above), one may choose to do the processing
 asynchronously — <code>async</code> property set to <code><b>true</b></code>. In that case, the call will return
 immediately with a <b>token transfer ID</b>, which should then be used to retrieve the non-fungible token transfer
 progress by calling the <a href="#retrieve-non-fungible-token-transfer-progress">Retrieve Non-Fungible Token Transfer Progress</a>
 API method.
</aside>

> Sample response:

```json
{
  "status": "success",
  "data": {
    "success": true
  }
}
```

### Success response

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `status` | String | The value **`success`**, indicating that the request was successful. |
| `data` | Object | The actual data returned in response to the API request. |
| &nbsp;&nbsp;`tokenTransferId` | String | *(only returned when doing processing asynchronously)* The non-fungible token transfer ID. Used for retrieving the progress of an asynchronous non-fungible token transfer. |
| &nbsp;&nbsp;`success` | Boolean | *(__not__ returned when doing processing asynchronously)* The value **`true`**, indicating that the non-fungible token has been successfully transferred. |

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_320">Invalid non-fungible token ID</a><br><a href="#error_msg_135">Invalid receiving device</a><br><a href="#error_msg_375">No possession to transfer non-fungible token</a><br><a href="#error_msg_370">Not enough credits to pay for transfer non-fungible token service</a><br><a href="#error_msg_325">Unavailable or inconsistent non-fungible token</a> |
| 403 | <a href="#error_msg_365">No permission to transfer non-fungible token to receiving device</a> |
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |
