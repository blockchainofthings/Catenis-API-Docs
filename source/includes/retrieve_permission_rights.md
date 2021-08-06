## Retrieve Permission Rights

Gets the permission rights currently set for a specific permission event.

The virtual device issuing the request acts as the controlling device. Thus the permission rights to be retrieved are the ones
set for the pair composed of the permission event specified in the API request and the virtual device issuing the request.

<aside class="notice">
For more information about Catenis permission rights, please refer to the <a href="#permission-rights">Permission rights</a> section above.
</aside>

> Sample request:

```http--raw
GET /api/0.11/permission/events/receive-msg/rights HTTP/1.1
X-BCoT-Timestamp: 20180217T193337Z
Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180217/ctn1_request, Signature=b6bf27017c8ee92da349f80e27e127f3c2cb3adeeeee28e19c18d9b9c3b752a8
Host: sandbox.catenis.io
Connection: close
User-Agent: Paw/3.1.5 (Macintosh; OS X/10.13.3) GCDHTTPRequest
```

```shell
curl "https://sandbox.catenis.io/api/0.11/permission/events/receive-msg/rights" \
     -H 'X-BCoT-Timestamp: 20180217T193358Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180217/ctn1_request, Signature=6d2748f961de6714c16a0ff9096a9a9c2607778c2dc107d2f7492bc0878d2a81'
```

```html--javascript
<script src="CatenisAPIClientJS.min.js"></script>

<script language="JavaScript">
var deviceId = 'dnN3Ea43bhMTHtTvpytS';

var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'sandbox'
});

ctnApiClient.retrievePermissionRights('receive-msg', function (err, data) {
    if (err) {
        // Process error
    }
    else {
        // Process returned data
        console.log('Default (system) permission right:', data.system);

        if (data.catenisNode) {
            if (data.catenisNode.allow) {
                console.log('Index of Catenis nodes with \'allow\' permission right:', data.catenisNode.allow);
            }

            if (data.catenisNode.deny) {
                console.log('Index of Catenis nodes with \'deny\' permission right:', data.catenisNode.deny);
            }
        }

        if (data.client) {
            if (data.client.allow) {
                console.log('ID of clients with \'allow\' permission right:', data.client.allow);
            }

            if (data.client.deny) {
                console.log('ID of clients with \'deny\' permission right:', data.client.deny);
            }
        }

        if (data.device) {
            if (data.device.allow) {
                console.log('Devices with \'allow\' permission right:', data.device.allow);
            }

            if (data.device.deny) {
                console.log('Devices with \'deny\' permission right:', data.device.deny);
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

ctnApiClient.retrievePermissionRights('receive-msg', function (err, data) {
    if (err) {
        // Process error
    }
    else {
        // Process returned data
        console.log('Default (system) permission right:', data.system);

        if (data.catenisNode) {
            if (data.catenisNode.allow) {
                console.log('Index of Catenis nodes with \'allow\' permission right:', data.catenisNode.allow);
            }

            if (data.catenisNode.deny) {
                console.log('Index of Catenis nodes with \'deny\' permission right:', data.catenisNode.deny);
            }
        }

        if (data.client) {
            if (data.client.allow) {
                console.log('ID of clients with \'allow\' permission right:', data.client.allow);
            }

            if (data.client.deny) {
                console.log('ID of clients with \'deny\' permission right:', data.client.deny);
            }
        }

        if (data.device) {
            if (data.device.allow) {
                console.log('Devices with \'allow\' permission right:', data.device.allow);
            }

            if (data.device.deny) {
                console.log('Devices with \'deny\' permission right:', data.device.deny);
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

try {
    $data = $ctnApiClient->retrievePermissionRights('receive-msg');
    
    // Process returned data
    echo 'Default (system) permission right: ' . $data->system . PHP_EOL;
    
    if (isset($data->catenisNode)) {
        if (isset($data->catenisNode->allow)) {
            echo 'Index of Catenis nodes with \'allow\' permission right: ' . implode($data->catenisNode->allow, ', ') . PHP_EOL;
        }
        
        if (isset($data->catenisNode->deny)) {
            echo 'Index of Catenis nodes with \'deny\' permission right: ' . implode($data->catenisNode->deny, ', ') . PHP_EOL;
        }
    }
    
    if (isset($data->client)) {
        if (isset($data->client->allow)) {
            echo 'ID of clients with \'allow\' permission right: ' . implode($data->client->allow, ', ') . PHP_EOL;
        }
        
        if (isset($data->client->deny)) {
            echo 'ID of clients with \'deny\' permission right: ' . implode($data->client->deny, ', ') . PHP_EOL;
        }
    }
    
    if (isset($data->device)) {
        if (isset($data->device->allow)) {
            echo 'Devices with \'allow\' permission right: ' . print_r($data->device->allow, true);
        }
        
        if (isset($data->device->deny)) {
            echo 'Devices with \'deny\' permission right: ' . print_r($data->device->deny, true);
        }
    }
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

    let result = ctn_client.retrieve_permission_rights(
        PermissionEvent::ReceiveMsg,
    )?;

    println!("Default (system) permission right: {:?}", result.system);

    if let Some(rights_setting) = result.catenis_node {
        if let Some(catenis_node_idxs) = rights_setting.allow {
            println!(
                "Index of Catenis nodes with 'allow' permission right: {:?}",
                catenis_node_idxs
            );
        }

        if let Some(catenis_node_idxs) = rights_setting.deny {
            println!(
                "Index of Catenis nodes with 'deny' permission right: {:?}",
                catenis_node_idxs
            );
        }
    }

    if let Some(rights_setting) = result.client {
        if let Some(client_ids) = rights_setting.allow {
            println!("ID of clients with 'allow' permission right: {:?}", client_ids);
        }

        if let Some(client_ids) = rights_setting.deny {
            println!("ID of clients with 'deny' permission right: {:?}", client_ids);
        }
    }

    if let Some(rights_setting) = result.device {
        if let Some(devices) = rights_setting.allow {
            println!("Devices with 'allow' permission right: {:?}", devices);
        }

        if let Some(devices) = rights_setting.deny {
            println!("Devices with 'deny' permission right: {:?}", devices);
        }
    }

    Ok(())
}
```

### Accessibility

Private

### Request

GET /permission/events/`:eventName`/rights

### Parameters

<!-- Note: we are not using the native markdown list feature for the second level items because the generated
        HTML has no space to the following first level item -->
- URL parameters:
<ul class="parameterList">
  <li>`eventName`: The name of the permission event the permission rights set for which should be retrieved.</li>
</ul>

> Sample response:

```json
{
  "status": "success",
  "data": {
    "system": "deny",
    "client": {
      "allow": [
        "cjNhuvGMUYoepFcRZadP"
      ]
    },
    "device": {
      "allow": [
        {
          "deviceId": "dv3htgvK7hjnKx3617Re",
          "name": "Catenis device #1"
        }
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
| &nbsp;&nbsp;`system` | String | Permission right set at the system level. |
| &nbsp;&nbsp;`catenisNode` | Object | *(only returned if there are any permission rights set at the Catenis node level)* |
| &nbsp;&nbsp;&nbsp;&nbsp;`allow` | Array(String) | *(only returned if not empty)* List of Catenis node indices identifying the Catenis nodes to which allow right has been given. |
| &nbsp;&nbsp;&nbsp;&nbsp;`deny` | Array(String) | *(only returned if not empty)* List of Catenis node indices identifying the Catenis nodes to which deny right has been given. |
| &nbsp;&nbsp;`client` | Object | *(only returned if there are any permission rights set at the client level)* |
| &nbsp;&nbsp;&nbsp;&nbsp;`allow` | Array(String) | *(only returned if not empty)* List of client IDs identifying the clients to which allow right has been given. |
| &nbsp;&nbsp;&nbsp;&nbsp;`deny` | Array(String) | *(only returned if not empty)* List of client IDs identifying the clients to which deny right has been given. |
| &nbsp;&nbsp;`device` | Object | *(only returned if there are any permission rights set at the device level)* |
| &nbsp;&nbsp;&nbsp;&nbsp;`allow` | Array(Object) | *(only returned if not empty)* List of virtual device info objects identifying the devices to which allow right has been given. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`deviceId` | String | The device ID of the virtual device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`name` | String | *(only returned if virtual device has this data, and the virtual device issuing the request has the necessary permission right)* The name of the virtual device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`prodUniqueId` | String | *(only returned if virtual device has this data, and the virtual device issuing the request has the necessary permission right)* The product unique ID of the virtual device. |
| &nbsp;&nbsp;&nbsp;&nbsp;`deny` | Array(Object) | *(only returned if not empty)* List of virtual device info objects identifying the virtual devices to which deny right has been given. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`deviceId` | String | The device ID of the virtual device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`name` | String | *(only returned if virtual device has this data, and the virtual device issuing the request has the necessary permission right)* The name of the virtual device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`prodUniqueId` | String | *(only returned if virtual device has this data, and the virtual device issuing the request has the necessary permission right)* The product unique ID of the virtual device. |

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_130">Invalid parameters</a> |
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |
