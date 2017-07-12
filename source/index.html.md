--- 

title: Catenis Enterprise RESTful API Specification

language_tabs:
  - shell: cURL
  - javascript: JavaScript
  - cpp: C++

toc_footers: 
- <a href='http://www.blockchainofthings.com/'>Sign Up for a Catenis Keys</a> 

includes: 
- errors

search: true 
--- 

# Introduction 

The Catenis Enterprise API is organized around REST. Our API has predictable, resource-oriented URLs, and uses HTTP response codes to indicate API errors. We use built-in HTTP features, like HTTP authentication and HTTP verbs, which are understood by off-the-shelf HTTP clients. We support cross-origin resource sharing, allowing you to interact securely with our API from a client-side web application (though you should never expose your API access secret in any public website's client-side code). JSON is returned by all API responses, including errors. 

**API Version:** 0.3 

**Base API Endpoint:** https://beta.catenis.io/api/0.3/

**Available Libraries:** [JavaScript](https://github.com/blockchainofthings/CatenisAPIClientJS), [C++](https://github.com/blockchainofthings/CatenisAPIClientCpp)

# Authentication

## General

Catenis Enterprise API methods require authentication on each request.  The authentication mechanism used is a SHA-256 Keyed-Hash Message Authentication Code (HMAC-SHA256).

Authenticating to the API via your Catenis virtual device requires your **API access secret** and unique virtual **device ID**. Please contact your Blockchain of Things’s representative who can provide you with both the API access secret and the ID. Your API access secret carry many privileges, so be sure to keep them secret! Do not share it in publicly accessible areas such as GitHub, client-side code, and so forth.

When accessing the Catenis Enterprise API using one of the Catenis Enterprise API clients, the client handles the authentication process for you. For a list of available clients supporting Catenis Enterprise API, see [Available Libraries](https://github.com/blockchainofthings).

## Detailed Specification

This section provides the specification of a Catenis HMAC-SHA256 method authentication request. This specification allows a developer to build the authentication request for languages in which there are no presently available clients.

The authentication is done by adding specific headers to the contructed http request.

1. host: the host name
2. x-bcot-timestamp: current (when request is made) UTC time in ISO 8601 format 
3. **Authorization Header**: A concatenated combination of hashes and strings that verifies the request

The Authorization Header is contructed through the strings that will be defined in detail below. 

### Conformed request

> Conformed request

```text
The conformed request is the concatenation of the following strings:

  <HTTP verb> + "\n"
  <API end-point URI> + "\n"
  <Essential headers> + "\n"
  <Hash of payload> + "\n"

Example:

  "POST" + "\n"
  "/api/0.1/message/send" + "\n"
  "host:api.catenis.com" + "\n"
  "x-bcot-timestamp:20170125T000000Z" + "\n"
  "3d412a230825959d14f6915214770bd45de23ebc2109dd2e9b59bb7a9640d216" + "\n"
```

| Name | Description |
| ---- | ----------- |
| HTTP verb | The HTTP method used for the request. One of “GET”, “POST”, “PUT”, “HEAD”, “DELETE”, etc. |
| API end-point URI | The complete path of the URL of the API end-point.Example: “/api/0.1/message/send” |
| Essential headers | A list containing the following HTTP headers (the header name and its value separated by a colon character), each one terminated with a newline character (“\n”): host => the host name (example: host:api.catenis.com), x-bcot-timestamp => current (when request is made) UTC time in ISO 8601 format (example: x-bcot-timestamp:20170125T000000Z). NOTE: the headers must be in this order, and their names must be in lowercase. The value must be separated from the header name by a colon character with no spaces in between. Example: “host:api.catenis.com\nx-bcot-timestamp:20170125T103246Z\n" |
| Hash of payload | HEX(SHA256(<payload>)) - the SHA256 hash of the request payload in hex format (a 64-character string containing only hexadecimal characters). If the request has no payload, it is the hash of the empty string. |

### String to sign

> String to sign

```text
The string to sign is the concatenation of the following strings:

  "CTN1-HMAC-SHA256" + "\n"
  <timestamp> + "\n"
  <Scope> + "\n"
  <Hash of conformed request> + "\n"

Example:

  "CTN1-HMAC-SHA256" + "\n"
  "20170125T103246Z" + "\n"
  "20170125" + "/ctn1_request" + "\n"
  "6026f969df459e934476a79dc3f95ad2569f7f51c4f7a2cbe276134698b90bca" + "\n"
```

| Name | Description |
| ---- | ----------- |
| timestamp | Current (when request is made) UTC time in ISO 8601 format (example: 20170125T103246Z). NOTE: this MUST match the value of the x-bcot-timestamp HTTP header. |
| Scope | The string "\<Date>" + “/ctn1_request”, where \<Date> is a date in the YYYYMMDD format. NOTE: the signature will be valid for seven days from this date. |
| Hash of conformed request | HEX(SHA256(\<Conformed request>)) - the SHA256 hash of the conformed request (as described in item 1. above) in hex format (a 64-character string containing only hexadecimal characters) |

<br/><br/><br/><br/><br/>

### Signature

> Signature

```text
The signature is the computed string of the following:

  HEX(HMAC-SHA256(<Signing key>, <String to sign>))
```

| Name | Description |
| ---- | ----------- |
| Signing key | HMAC-SHA256(\<Date key>, “ctn1_request”) - the computed HMAC using the SHA256 algorithm of the literal string “ctn1_request” with the key \<Date key> |
| Date key | HMAC-SHA256(“CTN1" + \<API access secret>, \<Date>) - the computed HMAC using the SHA256 algorithm of the scope date (the date used in the \<Scope> above) in the YYYYMMDD format with the key formed by the concatenation of the literal string “CTN1" and the API Access Secret of the Catenis device. |

### Authorization header

> Authorization header

```text
The Authorization header is the concatenation of the following strings:

  "CTN1-HMAC-SHA256" + <Space>
  "Credential" + "=" + <DeviceId> + "/" + <Scope> + ","
  "Signature" + "=" + <Signature>
```

| Name | Description |
| ---- | ----------- |
| Space | At least one whitespace character |
| DeviceId | The ID of the Catenis device |
| Scope | Same as the \<Scope> defined in above |
| Signature | The signature of the request as described above. |

<br/><br/>

### Example

```http
POST /api/0.3/messages/log HTTP/1.1
X-BCoT-Timestamp: 20170711T211602Z
Authorization: CTN1-HMAC-SHA256 Credential=<your_virtual_device_id>/20170711/ctn1_request, Signature=38c8f61d2bf3ef51917b26249e6aaa996780a92c04e0c27f11b1a77c8c6b8a6e
Content-Type: application/json; charset=utf-8
Host: beta.catenis.io
Connection: close
Content-Length: 91

{"message":"Example Message","options":{"encoding":"utf8","encrypt":true,"storage":"auto"}}
```

A fully constructed http request would be as so. Note that only https requests are permitted.



<!-- LOG MESSAGE -->
<!-- LOG MESSAGE -->
<!-- LOG MESSAGE -->
<!-- LOG MESSAGE -->
<!-- LOG MESSAGE -->
# Log Message

## ***POST*** 

> Sample Request

```shell
curl -X "POST" "https://beta.catenis.io/api/<api_version>/messages/log" \
     -H "X-BCoT-Timestamp: <UTC_date_ISO8601>" \
     -H "Authorization: CTN1-HMAC-SHA256 Credential=<your_virtual_device_id>/<date_YYYYMMDD>/ctn1_request, Signature=<generated_signature>" \
     -H "Content-Type: application/json; charset=utf-8" \
     -d $'{
  "message": "Only a test",
  "options": {
    "encoding": "utf8",
    "encrypt": true,
    "storage": "auto"
  }
}'
```

```javascript
var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'beta'
});

ctnApiClient.logMessage('My message', {
        encoding: 'utf8',
        encrypt: true,
        storage: 'auto'
    },
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
        }
});
```

```cpp
ctn::CtnApiClient ctnApiClient(device_id, api_access_secret, "catenis.io", "", "beta");
std::string response_data; // this is where the http response will be stored
ctn::MethodOption options("utf8", true, "auto");

ctnApiClient.logMessage("My message", response_data, options);
```

> Sample Response

```json-doc
{
  "status": [string], // ["success", "error"]
  "data": {
    "messageId": [string] // ID of the logged Catenis message
  }
}
```

**Description:** Stores a message to the blockchain

### HTTP Request 
`POST /messages/log`

### Parameters

* **HTTP Body**

| Name | Description | Required | Type |
| ---- | ----------- | -------- | ---- |
| message |  The message to record | Yes | string |
| options. encoding | Value identifying the encoding of the message | No, default: "utf8" | ["utf8", "base64", "hex"] |
| options. encrypt | Indicates whether message should be encrypted before storing it | No, default: true | boolean |
| options. storage | Value identifying where the message should be stored | No, default: "auto" | [“auto", "embedded", "external"] |

### Responses

| Code | Description | Type |
| ---- | ----------- | ---- |
| 200 | Success: message_Id returned | JSON |

<!-- SEND MESSAGE -->
<!-- SEND MESSAGE -->
<!-- SEND MESSAGE -->
<!-- SEND MESSAGE -->
<!-- SEND MESSAGE -->
# Send Message
## ***POST*** 

> Sample Request

```shell
curl -X "POST" "https://beta.catenis.io/api/<api_version>/messages/send" \
     -H "X-BCoT-Timestamp: <UTC_date_ISO8601>" \
     -H "Authorization: CTN1-HMAC-SHA256 Credential=<your_virtual_device_id>/<date_YYYYMMDD>/ctn1_request, Signature=<generated_signature>" \
     -H "Content-Type: application/json; charset=utf-8" \
     -d $'{
  "message": "Only a test to device 2",
  "options": {
    "encoding": "utf8",
    "encrypt": true,
    "storage": "external"
  },
  "targetDevice": {
    "id": "<target_virtual_device_id>",
    "isProdUniqueId": false
  }
}'

```

```javascript
var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'beta'
});

ctnApiClient.sendMessage({
        id: targetDeviceId,
        isProdUniqueId: false
    },
    'My message to send', {
        encoding: 'utf8',
        encrypt: true,
        storage: 'auto'
    },
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
        }
});
```

```cpp
ctn::CtnApiClient ctnApiClient(device_id, api_access_secret, "catenis.io", "", "beta");
std::string response_data; // this is where the http response will be stored
ctn::MethodOption options("utf8", true, "auto");
ctn::Device device(device_id, false);

ctnApiClient.sendMessage(device, "My message to send", response_data, options);
```

> Sample Response

```json-doc
{
  "status": "success",
  "data": {
    "messageId": [String]    // ID of the sent message 
  }
}
```

**Description:** Sends a message to a target device

### HTTP Request 
`POST /messages/send`

### Parameters

* **HTTP Body**

| Name | Description | Required | Type |
| ---- | ----------- | -------- | ---- |
| targetDevice. id |  ID of target device. Should be a Catenis virtual device ID unless isProdUniqueId is true | Yes | string |
| targetDevice. isProdUniqueId | Indicates whether supplied ID is a product unique ID (otherwise, it should be a Catenis virtual device ID) | No, default: false | boolean |
| message |  The message to send | Yes | string |
| options. encoding | Value identifying the encoding of the message | No, default: "utf8" | ["utf8", "base64", "hex"] |
| options. encrypt | Indicates whether message should be encrypted before storing it | No, default: true | boolean |
| options. storage | Value identifying where the message should be stored | No, default: "auto" | [“auto", "embedded", "external"] |

### Responses

| Code | Description | Type |
| ---- | ----------- | ---- |
| 200 | Success: message_Id returned | JSON |

<!-- READ MESSAGE -->
<!-- READ MESSAGE -->
<!-- READ MESSAGE -->
<!-- READ MESSAGE -->
<!-- READ MESSAGE -->
# Read Message
## ***GET*** 

> Sample Request

```shell
curl "https://beta.catenis.io/api/<api_version>/messages/<messsageId>?encoding=utf8" \
     -H "X-BCoT-Timestamp: <UTC_date_ISO8601>" \
     -H "Authorization: CTN1-HMAC-SHA256 Credential=<your_virtual_device_id>/<date_YYYYMMDD>/ctn1_request, Signature=<generated_signature>"
```

```javascript
var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'beta'
});

ctnApiClient.readMessage(messageId, 'utf8',
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
        }
});
```

```cpp
ctn::CtnApiClient ctnApiClient(device_id, api_access_secret, "catenis.io", "", "beta");
std::string response_data; // this is where the http response will be stored

ctnApiClient.readMessage(message_id, response_data, "utf8")
```

> Sample Response

```json-doc
{
  "status": "success",
   "action": [String],         // Action originally performed on   
                               //  the message; either 'log' or 
                               //  'send'
   "from": {                   // Note: only returned if origin 
                               //  device is different than device 
                               //  that issued the request,
                               //  unless it is the (rare) case
                               //  where device sent a message to
                               //  itself
     "deviceId": [String],     // Catenis ID of the origin device 
                               //  (device that had sent/logged 
                               //  the message)
     "name": [String],         // (only returned if device is 
                               //  public and has this data) - 
                               //  Assigned name of the device
     "prodUniqueId": [String]  // (only returned if device is 
                               //  public and has this data) -  
                               //  Product unique ID of the
                               //  device
   },
   "to": {                     //  Note: only returned if target 
                               //  device different than device 
                               //  that issued the request
     "deviceId": [String]      // Catenis ID of target device 
                               //  (device to which the message 
                               //  had been sent)
     "name": [String],         // (only returned if device is 
                               //  public and has this data) - 
                               //  Assigned name of the device
     "prodUniqueId": [String]  // (only returned if device is 
                               //  public and has this data) - 
                               //  Product unique ID of the
                               //  device
    },
    "message": [String]        // The read message formatted 
                               // using the specified encoding
}

// Logged message example
{
  "status": "success",
  "data": {
    "Action": "log",
    "message": "Only a test"
  }
}

// Sent message example
{
  "status": "success",
  "data": {
    "Action": "send",
    "from": {
      "deviceId": "<origin_virtual_device_id>",
      "name": "Catenis device #1"
    },
    "message": "Only a test to device 2"
  }
}
```

**Description:** Reads a message that had been previously logged or sent 

### HTTP Request 
`GET /messages/{messageId}` 

### Parameters

* **HTTP Path**

| Name | Description | Required | Type |
| ---- | ----------- | -------- | ---- |
| messageId | ID of the Catenis message to be read | Yes | string |

* **HTTP Query**

| Name | Description | Required | Type |
| ---- | ----------- | -------- | ---- |
| encoding | Value identifying the encoding | No, default: "utf8" | ["utf8", "base64", "hex"] |

### Responses

| Code | Description | Type |
| ---- | ----------- | ---- |
| 200 | Success: message returned | JSON |

<!-- RETRIEVE MESSAGE CONTAINER -->
<!-- RETRIEVE MESSAGE CONTAINER -->
<!-- RETRIEVE MESSAGE CONTAINER -->
<!-- RETRIEVE MESSAGE CONTAINER -->
<!-- RETRIEVE MESSAGE CONTAINER -->
# Retrieve Message Container

## ***GET*** 

> Sample Request

```shell
curl "https://beta.catenis.io/api/<api_version>/messages/<messageId>/container" \
     -H "X-BCoT-Timestamp: <UTC_date_ISO8601>" \
     -H "Authorization: CTN1-HMAC-SHA256 Credential=<your_virtual_device_id>/<date_YYYYMMDD>/ctn1_request, Signature=<generated_signature>"
```

```javascript
var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'beta'
});

ctnApiClient.retrieveMessageContainer(messageId,
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
        }
});
```

```cpp
ctn::CtnApiClient ctnApiClient(device_id, api_access_secret, "catenis.io", "", "beta");
std::string response_data; // this is where the http response will be stored

ctnApiClient.retrieveMessageContainer(message_id, response_data);
```

> Sample Response

```json-doc
{
 "status": "success",
   "blockchain" : {
     "txid": [String],         // ID of blockchain transaction 
                               //  where message is recorded
                               //  NOTE: due to malleability, 
                               //  the ID of the transaction may 
                               //  change until it is finally 
                               //  confirmed
     "isConfirmed": [Boolean]  // Indicates whether the 
                               //  blockchain transaction ID is
                               //  confirmed
   },
   "externalStorage" : {       // Note: only returned if
                               //  message is stored on IPFS
                               //  external storage
    "ipfs": [String]           // Reference to message on IPFS    
  }
}
```

**Description:** Retrieves information about where a message was previously sent of logged which includes the blockchain transaction ID and the location of where the content was stored.  

### HTTP Request 
`GET /messages/{messageId}/container` 

### Parameters

* **HTTP Path**

| Name | Description | Required | Type |
| ---- | ----------- | -------- | ---- |
| messageId | ID of the Catenis message to be read | Yes | string |

### Responses

| Code | Description | Type |
| ---- | ----------- | ---- |
| 200 | Success: message container returned | JSON |

<!-- LIST MESSAGES -->
<!-- LIST MESSAGES -->
<!-- LIST MESSAGES -->
<!-- LIST MESSAGES -->
<!-- LIST MESSAGES -->
# List Messages
## ***GET*** 

> Sample Request

```shell
curl "https://beta.catenis.io/api/<api_version>/messages?action=send&direction=inbound&fromDeviceIds=dmM2Dz32agLSGsSuoxsR&readState=read&startDate=2017-05-19T03:00:00Z&endDate=2017-06-13T18:20:58Z" \
     -H "X-BCoT-Timestamp: <UTC_date_ISO8601>" \
     -H "Authorization: CTN1-HMAC-SHA256 Credential=<your_virtual_device_id>/<date_YYYYMMDD>/ctn1_request, Signature=<generated_signature>"

```

```javascript
var ctnApiClient = new CtnApiClient(deviceId, apiAccessSecret, {
    environment: 'beta'
});

ctnApiClient.retrieveMessageContainer({
        action: 'send',
        direction: 'inbound',
        readState: 'unread',
        startDate: '20170101T000000Z'
    },
    function (err, data) {
        if (err) {
            // Process error
        }
        else {
            // Process returned data
        }
});
```

```cpp
ctn::CtnApiClient ctnApiClient(device_id, api_access_secret, "catenis.io", "", "beta");
std::string response_data; // this is where the http response will be stored

ctnApiClient.listMessages(response_data);
```

> Sample Response

```json-doc
{
  "status": "success",
  "data": {
    "messages": [{
      "messageId": [String],    // ID of message
      "action": [String],       // Action originally performed on      
                                //  the message; either "log" or 
                                //  "send"
      "direction": [String],    // (only returned for action = 
                                //  "send") - Direction of the
                                //  sent message; either
                                //  "inbound" or "outbound"
      "from": {                 // (only returned for messages  
                                //  sent to the device that
                                //  issued the request (action =
                                //  "send" and direction =
                                //  "inbound")
        "deviceId": [String],   // Catenis device ID of the
                                //  device that had sent the
                                //  message
        "name": [String]        // (only returned if device is 
                                //  public and has this data) - 
                                //  Assigned name of the device
        "prodUniqueId": [String] // (only returned if device is 
                                //  public and has this data) - 
                                //  Product unique ID of the
                                //  device
      },
      "to": {                   // (only returned for messages
                                //  sent from the device that
                                //  issued the request (action
                                //  = "send" and direction = 
                                //  "outbound")
        "deviceId": [String]    // Catenis device ID of device to 
                                //  which the message had been
                                //  sent
        "name": [String]        // (only returned if device is 
                                //  public and has this data) - 
                                //  Assigned name of the device
        "prodUniqueId": [String] // (only returned if device is 
                                //  public and has this data) - 
                                //  Product unique ID of the
                                //  device
      },
      "read": [Boolean],        // Indicates whether the message    
                                //  had already been read
      "date": [String],         // ISO 8601 formatted date and 
                                //  time when the message had
                                //  been: logged, in case of
                                //  messages logged by the device
                                //  that issued the request
                                //  (action = "log"); sent, in
                                //  case of messages sent from
                                //  the current device (action =
                                //  "send" and direction =
                                //  "outbound"); or received, in
                                //  case of messages sent to the
                                //  device that issued the
                                //  request (action = "send" and
                                //  direction = "inbound")
    }],
    "countExceeded": [Boolean]  // Indicates whether the number
                                //  of messages that satisfied
                                //  the query criteria was
                                //  greater than the maximum
                                //  number of messages that can
                                //  be returned (currently, 500),
                                //  and for that reason the
                                //  returned list had been
                                //  truncated
}
```
**Description:** Retrieves a list of message entries filtered by a given criteria. Used by requesting device to find out messages that had previously been logged by itself, or sent to or from it.

### HTTP Request 
`GET /messages` 

### Parameters

* **HTTP Query**

| Name | Description | Required | Type |
| ---- | ----------- | -------- | ---- |
| action | Value specifying the action originally performed on the messages intended to be retrieved | Optional, default: "any" | ["log", "send", "any"] |
| direction | Value specifying the direction of the sent messages intended to be retrieved. Note that this option only applies to sent messages (action = "send"). The value "inbound" indicates messages sent to the device that issued the request; while "outbound" indicates messages sent from the device that issued the request | Optional, default: "any" | ["inbound", "outbound", any"] |
| fromDeviceIds | Comma separated list containing the Catenis device IDs of the devices from which the messages intended to be retrieved had been sent. Note that this option only applies to messages sent to the device that issued the request (action = "send" and direction = "inbound") | Optional | string |
| toDeviceIds | Comma separated list containing the Catenis device IDs of the devices to which the messages intended to be retrieved had been sent. Note that this option only applies to messages sent from the device that issued the request (action = "send" and direction = "outbound") | Optional | string |
| fromDeviceProdUniqueIds | Comma separated list containing the unique product IDs of the devices from which the messages intended to be retrieved had been sent. Note that this option only applies to messages sent to the device that issued the request (action = "send" and direction = "inbound") | Optional | string |
| toDeviceProdUniqueIds | Comma separated list containing the product unique IDs of the devices to which the messages intended to be retrieved had been sent. Note that this option only applies to messages sent from the device that issued the request (action =  "send" and direction =  "outbound") | Optional | string |
| readState | Value specifying the current read state of the the messages intended to be retrieved | Optional, default: "any" | ["read", "unread", "any"] |
| startDate | ISO 8601 formatted date and time specifying the lower boundary of the time frame within which the messages intended to be retrieved had been: logged, in case of messages logged by the device that issued the request (action = "log"); sent, in case of messages sent from the current device (action = "send" and direction = "outbound"); or received, in case of messages sent to the device that issued the request (action = "send" and direction = "inbound") | Optional | string |
| endDate | ISO 8601 formatted date and time specifying the upper boundary of the time frame within which the messages intended to be retrieved has been: logged, in case of messages logged by the device that issued the request (action = "log"); sent, in case of messages sent from the device that issued the request (action = "send" and direction = "outbound"); or received, in case of messages sent to the device that issued the request (action = "send" and direction = "inbound") | Optional | string |

### Responses

| Code | Description | Type |
| ---- | ----------- | ---- |
| 200 | Success: list of messages returned | JSON |
