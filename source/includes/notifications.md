# Notifications

Catenis Enterprise provides a notification service where a virtual device can receive a real-time message notifying
that a given predefined event that concerns it has taken place. Such predefined events are referred to as *notification events*.

The Catenis notification service is currently at **version 0.1**.

## Notification events

The following notification events are currently defined:

| Event name | Description |
| ---------- | ----------- |
| `new-msg-received` | A new message has been received |
| `sent-msg-read` | Previously sent message has been read by intended receiver (target device) |

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
| `from` | Object | Identifies the virtual device that sent the received message &mdash; the *origin device*. |
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
| `to` | Object | Identifies the device to which the read message had been sent &mdash; the *target device*. |
| &nbsp;&nbsp;`deviceId` | String | The device ID of the target device. |
| &nbsp;&nbsp;`name` | String | *(only returned if target device has this data, and the device receiving the notification has the necessary permission right)* The name of the target device. |
| &nbsp;&nbsp;`prodUniqueId` | String | *(only returned if target device has this data, and the device receiving the notification has the necessary permission right)* The product unique ID of the target device. |
| `readDate` | String | ISO 8601 formatted date and time when the message has been read. |

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

**Beta environment**: <span class="url">wss://beta.catenis.io/api/notify/0.1/ws/0.1/<i>:eventName</i></span>

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
Host: beta.catenis.io
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
a regular Catenis API request &mdash; for more information about API request authentication, please refer to the [Authentication](#authentication) section above.

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
