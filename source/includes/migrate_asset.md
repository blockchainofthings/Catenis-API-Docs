## Migrate Asset

Migrate an amount of a previously exported asset to/from the foreign blockchain token.

The migration can occur in two directions: outward or inward. When out-migrating, the specified amount is deducted from
 the asset and credited to the foreign token. Otherwise, when in-migrating, the specified amount is deducted from the
 foreign token and credited to the asset.

<aside class="notice">
Only the virtual device that exported the asset can migrate an amount of it.
</aside>

<aside class="notice">
To in-migrate an asset amount, one needs first to credit the corresponding foreign token amount to the virtual device's
 client foreign blockchain asset export admin account, the address of which can be obtained from Catenis's client admin
 UI.
</aside>

<aside class="notice">
This method requires that an amount of the foreign blockchain's native coin be spent to pay for the execution of the
 issued foreign blockchain transaction. That amount is taken from the virtual device's client foreign blockchain asset
 export admin account, and it is the end user's responsibility to fund it (via Catenis's client admin UI).
</aside>
 
> Sample request:

```http--raw
POST /api/0.11/assets/aH2AkrrL55GcThhPNa3J/migrate/ethereum HTTP/1.1
X-BCoT-Timestamp: 20210810T121125Z
Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20210810/ctn1_request, Signature=e0493fed7f758c444bc29be683723165e255df40549ecc60d292d5745e1dcb68
Content-Type: application/json; charset=utf-8
Host: localhost:3000
Connection: close
User-Agent: Paw/3.2.3 (Macintosh; OS X/11.5.0) GCDHTTPRequest
Content-Length: 108

{"migration":{"direction":"outward","amount":50.5,"destAddress":"0xe247c9BfDb17e7D8Ae60a744843ffAd19C784943"}}
```

```shell
curl -X "POST" "http://localhost:3000/api/0.11/assets/aH2AkrrL55GcThhPNa3J/migrate/ethereum" \
     -H 'X-BCoT-Timestamp: 20210809T203625Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20210809/ctn1_request, Signature=a94d8ed1df52dfd21959f3a04436bdc68f47ea41685cd7f20fbf126f6fec63df' \
     -H 'Content-Type: application/json; charset=utf-8' \
     -d $'{
  "migration": {
    "amount": 50.5,
    "direction": "outward",
    "destAddress": "0xe247c9BfDb17e7D8Ae60a744843ffAd19C784943"
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

ctnApiClient.migrateAsset(assetId, foreignBlockchain, {
    direction: 'outward',
    amount: 50.5,
    destAddress: '0xe247c9BfDb17e7D8Ae60a744843ffAd19C784943'
}, function (error, data) {
    if (error) {
        // Process error
    }
    else {
        // Process returned data
        console.log('Pending asset migration:', data);
        
        // Start polling for asset migration outcome
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

ctnApiClient.migrateAsset(assetId, foreignBlockchain, {
    direction: 'outward',
    amount: 50.5,
    destAddress: '0xe247c9BfDb17e7D8Ae60a744843ffAd19C784943'
}, function (error, data) {
    if (error) {
        // Process error
    }
    else {
        // Process returned data
        console.log('Pending asset migration:', data);
        
        // Start polling for asset migration outcome
    }
});
```

```php
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
    $data = $ctnApiClient->migrateAsset($assetId, $foreignBlockchain, [
        'direction' => 'outward',
        'amount' => 50.5,
        'destAddress' => '0xe247c9BfDb17e7D8Ae60a744843ffAd19C784943'
    ]);

    // Process returned data
    echo 'Pending asset migration: ' . print_r($data, true);
    
    // Start polling for asset migration outcome
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

    let result = ctn_client.migrate_asset(
        asset_id,
        ForeignBlockchain::Ethereum,
        AssetMigration::Info(AssetMigrationInfo {
            direction: AssetMigrationDirection::Outward,
            amount: 50.5,
            dest_address: Some(String::from("0xe247c9BfDb17e7D8Ae60a744843ffAd19C784943")),
        }),
        None,
    )?;

    println!("Pending asset migration: {:?}", result);

    // Start polling for asset migration outcome

    Ok(())
}
```

### Accessibility

Private

### Request

POST /assets/`:assetId`/migrate/`:foreignBlockchain`

### Parameters

<!-- Note: we are not using the native markdown list feature for the second level items because the generated
        HTML has no space to the following first level item -->
- URL parameters:
<ul class="parameterList">
  <li>`assetId`: The ID of the asset to migrate an amount of it.</li>
  <li>`foreignBlockchain`: The key identifying the foreign blockchain. Valid options: `ethereum`, `binance`, `polygon`.</li>
</ul>

* Request body:

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `migration` | Object&#124;String | Object describing a new asset migration, or the ID of the asset migration to be reprocessed. |
| &nbsp;&nbsp;`direction` | String | The direction of the migration. Valid options: `outward`, `inward`. |
| &nbsp;&nbsp;`amount` | Number | The amount of the asset to be migrated. |
| &nbsp;&nbsp;`destAddress` | String | *(optional, only required for an out-migration)* The address of the account on the foreign blockchain that should be credited with the specified amount of the foreign token. |
| `options` | Object | *(optional)* |
| &nbsp;&nbsp;`consumptionProfile` | String | *(optional)* Name of the foreign blockchain's native coin consumption profile to use. Valid options: `fastest`, `fast`, `average`, `slow`. |
| &nbsp;&nbsp;`estimateOnly` | Boolean | *(optional, default: __`false`__)* When set, indicates that no asset migration should be executed but only the estimated price (in the foreign blockchain's native coin) to fulfill the operation should be returned. |

<aside class="notice">
If the <code>options.consumptionProfile</code> property is not specified, the value currently set (via Catenis's client
 admin UI) for the virtual device's client foreign blockchain consumption profile is used.
</aside>

> Sample response (regular migration):

```json
{
  "status": "success",
  "data": {
    "migrationId": "gq8x3efLpEXTkGQchHTb",
    "catenisService": {
      "status": "fulfilled",
      "txid": "61fcb4feb64ecf3b39b4bb6d64eb9cc68a58ba1d892f981ef568d07b7aa11fdf"
    },
    "foreignTransaction": {
      "txid": "0x212ab54f136a6fc1deae9ec217ef2d0417615178777131e8bb6958447fd20fe7",
      "isPending": true
    },
    "status": "pending",
    "date": "2021-08-03T18:51:26.631Z"
  }
}
```

> Sample response (estimate only):

```json
{
  "status": "success",
  "data": {
    "estimatedPrice": "0.001723913"
  }
}
```

### Success response

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `status` | String | The value **`success`**, indicating that the request was successful. |
| `data` | Object | The actual data returned in response to the API request. |
| &nbsp;&nbsp;`migrationId` | String | *(not returned for estimate only)* A unique ID used to identify this asset migration. |
| &nbsp;&nbsp;`catenisService` | Object | *(not returned for estimate only)* Information about the execution of the migrate asset Catenis service. |
| &nbsp;&nbsp;&nbsp;&nbsp;`status` | String | The current state of the service's execution. One of: `awaiting`, `failure`, or `fulfilled`. |
| &nbsp;&nbsp;&nbsp;&nbsp;`txid` | String | *(only returned if the service is successfully fulfilled)* The ID of the Catenis transaction issued to fulfill the service. |
| &nbsp;&nbsp;&nbsp;&nbsp;`error` | String | *(only returned if the service's execution has failed)* An error message describing what went wrong when executing the service. |
| &nbsp;&nbsp;`foreignTransaction` | Object | *(not returned for estimate only)* Information about the transaction issued on the foreign blockchain to mint/burn the amount of the foreign token. |
| &nbsp;&nbsp;&nbsp;&nbsp;`txid` | String | The ID (or hash) of the foreign blockchain transaction. |
| &nbsp;&nbsp;&nbsp;&nbsp;`isPending` | Boolean | Indicates whether the foreign blockchain transaction is yet to be executed. |
| &nbsp;&nbsp;&nbsp;&nbsp;`success` | Boolean | *(only returned after the foreign blockchain transaction is executed)* Indicates whether the foreign blockchain transaction has been successfully executed or not. |
| &nbsp;&nbsp;&nbsp;&nbsp;`error` | String | *(only returned if the foreign blockchain transaction's execution has failed)* An error message describing what went wrong when executing the transaction. |
| &nbsp;&nbsp;`status` | String | *(not returned for estimate only)* The current state of the asset migration. One of: `pending`, `interrupted`, `success`, or `error`. |
| &nbsp;&nbsp;`date` | String | *(not returned for estimate only)* <a href="https://en.wikipedia.org/wiki/ISO_8601" target="_blank">ISO 8601</a> formatted date and time when the asset amount has been migrated. |
| &nbsp;&nbsp;`estimatedPrice` | String | *(only returned for estimate only)* A text value representing the price, in the foreign blockchain's native coin, required to execute the foreign blockchain transaction. |

<aside class="notice">
The status value <code>interrupted</code> represents a final state that indicates that the migration started (amount
 successfully deducted) but failed during its final step (to credit the amount). Note that this is an
 <b>inconsistent</b> state, and the migration should be <b>reprocessed</b>.
</aside>

<aside class="notice">
Note that the estimated price is <b>volatile</b>, and it will vary depending on the current foreign blockchain fee
 market. Thus it is possible that, when the asset amount is finally migrated, the actual price charged will be
 <b>different</b> than the returned value.
</aside>

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_4">Amount to migrate is too large</a><br><a href="#error_msg_8">Asset is not yet exported</a><br><a href="#error_msg_9">Asset migration already successfully processed</a><br><a href="#error_msg_80">Discarded concurrent foreign token smart contract call</a><br><a href="#error_msg_90">Foreign blockchain funds not enough to cover transaction execution price (<i>&lt;value&gt;</i>)</a><br><a href="#error_msg_91">Foreign token balance too low to in-migrate the asset amount</a><br><a href="#error_msg_93">Insufficient balance to out-migrate asset</a><br><a href="#error_msg_97">Insufficient migrated asset amount to in-migrate asset</a><br><a href="#error_msg_105">Invalid asset ID</a><br><a href="#error_msg_107">Invalid asset migration ID</a><br><a href="#error_msg_113">Invalid foreign blockchain destination address</a><br><a href="#error_msg_130">Invalid parameters: <i>&lt;param_list&gt;</i></a><br><a href="#error_msg_153">Mismatched asset migration</a><br><a href="#error_msg_165">Not enough credits to pay for migrate asset service</a><br><a href="#error_msg_230">Unexpected error calling foreign token smart contract</a> |
| 403 | <a href="#error_msg_178">No permission to migrate asset</a> |
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |
