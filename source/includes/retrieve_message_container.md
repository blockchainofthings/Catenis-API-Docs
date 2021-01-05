## Retrieve Message Container

Gets information about the place where a previously recorded — either logged or sent — message is actually
stored.

<aside class="notice">
A message container can be retrieved either by the virtual device that originally recorded (logged/sent) the message
 or by the virtual device that received the message.
</aside>

> Sample request:

```http--raw
GET /api/0.10/messages/oDWPuD5kjCsEiNEEWwrW/container HTTP/1.1
X-BCoT-Timestamp: 20180215T200325Z
Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180215/ctn1_request, Signature=f06dc359270c2a3a91326ef2e7fd5506fd75dc9740b2609ed796ce01b3f92afb
Host: sandbox.catenis.io
Connection: close
User-Agent: Paw/3.1.5 (Macintosh; OS X/10.13.3) GCDHTTPRequest
```

```shell
curl "https://sandbox.catenis.io/api/0.10/messages/oDWPuD5kjCsEiNEEWwrW/container" \
     -H 'X-BCoT-Timestamp: 20180215T200350Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180215/ctn1_request, Signature=7e50993e18975294f7f22aae7ee7ef4e4d68425502e38961c40743b1f72194eb'
```

```html--javascript
<script src="CatenisAPIClientJS.min.js"></script>

<script language="JavaScript">
var deviceId = 'dnN3Ea43bhMTHtTvpytS';

var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'sandbox'
});

var messageId = 'oDWPuD5kjCsEiNEEWwrW';

ctnApiClient.retrieveMessageContainer(messageId, function (err, data) {
    if (err) {
        // Process error
    }
    else {
        // Process returned data
        if (data.offChain) {
            console.log('IPFS CID of Catenis off-chain message envelope:', data.offChain.cid);
        }
        
        if (data.blockchain) {
            console.log('ID of blockchain transaction containing the message:', data.blockchain.txid);
        }

        if (data.externalStorage) {
            console.log('IPFS reference to message:', data.externalStorage.ipfs);
        }
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

var messageId = 'oDWPuD5kjCsEiNEEWwrW';

ctnApiClient.retrieveMessageContainer(messageId, function (err, data) {
    if (err) {
        // Process error
    }
    else {
        // Process returned data
        if (data.offChain) {
            console.log('IPFS CID of Catenis off-chain message envelope:', data.offChain.cid);
        }
        
        if (data.blockchain) {
            console.log('ID of blockchain transaction containing the message:', data.blockchain.txid);
        }

        if (data.externalStorage) {
            console.log('IPFS reference to message:', data.externalStorage.ipfs);
        }
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

$messageId = 'oDWPuD5kjCsEiNEEWwrW';

try {
    $data = $ctnApiClient->retrieveMessageContainer($messageId);

    // Process returned data
    if (isset($data->offChain)) {
        echo 'IPFS CID of Catenis off-chain message envelope: ' . $data->offChain->cid . PHP_EOL;
    }
    
    if (isset($data->blockchain)) {
        echo 'ID of blockchain transaction containing the message: ' . $data->blockchain->txid . PHP_EOL;
    }

    if (isset($data->externalStorage)) {
        echo 'IPFS reference to message: ' . $data->externalStorage->ipfs . PHP_EOL;
    }
}
catch (CatenisException $ex) {
    // Process exception
}
```

```rust
use catenis_api_client::{
    CatenisClient, ClientOptions, Environment, Result,
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

    let message_id = "oDWPuD5kjCsEiNEEWwrW";

    let result = ctn_client.retrieve_message_container(
        message_id,
    )?;

    if let Some(off_chain) = result.off_chain {
        println!("IPFS CID of Catenis off-chain message envelope: {}", off_chain.cid);
    }

    if let Some(blockchain) = result.blockchain {
        println!("ID of blockchain transaction containing the message: {}", blockchain.txid);
    }

    if let Some(external_storage) = result.external_storage {
        println!("IPFS reference to message: {}", external_storage.ipfs);
    }

    Ok(())
}
```

### Accessibility

Private

### Request

GET /messages/`:messageId`/container

### Parameters

<!-- Note: we are not using the native markdown list feature for the second level items because the generated
        HTML has no space to the following first level item -->
- URL parameters:
<ul class="parameterList">
  <li>`messageId`: The ID of the message the container of which is to be retrieved.</li>
</ul>

> Sample response:

```json
{
  "status": "success",
  "data": {
    "offChain": {
      "cid": "QmUPNgbkB2esFHLZdS5rhD8wxFaCBU8JeBrBePWqMfSWub"
    },
    "blockchain": {
      "txid": "e4080d2badac0b4d4524aa20cd3abfa2f1bdd05a15c85b9d156374c7c6bbfc82",
      "isConfirmed": true
    },
    "externalStorage": {
      "ipfs": "QmQ2UaYLHwSjU4VvHyD4SfCUyo7AvrufdNrX1kmsbtbn3w"
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
| &nbsp;&nbsp;`offChain` | Object | *(only returned for Catenis off-chain messages)* |
| &nbsp;&nbsp;&nbsp;&nbsp;`cid` | String | IPFS CID of Catenis off-chain message envelope data structure that holds the off-chain message's contents. |
| &nbsp;&nbsp;`blockchain` | Object | *(for Catenis off-chain messages, this property refers to the transaction used to settle the message to the blockchain, and it is only returned at a later time after the settlement takes place)* |
| &nbsp;&nbsp;&nbsp;&nbsp;`txid` | String | The ID of the blockchain transaction where the message was recorded. |
| &nbsp;&nbsp;&nbsp;&nbsp;`isConfirmed` | Boolean | Indicates whether the blockchain transaction has already been confirmed. |
| &nbsp;&nbsp;`externalStorage` | Object | *(only returned if message is stored on an external storage rather than on the blockchain transaction itself)* |
| &nbsp;&nbsp;&nbsp;&nbsp;`ipfs` | String | The hash used to reference the message on IPFS. |

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_80">Device is deleted</a><br><a href="#error_msg_90">Device is not active</a><br><a href="#error_msg_120">Invalid message ID</a><br><a href="#error_msg_130">Invalid parameters</a> |
| 403 | <a href="#error_msg_200">No permission to retrieve message container</a> |
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |
