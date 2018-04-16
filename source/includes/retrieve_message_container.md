## Retrieve Message Container

Gets information about the place where a previously recorded message &mdash; either logged or sent &mdash; is actually
stored.

<aside class="notice">
A message container can only be retrieved by the virtual device that originally recorded (logged/sent) the message.
</aside>

> Sample request:

```http--raw
GET /api/0.5/messages/mDWPuD5kjCsEiNEEWwrW/container HTTP/1.1
X-BCoT-Timestamp: 20180215T200325Z
Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180215/ctn1_request, Signature=f06dc359270c2a3a91326ef2e7fd5506fd75dc9740b2609ed796ce01b3f92afb
Host: beta.catenis.io
Connection: close
User-Agent: Paw/3.1.5 (Macintosh; OS X/10.13.3) GCDHTTPRequest
```

```shell
curl "https://beta.catenis.io/api/0.5/messages/mDWPuD5kjCsEiNEEWwrW/container" \
     -H 'X-BCoT-Timestamp: 20180215T200350Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180215/ctn1_request, Signature=7e50993e18975294f7f22aae7ee7ef4e4d68425502e38961c40743b1f72194eb'
```

```html--javascript
<script src="CatenisAPIClientJS.min.js"></script>

<script language="JavaScript">
var deviceId = 'dnN3Ea43bhMTHtTvpytS';

var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'beta'
});

var messageId = 'mDWPuD5kjCsEiNEEWwrW';

ctnApiClient.retrieveMessageContainer(messageId, function (err, data) {
    if (err) {
        // Process error
    }
    else {
        // Process returned data
        console.log('ID of blockchain transaction containing the message:', data.blockchain.txid);

        if (data.externalStorage.ipfs) {
            console.log('IPFS reference to message:', data.externalStorage.ipfs);
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

ctnApiClient.retrieveMessageContainer(messageId, function (err, data) {
    if (err) {
        // Process error
    }
    else {
        // Process returned data
        console.log('ID of blockchain transaction containing the message:', data.blockchain.txid);

        if (data.externalStorage.ipfs) {
            console.log('IPFS reference to message:', data.externalStorage.ipfs);
        }
    }
});
```

```cpp
#include "CatenisApiClient.h"

std::string device_id("dnN3Ea43bhMTHtTvpytS");

ctn::CtnApiClient ctnApiClient(device_id, api_access_secret, "catenis.io", "", "beta");

ctn::RetrieveMessageContainerResult data;
std::string message_id("mDWPuD5kjCsEiNEEWwrW");

try {
    client.retrieveMessageContainer(data, message_id);

    std::cout << "ID of blockchain transaction containing the message: " << data.blockchain.txid << endl;

    if (data.externalStorage != nullptr) {
       std::cout << "IPFS reference to message: " << (*data.externalStorage)["ipfs"] << endl;
    }
}
catch (ctn::CatenisAPIException &errObject) {
    std::cerr << errObject.getErrorDescription() << std::endl;
}
```

### Request

GET /messages/`:messageId`/container

### Parameters

<!-- Note: we are not using the native markdown list feature for the second level items because the generated
        HTML has no space to the following first level item -->
- URL parameters:
<ul class="parameterList">
  <li>`messageId`: The ID of the message the container of which is to be retrieved.</li>
</ul>

> Sample response:

```json
{
  "status": "success",
  "data": {
    "blockchain": {
      "txid": "f624e66c5fc424fbde00b5c134fa0f4fe45ed2f7d0e4540cb0b302815f2ea7f8",
      "isConfirmed": false
    },
    "externalStorage": {
      "ipfs": "QmfWZ7GCNouMNHjkz9BBJazCsfvR5hY9j62HVh5K6uzrwd"
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
| &nbsp;&nbsp;`blockchain` | Object | |
| &nbsp;&nbsp;&nbsp;&nbsp;`txid` | String | The ID of the blockchain transaction where the message was recorded. |
| &nbsp;&nbsp;&nbsp;&nbsp;`confirmed` | Boolean | Indicates whether the blockchain transaction has already been confirmed. |
| &nbsp;&nbsp;`externalStorage` | String |  *(only returned if message is stored on an external storage rather than on the blockchain transaction itself)* |
| &nbsp;&nbsp;&nbsp;&nbsp;`ipfs` | String | The hash used to reference the message on IPFS. |

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_80">Device is deleted<br><a href="#error_msg_90">Device is not active<br><a href="#error_msg_120">Invalid message ID<br><a href="#error_msg_130">Invalid parameters |
| 403 | <a href="#error_msg_200">No permission to retrieve message container |
| 500 | <a href="#error_msg_100">Internal server error |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time |
