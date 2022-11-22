## Issue Non-Fungible Asset

Creates a new non-fungible asset, and issues its initial non-fungible tokens.

> Sample request (initial call):

```http--raw
POST /api/0.13/assets/non-fungible/issue HTTP/1.1
X-BCoT-Timestamp: 20220816T184259Z
Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20220816/ctn1_request, Signature=bbbde6e3ece3d8df044ecf68a291c26868e50faff512dce5f6de2d67da39451f
Content-Type: application/json; charset=utf-8
Host: localhost:3000
Connection: close
User-Agent: Paw/3.3.6 (Macintosh; OS X/12.5.0) GCDHTTPRequest
Content-Length: 584

{"assetInfo":{"name":"Catenis NFA 9","description":"Non-fungible asset #9 for testing","canReissue":true},"encryptNFTContents":true,"nonFungibleTokens":[{"metadata":{"name":"NFA9 NFT 1","description":"First token of Catenis non-fungible asset #9"},"contents":{"data":"Contents of first token of Catenis non-fungible asset #9","encoding":"utf8"}},{"metadata":{"name":"NFA9 NFT 2","description":"Second token of Catenis non-fungible asset #9"},"contents":{"data":"Here is the contents of the second token of Catenis non-fungible asset #9 (part #1)","encoding":"utf8"}}],"isFinal":false}
```

```shell
curl -X "POST" "http://localhost:3000/api/0.13/assets/non-fungible/issue" \
     -H 'X-BCoT-Timestamp: 20220816T184259Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20220816/ctn1_request, Signature=bbbde6e3ece3d8df044ecf68a291c26868e50faff512dce5f6de2d67da39451f' \
     -H 'Content-Type: application/json; charset=utf-8' \
     -d $'{
  "assetInfo": {
    "name": "Catenis NFA 9",
    "canReissue": true,
    "description": "Non-fungible asset #9 for testing"
  },
  "encryptNFTContents": true,
  "nonFungibleTokens": [
    {
      "metadata": {
        "name": "NFA9 NFT 1",
        "description": "First token of Catenis non-fungible asset #9"
      },
      "contents": {
        "data": "Contents of first token of Catenis non-fungible asset #9",
        "encoding": "utf8"
      }
    },
    {
      "metadata": {
        "name": "NFA9 NFT 2",
        "description": "Second token of Catenis non-fungible asset #9"
      },
      "contents": {
        "data": "Here is the contents of the second token of Catenis non-fungible asset #9 (part #1)",
        "encoding": "utf8"
      }
    }
  ],
  "isFinal": false
}'
```

```html--javascript
<script src="CatenisAPIClientJS.min.js"></script>

<script language="JavaScript">
var deviceId = 'dnN3Ea43bhMTHtTvpytS';

var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'sandbox'
});

ctnApiClient.issueNonFungibleAsset({
        assetInfo: {
            name: 'Catenis NFA 9',
            description: 'Non-fungible asset #9 for testing',
            canReissue: true
        },
        encryptNFTContents: true
    }, [{
        metadata: {
            name: 'NFA9 NFT 1',
            description: 'First token of Catenis non-fungible asset #9'
        },
        contents: {
            data: 'Contents of first token of Catenis non-fungible asset #9',
            encoding: 'utf8'
        }
    }, {
        metadata: {
            name: 'NFA9 NFT 2',
            description: 'Second token of Catenis non-fungible asset #9'
        },
        contents: {
            data: 'Here is the contents of the second token of Catenis non-fungible asset #9 (part #1)',
            encoding: 'utf8'
        }
    }],
    false,
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            console.log('Continuation token:', data.continuationToken);
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

ctnApiClient.issueNonFungibleAsset({
        assetInfo: {
            name: 'Catenis NFA 9',
            description: 'Non-fungible asset #9 for testing',
            canReissue: true
        },
        encryptNFTContents: true
    }, [{
        metadata: {
            name: 'NFA9 NFT 1',
            description: 'First token of Catenis non-fungible asset #9'
        },
        contents: {
            data: 'Contents of first token of Catenis non-fungible asset #9',
            encoding: 'utf8'
        }
    }, {
        metadata: {
            name: 'NFA9 NFT 2',
            description: 'Second token of Catenis non-fungible asset #9'
        },
        contents: {
            data: 'Here is the contents of the second token of Catenis non-fungible asset #9 (part #1)',
            encoding: 'utf8'
        }
    }],
    false,
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            console.log('Continuation token:', data.continuationToken);
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

try {
    $data = $ctnApiClient->issueNonFungibleAsset([
        'assetInfo' => [
            'name' => 'Catenis NFA 9',
            'description' => 'Non-fungible asset #9 for testing',
            'canReissue' => true
        ],
        'encryptNFTContents' => true
    ], [
        [
            'metadata' => [
                'name' => 'NFA9 NFT 1',
                'description' => 'First token of Catenis non-fungible asset #9'
            ],
            'contents' => [
                'data' => 'Contents of first token of Catenis non-fungible asset #9',
                'encoding' => 'utf8'
            ]
        ],
        [
            'metadata' => [
                'name' => 'NFA9 NFT 2',
                'description' => 'Second token of Catenis non-fungible asset #9'
            ],
            'contents' => [
                'data' => 'Here is the contents of the second token of Catenis non-fungible asset #9 (part #1)',
                'encoding' => 'utf8'
            ]
        ]
    ], false);

    // Process returned data
    echo 'Continuation token: ' . $data->continuationToken . PHP_EOL;
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

    let result = ctn_client.issue_non_fungible_asset(
        NFAssetIssuanceInfoOrContToken::IssuanceInfo(NonFungibleAssetIssuanceInfo {
            asset_info: Some(NewNonFungibleAssetInfo {
                name: String::from("NFA 9"),
                description: Some(String::from("Non-fungible asset #9 for testing")),
                can_reissue: true
            }),
            encrypt_nft_contents: Some(true),
            holding_devices: None,
            async_: None,
        }),
        Some(vec![
            Some(NewNonFungibleTokenInfo {
                metadata: Some(NewNonFungibleTokenMetadata {
                    name: String::from("NFA9 NFT 1"),
                    description: Some(String::from("First token of non-fungible asset #9")),
                    custom: None,
                }),
                contents: Some(NewNonFungibleTokenContents {
                    data: String::from("Contents of first token of non-fungible asset #9"),
                    encoding: Encoding::UTF8
                }),
            }),
            Some(NewNonFungibleTokenInfo {
                metadata: Some(NewNonFungibleTokenMetadata {
                    name: String::from("NFA9 NFT 2"),
                    description: Some(String::from("Second token of non-fungible asset #9")),
                    custom: None,
                }),
                contents: Some(NewNonFungibleTokenContents {
                    data: String::from("Here is the contents of the second token of Catenis non-fungible asset #9 (part #1)"),
                    encoding: Encoding::UTF8
                }),
            }),
        ]),
        Some(false)
    )?;
  
    println!("Continuation token: {}", result.continuation_token.unwrap());
  
    Ok(())
}
```

> Sample request (final continuation call):

```http--raw
POST /api/0.13/assets/non-fungible/issue HTTP/1.1
X-BCoT-Timestamp: 20220816T184627Z
Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20220816/ctn1_request, Signature=d320bfba65c206022138f9d3ac2d63fd6058c44b3a01e5462b93522fe3337e19
Content-Type: application/json; charset=utf-8
Host: localhost:3000
Connection: close
User-Agent: Paw/3.3.6 (Macintosh; OS X/12.5.0) GCDHTTPRequest
Content-Length: 226

{"continuationToken":"bRQDsLZpksdHyMPxFk3J","nonFungibleTokens":[null,{"contents":{"data":"; and here is the last part of the contents of the second token of Catenis non-fungible asset #9.","encoding":"utf8"}}],"isFinal":true}
```

```shell
curl -X "POST" "http://localhost:3000/api/0.13/assets/non-fungible/issue" \
     -H 'X-BCoT-Timestamp: 20220816T184627Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20220816/ctn1_request, Signature=d320bfba65c206022138f9d3ac2d63fd6058c44b3a01e5462b93522fe3337e19' \
     -H 'Content-Type: application/json; charset=utf-8' \
     -d $'{
  "continuationToken": "bRQDsLZpksdHyMPxFk3J",
  "nonFungibleTokens": [
    null,
    {
      "contents": {
        "data": "; and here is the last part of the contents of the second token of Catenis non-fungible asset #9.",
        "encoding": "utf8"
      }
    }
  ],
  "isFinal": true,
}'
```

```html--javascript
<script src="CatenisAPIClientJS.min.js"></script>

<script language="JavaScript">
var deviceId = 'dnN3Ea43bhMTHtTvpytS';

var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'sandbox'
});

var continuationToken = 'bRQDsLZpksdHyMPxFk3J';

ctnApiClient.issueNonFungibleAsset(continuationToken, [
    null, {
        contents: {
            data: '; and here is the last part of the contents of the second token of Catenis non-fungible asset #9.',
            encoding: 'utf8'
        }
    }],
    true,
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            console.log('ID of newly created non-fungible asset:', data.assetId);
            console.log('IDs of newly issued non-fungible tokens:', data.nfTokenIds);
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

var continuationToken = 'bRQDsLZpksdHyMPxFk3J';

ctnApiClient.issueNonFungibleAsset(continuationToken, [
    null, {
        contents: {
            data: '; and here is the last part of the contents of the second token of Catenis non-fungible asset #9.',
            encoding: 'utf8'
        }
    }],
    true,
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            console.log('ID of newly created non-fungible asset:', data.assetId);
            console.log('IDs of newly issued non-fungible tokens:', data.nfTokenIds);
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

$continuationToken = 'bRQDsLZpksdHyMPxFk3J';

try {
    $data = $ctnApiClient->issueNonFungibleAsset($continuationToken, [
        null,
        [
            'contents' => [
                'data' => '; and here is the last part of the contents of the second token of Catenis non-fungible asset #9.',
                'encoding' => 'utf8'
            ]
        ]
    ], true);

    // Process returned data
    echo 'ID of newly created non-fungible asset: ' . $data->assetId . PHP_EOL;
    echo 'IDs of newly issued non-fungible tokens: ' . implode(', ', $data->nfTokenIds) . PHP_EOL;
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
  
    let continuation_token = "bRQDsLZpksdHyMPxFk3J";

    let result = ctn_client.issue_non_fungible_asset(
        NFAssetIssuanceInfoOrContToken::ContinuationToken(String::from(continuation_token)),
        Some(vec![
            None,
            Some(NewNonFungibleTokenInfo {
                metadata: None,
                contents: Some(NewNonFungibleTokenContents {
                    data: String::from("; and here is the last part of the contents of the second token of Catenis non-fungible asset #9."),
                    encoding: Encoding::UTF8
                }),
            }),
        ]),
        Some(true)
    )?;

    println!("ID of newly created non-fungible asset: {}", result.asset_id.unwrap());
    println!("IDs of newly issued non-fungible tokens: {:?}", result.nf_token_ids.unwrap());

    Ok(())
}
```

### Accessibility

Private

### Request

POST /assets/non-fungible/issue

### Parameters

* Request body:

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `assetInfo` | Object | *(optional; should be omitted in a continuation call)* The properties of the new non-fungible asset to create. |
| &nbsp;&nbsp;`name` | String | The name of the non-fungible asset. |
| &nbsp;&nbsp;`description` | String | *(optional)* A description of the non-fungible asset. |
| &nbsp;&nbsp;`canReissue` | Boolean |  Indicates whether more non-fungible tokens of that non-fungible asset can be issued at a later time. |
| `encryptNFTContents` | Boolean | *(optional, default: __`true`__; should be omitted in a continuation call)* Indicates whether the contents of the non-fungible tokens being issued should be encrypted before being stored. |
| `holdingDevices` | Object&#124;Array(Object) | *(optional; should be omitted in a continuation call)* A single virtual device or a list of virtual devices that will hold the issued non-fungible tokens. |
| &nbsp;&nbsp;`id` | String | The ID of the holding device. Should be a device ID unless `isProdUniqueId` is set. |
| &nbsp;&nbsp;`isProdUniqueId` | Boolean | *(optional, default: __`false`__)* Indicates whether the supplied ID is a product unique ID. |
| `async` | Boolean | *(optional, default: __`false`__; should be omitted in a continuation call)* Indicates whether processing should be done asynchronously. |
| `continuationToken` | String | *(optional; should be included only in a continuation call)* This signals a continuation call of the asset issuance. It should be filled with the continuation token returned by the previous call. |
| `nonFungibleTokens` | Array(Object) | *(optional; may be omitted in the final continuation call)* List with the properties of the non-fungible tokens to be issued. |
| &nbsp;&nbsp;`metadata` | Object | *(optional; should be omitted in a continuation call)* The properties of the non-fungible token to issue. |
| &nbsp;&nbsp;&nbsp;&nbsp;`name` | String | The name of the non-fungible token. |
| &nbsp;&nbsp;&nbsp;&nbsp;`description` | String | *(optional)* A description of the non-fungible token. |
| &nbsp;&nbsp;&nbsp;&nbsp;`custom` | Object | *(optional)* User defined, custom properties of the non-fungible token. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`sensitiveProps` | Object | *(optional)* User defined, sensitive properties of the non-fungible token. Sensitive properties are encrypted before being stored. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_`<prop_name>`_ | * | A custom, sensitive property identified by _`prop_name`_. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_`<prop_name>`_ | * | A custom property identified by _`prop_name`_. |
| &nbsp;&nbsp;`contents` | Object | *(optional; may be omitted in the initial call)* The contents of the non-fungible token to issue. |
| &nbsp;&nbsp;&nbsp;&nbsp;`data` | String | An additional chunk of data of the non-fungible token's contents. |
| &nbsp;&nbsp;&nbsp;&nbsp;`encoding` | String | *(optional, default: __`base64`__)* The encoding of the contents data chunk. Valid options: `utf8`, `base64`, `hex`. |
| `isFinal` | Boolean | *(optional, default: __`true`__)* Indicates whether this is the final call of the asset issuance. There should be no more continuation calls after this is set. |

<aside class="notice">
When passing large non-fungible token contents, break the contents into smaller chunks of data, and call this API
 method iteratively until all the data chunks are passed. Make sure to set the <code>isFinal</code> property to <code><b>true</b></code>
 only in the final call.
</aside>

<aside class="notice">
Continuation calls should only include the top-level properties <code>continuationToken</code>, <code>nonFungibleTokens</code>
 and <code>isFinal</code>, and the items of the <code>nonFungibleTokens</code> array should only include the
 <code>contents</code> property. However, the <code>nonFungibleTokens</code> property may be omitted in the final call
 if there are no more non-fungible token contents to be passed.
</aside>

<aside class="notice">
When passing data for more than one non-fungible token in continuation calls, and the contents of some of the
 non-fungible tokens have already been completely passed, the corresponding entry of the <code>nonFungibleTokens</code>
 array should have the value <code><b>null</b></code>, or not be included altogether.
</aside>

<aside class="notice">
The contents of the first non-fungible token (first entry of the <code>nonFungibleTokens</code> array) can optionally be
 shared with one or more of the other non-fungible tokens. That is accomplished by omitting the <code>contents</code>
 property of the corresponding entries of the <code>nonFungibleTokens</code> array in the initial call.
</aside>

<aside class="notice">
If no description is specified — <code>assetInfo.description</code> property not defined —, the default description
 <b>"General purpose Catenis non-fungible asset"</b> is used for the new non-fungible asset.
</aside>

<aside class="notice">
If a single holding device is specified, all the issued non-fungible tokens are assigned to that virtual device. If
 instead a list of holding devices is specified, the number of items on that list must match the number of non-fungible
 tokens being issued, and it designates which virtual device will hold each of the issued non-fungible tokens. If no
 holding devices are specified — <code>holdingDevices</code> property not defined —, the device that issues the
 request will hold the issued non-fungible tokens.
</aside>

<aside class="notice">
To avoid a possible timeout while waiting for Catenis to process a non-fungible asset issuance, especially when passing
 large non-fungible token contents, one may choose to do the processing asynchronously — <code>async</code> property set
 to <code><b>true</b></code>. In that case, a final call will return immediately with an <b>asset issuance ID</b>, which
 should then be used to retrieve the issuance progress by calling the <a href="#retrieve-non-fungible-asset-issuance-progress">Retrieve Non-Fungible Asset Issuance Progress</a>
 API method.
</aside>

> Sample response (non-final call):

```json
{
  "status": "success",
  "data": {
    "continuationToken": "bRQDsLZpksdHyMPxFk3J"
  }
}
```

> Sample response (final call, no asynchronous processing):

```json
{
  "status": "success",
  "data": {
    "assetId": "ahfTzqgWAXnMR6Z57mcp",
    "nfTokenIds": [
      "tSWtJurhbkSJLGjjbN4R",
      "t76Yzrbqcjbtehk6Wecf"
    ]
  }
}
```

### Success response

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `status` | String | The value **`success`**, indicating that the request was successful. |
| `data` | Object | The actual data returned in response to the API request. |
| &nbsp;&nbsp;`continuationToken` | String | *(only returned for a non-final call)* The continuation token to be used in the next continuation call. |
| &nbsp;&nbsp;`assetIssuanceId` | String | *(only returned for a final call when doing processing asynchronously)* The asset issuance ID. Used for retrieving the progress of an asynchronous non-fungible asset issuance. |
| &nbsp;&nbsp;`assetId` | String | *(only returned for a final call when __not__ doing processing asynchronously)* The ID of the newly created non-fungible asset. |
| &nbsp;&nbsp;`nfTokenIds` | Array(String) | *(only returned for a final call when __not__ doing processing asynchronously)* A list of the IDs of the issued non-fungible tokens. |

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_390">Asset issuance timed out</a><br><a href="#error_msg_275">Inconsistent number of non-fungible tokens</a><br><a href="#error_msg_115">Invalid holding device</a><br><a href="#error_msg_270">Invalid or unexpected asset issuance continuation token</a><br><a href="#error_msg_130">Invalid parameters: <i>&lt;param_list&gt;</i></a><br><a href="#error_msg_290">Missing non-fungible token contents</a><br><a href="#error_msg_280">Missing non-fungible token data</a><br><a href="#error_msg_285">Missing non-fungible token metadata</a><br><a href="#error_msg_260">Non-fungible asset issuance cannot be finalized with no tokens</a><br><a href="#error_msg_265">Non-fungible asset issuance is already complete</a><br><a href="#error_msg_295">Non-fungible token contents is already finalized</a><br><a href="#error_msg_250">Not enough credits to pay for issue non-fungible asset service</a><br><a href="#error_msg_255">Number of non-fungible tokens to issue is too large</a> |
| 403 | <a href="#error_msg_245">No permission to assign issued non-fungible tokens to holding device</a> |
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |
