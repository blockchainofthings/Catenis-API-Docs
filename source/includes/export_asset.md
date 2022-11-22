## Export Asset

Export an asset to a foreign blockchain, by creating a new (ERC-20 compliant) token on that blockchain.

<aside class="notice">
Only the virtual device that issued the asset can export it.
</aside>

<aside class="notice">
This method requires that an amount of the foreign blockchain's native coin be spent to pay for the execution of the
 issued foreign blockchain transaction. That amount is taken from the virtual device's client foreign blockchain asset
 export admin account, and it is the end user's responsibility to fund it (via Catenis's client admin UI).
</aside>

> Sample request:

```http--raw
POST /api/0.13/assets/aH2AkrrL55GcThhPNa3J/export/ethereum HTTP/1.1
X-BCoT-Timestamp: 20210809T144134Z
Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20210809/ctn1_request, Signature=87ed19ecefc670d61d4d85c0da80b608fc102a060e45c3d5caa5057eefc33d13
Content-Type: application/json; charset=utf-8
Host: localhost:3000
Connection: close
User-Agent: Paw/3.2.3 (Macintosh; OS X/11.5.0) GCDHTTPRequest
Content-Length: 60

{"token":{"name":"Catenis test token #10","symbol":"CTK10"}}
```

```shell
curl -X "POST" "http://localhost:3000/api/0.13/assets/aH2AkrrL55GcThhPNa3J/export/ethereum" \
     -H 'X-BCoT-Timestamp: 20210809T144203Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20210809/ctn1_request, Signature=989280734b7ebf40057ec305d02af8d2d899f78cddcfca1ff4d30c652a3b8dc6' \
     -H 'Content-Type: application/json; charset=utf-8' \
     -d $'{
  "token": {
    "name": "Catenis test token #10",
    "symbol": "CTK10"
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

var assetId = 'aH2AkrrL55GcThhPNa3J';
var foreignBlockchain = 'ethereum';

ctnApiClient.exportAsset(assetId, foreignBlockchain, {
    name: 'Catenis test token #10',
    symbol: 'CTK10'
}, function (error, data) {
    if (error) {
        // Process error
    }
    else {
        // Process returned data
        console.log('Pending asset export:', data);
        
        // Start polling for asset export outcome
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

ctnApiClient.exportAsset(assetId, foreignBlockchain, {
    name: 'Catenis test token #10',
    symbol: 'CTK10'
}, function (error, data) {
    if (error) {
        // Process error
    }
    else {
        // Process returned data
        console.log('Pending asset export:', data);
        
        // Start polling for asset export outcome
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
    $data = $ctnApiClient->exportAsset($assetId, $foreignBlockchain, [
        'name' => 'Catenis test token #10',
        'symbol' => 'CTK10'
    ]);

    // Process returned data
    echo 'Pending asset export: ' . print_r($data, true);
    
    // Start polling for asset export outcome
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

    let result = ctn_client.export_asset(
        asset_id,
        ForeignBlockchain::Ethereum,
        NewForeignTokenInfo {
            name: String::from("Catenis test token #10"),
            symbol: String::from("CTK10"),
        },
        None,
    )?;

    println!("Pending asset export: {:?}", result);

    // Start polling for asset export outcome

    Ok(())
}
```

### Accessibility

Private

### Request

POST /assets/`:assetId`/export/`:foreignBlockchain`

### Parameters

<!-- Note: we are not using the native markdown list feature for the second level items because the generated
        HTML has no space to the following first level item -->
- URL parameters:
<ul class="parameterList">
  <li>`assetId`: The ID of the asset to export.</li>
  <li>`foreignBlockchain`: The key identifying the foreign blockchain. Valid options: `ethereum`, `binance`, `polygon`.</li>
</ul>

* Request body:

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `token` | Object | |
| &nbsp;&nbsp;`name` | String | The name of the token to be created on the foreign blockchain. |
| &nbsp;&nbsp;`symbol` | String | The symbol of the token to be created on the foreign blockchain. |
| `options` | Object | *(optional)* |
| &nbsp;&nbsp;`consumptionProfile` | String | *(optional)* Name of the foreign blockchain's native coin consumption profile to use. Valid options: `fastest`, `fast`, `average`, `slow`. |
| &nbsp;&nbsp;`estimateOnly` | Boolean | *(optional, default: __`false`__)* When set, indicates that no asset export should be executed but only the estimated price (in the foreign blockchain's native coin) to fulfill the operation should be returned. |

<aside class="notice">
If the <code>options.consumptionProfile</code> property is not specified, the value currently set (via Catenis's client
 admin UI) for the virtual device's client foreign blockchain consumption profile is used.
</aside>

> Sample response (regular export):

```json
{
  "status": "success",
  "data": {
    "foreignTransaction": {
      "txid": "0x1f14474f441557056055a186ccf6839bd4dfce79e0b134d77084b6ef4274dc1a",
      "isPending": true
    },
    "token": {
      "name": "Catenis test token #10",
      "symbol": "CTK10"
    },
    "status": "pending",
    "date": "2021-08-03T18:41:11.781Z"
  }
}
```

> Sample response (estimate only):

```json
{
  "status": "success",
  "data": {
    "estimatedPrice": "0.05850782"
  }
}
```

### Success response

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `status` | String | The value **`success`**, indicating that the request was successful. |
| `data` | Object | The actual data returned in response to the API request. |
| &nbsp;&nbsp;`foreignTransaction` | Object | *(not returned for estimate only)* Information about the transaction issued on the foreign blockchain to create the resulting foreign token. |
| &nbsp;&nbsp;&nbsp;&nbsp;`txid` | String | The ID (or hash) of the foreign blockchain transaction. |
| &nbsp;&nbsp;&nbsp;&nbsp;`isPending` | Boolean | Indicates whether the foreign blockchain transaction is yet to be executed. |
| &nbsp;&nbsp;&nbsp;&nbsp;`success` | Boolean | *(only returned after the foreign blockchain transaction is executed)* Indicates whether the foreign blockchain transaction has been successfully executed or not. |
| &nbsp;&nbsp;&nbsp;&nbsp;`error` | String | *(only returned if the foreign blockchain transaction's execution has failed)* An error message describing what went wrong when executing the transaction. |
| &nbsp;&nbsp;`token` | Object | *(not returned for estimate only)* Information about the resulting foreign token. |
| &nbsp;&nbsp;&nbsp;&nbsp;`name` | String | The token name. |
| &nbsp;&nbsp;&nbsp;&nbsp;`symbol` | String | The token symbol. |
| &nbsp;&nbsp;&nbsp;&nbsp;`id` | String | *(only returned if the asset is successfully export)* The ID (or address) of the token on the foreign blockchain. |
| &nbsp;&nbsp;`status` | String | *(not returned for estimate only)* The current state of the asset export. One of: `pending`, `success`, or `error`. |
| &nbsp;&nbsp;`date` | String | *(not returned for estimate only)* <a href="https://en.wikipedia.org/wiki/ISO_8601" target="_blank">ISO 8601</a> formatted date and time when the asset has been exported. |
| &nbsp;&nbsp;`estimatedPrice` | String | *(only returned for estimate only)* A text value representing the price, in the foreign blockchain's native coin, required to execute the foreign blockchain transaction. |

<aside class="notice">
Note that the estimated price is <b>volatile</b>, and it will vary depending on the current foreign blockchain fee
 market. Thus it is possible that, when the asset is finally exported, the actual price charged will be <b>different</b>
 than the returned value.
</aside>

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_6">Asset already exported</a><br><a href="#error_msg_80">Discarded concurrent foreign token smart contract call</a><br><a href="#error_msg_90">Foreign blockchain funds not enough to cover transaction execution price (<i>&lt;value&gt;</i>)</a><br><a href="#error_msg_105">Invalid asset ID</a><br><a href="#error_msg_130">Invalid parameters: <i>&lt;param_list&gt;</i></a><br><a href="#error_msg_240">Not a regular (fungible) asset</a><br><a href="#error_msg_230">Unexpected error calling foreign token smart contract</a> |
| 403 | <a href="#error_msg_176">No permission to export asset</a> |
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |
