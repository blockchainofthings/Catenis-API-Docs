## Retrieve Non-Fungible Asset Issuance Progress

Retrieves the current progress of an asynchronous non-fungible asset issuance.

<aside class="notice">
Alternatively, instead of calling this API method, one may choose to receive a <a href="#final-non-fungible-asset-issuance-outcome-nf-asset-issuance-outcome">nf-asset-issuance-outcome</a> notification event.
</aside>

> Sample request:

```http--raw
GET /api/0.13/assets/non-fungible/issuance/iwoTJPbnogCktrYpzwQn HTTP/1.1
X-BCoT-Timestamp: 20220817T143811Z
Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20220817/ctn1_request, Signature=de6a572fa907c591a581c30049c30ec24508a07f17510695b014f060d1adc60c
Host: localhost:3000
Connection: close
User-Agent: Paw/3.3.6 (Macintosh; OS X/12.5.0) GCDHTTPRequest
```

```shell
curl "http://localhost:3000/api/0.13/assets/non-fungible/issuance/iwoTJPbnogCktrYpzwQn" \
     -H 'X-BCoT-Timestamp: 20220817T143811Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20220817/ctn1_request, Signature=de6a572fa907c591a581c30049c30ec24508a07f17510695b014f060d1adc60c'
```

```html--javascript
<script src="CatenisAPIClientJS.min.js"></script>

<script language="JavaScript">
var deviceId = 'dnN3Ea43bhMTHtTvpytS';

var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'sandbox'
});

var assetIssuanceId = 'iwoTJPbnogCktrYpzwQn';

ctnApiClient.retrieveNonFungibleAssetIssuanceProgress(assetIssuanceId,
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            if (data.assetId) {
                console.log('Reissuance for non-fungible asset:', data.assetId);
            }
            
            console.log('Percent processed:', data.progress.percentProcessed);
                
            if (data.progress.done) {
                if (data.progress.success) {
                    // Display result
                    if (data.result.assetId) {
                        console.log('ID of newly created non-fungible asset:', data.result.assetId);
                    }
                    
                    console.log('IDs of newly issued non-fungible tokens:', data.result.nfTokenIds);
                }
                else {
                    // Process error
                    console.error('Asynchronous processing error: [', data.progress.error.code, ' ] -', data.progress.error.message);
                }
            }
            else {
                // Asynchronous processing not done yet. Continue pooling
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

var assetIssuanceId = 'iwoTJPbnogCktrYpzwQn';

ctnApiClient.retrieveNonFungibleAssetIssuanceProgress(assetIssuanceId,
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            if (data.assetId) {
                console.log('Reissuance for non-fungible asset:', data.assetId);
            }
            
            console.log('Percent processed:', data.progress.percentProcessed);
                
            if (data.progress.done) {
                if (data.progress.success) {
                    // Display result
                    if (data.result.assetId) {
                        console.log('ID of newly created non-fungible asset:', data.result.assetId);
                    }
                    
                    console.log('IDs of newly issued non-fungible tokens:', data.result.nfTokenIds);
                }
                else {
                    // Process error
                    console.error('Asynchronous processing error: [', data.progress.error.code, ' ] -', data.progress.error.message);
                }
            }
            else {
                // Asynchronous processing not done yet. Continue pooling
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

$assetIssuanceId = 'iwoTJPbnogCktrYpzwQn';

try {
    $data = $ctnApiClient->retrieveNonFungibleAssetIssuanceProgress($assetIssuanceId);

    // Process returned data
    if (isset($data->assetId)) {
        echo 'Reissuance for non-fungible asset:: ', $data->assetId . PHP_EOL;
    }
    
    echo 'Percent processed: ', $data->progress->percentProcessed . PHP_EOL;
        
    if ($data->progress->done) {
        if ($data->progress->success) {
            // Display result
            if (isset($data->result->assetId)) {
                echo 'ID of newly created non-fungible asset: ' . $data->result->assetId . PHP_EOL;
            }
            
            echo 'IDs of newly issued non-fungible tokens: ' . implode(', ', $data->result->nfTokenIds) . PHP_EOL;
        } else {
            // Process error
            echo 'Asynchronous processing error: [' . $data->progress->error->code . '] - '
                . $data->progress->error->message . PHP_EOL;
        }
    } else {
        // Asynchronous processing not done yet. Continue pooling
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

    let issuance_id = "iwoTJPbnogCktrYpzwQn";
  
    let result = ctn_client.retrieve_non_fungible_asset_issuance_progress(
        issuance_id,
    )?;
  
    if let Some(asset_id) = result.asset_id {
        println!("Reissuance for non-fungible asset: {}", asset_id);
    }
  
    println!("Percent processed: {}", result.progress.percent_processed.to_string());
  
    if result.progress.done {
        if let Some(true) = result.progress.success {
            // Get result
            let issuance_result = result.result.unwrap();
      
            if let Some(asset_id) = issuance_result.asset_id {
                println!("ID of newly created non-fungible asset: {}", asset_id);
            }
      
            println!("IDs of newly issued non-fungible tokens:: {:?}", issuance_result.nf_token_ids);
        } else {
            // Process error
            let error = result.progress.error.unwrap();
      
            println!("Asynchronous processing error: [{}] - {}", error.code, error.message);
        }
    } else {
        // Asynchronous processing not done yet. Continue pooling
    }
   
    Ok(())
}
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
| &nbsp;&nbsp;&nbsp;&nbsp;`finishDate` | String | *(only returned if the processing has already been finished)* ISO 8601 formatted date and time when processing has been finalized. |
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
