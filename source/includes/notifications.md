# Notifications

Catenis Enterprise provides a notification service where a virtual device can receive a real-time message notifying
that a given predefined event that concerns it has taken place. Such predefined events are referred to as *notification events*.

The Catenis notification service is currently at **version 0.3**.

## Notification events

The following notification events are currently defined:

| Event name | Description |
| ---------- | ----------- |
| `new-msg-received` | A new message has been received |
| `sent-msg-read` | Previously sent message has been read by intended receiver (target device) |
| `asset-received` | An amount of an asset has been received |
| `asset-confirmed` | An amount of an asset that was pending due to an asset transfer has been confirmed |
| `final-msg-progress` | Progress of asynchronous message processing has come to an end |

<aside class="notice">
The list of all system defined notification events can be programmatically retrieved by means of the <a href="#list-notification-events">List Notification Events</a> API method.
</aside>

## Notification messages

The Catenis Enterprise notifications are conveyed by means of notification messages the contents of which vary according to the
notification event, as follows:

### New message received (new-msg-received)

> Sample notification message:

```json
{
  "messageId": "mNEWqgSMAeDAmBAkBDWr",
  "from": {
    "deviceId": "dnN3Ea43bhMTHtTvpytS",
    "name": "deviceB",
    "prodUniqueId": "XYZABC001"
  },
  "receivedDate": "2018-01-29T23:27:39.657Z"
}
```

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `messageId` | String | The ID of the received message. |
| `from` | Object | Identifies the virtual device that sent the received message — the *origin device*. |
| &nbsp;&nbsp;`deviceId` | String | The device ID of the origin device. |
| &nbsp;&nbsp;`name` | String | *(only returned if origin device has this data, and the device receiving the notification has the necessary permission right)* The name of the origin device. |
| &nbsp;&nbsp;`prodUniqueId` | String | *(only returned if origin device has this data, and the device receiving the notification has the necessary permission right)* The product unique ID of the origin device. |
| `receivedDate` | String | <a href="https://en.wikipedia.org/wiki/ISO_8601" target="_blank">ISO 8601</a> formatted date and time when the message has been received. |

### Sent message read (sent-msg-read)

> Sample notification message:

```json
{
  "messageId": "mNEWqgSMAeDAmBAkBDWr",
  "to": {
    "deviceId": "dv3htgvK7hjnKx3617Re",
    "name": "Catenis device #1"
  },
  "readDate": "2018-01-30T01:02:12.162Z"
}
```

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `messageId` | String | The ID of the read message. |
| `to` | Object | Identifies the virtual device to which the read message had been sent — the *target device*. |
| &nbsp;&nbsp;`deviceId` | String | The device ID of the target device. |
| &nbsp;&nbsp;`name` | String | *(only returned if target device has this data, and the device receiving the notification has the necessary permission right)* The name of the target device. |
| &nbsp;&nbsp;`prodUniqueId` | String | *(only returned if target device has this data, and the device receiving the notification has the necessary permission right)* The product unique ID of the target device. |
| `readDate` | String | ISO 8601 formatted date and time when the message has been read. |

### Asset amount received (asset-received)

> Sample notification message:

```json
{
  "assetId": "aQjlzShmrnEZeeYBZihc",
  "issuer": {
    "deviceId": "dnN3Ea43bhMTHtTvpytS",
    "name": "deviceB",
    "prodUniqueId": "XYZABC001"
  },
  "from": {
    "deviceId": "dv3htgvK7hjnKx3617Re",
    "name": "Catenis device #1"
  },
  "receivedDate": "2018-04-01T17:15:36.134Z"
}
```

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `assetId` | String | The ID of the received asset. |
| `amount` | Amount | The amount of the asset that has been received. |
| `issuer` | Object | Identifies the virtual device that issued the asset — the *issuing device*. |
| &nbsp;&nbsp;`deviceId` | String | The device ID of the issuing device. |
| &nbsp;&nbsp;`name` | String | *(only returned if issuing device has this data, and the device receiving the notification has the necessary permission right)* The name of the issuing device. |
| &nbsp;&nbsp;`prodUniqueId` | String | *(only returned if issuing device has this data, and the device receiving the notification has the necessary permission right)* The product unique ID of the issuing device. |
| `from` | Object | Identifies the virtual device that sent or assigned the asset amount — the *sending device*. |
| &nbsp;&nbsp;`deviceId` | String | The device ID of the sending device. |
| &nbsp;&nbsp;`name` | String | *(only returned if sending device has this data, and the device receiving the notification has the necessary permission right)* The name of the sending device. |
| &nbsp;&nbsp;`prodUniqueId` | String | *(only returned if sending device has this data, and the device receiving the notification has the necessary permission right)* The product unique ID of the sending device. |
| `receivedDate` | String | ISO 8601 formatted date and time when the asset amount has been received. |

<aside class="notice">
The event of a virtual device issuing an amount of an asset and assigning it to a different virtual device can also trigger this notification.
</aside>

### Asset amount confirmed (asset-confirmed)

> Sample notification message:

```json
{
  "assetId": "aQjlzShmrnEZeeYBZihc",
  "amount": 54.25,
  "issuer": {
    "deviceId": "dnN3Ea43bhMTHtTvpytS",
    "name": "deviceB",
    "prodUniqueId": "XYZABC001"
  },
  "from": {
    "deviceId": "dv3htgvK7hjnKx3617Re",
    "name": "Catenis device #1"
  },
  "confirmedDate": "2018-04-01T17:32:03.012Z"
}
```

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `assetId` | String | The ID of the confirmed asset. |
| `amount` | Amount | The amount of the asset that has been confirmed. |
| `issuer` | Object | Identifies the virtual device that issued the asset — the *issuing device*. |
| &nbsp;&nbsp;`deviceId` | String | The device ID of the issuing device. |
| &nbsp;&nbsp;`name` | String | *(only returned if issuing device has this data, and the device receiving the notification has the necessary permission right)* The name of the issuing device. |
| &nbsp;&nbsp;`prodUniqueId` | String | *(only returned if issuing device has this data, and the device receiving the notification has the necessary permission right)* The product unique ID of the issuing device. |
| `from` | Object | Identifies the virtual device that originally sent or assigned the asset amount — the *sending device*. |
| &nbsp;&nbsp;`deviceId` | String | The device ID of the sending device. |
| &nbsp;&nbsp;`name` | String | *(only returned if sending device has this data, and the device receiving the notification has the necessary permission right)* The name of the sending device. |
| &nbsp;&nbsp;`prodUniqueId` | String | *(only returned if sending device has this data, and the device receiving the notification has the necessary permission right)* The product unique ID of the sending device. |
| `confirmedDate` | String | ISO 8601 formatted date and time when the asset amount has been confirmed. |

<aside class="notice">
An asset issuance can also cause the issued amount to be pending. Thus the confirmation of such pending amount can
also trigger this notification.
</aside>

<aside class="notice">
This notification can also be sent to the virtual device that initiated an asset transfer — the sending device — in case
that a change asset amount had to be sent back to that device.
</aside>

### Final progress of message processing (final-msg-progress)

> Sample notification message:

```json
{
  "ephemeralMessageId": "hEXMdtTMzkhyJ4WssQmp",
  "action": "read",
  "progress": {
    "bytesProcessed": 28,
    "done": true,
    "success": true,
    "finishDate": "2019-03-13T14:09:10.121Z"
  },
  "result": {
    "messageId": "mt7ZYbBYpM3zcgAf3H8X",
    "continuationToken": "kjXP2CZaSdkTKCi2jDi2"
  }
}
```

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `ephemeralMessageId` | String | The ID of the ephemeral message — either a provisional or a cached message — to which this notification refers. |
| `action` | String | The action that was to be performed on the message. One of: `log`, `send`, or `read`. |
| `progress` | Object | Current processing status. |
| &nbsp;&nbsp;`bytesProcessed` | Number | Total number of bytes of message that had already been processed. |
| &nbsp;&nbsp;`done` | Boolean | *(should always be __`true`__)* Indicates that processing has finished. |
| &nbsp;&nbsp;`success` | Boolean | Indicates whether message has been successfully processed. |
| &nbsp;&nbsp;`error` | Object | *(only returned if processing finished with error)* Error information. |
| &nbsp;&nbsp;&nbsp;&nbsp;`code` | Number | Numeric code — equivalent to an HTML status code — of the error that took place while processing the message. |
| &nbsp;&nbsp;&nbsp;&nbsp;`message` | String | Text describing the error that took place while processing the message. |
| &nbsp;&nbsp;`finishDate` | String | ISO 8601 formatted date and time when processing was finalized. |
| `result` | Object | *(only returned if processing finished successfully)* Result of processing. |
| &nbsp;&nbsp;`messageId` | String | ID of the Catenis message. When logging or sending — `action` equals to __`log`__ or __`send`__—, it is the ID of the resulting message. When reading — `action` equals to __`read`__—, it references the message being read. |
| &nbsp;&nbsp;`continuationToken` | String | *(only returned if reading message — `action` equals to __`read`__)* The token that should be used to complete the read of the message. |

<aside class="notice">
This notification signals the end of the asynchronous processing of a message. Use the ID returned in the <code>ephemeralMessageId</code>
 field to identify the message. When <b>sending</b> or <b>logging</b> a message asynchronously, it should match the ID in the <b><code>provisionalMessageId</code></b>
 field returned by either the <a href="#log-message">Log Message</a> or <a href="#send-message">Send Message</a> API method. When <b>reading</b> a message asynchronously, it should
 match the ID in the <b><code>cachedMessageId</code></b> field returned by the <a href="#read-message">Read Message</a> API method instead.
</aside>

## Notification channel

To be able to receive notifications, a virtual device must open a notification channel for a specific notification
event. Then, as long as the notification channel is open, the virtual device shall receive notification messages when
the corresponding event takes place.

The way that a notification channel is open depends on the notification message dispatcher used.

The following notification message dispatchers are currently available:

- WebSocket notification message dispatcher

## WebSocket notification message dispatcher

This notification message dispatcher uses a WebSocket connection as the communication transport for the notification channel.

The WebSocket notification message dispatcher is currently at **version 0.1**.

To open a notification channel, one needs to establish a WebSocket connection
using the information provided below.

### Connection endpoint URL

**Sandbox environment**: <span class="url">wss://sandbox.catenis.io/api/notify/0.3/ws/0.1/<i>:eventName</i></span>

### Parameters

<!-- Note: we are not using the native markdown list feature for the second level items because the generated
        HTML has no space to the following first level item -->
- URL parameters:
<ul class="parameterList">
  <li>`eventName`: The name of the notification event for which a notification channel should be open.</li>
</ul>

### WebSocket subprotocol

`notify.catenis.io`

### Authentication

The following steps should be taken in order to successfully authenticate the virtual device when establishing a WebSocket
connection to open the notification channel:

> Sample authenticated dummy WebSocket notification request:

```http
GET /api/notify/ws/new-msg-received HTTP/1.1
X-BCoT-Timestamp: 20180219T223932Z
Authorization: CTN1-HMAC-SHA256 Credential=dmM2Dz32agLSGsSuoxsR/20180219/ctn1_request, Signature=59b44f3d504b272e92c1f96694b7f6abb39b8cb7726ffe8b57d2cb46aedf568b
Host: sandbox.catenis.io
Connection: close
User-Agent: Paw/3.1.5 (Macintosh; OS X/10.13.3) GCDHTTPRequest
```

> Sample WebSocket authentication message:

```json
{
  "x-bcot-timestamp": "20180219T223932Z",
  "authorization": "CTN1-HMAC-SHA256 Credential=dmM2Dz32agLSGsSuoxsR/20180219/ctn1_request, Signature=59b44f3d504b272e92c1f96694b7f6abb39b8cb7726ffe8b57d2cb46aedf568b"
}
```

1. Assemble a dummy GET request using the WebSocket notification channel URL, and then authenticate it as if it was
a regular Catenis API request — for more information about API request authentication, please refer to the [Authentication](#authentication) section above.

2. Do not send the authenticated request, but rather just take the HTTP headers `X-BCoT-Timestamp` and `Authorization`
contained in it and save them.

3. Go ahead and open the WebSocket connection.

4. Right after the WebSocket connection is open, send a single message the contents of which should be a JSON containing
the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `x-bcot-timestamp` | String | The value of the `X-BCoT-Timestamp` HTTP header saved at step 3 above. |
| `authorization` | String | The value of the `Authorization` HTTP header saved at step 3 above. |

<aside class="warning">
Failure to do so will result in the WebSocket connection being closed by the Catenis server.
</aside>
