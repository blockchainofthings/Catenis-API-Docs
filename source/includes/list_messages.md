## List Messages

Retrieves a list of message entries that satisfy a given search criteria.

A virtual device can use it to identify newly received messages, for instance.


> Sample request:

```http--raw
GET /api/0.6/messages?action=send&direction=inbound&fromDeviceIds=dv3htgvK7hjnKx3617Re&readState=unread&startDate=2018-01-01T00:00:00Z&endDate=2018-02-28T23:59:59Z HTTP/1.1
X-BCoT-Timestamp: 20180216T135036Z
Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180216/ctn1_request, Signature=bb8a7853798df41e6f9af1a900da4c3cecc161265ec85649f8b883678e8993ed
Host: sandbox.catenis.io
Connection: close
User-Agent: Paw/3.1.5 (Macintosh; OS X/10.13.3) GCDHTTPRequest
```

```shell
curl "https://sandbox.catenis.io/api/0.6/messages?action=send&direction=inbound&fromDeviceIds=dv3htgvK7hjnKx3617Re&readState=unread&startDate=2018-01-01T00:00:00Z&endDate=2018-02-28T23:59:59Z" \
     -H 'X-BCoT-Timestamp: 20180216T135101Z' \
     -H 'Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180216/ctn1_request, Signature=c0bb81382db103e30859056646bfa17759e9e8f73778abc0245fdbdb54be4656'
```

```html--javascript
<script src="CatenisAPIClientJS.min.js"></script>

<script language="JavaScript">
var deviceId = 'dnN3Ea43bhMTHtTvpytS';

var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'sandbox'
});

ctnApiClient.listMessages({
        action: 'send',
        direction: 'inbound',
        fromDevices: [{
            id: 'dv3htgvK7hjnKx3617Re'
        }],
        readState: 'unread',
        startDate: '20180101T000000Z',
        endDate: '20180228T235959Z'
    },
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            if (data.msgCount > 0) {
                console.log('Returned messages:', data.messages);

                if (data.countExceeded) {
                    console.log('Warning: not all messages fulfilling search criteria have been returned!';
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

ctnApiClient.listMessages({
        action: 'send',
        direction: 'inbound',
        fromDevices: [{
            id: 'dv3htgvK7hjnKx3617Re'
        }],
        readState: 'unread',
        startDate: '20180101T000000Z',
        endDate: '20180228T235959Z'
    },
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
            if (data.msgCount > 0) {
                console.log('Returned messages:', data.messages);

                if (data.countExceeded) {
                    console.log('Warning: not all messages fulfilling search criteria have been returned!';
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
    $data = $ctnApiClient->listMessages([
        'action' => 'send',
        'direction' => 'inbound',
        'fromDevices' => [[
            'id' => 'dv3htgvK7hjnKx3617Re'
        ]],
        'readState' => 'unread',
        'startDate' => '20180101T000000Z',
        'endDate' => '20180228T235959Z'
    ]);

    // Process returned data
    if ($data->msgCount > 0) {
        echo 'Returned messages: ' . print_r($data->messages, true);
        
        if ($data->countExceeded) {
            echo 'Warning: not all messages fulfilling search criteria have been returned!' . PHP_EOL;
        }
    }
}
catch (CatenisException $ex) {
    // Process exception
}
```

```cpp
#include "CatenisApiClient.h"

std::string device_id("dnN3Ea43bhMTHtTvpytS");

ctn::CtnApiClient ctnApiClient(device_id, api_access_secret, "catenis.io", "", "sandbox");

ctn::ListMessagesResult data;

try {
    client.listMessages(data, "send", "inbound", "dv3htgvK7hjnKx3617Re", "", "", "", "unread", "20180101T000000Z", "20180228T235959Z");

    int msgCounter = 0;

    for (auto it = data.messageList.begin(); it != data.messageList.end(); it++) {
        std::cout << "Message #" << ++msgCounter << ":" << std::endl;

        std::shared_ptr<ctn::MessageDescription> msgDesc = *it;

        std::cout << "  message ID: " << msgDesc->messageId << std::endl;
        std::cout << "  action: " << msgDesc->action << std::endl;

        // Process further message info appropriately
    }

    if (data.countExceeded) {
        std::cout << "Warning: not all messages fulfilling search criteria have been returned!" << std::endl;
    }
}
catch (ctn::CatenisAPIException &errObject) {
    std::cerr << errObject.getErrorDescription() << std::endl;
}
```

### Request

GET /messages

### Parameters

<!-- Note: we are not using the native markdown list feature for the second level items because the generated
        HTML has no space to the following first level item -->
- Query string parameters:
<ul class="parameterList">
  <li>`action`: *(optional, default: __`any`__)* Action originally performed on the messages to be retrieved. Valid options: `log`, `send`, `any`. Use `log` to retrieve only logged messages, and `send` to retrieve only sent messages. The value `any` can be used to retrieve both logged and sent messages.</li>
  <li>`direction`: *(optional, default: __`any`__)* The direction of the sent messages to be retrieved. Valid options: `inbound`, `outbound`, `any`. Use `inbound` to retrieve only sent messages that had been received by the virtual device issuing the request, and `outbound` to retrieve only sent messages that had been sent by the device issuing the request. The value `any` can be used to retrieve both inbound and outbound messages.</li>
  <li>`fromDeviceIds`: *(optional)* A comma-separated list of virtual device IDs specifying the devices from which the sent messages to be retrieved had been sent. Note that this option only applies to inbound sent messages.</li>
  <li>`fromDeviceProdUniqueIds`: *(optional)* A comma-separated list of product unique IDs specifying the devices from which the sent messages to be retrieved had been sent. Note that this option only applies to inbound sent messages.</li>
  <li>`toDeviceIds`: *(optional)* A comma-separated list of virtual device IDs specifying the devices to which the sent messages to be retrieved had been sent. Note that this option only applies to outbound sent messages.</li>
  <li>`toDeviceProdUniqueIds`: *(optional)* A comma-separated list of product unique IDs specifying the devices to which the sent messages to be retrieved had been sent. Note that this option only applies to outbound sent messages.</li>
  <li>`readState`: *(optional, default: __`any`__)* The current read state of the message. Valid options: `read`, `unread`, `any`. Use `read` to retrieve only logged or inbound sent messages that had already been read by the virtual device issuing the request, or outbound sent messages sent with the read confirmation option set for which a message read notification has already been received. Use `unread` to retrieve only logged or inbound sent messages that had not yet been read by the device issuing the request, or outbound sent messages sent with the read confirmation option set for which a message read notification has not been received yet. Use `any` if you do not care about the read state of the message to be retrieved.</li>
  <li>`startDate`: *(optional)* <a href="https://en.wikipedia.org/wiki/ISO_8601" target="_blank">ISO 8601</a> formatted date and time specifying the inclusive lower bound of the time frame within which the messages to be retrieved had been: logged, for logged messages; sent, for outbound sent messages; and received, for inbound sent messages.</li>
  <li>`endDate`: *(optional)* ISO 8601 formatted date and time specifying the inclusive upper bound of the time frame within which the messages to be retrieved had been: logged, for logged messages; sent, for outbound sent messages; and received, for inbound sent messages.</li>
</ul>

> Sample response:

```json
{
  "status": "success",
  "data": {
    "messages": [
      {
        "messageId": "mospScAtxyX8ytD9Cq58",
        "action": "log",
        "read": false,
        "date": "2018-01-29T23:25:47.865Z"
      },
      {
        "messageId": "mNEWqgSMAeDAmBAkBDWr",
        "action": "send",
        "direction": "outbound",
        "to": {
          "deviceId": "dv3htgvK7hjnKx3617Re",
          "name": "Catenis device #1"
        },
        "readConfirmationEnabled": true,
        "read": true,
        "date": "2018-01-29T23:27:39.331Z"
      }
    ],
    "msgCount": 2,
    "countExceeded": false
  }
}
```

### Success response

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `status` | String | The value **`success`**, indicating that the request was successful. |
| `data` | Object | The actual data returned in response to the API request. |
| &nbsp;&nbsp;`messages` | Array(Object) | The returned list of message information entries including the messages that satisfies the search criteria. The list is sorted in ascending order in regard to the returned `date` field.  |
| &nbsp;&nbsp;&nbsp;&nbsp;`messageId` | String | The ID of the message. |
| &nbsp;&nbsp;&nbsp;&nbsp;`action` | String | Action originally performed on the message. Possible values: `log`, `send`. The value `log` indicates that this is a logged message, and the value `send` indicates that this is a sent message. |
| &nbsp;&nbsp;&nbsp;&nbsp;`direction` | String | *(only returned for sent messages)* The direction of the sent message. Possible values: `inbound`, `outbound`. The value `inbound` indicates that this is a message received by the virtual device issuing the request, and the value `outbound` indicates that this is a message sent by the device issuing the request. |
| &nbsp;&nbsp;&nbsp;&nbsp;`from` | Object | *(only returned for sent messages)* Identifies the virtual device that sent the message — the *origin device*. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`deviceId` | String | The device ID of the origin device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`name` | String | *(only returned if origin device has this data, and the device issuing the request has the necessary permission right)* The name of the origin device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`prodUniqueId` | String | *(only returned if origin device has this data, and the device issuing the request has the necessary permission right)* The product unique ID of the origin device. |
| &nbsp;&nbsp;&nbsp;&nbsp;`to` | Object | *(only returned for sent messages)* Identifies the device to which the message had been sent — the *target device*. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`deviceId` | String | The device ID of the target device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`name` | String | *(only returned if target device has this data, and the device issuing the request has the necessary permission right)* The name of the target device. |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`prodUniqueId` | String | *(only returned if target device has this data, and the device issuing the request has the necessary permission right)* The product unique ID of the target device. |
| &nbsp;&nbsp;&nbsp;&nbsp;`readConfirmationEnabled` | Boolean | *(only returned for outbound sent messages)* Indicates whether message had been sent with read confirmation enabled. |
| &nbsp;&nbsp;&nbsp;&nbsp;`read` | Boolean | *(not returned for outbound sent messages sent with read confirmation not enabled)* Indicates whether the message had already been read. |
| &nbsp;&nbsp;&nbsp;&nbsp;`date` | String | ISO 8601 formatted date and time when the message had been: logged, for logged message; sent, for outbound sent message; and received, for inbound sent message. |
| &nbsp;&nbsp;`msgCount` | Number | Number of messages for which information was returned. |
| &nbsp;&nbsp;`countExceeded` | Boolean | Indicates whether the number of messages that satisfies the search criteria exceeded the maximum allowed number of returned messages, and thus the returned result set had been truncated. |

<aside class="notice">
The returned <code>msgCount</code> field does not always match the number of message information entries returned. This
is due to the fact that, in the rare cases where the virtual device issuing the request had sent messages to itself, if such
messages are included in the returned result set and the search criteria allows for both inbound and outbond sent messages
to be returned, there will be two entries for each of those messages: one in which the message appears as an outbound
message, and another where the message appears as an inbound message.
</aside>

<aside class="warning">
The practice of a virtual device sending a message to itself, although possible, is fully discouraged. Instead, a virtual device should
choose to log — as opposed to send — the message in such cases. This not only avoids the idiosyncrasy
mentioned in the notice above, but also and more importantly leads to a more efficient and less expensive solution.
</aside>

<aside class="success">
It is always a good practice to revise the search creteria in order to restrict the search when the returned
<code>countExceeded</code> field is true so a complete result set can be returned.
</aside>

### Possible errors

| Status&nbsp;code | Error&nbsp;message |
| ----------- | ------------- |
| 400 | <a href="#error_msg_80">Device is deleted</a><br><a href="#error_msg_90">Device is not active</a><br><a href="#error_msg_130">Invalid parameters</a> |
| 500 | <a href="#error_msg_100">Internal server error</a> |
| 503 | <a href="#error_msg_220">System currently not available; please try again at a later time</a> |
