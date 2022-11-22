## Retrieve Message Origin *

Gets information about the origin of a previously recorded — either logged or sent — message.

> Sample request:

```http--raw
GET /api/0.13/messages/oDWPuD5kjCsEiNEEWwrW/origin?msgToSign=This%20is%20only%20a%20test HTTP/1.1
Host: sandbox.catenis.io
Connection: close
User-Agent: Paw/3.1.5 (Macintosh; OS X/10.13.3) GCDHTTPRequest
```

```shell
curl "https://sandbox.catenis.io/api/0.13/messages/oDWPuD5kjCsEiNEEWwrW/origin?msgToSign=This%20is%20only%20a%20test"
```

```html--javascript
<script src="CatenisAPIClientJS.min.js"></script>

<script language="JavaScript">
var ctnApiClient = new CtnApiClient({
    environment: 'sandbox'
});

var messageId = 'oDWPuD5kjCsEiNEEWwrW';

ctnApiClient.retrieveMessageOrigin(messageId, 'Any text to be signed',
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            if (data.tx) {
                console.log('Catenis message transaction info:', data.tx);
            }

            if (data.offChainMsgEnvelope) {
                console.log('Off-chain message envelope info:', data.offChainMsgEnvelope);
            }

            if (data.proof) {
                console.log('Origin proof info:', data.proof);
            }
        }
});
</script>
```

```javascript--node
var CtnApiClient = require('catenis-api-client');

var ctnApiClient = new CtnApiClient({
    environment: 'sandbox'
});

var messageId = 'oDWPuD5kjCsEiNEEWwrW';

ctnApiClient.retrieveMessageOrigin(messageId, 'Any text to be signed',
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            if (data.tx) {
                console.log('Catenis message transaction info:', data.tx);
            }

            if (data.offChainMsgEnvelope) {
                console.log('Off-chain message envelope info:', data.offChainMsgEnvelope);
            }

            if (data.proof) {
                console.log('Origin proof info:', data.proof);
            }
        }
});
```

```php
<?php
require __DIR__ . '/vendor/autoload.php';

use Catenis\ApiClient;
use Catenis\Exception\CatenisException;

$ctnApiClient = new ApiClient(null, null, [
    'environment' => 'sandbox'
]);

$messageId = 'oDWPuD5kjCsEiNEEWwrW';

try {
    $data = $ctnApiClient->retrieveMessageOrigin($messageId, 'Any text to be signed');

    // Process returned data
    if (isset($data->tx)) {
        echo 'Catenis message transaction info: ' . print_r($data->tx, true);
    }
    
    if (isset($data->offChainMsgEnvelope)) {
        echo 'Off-chain message envelope info: ' . print_r($data->offChainMsgEnvelope, true);
    }

    if (isset($data->proof)) {
        echo 'Origin proof info: ' . print_r($data->proof, true);
    }
}
catch (\Catenis\Exception\CatenisException $ex) {
    // Process exception
}
```

```rust
use catenis_api_client::{
    CatenisClient, ClientOptions, Environment, Result,
};

fn main() -> Result<()> {
    let ctn_client = CatenisClient::new_with_options(
        None,
        &[
            ClientOptions::Environment(Environment::Sandbox),
        ],
    )?;

    let message_id = "oDWPuD5kjCsEiNEEWwrW";

    let result = ctn_client.retrieve_message_origin(
        message_id,
        Some("Any text to be signed"),
    )?;

    if let Some(tx) = result.tx {
        println!("Catenis message transaction info: {:?}", tx);
    }

    if let Some(off_chain_msg_env) = result.off_chain_msg_envelope {
        println!("Off-chain message envelope info: {:?}", off_chain_msg_env);
    }

    if let Some(proof) = result.proof {
        println!("Origin proof info: {:?}", proof);
    }

    Ok(())
}
```

### Accessibility

Public

### Request

GET /messages/`:messageId`/origin

### Parameters

<!-- Note: we are not using the native markdown list feature for the second level items because the generated
        HTML has no space to the following first level item -->
- URL parameters:
<ul class="parameterList">
  <li>`messageId`: The ID of the message the origin info of which is to be retrieved.</li>
</ul>

- Query string parameters:
<ul class="parameterList">
  <li>`msgToSign`: *(optional)* A message (any text) to be signed using the Catenis message's origin device's private
 key. The resulting signature can then later be independently verified to prove the Catenis message's origin.</li>
</ul>

> Sample response:

```json
{
  "status": "success",
  "data": {
    "tx": {
      "txid": "e80b97c1ee45da349f774e4e509c0ddce56003fa737ef37ab22e1b676fe4a9c8",
      "type": "Settle Off-Chain Messages",
      "batchDoc": {
        "cid": "QmT2kJRaShQbMEzjDVmqMtsjccqvUaemNNrXzkv6oVgi6d"
      }
    },
    "offChainMsgEnvelope": {
      "cid": "Qmd7xeEwwmWrJpovmTYhCTRjpfRPr9mtDxj7VRscrcqsgP",
      "type": "Log Message",
      "originDevice": {
        "pubKeyHash": "25f154093fe70c4a45518f858a1edececf208ee6",
        "deviceId": "drc3XdxNtzoucpw9xiRp",
        "name": "TstDev1",
        "prodUniqueId": "ABC123",
        "ownedBy": {
          "company": "Blockchain of Things",
          "contact": "Cláudio de Castro",
          "domains": [
            "blockchainofthings.com",
            "catenis.io"
          ]
        }
      }
    },
    "proof": {
      "message": "This is only a test",
      "signature": "H6bt6sl7T6VpOUQ1of0rjYEmT3u14h8gP7kmoWG4aEblNNc9Zx00tRaxcxPZgSxkmWH2427FBOFE5W/t9fgW4eU="
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
| &nbsp;&nbsp;`tx` | Object | *(not returned for off-chain messages not yet settled to the blockchain)* Information about the blockchain transaction used to record the Catenis message to the blockchain — the Catenis message transaction. |
| &nbsp;&nbsp;&nbsp;&nbsp;`txid` | String | ID of Catenis message transaction. |
| &nbsp;&nbsp;&nbsp;&nbsp;`type` | String | Type of Catenis message transaction. One of: `Send Message`, `Log Message`, or <code style="white-space: normal">Settle Off-Chain Messages</code>. |
| &nbsp;&nbsp;&nbsp;&nbsp;`batchDoc` | Object | *(only returned for off-chain messages)* Information about the batch document used to settle off-chain messages on the blockchain. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`cid` | String | Content ID (CID) of batch document on IPFS. |
| &nbsp;&nbsp;&nbsp;&nbsp;`originDevice` | Object | *(not returned for off-chain messages)* Information about the virtual device that recorded the message — the origin device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`address` | String | Origin device's blockchain address used to generate the Catenis message transaction. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`deviceId` | String | Device ID of origin device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`name` | String | *(only returned if defined)* Origin device's name. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`prodUniqueId` | String | *(only returned if defined)* Origin device's product unique ID. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`ownedBy` | Object | |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`company` | String | *(only returned if defined)* Name of company that owns the origin device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`contact` | String | *(only returned if defined and `company` is returned)* Name of company's contact. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`name` | String | *(only returned if `company` is not returned)* Name of the person who owns the origin device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`domains` | Array(String) | *(only returned if defined)* List of internet domains owned by this company or person. |
| &nbsp;&nbsp;`offChainMsgEnvelope` | Object | *(only returned for off-chain messages)* Information about the off-chain message envelope data structure used to record the Catenis message on IPFS. |
| &nbsp;&nbsp;&nbsp;&nbsp;`cid` | String | Content ID (CID) of off-chain message envelope on IPFS. |
| &nbsp;&nbsp;&nbsp;&nbsp;`type` | String | Type of Catenis off-chain message. One of: `Send Message`, or `Log Message`. |
| &nbsp;&nbsp;&nbsp;&nbsp;`originDevice` | Object | *(not returned for off-chain messages)* Information about the virtual device that recorded the message — the origin device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`pubKeyHash` | String | Hex-encoded hash of origin device's public key used to generate the off-chain message envelope. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`deviceId` | String | Device ID of origin device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`name` | String | *(only returned if defined)* Origin device's name. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`prodUniqueId` | String | *(only returned if defined)* Origin device's product unique ID. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`ownedBy` | Object | |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`company` | String | *(only returned if defined)* Name of company that owns the origin device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`contact` | String | *(only returned if defined and `company` is returned)* Name of company's contact. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`name` | String | *(only returned if `company` is not returned)* Name of the person who owns the origin device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`domains` | Array(String) | *(only returned if defined)* List of internet domains owned by this company or person. |
| &nbsp;&nbsp;`proof` | Object | *(only returned if `msgToSign` parameter is supplied)* |
| &nbsp;&nbsp;&nbsp;&nbsp;`message` | String | Message for which the signature was generated. |
| &nbsp;&nbsp;&nbsp;&nbsp;`signature` | String | Base64-encoded message's signature generated using origin device's private key. |

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_120">Invalid message ID</a> |
| 403 | <a href="#error_msg_151">Message origin cannot be disclosed</a> |
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |
