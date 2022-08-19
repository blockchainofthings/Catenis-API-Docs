# Notifications

Catenis provides a notification service where a virtual device can receive a real-time message notifying
that a given predefined event that concerns it has taken place. Such predefined events are referred to as *notification events*.

## Notification events

The following notification events are currently defined:

| Event name | Description |
| ---------- | ----------- |
| [`new-msg-received`](#new-message-received-new-msg-received) | A new message has been received |
| [`sent-msg-read`](#sent-message-read-sent-msg-read) | Previously sent message has been read by intended receiver (target device) |
| [`asset-received`](#asset-amount-received-asset-received) | An amount of an asset has been received |
| [`asset-confirmed`](#asset-amount-confirmed-asset-confirmed) | An amount of an asset that was pending due to an asset transfer has been confirmed |
| [`final-msg-progress`](#final-progress-of-message-processing-final-msg-progress) | Progress of asynchronous message processing has come to an end |
| [`asset-export-outcome`](#final-asset-export-outcome-asset-export-outcome) | Asset export has been finalized |
| [`asset-migration-outcome`](#final-asset-migration-outcome-asset-migration-outcome) | Asset migration has been finalized |
| [`nf-asset-issuance-outcome`](#final-non-fungible-asset-issuance-outcome-nf-asset-issuance-outcome) | Non-fungible asset issuance has been finalized |
| [`nf-token-received`](#non-fungible-token-received-nf-token-received) | One or more non-fungible tokens have been received |
| [`nf-token-confirmed`](#non-fungible-token-confirmed-nf-token-confirmed) | One or more non-fungible tokens that were pending due to a non-fungible token transfer has been confirmed |
| [`nf-token-retrieval-outcome`](#final-non-fungible-token-retrieval-outcome-nf-token-retrieval-outcome) | Non-fungible token retrieval has been finalized |
| [`nf-token-transfer-outcome`](#final-non-fungible-token-transfer-outcome-nf-token-transfer-outcome) | Non-fungible token transfer has been finalized |

<aside class="notice">
The list of all system defined notification events can be programmatically retrieved by means of the <a href="#list-notification-events">List Notification Events</a> API method.
</aside>

## Notification messages

The Catenis notifications are conveyed by means of notification messages the contents of which vary according to the
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

### Final asset export outcome (asset-export-outcome)

> Sample notification message:

```json
{
  "assetId": "amNiawM69NjYM8QghoPD",
  "foreignBlockchain": "ethereum",
  "foreignTransaction": {
    "isPending": false,
    "success": true,
    "txid": "0x1738722379007192cac3b8e7ee3babfd1c8304133ea1a7957b93f6134ed62e48"
  },
  "token": {
    "name": "Catenis test token #5",
    "symbol": "CTK5",
    "id": "0xbAE69964D40900c6933A2CF8dD53f97c97Ab9BE7"
  },
  "status": "success",
  "date": "2021-07-02T21:26:33.841Z"
}
```

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `assetId` | String | The ID of the exported asset. |
| `foreignBlockchain` | String | The key identifying the foreign blockchain to where the asset has been exported. One of: `ethereum`, `binance`, or `polygon`. |
| `foreignTransaction` | Object | Information about the transaction issued on the foreign blockchain to create the resulting foreign token. |
| &nbsp;&nbsp;`txid` | String | The ID (or hash) of the foreign blockchain transaction. |
| &nbsp;&nbsp;`isPending` | Boolean | The value `false`, indicating that the foreign blockchain transaction has already been executed. |
| &nbsp;&nbsp;`success` | Boolean | Indicates whether the foreign blockchain transaction has been successfully executed or not. |
| &nbsp;&nbsp;`error` | String | *(only returned if the foreign blockchain transaction's execution has failed)* An error message describing what went wrong when executing the transaction. |
| `token` | Object | Information about the resulting foreign token. |
| &nbsp;&nbsp;`name` | String | The token name. |
| &nbsp;&nbsp;`symbol` | String | The token symbol. |
| &nbsp;&nbsp;`id` | String | *(only returned if the asset is successfully export)* The ID (or address) of the token on the foreign blockchain. |
| `status` | String | The final state of the asset export. One of: `success`, or `error`. |
| `date` | String | ISO 8601 formatted date and time when the asset has been exported. |

### Final asset migration outcome (asset-migration-outcome)

> Sample notification message:

```json
{
  "migrationId": "gbRQqs5z3ReCGfygorai",
  "assetId": "amNiawM69NjYM8QghoPD",
  "foreignBlockchain": "ethereum",
  "direction": "outward",
  "amount": 50,
  "catenisService": {
    "status": "fulfilled",
    "txid": "823941a1e02eab77d5ceecc943d7745bc49068f35d4109f7d60f9ca6fc669838"
  },
  "foreignTransaction": {
    "isPending": false,
    "success": true,
    "txid": "0x098d5588d03db577edfc8fc5b0094a62e22825bc9c7fc8e38430563350c75bfd"
  },
  "status": "success",
  "date": "2021-07-03T12:51:04.771Z"
}
```

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `migrationId` | String | The ID of the asset migration. |
| `assetId` | String | The ID of the asset the amount of which has been migrated. |
| `foreignBlockchain` | String | The key identifying the foreign blockchain to/from where the asset amount has been migrated. One of: `ethereum`, `binance`, or `polygon`. |
| `direction` | String | The direction of the migration. One of: `outward` or `inward`. |
| `amount` | Number | The migrated asset amount. |
| `catenisService` | Object | Information about the execution of the migrate asset Catenis service. |
| &nbsp;&nbsp;`status` | String | The current state of the service's execution. One of: `awaiting`, `failure`, or `fulfilled`. |
| &nbsp;&nbsp;`txid` | String | *(only returned if the service is successfully fulfilled)* The ID of the Catenis transaction issued to fulfill the service. |
| &nbsp;&nbsp;`error` | String | *(only returned if the service's execution has failed)* An error message describing what went wrong when executing the service. |
| `foreignTransaction` | Object | Information about the transaction issued on the foreign blockchain to mint/burn the amount of the foreign token. |
| &nbsp;&nbsp;`txid` | String | The ID (or hash) of the foreign blockchain transaction. |
| &nbsp;&nbsp;`isPending` | Boolean | The value `false`, indicating that the foreign blockchain transaction has already been executed. |
| &nbsp;&nbsp;`success` | Boolean | Indicates whether the foreign blockchain transaction has been successfully executed or not. |
| &nbsp;&nbsp;`error` | String | *(only returned if the foreign blockchain transaction's execution has failed)* An error message describing what went wrong when executing the transaction. |
| `status` | String | The final state of the asset migration. One of: `interrupted`, `success`, or `error`. |
| `date` | String | ISO 8601 formatted date and time when the asset amount has been migrated. |

### Final non-fungible asset issuance outcome (nf-asset-issuance-outcome)

> Sample notification message:

```json
{
  "assetIssuanceId": "iAf6MpZLp6HTqJqX7iF5",
  "progress": {
    "percentProcessed": 100,
    "done": true,
    "success": true,
    "finishDate": "2022-08-06T14:54:43.939Z"
  },
  "result": {
    "assetId": "asBEmCgFFApxDKNxYuC3",
    "nfTokenIds": [
      "t4bicJiRWq5JsoqW893Y",
      "tZZwesXfFRvgZNsCN8gF"
    ]
  }
}
```

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `assetIssuanceId` | String | The ID of the non-fungible asset issuance. |
| `assetId` | String | *(only returned in case of re-issuance)* The ID of the non-fungible asset for which more non-fungible tokens are being issued. |
| `progress` | Object | Final processing status. |
| &nbsp;&nbsp;`percentProcessed` | Number | The percentage of the total processing that has been already completed. |
| &nbsp;&nbsp;`done` | Boolean | *(should always be __`true`__)* Indicates that the processing has finished. |
| &nbsp;&nbsp;`success` | Boolean | Indicates whether the asset issuance has been successfully completed. |
| &nbsp;&nbsp;`error` | Object | *(only returned in case of error)* Information about the error that took place while processing the asset issuance. |
| &nbsp;&nbsp;&nbsp;&nbsp;`code` | Number | Numeric code — equivalent to an HTML status code — of the error. |
| &nbsp;&nbsp;&nbsp;&nbsp;`message` | String | Text describing the error. |
| &nbsp;&nbsp;`finishDate` | String | ISO 8601 formatted date and time when processing has been finalized. |
| `result` | Object | *(only returned in case of success)* The result of the asset issuance. |
| &nbsp;&nbsp;`assetId` | String | *(not returned in case of re-issuance)* The ID of the newly created Catenis non-fungible asset. |
| &nbsp;&nbsp;`nfTokenIds` | Array(String) | List of the IDs of the newly issued non-fungible tokens. |

<aside class="notice">
This notification signals the end of an asynchronous issuance of a non-fungible asset. Use the ID returned in the
 <code>assetIssuanceId</code> field to identify the non-fungible asset issuance.
</aside>

### Non-fungible token received (nf-token-received)

> Sample notification message:

```json
{
  "nfTokenIds": [
    "tZZwesXfFRvgZNsCN8gF"
  ],
  "issuer": {
    "deviceId": "dnN3Ea43bhMTHtTvpytS",
    "name": "deviceB",
    "prodUniqueId": "XYZABC001"
  },
  "from": {
    "deviceId": "dv3htgvK7hjnKx3617Re",
    "name": "Catenis device #1"
  },
  "receivedDate": "2022-08-10T12:50:43.834Z"
}
```

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `nfTokenIds` | Array(String) | List of the IDs of the non-fungible tokens that have been received. |
| `issuer` | Object | Identifies the virtual device that issued the non-fungible tokens — the issuing device. |
| &nbsp;&nbsp;`deviceId` | String | The device ID of the issuing device. |
| &nbsp;&nbsp;`name` | String | *(only returned if issuing device has this data, and the device receiving the notification has the necessary permission right)* The name of the issuing device. |
| &nbsp;&nbsp;`prodUniqueId` | String | *(only returned if issuing device has this data, and the device receiving the notification has the necessary permission right)* The product unique ID of the issuing device. |
| `from` | Object | Identifies the virtual device that sent or assigned the non-fungible tokens — the *sending device*. |
| &nbsp;&nbsp;`deviceId` | String | The device ID of the sending device. |
| &nbsp;&nbsp;`name` | String | *(only returned if sending device has this data, and the device receiving the notification has the necessary permission right)* The name of the sending device. |
| &nbsp;&nbsp;`prodUniqueId` | String | *(only returned if sending device has this data, and the device receiving the notification has the necessary permission right)* The product unique ID of the sending device. |
| `receivedDate` | String | ISO 8601 formatted date and time when the non-fungible tokens have been received. |

<aside class="notice">
The event of a virtual device issuing non-fungible tokens of a non-fungible asset and assigning them to a different
 virtual device can also trigger this notification.
</aside>

### Non-fungible token confirmed (nf-token-confirmed)

> Sample notification message:

```json
{
  "nfTokenIds": [
    "tZZwesXfFRvgZNsCN8gF"
  ],
  "issuer": {
    "deviceId": "dnN3Ea43bhMTHtTvpytS",
    "name": "deviceB",
    "prodUniqueId": "XYZABC001"
  },
  "from": {
    "deviceId": "dv3htgvK7hjnKx3617Re",
    "name": "Catenis device #1"
  },
  "confirmedDate": "2022-08-10T13:00:06.083Z"
}
```

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `nfTokenIds` | Array(String) | List of the IDs of the non-fungible tokens that have been confirmed. |
| `issuer` | Object | Identifies the virtual device that issued the non-fungible tokens — the issuing device. |
| &nbsp;&nbsp;`deviceId` | String | The device ID of the issuing device. |
| &nbsp;&nbsp;`name` | String | *(only returned if issuing device has this data, and the device receiving the notification has the necessary permission right)* The name of the issuing device. |
| &nbsp;&nbsp;`prodUniqueId` | String | *(only returned if issuing device has this data, and the device receiving the notification has the necessary permission right)* The product unique ID of the issuing device. |
| `from` | Object | Identifies the virtual device that sent or assigned the non-fungible tokens — the *sending device*. |
| &nbsp;&nbsp;`deviceId` | String | The device ID of the sending device. |
| &nbsp;&nbsp;`name` | String | *(only returned if sending device has this data, and the device receiving the notification has the necessary permission right)* The name of the sending device. |
| &nbsp;&nbsp;`prodUniqueId` | String | *(only returned if sending device has this data, and the device receiving the notification has the necessary permission right)* The product unique ID of the sending device. |
| `confirmedDate` | String | ISO 8601 formatted date and time when the non-fungible tokens have been confirmed. |

<aside class="notice">
A non-fungible asset issuance can also cause the issued non-fungible tokens to be pending. Thus the confirmation of such
 pending non-fungible tokens can also trigger this notification.
</aside>

<aside class="notice">
This notification can also be sent to the virtual device that initiated a non-fungible token transfer — the sending
 device — in case that non-fungible tokens (held by the same unspent transaction output — UTXO) had to be sent back to
 that device.
</aside>

### Final non-fungible token retrieval outcome (nf-token-retrieval-outcome)

> Sample notification message:

```json
{
  "nfTokenId": "t8uFtevcSysNJWQYykiZ",
  "tokenRetrievalId": "rANdAbC4dkyuih49hE4B",
  "progress": {
    "bytesRetrieved": 397,
    "done": true,
    "success": true,
    "finishDate": "2022-08-10T12:46:16.522Z"
  },
  "continuationToken": "e6cHx3AQ5ym94mp5G83s"
}
```

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `nfTokenId` | String | The ID of the non-fungible token being retrieved. |
| `tokenRetrievalId` | String | The ID of the non-fungible token retrieval. |
| `progress` | Object | Final processing status. |
| &nbsp;&nbsp;`bytesRetrieved` | Number | Total number of bytes of non-fungible token data that have been retrieved. |
| &nbsp;&nbsp;`done` | Boolean | *(should always be __`true`__)* Indicates that the data retrieval has been finalized. |
| &nbsp;&nbsp;`success` | Boolean | Indicates whether all the non-fungible token data has been successfully retrieved. |
| &nbsp;&nbsp;`error` | Object | *(only returned in case of error)* Information about the error that took place while retrieving the non-fungible token data. |
| &nbsp;&nbsp;&nbsp;&nbsp;`code` | Number | Numeric code — equivalent to an HTML status code — of the error. |
| &nbsp;&nbsp;&nbsp;&nbsp;`message` | String | Text describing the error. |
| &nbsp;&nbsp;`finishDate` | String | ISO 8601 formatted date and time when the data retrieval has been finalized. |
| `continuationToken` | string | *(only returned in case of success)* The token that should be used to complete the retrieval of the non-fungible token. |

<aside class="notice">
This notification signals the end of an asynchronous retrieval of a non-fungible token. Use the ID returned in the
 <code>tokenRetrievalId</code> field to identify the non-fungible token retrieval. Then, call the <a href="#retrieve-non-fungible-token">Retrieve Non-Fungible Token</a>
 API method again passing the token returned in the <code>continuationToken</code> field.
</aside>

### Final non-fungible token transfer outcome (nf-token-transfer-outcome)

> Sample notification message:

```json
{
  "nfTokenId": "tZZwesXfFRvgZNsCN8gF",
  "tokenTransferId": "x5ytgabGEnqme3N3GCLy",
  "progress": {
    "metadata": {
      "bytesRead": 491,
      "bytesWritten": 565
    },
    "done": true,
    "success": true,
    "finishDate": "2022-08-10T12:50:43.834Z"
  }
}
```

A JSON containing the following properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `nfTokenId` | String | The ID of the non-fungible token being transferred. |
| `tokenTransferId` | String | The ID of the non-fungible token transfer. |
| `progress` | Object | Final processing status. |
| &nbsp;&nbsp;`dataManipulation` | Object | Progress of the non-fungible token data manipulation: reading and rewriting it after re-encryption (if required). |
| &nbsp;&nbsp;&nbsp;&nbsp;`bytesRead` | Number | Number of bytes of non-fungible token data that have been read. |
| &nbsp;&nbsp;&nbsp;&nbsp;`bytesWritten` | Number | *(only returned if data needed to be re-encrypted)* Number of bytes of non-fungible token data that have been written. |
| &nbsp;&nbsp;`done` | Boolean | *(should always be __`true`__)* Indicates that the non-fungible token transfer has been finalized. |
| &nbsp;&nbsp;`success` | Boolean | Indicates whether the non-fungible token has been successfully transferred. |
| &nbsp;&nbsp;`error` | Object | *(only returned in case of error)* Information about the error that took place while transferring the non-fungible token. |
| &nbsp;&nbsp;&nbsp;&nbsp;`code` | Number | Numeric code — equivalent to an HTML status code — of the error. |
| &nbsp;&nbsp;&nbsp;&nbsp;`message` | String | Text describing the error. |
| &nbsp;&nbsp;`finishDate` | String | ISO 8601 formatted date and time when the non-fungible token transfer has been finalized. |

<aside class="notice">
This notification signals the end of an asynchronous transfer of a non-fungible token. Use the ID returned in the
 <code>tokenTransferId</code> field to identify the non-fungible token transfer.
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

To open a notification channel, one needs to establish a WebSocket connection
using the information provided below.

### Connection endpoint URL

**Sandbox environment**: <span class="url">wss://sandbox.catenis.io/api/0.12/notify/ws/<i>:eventName</i></span>

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
GET /api/0.12/notify/ws/new-msg-received HTTP/1.1
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

### Authentication response

If a successful authentication message is not received by the WebSocket message dispatcher within 5 seconds after the
WebSocket connection is established, the WebSocket connection is closed by the Catenis server.

### Notification Channel Open message

After receiving a successful authentication message, the WebSocket message dispatcher will send a special message the
 content of which is `NOTIFICATION_CHANNEL_OPEN`.

This message is used to confirm that the WebSocket notification channel is open and ready to send notifications.
