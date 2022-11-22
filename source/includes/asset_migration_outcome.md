## Asset Migration Outcome

Retrieve the current information about the outcome of an asset migration.

<aside class="notice">
Only the virtual device that issued the asset migration can retrieve information about its outcome.
</aside>

> Sample request:

```http--raw
GET /api/0.13/assets/migrations/gq8x3efLpEXTkGQchHTb HTTP/1.1
X-BCoT-Timestamp: 20210810T211045Z
Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20210810/ctn1_request, Signature=60c4f0069c227fca8780ecb263cac1b98f40d15416a21c54cd6c1498644a7915
Host: localhost:3000
Connection: close
User-Agent: Paw/3.2.3 (Macintosh; OS X/11.5.0) GCDHTTPRequest
```

```shell
curl "http://localhost:3000/api/0.13/assets/migrations/gq8x3efLpEXTkGQchHTb" \
     -H 'X-BCoT-Timestamp: 20210810T211101Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20210810/ctn1_request, Signature=97a742d0245a5b078bccaed62724d725826ba87d92ae0a6d160abe26ab0958af'
```

```html--javascript
<script src="CatenisAPIClientJS.min.js"></script>

<script language="JavaScript">
var deviceId = 'dnN3Ea43bhMTHtTvpytS';

var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'sandbox'
});

var migrationId = 'gq8x3efLpEXTkGQchHTb';

ctnApiClient.assetMigrationOutcome(migrationId, function(error, data) {
    if (error) {
        // Process error
    }
    else {
        // Process returned data
        if (data.status === 'success') {
            // Asset amount successfully migrated
            console.log('Asset amount successfully migrated');
        }
        else if (data.status === 'pending') {
            // Final asset migration state not yet reached
        }
        else {
            // Asset migration has failed. Process error
            if (data.catenisService.error) {
                console.error('Error executing Catenis service:', data.catenisService.error);
            }
            
            if (data.foreignTransaction.error) {
                console.error('Error executing foreign blockchain transaction:', data.foreignTransaction.error);
            }
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

var migrationId = 'gq8x3efLpEXTkGQchHTb';

ctnApiClient.assetMigrationOutcome(migrationId, function(error, data) {
    if (error) {
        // Process error
    }
    else {
        // Process returned data
        if (data.status === 'success') {
            // Asset amount successfully migrated
            console.log('Asset amount successfully migrated');
        }
        else if (data.status === 'pending') {
            // Final asset migration state not yet reached
        }
        else {
            // Asset migration has failed. Process error
            if (data.catenisService.error) {
                console.error('Error executing Catenis service:', data.catenisService.error);
            }
            
            if (data.foreignTransaction.error) {
                console.error('Error executing foreign blockchain transaction:', data.foreignTransaction.error);
            }
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

$migrationId = 'gq8x3efLpEXTkGQchHTb';

try {
    $data = $ctnApiClient->assetMigrationOutcome($migrationId);

    // Process returned data
    if ($data->status === 'success') {
        // Asset amount successfully migrated
        echo 'Asset amount successfully migrated' . PHP_EOL;
    } elseif ($data->status === 'pending') {
        // Final asset migration state not yet reached
    } else {
        // Asset migration has failed. Process error
        if (isset($data->catenisService->error)) {
            echo 'Error executing Catenis service: ' . $data->catenisService->error . PHP_EOL;
        }

        if (isset($data->foreignTransaction->error)) {
            echo 'Error executing foreign blockchain transaction: ' . $data->foreignTransaction->error . PHP_EOL;
        }
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

    let migration_id = "gq8x3efLpEXTkGQchHTb";

    let result = ctn_client.asset_migration_outcome(
        migration_id,
    )?;
  
    match result.status {
        AssetMigrationStatus::Success => {
            // Asset amount successfully migrated
            println!("Asset amount successfully migrated");
        },
        AssetMigrationStatus::Pending => {
            // Final asset migration state not yet reached
        },
        _ => {
            // Asset migration has failed. Process error
            if let Some(error) = result.catenis_service.error {
                println!("Error executing Catenis service: {}", error);
            }
      
            if let Some(error) = result.foreign_transaction.error {
                println!("Error executing foreign blockchain transaction: {}", error);
            }
        },
    }

    Ok(())
}
```

### Accessibility

Private

### Request

GET /assets/migrations/`:migrationId`

### Parameters

<!-- Note: we are not using the native markdown list feature for the second level items because the generated
        HTML has no space to the following first level item -->
- URL parameters:
<ul class="parameterList">
  <li>`migrationId`: The ID of the asset migration.</li>
</ul>

> Sample response:

```json
{
  "status": "success",
  "data": {
    "assetId": "aH2AkrrL55GcThhPNa3J",
    "foreignBlockchain": "ethereum",
    "direction": "outward",
    "amount": 10,
    "catenisService": {
      "status": "fulfilled",
      "txid": "61fcb4feb64ecf3b39b4bb6d64eb9cc68a58ba1d892f981ef568d07b7aa11fdf"
    },
    "foreignTransaction": {
      "txid": "0x212ab54f136a6fc1deae9ec217ef2d0417615178777131e8bb6958447fd20fe7",
      "isPending": false,
      "success": true
    },
    "status": "success",
    "date": "2021-08-03T18:51:55.591Z"
  }
}
```

### Success response

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `status` | String | The value **`success`**, indicating that the request was successful. |
| `data` | Object | The actual data returned in response to the API request. |
| &nbsp;&nbsp;`assetId` | String | The ID of the asset the amount of which has been migrated. |
| &nbsp;&nbsp;`foreignBlockchain` | String | The key identifying the foreign blockchain to/from where the asset amount has been migrated. One of: `ethereum`, `binance`, or `polygon`. |
| &nbsp;&nbsp;`direction` | String | The direction of the migration. One of: `outward` or `inward`. |
| &nbsp;&nbsp;`amount` | Number | The migrated asset amount. |
| &nbsp;&nbsp;`catenisService` | Object | Information about the execution of the migrate asset Catenis service. |
| &nbsp;&nbsp;&nbsp;&nbsp;`status` | String | The current state of the service's execution. One of: `awaiting`, `failure`, or `fulfilled`. |
| &nbsp;&nbsp;&nbsp;&nbsp;`txid` | String | *(only returned if the service is successfully fulfilled)* The ID of the Catenis transaction issued to fulfill the service. |
| &nbsp;&nbsp;&nbsp;&nbsp;`error` | String | *(only returned if the service's execution has failed)* An error message describing what went wrong when executing the service. |
| &nbsp;&nbsp;`foreignTransaction` | Object | Information about the transaction issued on the foreign blockchain to mint/burn the amount of the foreign token. |
| &nbsp;&nbsp;&nbsp;&nbsp;`txid` | String | The ID (or hash) of the foreign blockchain transaction. |
| &nbsp;&nbsp;&nbsp;&nbsp;`isPending` | Boolean | Indicates whether the foreign blockchain transaction is yet to be executed. |
| &nbsp;&nbsp;&nbsp;&nbsp;`success` | Boolean | *(only returned after the foreign blockchain transaction is executed)* Indicates whether the foreign blockchain transaction has been successfully executed or not. |
| &nbsp;&nbsp;&nbsp;&nbsp;`error` | String | *(only returned if the foreign blockchain transaction's execution has failed)* An error message describing what went wrong when executing the transaction. |
| &nbsp;&nbsp;`status` | String | The current state of the asset migration. One of: `pending`, `interrupted`, `success`, or `error`. |
| &nbsp;&nbsp;`date` | String | <a href="https://en.wikipedia.org/wiki/ISO_8601" target="_blank">ISO 8601</a> formatted date and time when the asset amount has been migrated. |

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_107">Invalid asset migration ID</a><br><a href="#error_msg_130">Invalid parameters: <i>&lt;param_list&gt;</i></a> |
| 403 | <a href="#error_msg_189">No permission to retrieve asset migration outcome</a> |
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |
