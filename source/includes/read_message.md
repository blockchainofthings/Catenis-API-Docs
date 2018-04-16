## Read Message

Retrieves the contents of a message that had been previously recorded on the blockchain.

<aside class="notice">
Logged messages can only be read by the virtual device that logged it.
</aside>

<aside class="notice">
Sent messages can only be read by the virtual device that sent it &mdash; the <i>target device</i>.
</aside>

> Sample request:

```http--raw
GET /api/0.5/messages/mDWPuD5kjCsEiNEEWwrW?encoding=utf8 HTTP/1.1
X-BCoT-Timestamp: 20180215T112048Z
Authorization: CTN1-HMAC-SHA256 Credential=dmM2Dz32agLSGsSuoxsR/20180215/ctn1_request, Signature=10b1299fdf935544b44e3e1e8de7d3f3df03df9ddc35db0127d5ab0cafa36cbb
Host: beta.catenis.io
Connection: close
User-Agent: Paw/3.1.5 (Macintosh; OS X/10.13.3) GCDHTTPRequest
```

```shell
curl "https://beta.catenis.io/api/0.5/messages/mDWPuD5kjCsEiNEEWwrW?encoding=utf8" \
     -H 'X-BCoT-Timestamp: 20180215T112120Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=dmM2Dz32agLSGsSuoxsR/20180215/ctn1_request, Signature=84ddc0f0e3a3cadab6011b18962912bdf62bfcd2234e0984513a1856fd88c1c1'
```

```html--javascript
<script src="CatenisAPIClientJS.min.js"></script>

<script language="JavaScript">
var deviceId = 'dnN3Ea43bhMTHtTvpytS';

var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'beta'
});

var messageId = 'mDWPuD5kjCsEiNEEWwrW';

ctnApiClient.readMessage(messageId, 'utf8', function (err, data) {
    if (err) {
        // Process error
    }
    else {
        // Process returned data
        console.log('Message read:', data.message);

        if (data.action === 'send') {
            console.log('Message originally from:', data.from);
        }
    }
});
</script>
```

```javascript--node
var CtnApiClient = require('catenis-api-client');

var deviceId = 'dnN3Ea43bhMTHtTvpytS';

var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'beta'
});

var messageId = 'mDWPuD5kjCsEiNEEWwrW';

ctnApiClient.readMessage(messageId, 'utf8', function (err, data) {
    if (err) {
        // Process error
    }
    else {
        // Process returned data
        console.log('Message read:', data.message);

        if (data.action === 'send') {
            console.log('Message originally from:', data.from);
        }
    }
});
```

```cpp
#include "CatenisApiClient.h"

std::string device_id("dnN3Ea43bhMTHtTvpytS");

ctn::CtnApiClient ctnApiClient(device_id, api_access_secret, "catenis.io", "", "beta");

ctn::ReadMessageResult data;
std::string message_id("mDWPuD5kjCsEiNEEWwrW");

try {
    client.readMessage(data, message_id, "utf8");

    std::cout << "Message read: " << data.message << endl;

    if (data.action == "send"} {
        std::cout << "Message originally from (device ID): " << data.from->deviceId;
    }
}
catch (ctn::CatenisAPIException &errObject) {
    std::cerr << errObject.getErrorDescription() << std::endl;
}
```

### Request

GET /messages/`:messageId`

### Parameters

<!-- Note: we are not using the native markdown list feature for the second level items because the generated
        HTML has no space to the following first level item -->
- URL parameters:
<ul class="parameterList">
  <li>`messageId`: The ID of the message to read.</li>
</ul>

- Query string parameters:
<ul class="parameterList">
  <li>`encoding`: *(optional, default: __`utf8`__)* The encoding to be used for the contents of the message. Valid values: `utf8`, `base64`, `hex`.</li>
</ul>

> Sample response:

```json
{
  "status": "success",
  "data": {
    "action": "send",
    "from": {
      "deviceId": "dv3htgvK7hjnKx3617Re",
      "name": "Catenis device #1"
    },
    "message": "This is only a test"
  }
}
```

### Success response

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `status` | String | The value **`success`**, indicating that the request was successful. |
| `data` | Object | The actual data returned in response to the API request. |
| &nbsp;&nbsp;`action` | String | Action originally performed on the message. Possible values: `log`, `send`. The value `log` indicates that this is a logged message, and the value `send` indicates that this is a sent message. |
| &nbsp;&nbsp;`from` | Object | *(only returned for sent messages)* Identifies the virtual device that sent the message &mdash; the *origin device*. |
| &nbsp;&nbsp;&nbsp;&nbsp;`deviceId` | String | The device ID of the origin device. |
| &nbsp;&nbsp;&nbsp;&nbsp;`name` | String | *(only returned if origin device has this data, and the virtual device issuing the request has the necessary permission right)* The name of the origin device. |
| &nbsp;&nbsp;&nbsp;&nbsp;`prodUniqueId` | String | *(only returned if origin device has this data, and the virtual device issuing the request has the necessary permission right)* The product unique ID of the origin device. |
| &nbsp;&nbsp;`message` | String | The contents of the message formatted using the specified encoding. |

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_80">Device is deleted<br><a href="#error_msg_90">Device is not active<br><a href="#error_msg_120">Invalid message ID<br><a href="#error_msg_130">Invalid parameters |
| 403 | <a href="#error_msg_180">No permission to read message |
| 500 | <a href="#error_msg_100">Internal server error |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time |
