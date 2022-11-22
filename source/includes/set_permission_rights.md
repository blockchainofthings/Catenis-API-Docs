## Set Permission Rights

Sets permission rights at different levels for a specific permission event.

The virtual device issuing the request acts as the controlling device. Thus the permission rights are set for the pair composed
of the permission event specified in the API request and the virtual device issuing the request.

<aside class="notice">
This method is used to set the permission rights in an incremental way. Thus, when calling this method to set or change
the permission right for only one virtual device, for instance, the permission rights that might had been previously set for
other virtual devices or at deferent levels are not modified.
</aside>

<aside class="notice">
For more information about Catenis permission rights, please refer to the <a href="#permission-rights">Permission rights</a> section above.
</aside>

> Sample request:

```http--raw
POST /api/0.13/permission/events/receive-msg/rights HTTP/1.1
X-BCoT-Timestamp: 20180217T201833Z
Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180217/ctn1_request, Signature=df048c4f799dbc0b15b7b105313b9c134d499eb330ecf1ee2b27b5319c89bb86
Content-Type: application/json; charset=utf-8
Host: sandbox.catenis.io
Connection: close
User-Agent: Paw/3.1.5 (Macintosh; OS X/10.13.3) GCDHTTPRequest
Content-Length: 147

{"client":{"allow":"self","deny":"cjNhuvGMUYoepFcRZadP"},"device":{"allow":[{"id":"dv3htgvK7hjnKx3617Re"},{"id":"XYZ0001","isProdUniqueId":true}]}}
```

```shell
curl -X "POST" "https://sandbox.catenis.io/api/0.13/permission/events/receive-msg/rights" \
     -H 'X-BCoT-Timestamp: 20180217T201855Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180217/ctn1_request, Signature=d52d99ab524ee9f6ed7ca4d96c0041ff9ba7ca1540497dc527c51596da98a27a' \
     -H 'Content-Type: application/json; charset=utf-8' \
     -d $'{
  "client": {
    "allow": "self",
    "deny": "cjNhuvGMUYoepFcRZadP"
  },
  "device": {
    "allow": [
      {
        "id": "dv3htgvK7hjnKx3617Re"
      },
      {
        "id": "XYZ0001",
        "isProdUniqueId": true
      }
    ]
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

ctnApiClient.setPermissionRights('receive-msg', {
        client: {
            allow: 'self'
            deny: 'cjNhuvGMUYoepFcRZadP'
        },
        device: {
            allow: [{
                id: 'dv3htgvK7hjnKx3617Re'
            }, {
                id: 'XYZ0001',
                isProdUniqueId: true
            }]
        }
    },
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            console.log('Permission rights successfully set');
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

ctnApiClient.setPermissionRights('receive-msg', {
        client: {
            allow: 'self'
            deny: 'cjNhuvGMUYoepFcRZadP'
        },
        device: {
            allow: [{
                id: 'dv3htgvK7hjnKx3617Re'
            }, {
                id: 'XYZ0001',
                isProdUniqueId: true
            }]
        }
    },
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            console.log('Permission rights successfully set');
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
    $data = $ctnApiClient->setPermissionRights('receive-msg', [
        'client' => [
            'allow' => 'self',
            'deny' => 'cjNhuvGMUYoepFcRZadP'
        ],
        'device' => [
            'allow' => [[
                'id' => 'dv3htgvK7hjnKx3617Re'
            ], [
                'id' => 'XYZ0001',
                'isProdUniqueId' => true
            ]]
        ]
    ]);

    // Process returned data
    echo 'Permission rights successfully set' . PHP_EOL;
}
catch (CatenisException $ex) {
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

    let _result = ctn_client.set_permission_rights(
        PermissionEvent::ReceiveMsg,
        AllPermissionRightsUpdate {
            system: None,
            catenis_node: None,
            client: Some(PermissionRightsUpdate {
                allow: Some(vec![
                    String::from("self"),
                ]),
                deny: Some(vec![
                    String::from("cjNhuvGMUYoepFcRZadP"),
                ]),
                none: None,
            }),
            device: Some(DevicePermissionRightsUpdate {
                allow: Some(vec![
                    DeviceId {
                        id: String::from("dv3htgvK7hjnKx3617Re"),
                        is_prod_unique_id: None,
                    },
                    DeviceId {
                        id: String::from("XYZ0001"),
                        is_prod_unique_id: Some(true),
                    },
                ]),
                deny: None,
                none: None,
            }),
        },
    )?;

    println!("Permission rights successfully set");

    Ok(())
}
```

### Accessibility

Private

### Request

POST /permission/events/`:eventName`/rights

### Parameters

<!-- Note: we are not using the native markdown list feature for the second level items because the generated
        HTML has no space to the following first level item -->
- URL parameters:
<ul class="parameterList">
  <li>`eventName`: The name of the permission event for which the permission rights should be set.</li>
</ul>

* Request body:

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `system` | String | *(optional)* Permission right to be set at the system level. Valid options: `allow`, `deny`. |
| `catenisNode` | Object | *(optional)* Permission rights to be set at the Catenis node level. |
| &nbsp;&nbsp;`allow` | String&#124;Array(String) | *(optional)* A single Catenis node index or a list of Catenis node indices identifying the Catenis nodes to which allow right should be given. The special value `self` can be used in place of the index of the Catenis node where the client to which the virtual device issuing the request belongs is defined. |
| &nbsp;&nbsp;`deny` | String&#124;Array(String) | *(optional)* A single Catenis node index or a list of Catenis node indices identifying the Catenis nodes to which deny right should be given. The special value `self` can be used in place of the index of the Catenis node where the client to which the virtual device issuing the request belongs is defined. |
| &nbsp;&nbsp;`none` | String&#124;Array(String) | *(optional)* A single Catenis node index or a list of Catenis node indices identifying the Catenis nodes the rights of which should be removed. The special value `self` can be used in place of the index of the Catenis node where the client to which the virtual device issuing the request belongs is defined. The special wildcard character `*` can also be used to indicate that the rights for all Catenis nodes should be remove. |
| `client` | Object | *(optional)* Permission rights to be set at the client level. |
| &nbsp;&nbsp;`allow` | String&#124;Array(String) | *(optional)* A single client ID or a list of client IDs identifying the clients to which allow right should be given. The special value `self` can be used in place of the client ID of the client to which the virtual device issuing the request belongs. |
| &nbsp;&nbsp;`deny` | String&#124;Array(String) | *(optional)* A single client ID or a list of client IDs identifying the clients to which deny right should be given. The special value `self` can be used in place of the client ID of the client to which the virtual device issuing the request belongs. |
| &nbsp;&nbsp;`none` | String&#124;Array(String) | *(optional)* A single client ID or a list of client IDs identifying the clients the rights of which should be removed. The special value `self` can be used in place of the client ID of the client to which the virtual device issuing the request belongs. The special wildcard character `*` can also be used to indicate that the rights for all clients should be remove. |
| `device` | Object | *(optional)* Permission rights to be set at the device level. |
| &nbsp;&nbsp;`allow` | Object&#124;Array(Object) | *(optional)* A single virtual device info object or a list of virtual device info objects identifying the virtual devices to which allow right should be given. |
| &nbsp;&nbsp;&nbsp;&nbsp;`id` | String | *(optional)* The ID of the virtual device. Should be a device ID unless `isProdUniqueId` is set. The special value `self` can be used in place of the device ID of the virtual device issuing the request. |
| &nbsp;&nbsp;&nbsp;&nbsp;`isProdUniqueId` | Boolean | *(optional, default: __`false`__)* Indicates whether the supplied ID is a product unique ID. |
| &nbsp;&nbsp;`deny` | Object&#124;Array(Object) | *(optional)* A single virtual device info object or a list of virtual device info objects identifying the virtual devices to which deny right should be given. |
| &nbsp;&nbsp;&nbsp;&nbsp;`id` | String | *(optional)* The ID of the virtual device. Should be a device ID unless `isProdUniqueId` is set. The special value `self` can be used in place of the device ID of the virtual device issuing the request. |
| &nbsp;&nbsp;&nbsp;&nbsp;`isProdUniqueId` | Boolean | *(optional, default: __`false`__)* Indicates whether the supplied ID is a product unique ID. |
| &nbsp;&nbsp;`none` | Object&#124;Array(Object) | *(optional)* A single virtual device info object or a list of virtual device info objects identifying the virtual devices the rights of which should be removed. |
| &nbsp;&nbsp;&nbsp;&nbsp;`id` | String | *(optional)* The ID of the virtual device. Should be a device ID unless `isProdUniqueId` is set. The special value `self` can be used in place of the device ID of the virtual device issuing the request. The special wildcard character `*` can also be used to indicate that the rights for all devices should be remove. |
| &nbsp;&nbsp;&nbsp;&nbsp;`isProdUniqueId` | Boolean | *(optional, default: __`false`__)* Indicates whether the supplied ID is a product unique ID. |

<aside class="success">
Removals of permission rights are always processed first. Thus, one can completely reset the permission rights
at a given level by passing the wildcard character <code>*</code> for the <code>none</code> entry, and at the same time the IDs
of the entities for which either <code>allow</code> or <code>deny</code> right is to be set.
</aside>

<aside class="warning">
An <b><i>Invalid entity ID</i></b> error does not mean that the whole request has failed, but rather only that the permission rights
could not be set for those specific invalid IDs — which are specified in the error message. Any other valid
IDs that might have been passed in the same request should have the corresponding permission rights correctly set.
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
| &nbsp;&nbsp;`success` | Boolean | The value **`true`** indicating that the permission rights have been correctly set. |

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_130">Invalid parameters: <i>&lt;param_list&gt;</i></a><br><a href="#error_msg_210">Invalid entity ID: <i>[ctnNodeIdx: …][; clientId: …][; deviceId: …][; prodUniqueId: …]</i></a> |
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |
