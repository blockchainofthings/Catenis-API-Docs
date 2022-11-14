## Reissue Non-Fungible Asset

Issues more non-fungible tokens for a previously created non-fungible asset.

<aside class="notice">
Only the virtual device that created the non-fungible asset (and issued its initial non-fungible tokens) can issue more
non-fungible tokens for that same asset, provided that the asset had been created with the <code>canReissue</code>
property set.
</aside>

> Sample request (initial call):

```http--raw
POST /api/0.12/assets/non-fungible/ahfTzqgWAXnMR6Z57mcp/issue HTTP/1.1
X-BCoT-Timestamp: 20220817T134801Z
Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20220817/ctn1_request, Signature=a9b862ea223e8f0bb67b1cf50bd36fb94ebeaef55a94ebc6ae31048cc668ac49
Content-Type: application/json; charset=utf-8
Host: localhost:3000
Connection: close
User-Agent: Paw/3.3.6 (Macintosh; OS X/12.5.0) GCDHTTPRequest
Content-Length: 481

{"encryptNFTContents":true,"nonFungibleTokens":[{"metadata":{"name":"NFA9 NFT 3","description":"Third token of Catenis non-fungible asset #9"},"contents":{"data":"This is the contents of token #3 of Catenis non-fungible asset #9 (part #1)","encoding":"utf8"}},{"metadata":{"name":"NFA9 NFT 4","description":"Forth token of Catenis non-fungible asset #9"},"contents":{"data":"This is the contents of token #4 of Catenis non-fungible asset #9.","encoding":"utf8"}}],"isFinal":false}
```

```shell
curl -X "POST" "http://localhost:3000/api/0.12/assets/non-fungible/ahfTzqgWAXnMR6Z57mcp/issue" \
     -H 'X-BCoT-Timestamp: 20220817T134801Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20220817/ctn1_request, Signature=a9b862ea223e8f0bb67b1cf50bd36fb94ebeaef55a94ebc6ae31048cc668ac49' \
     -H 'Content-Type: application/json; charset=utf-8' \
     -d $'{
  "encryptNFTContents": true,
  "nonFungibleTokens": [
    {
      "metadata": {
        "name": "NFA9 NFT 3",
        "description": "Third token of Catenis non-fungible asset #9"
      },
      "contents": {
        "data": "This is the contents of token #3 of Catenis non-fungible asset #9 (part #1)",
        "encoding": "utf8"
      }
    },
    {
      "metadata": {
        "name": "NFA9 NFT 4",
        "description": "Forth token of Catenis non-fungible asset #9"
      },
      "contents": {
        "data": "This is the contents of token #4 of Catenis non-fungible asset #9.",
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

var assetId = 'ahfTzqgWAXnMR6Z57mcp';

ctnApiClient.reissueNonFungibleAsset(assetId, {
        encryptNFTContents: true
    }, [{
        metadata: {
            name: 'NFA9 NFT 3',
            description: 'Third token of Catenis non-fungible asset #9'
        },
        contents: {
            data: 'This is the contents of token #3 of Catenis non-fungible asset #9 (part #1)',
            encoding: 'utf8'
        }
    }, {
        metadata: {
            name: 'NFA9 NFT 4',
            description: 'Forth token of Catenis non-fungible asset #9'
        },
        contents: {
            data: 'This is the contents of token #4 of Catenis non-fungible asset #9.',
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

```javascript--node
var CtnApiClient = require('catenis-api-client');

var deviceId = 'dnN3Ea43bhMTHtTvpytS';

var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'sandbox'
});

var assetId = 'ahfTzqgWAXnMR6Z57mcp';

ctnApiClient.reissueNonFungibleAsset(assetId, {
        encryptNFTContents: true
    }, [{
        metadata: {
            name: 'NFA9 NFT 3',
            description: 'Third token of Catenis non-fungible asset #9'
        },
        contents: {
            data: 'This is the contents of token #3 of Catenis non-fungible asset #9 (part #1)',
            encoding: 'utf8'
        }
    }, {
        metadata: {
            name: 'NFA9 NFT 4',
            description: 'Forth token of Catenis non-fungible asset #9'
        },
        contents: {
            data: 'This is the contents of token #4 of Catenis non-fungible asset #9.',
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

$assetId = 'ahfTzqgWAXnMR6Z57mcp';

try {
    $data = $ctnApiClient->reissueNonFungibleAsset($assetId, [
        'encryptNFTContents' => true
    ], [
        [
            'metadata' => [
                'name' => 'NFA9 NFT 3',
                'description' => 'Third token of Catenis non-fungible asset #9'
            ],
            'contents' => [
                'data' => 'This is the contents of token #3 of Catenis non-fungible asset #9 (part #1)',
                'encoding' => 'utf8'
            ]
        ],
        [
            'metadata' => [
                'name' => 'NFA9 NFT 4',
                'description' => 'Forth token of Catenis non-fungible asset #9'
            ],
            'contents' => [
                'data' => 'This is the contents of token #4 of Catenis non-fungible asset #9.',
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

    let asset_id = "ahfTzqgWAXnMR6Z57mcp";
  
    let result = ctn_client.reissue_non_fungible_asset(
        asset_id,
        NFAssetReissuanceInfoOrContToken::ReissuanceInfo(NonFungibleAssetReissuanceInfo {
            encrypt_nft_contents: Some(true),
            holding_devices: None,
            async_: None,
        }),
        Some(vec![
            Some(NewNonFungibleTokenInfo {
                metadata: Some(NewNonFungibleTokenMetadata {
                    name: String::from("NFA9 NFT 3"),
                    description: Some(String::from("Third token of non-fungible asset #9")),
                    custom: None,
                }),
                contents: Some(NewNonFungibleTokenContents {
                    data: String::from("This is the contents of token #3 of Catenis non-fungible asset #9 (part #1)"),
                    encoding: Encoding::UTF8
                }),
            }),
            Some(NewNonFungibleTokenInfo {
                metadata: Some(NewNonFungibleTokenMetadata {
                    name: String::from("NFA9 NFT 4"),
                    description: Some(String::from("Forth token of non-fungible asset #9")),
                    custom: None,
                }),
                contents: Some(NewNonFungibleTokenContents {
                    data: String::from("This is the contents of token #4 of Catenis non-fungible asset #9."),
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
POST /api/0.12/assets/non-fungible/ahfTzqgWAXnMR6Z57mcp/issue HTTP/1.1
X-BCoT-Timestamp: 20220817T135103Z
Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20220817/ctn1_request, Signature=8083c6b45899fc6d77aa36978ece9c6aea02862b0cc68a4d16355ba50e090f37
Content-Type: application/json; charset=utf-8
Host: localhost:3000
Connection: close
User-Agent: Paw/3.3.6 (Macintosh; OS X/12.5.0) GCDHTTPRequest
Content-Length: 204

{"continuationToken":"bNg8PeRoTvzbqYyLmCg6","nonFungibleTokens":[{"contents":{"data":"; last part of the contents of the third token of Catenis non-fungible asset #9.","encoding":"utf8"}}],"isFinal":true}
```

```shell
curl -X "POST" "http://localhost:3000/api/0.12/assets/non-fungible/ahfTzqgWAXnMR6Z57mcp/issue" \
     -H 'X-BCoT-Timestamp: 20220817T135103Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=drc3XdxNtzoucpw9xiRp/20220817/ctn1_request, Signature=8083c6b45899fc6d77aa36978ece9c6aea02862b0cc68a4d16355ba50e090f37' \
     -H 'Content-Type: application/json; charset=utf-8' \
     -d $'{
  "continuationToken": "bNg8PeRoTvzbqYyLmCg6",
  "nonFungibleTokens": [
    {
      "contents": {
        "data": "; last part of the contents of the third token of Catenis non-fungible asset #9.",
        "encoding": "utf8"
      }
    }
  ],
  "isFinal": true
}'
```

```html--javascript
<script src="CatenisAPIClientJS.min.js"></script>

<script language="JavaScript">
var deviceId = 'dnN3Ea43bhMTHtTvpytS';

var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'sandbox'
});

var assetId = 'ahfTzqgWAXnMR6Z57mcp';
var continuationToken = 'bNg8PeRoTvzbqYyLmCg6';

ctnApiClient.reissueNonFungibleAsset(assetId, continuationToken, [{
        contents: {
            data: '; last part of the contents of the third token of Catenis non-fungible asset #9.',
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
            console.log('IDs of newly issued non-fungible tokens:', data.nfTokenIds);
        }
});
```

```javascript--node
var CtnApiClient = require('catenis-api-client');

var deviceId = 'dnN3Ea43bhMTHtTvpytS';

var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'sandbox'
});

var assetId = 'ahfTzqgWAXnMR6Z57mcp';
var continuationToken = 'bNg8PeRoTvzbqYyLmCg6';

ctnApiClient.reissueNonFungibleAsset(assetId, continuationToken, [{
        contents: {
            data: '; last part of the contents of the third token of Catenis non-fungible asset #9.',
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
            console.log('IDs of newly issued non-fungible tokens:', data.nfTokenIds);
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

$assetId = 'ahfTzqgWAXnMR6Z57mcp';
$continuationToken = 'bNg8PeRoTvzbqYyLmCg6';

try {
    $data = $ctnApiClient->reissueNonFungibleAsset($assetId, $continuationToken, [
        [
            'contents' => [
                'data' => '; last part of the contents of the third token of Catenis non-fungible asset #9.',
                'encoding' => 'utf8'
            ]
        ]
    ], true);

    // Process returned data
    echo 'IDs of newly issued non-fungible tokens: ' . $data->nfTokenIds . PHP_EOL;
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

    let asset_id = "ahfTzqgWAXnMR6Z57mcp";
    let continuation_token = "bNg8PeRoTvzbqYyLmCg6";
  
    let result = ctn_client.reissue_non_fungible_asset(
        asset_id,
        NFAssetReissuanceInfoOrContToken::ContinuationToken(String::from(continuation_token)),
        Some(vec![
            Some(NewNonFungibleTokenInfo {
                metadata: None,
                contents: Some(NewNonFungibleTokenContents {
                    data: String::from("; last part of the contents of the third token of Catenis non-fungible asset #9."),
                    encoding: Encoding::UTF8
                }),
            }),
        ]),
        Some(true)
    )?;
  
    println!("IDs of newly issued non-fungible tokens: {:?}", result.nf_token_ids.unwrap());
   
    Ok(())
}
```

### Accessibility

Private

### Request

POST /assets/non-fungible/`:assetId`/issue

### Parameters

<!-- Note: we are not using the native markdown list feature for the second level items because the generated
        HTML has no space to the following first level item -->
- URL parameters:
<ul class="parameterList">
  <li>`assetId`: The ID of the non-fungible asset for which more non-fungible tokens should be issued.</li>
</ul>

* Request body:

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
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
    "continuationToken": "bNg8PeRoTvzbqYyLmCg6"
  }
}
```

> Sample response (final call, no asynchronous processing):

```json
{
  "status": "success",
  "data": {
    "nfTokenIds": [
      "tquy3RRz8vd5BFiZyw99",
      "tNp8btQLcSyMmF5mzcS3"
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
| &nbsp;&nbsp;`nfTokenIds` | Array(String) | *(only returned for a final call when __not__ doing processing asynchronously)* A list of the IDs of the issued non-fungible tokens. |

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_7">Asset cannot be reissued</a><br><a href="#error_msg_390">Asset issuance timed out</a><br><a href="#error_msg_275">Inconsistent number of non-fungible tokens</a><br><a href="#error_msg_105">Invalid asset ID</a><br><a href="#error_msg_115">Invalid holding device</a><br><a href="#error_msg_270">Invalid or unexpected asset issuance continuation token</a><br><a href="#error_msg_130">Invalid parameters: <i>&lt;param_list&gt;</i></a><br><a href="#error_msg_290">Missing non-fungible token contents</a><br><a href="#error_msg_280">Missing non-fungible token data</a><br><a href="#error_msg_285">Missing non-fungible token metadata</a><br><a href="#error_msg_260">Non-fungible asset issuance cannot be finalized with no tokens</a><br><a href="#error_msg_265">Non-fungible asset issuance is already complete</a><br><a href="#error_msg_295">Non-fungible token contents is already finalized</a><br><a href="#error_msg_300">Not a non-fungible asset</a><br><a href="#error_msg_250">Not enough credits to pay for issue non-fungible asset service</a><br><a href="#error_msg_255">Number of non-fungible tokens to issue is too large</a> |
| 403 | <a href="#error_msg_245">No permission to assign issued non-fungible tokens to holding device</a><br><a href="#error_msg_185">No permission to reissue asset</a> |
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |
