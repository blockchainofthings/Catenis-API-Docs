## Asset Export Outcome

Retrieve the current information about the outcome of an asset export.

<aside class="notice">
Only the virtual device that issued the asset export can retrieve information about its outcome.
</aside>

> Sample request:

```http--raw
GET /api/0.12/assets/aH2AkrrL55GcThhPNa3J/export/ethereum HTTP/1.1
X-BCoT-Timestamp: 20210810T195125Z
Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20210810/ctn1_request, Signature=2d30b89906b459b0ebc5c5df6bf12b862b59851530a636c11320d2fd89c5614e
Host: localhost:3000
Connection: close
User-Agent: Paw/3.2.3 (Macintosh; OS X/11.5.0) GCDHTTPRequest
```

```shell
curl "http://localhost:3000/api/0.12/assets/aH2AkrrL55GcThhPNa3J/export/ethereum" \
     -H 'X-BCoT-Timestamp: 20210810T195231Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20210810/ctn1_request, Signature=3fc5a2654f845c15b0fa731094e9ac8b7f0aa1b2f657580c162985e31d3b5438'
```

```html--javascript
<script src="CatenisAPIClientJS.min.js"></script>

<script language="JavaScript">
var deviceId = 'dnN3Ea43bhMTHtTvpytS';

var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'sandbox'
});

var assetId = 'aH2AkrrL55GcThhPNa3J';
var foreignBlockchain = 'ethereum';

ctnApiClient.assetExportOutcome(assetId, foreignBlockchain, function(error, data) {
    if (error) {
        // Process error
    }
    else {
        // Process returned data
        if (data.status === 'success') {
            // Asset successfully exported
            console.log('Foreign token ID (address):', data.token.id);
        }
        else if (data.status === 'pending') {
            // Final asset export state not yet reached
        }
        else {
            // Asset export has failed. Process error
            console.error('Error executing foreign blockchain transaction:', data.foreignTransaction.error);
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

var assetId = 'aH2AkrrL55GcThhPNa3J';
var foreignBlockchain = 'ethereum';

ctnApiClient.assetExportOutcome(assetId, foreignBlockchain, function(error, data) {
    if (error) {
        // Process error
    }
    else {
        // Process returned data
        if (data.status === 'success') {
            // Asset successfully exported
            console.log('Foreign token ID (address):', data.token.id);
        }
        else if (data.status === 'pending') {
            // Final asset export state not yet reached
        }
        else {
            // Asset export has failed. Process error
            console.error('Error executing foreign blockchain transaction:', data.foreignTransaction.error);
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

$assetId = 'aH2AkrrL55GcThhPNa3J';
$foreignBlockchain = 'ethereum';

try {
    $data = $ctnApiClient->assetExportOutcome($assetId, $foreignBlockchain);

    // Process returned data
    if ($data->status === 'success') {
        // Asset successfully exported
        echo 'Foreign token ID (address): ' . $data->token->id . PHP_EOL;
    } elseif ($data->status === 'pending') {
        // Final asset export state not yet reached
    } else {
        // Asset export has failed. Process error
        echo 'Error executing foreign blockchain transaction: ' . $data->foreignTransaction->error . PHP_EOL;
    }
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

    let asset_id = "aH2AkrrL55GcThhPNa3J";

    let result = ctn_client.asset_export_outcome(
        asset_id,
        ForeignBlockchain::Ethereum,
    )?;

    match result.status {
        AssetExportStatus::Success => {
            // Asset successfully exported
            println!("Foreign token ID (address): {}", result.token.id.unwrap());
        },
        AssetExportStatus::Pending => {
            // Final asset export state not yet reached
        },
        AssetExportStatus::Error => {
            // Asset export has failed. Process error
            println!(
                "Error executing foreign blockchain transaction: {}",
                result.foreign_transaction.error.unwrap()
            );
        },
    }

    Ok(())
}
```

### Accessibility

Private

### Request

GET /assets/`:assetId`/export/`:foreignBlockchain`

### Parameters

<!-- Note: we are not using the native markdown list feature for the second level items because the generated
        HTML has no space to the following first level item -->
- URL parameters:
<ul class="parameterList">
  <li>`assetId`: The ID of the asset that was exported.</li>
  <li>`foreignBlockchain`: The key identifying the foreign blockchain. Valid options: `ethereum`, `binance`, `polygon`.</li>
</ul>

> Sample response:

```json
{
  "status": "success",
  "data": {
    "foreignTransaction": {
      "txid": "0x1f14474f441557056055a186ccf6839bd4dfce79e0b134d77084b6ef4274dc1a",
      "isPending": false,
      "success": true
    },
    "token": {
      "name": "Catenis test token #10",
      "symbol": "CTK10",
      "id": "0x537580164Ba9DB2e8C254a38E254ce15d07fDef9"
    },
    "status": "success",
    "date": "2021-08-03T18:41:27.679Z"
  }
}
```

### Success response

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `status` | String | The value **`success`**, indicating that the request was successful. |
| `data` | Object | The actual data returned in response to the API request. |
| &nbsp;&nbsp;`foreignTransaction` | Object | Information about the transaction issued on the foreign blockchain to create the resulting foreign token. |
| &nbsp;&nbsp;&nbsp;&nbsp;`txid` | String | The ID (or hash) of the foreign blockchain transaction. |
| &nbsp;&nbsp;&nbsp;&nbsp;`isPending` | Boolean | Indicates whether the foreign blockchain transaction is yet to be executed. |
| &nbsp;&nbsp;&nbsp;&nbsp;`success` | Boolean | *(only returned after the foreign blockchain transaction is executed)* Indicates whether the foreign blockchain transaction has been successfully executed or not. |
| &nbsp;&nbsp;&nbsp;&nbsp;`error` | String | *(only returned if the foreign blockchain transaction's execution has failed)* An error message describing what went wrong when executing the transaction. |
| &nbsp;&nbsp;`token` | Object | Information about the resulting foreign token. |
| &nbsp;&nbsp;&nbsp;&nbsp;`name` | String | The token name. |
| &nbsp;&nbsp;&nbsp;&nbsp;`symbol` | String | The token symbol. |
| &nbsp;&nbsp;&nbsp;&nbsp;`id` | String | *(only returned if the asset is successfully export)* The ID (or address) of the token on the foreign blockchain. |
| &nbsp;&nbsp;`status` | String | The current state of the asset export. One of: `pending`, `success`, or `error` |
| &nbsp;&nbsp;`date` | String | <a href="https://en.wikipedia.org/wiki/ISO_8601" target="_blank">ISO 8601</a> formatted date and time when the asset has been exported. |

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_8">Asset is not yet exported</a><br><a href="#error_msg_105">Invalid asset ID</a><br><a href="#error_msg_130">Invalid parameters: <i>&lt;param_list&gt;</i></a><br><a href="#error_msg_240">Not a regular (fungible) asset</a> |
| 403 | <a href="#error_msg_186">No permission to retrieve asset export outcome</a> |
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |
