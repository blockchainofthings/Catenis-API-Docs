--- 

title: Catenis Enterprise RESTful API Specification

language_tabs:
  - shell: cURL
  - javascript: JavaScript
  - cpp: C++

toc_footers: 
- <a href='#'>Sign Up for a Developer Key</a> 
- <a href='https://github.com/lavkumarv'>Documentation Powered by lav</a> 

includes: 
- errors 

search: true 
--- 

# Introduction 

The Catenis Enterprise API is organized around REST. Our API has predictable, resource-oriented URLs, and uses HTTP response codes to indicate API errors. We use built-in HTTP features, like HTTP authentication and HTTP verbs, which are understood by off-the-shelf HTTP clients. We support cross-origin resource sharing, allowing you to interact securely with our API from a client-side web application (though you should never expose your API access secret in any public website's client-side code). JSON is returned by all API responses, including errors. 

**API Version:** 0.3 

**Base API Endpoint:** https://beta.catenis.io/api/0.3/

**Available Libraries:** JavaScript, C++

# Authentication

TODO

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

| Name | Description | Required | Type |
| ---- | ----------- | -------- | ---- |
| message |  The message to record | Yes | string |
| encoding | Value identifying the encoding of the message | No, default: "utf8" | ["utf8", "base64", "hex"] |
| encrypt | Indicates whether message should be encrypted before storing it | No, default: true | boolean |
| storage | Value identifying where the message should be stored | No, default: "auto" | [“auto", "embedded", "external"] |

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

| Name | Description | Required | Type |
| ---- | ----------- | -------- | ---- |
| targetDevice.id |  ID of target device. Should be a Catenis virtual device ID unless isProdUniqueId is true | Yes | string |
| targetDevice.isProdUniqueId | Indicates whether supplied ID is a product unique ID (otherwise, it should be a Catenis virtual device ID) | No, default: false | boolean |
| message |  The message to record | Yes | string |
| encoding | Value identifying the encoding of the message | No, default: "utf8" | ["utf8", "base64", "hex"] |
| encrypt | Indicates whether message should be encrypted before storing it | No, default: true | boolean |
| storage | Value identifying where the message should be stored | No, default: "auto" | [“auto", "embedded", "external"] |

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

**Parameters**

| Name | Located in | Description | Required | Type |
| ---- | ---------- | ----------- | -------- | ---- |
| messageId | path | ID of the Catenis message to be read | Yes | string |
| encoding | query | Value identifying the encoding | No, default: "utf8" | ["utf8", "base64", "hex"] |

**Responses**

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

**Parameters**

| Name | Located in | Description | Required | Type |
| ---- | ---------- | ----------- | -------- | ---- |
| messageId | path | ID of the Catenis message to be read | Yes | string |

**Responses**

| Code | Description | Type |
| ---- | ----------- | ---- |
| 200 | Success: message container returned | JSON |

# List Messages
## ***GET*** 

**Summary:** List Messages

**Description:** Optional extended description in Markdown.

### HTTP Request 
`***GET*** /messages` 

**Responses**

| Code | Description |
| ---- | ----------- |
| 200 | OK |

<!-- Converted with the swagger-to-slate https://github.com/lavkumarv/swagger-to-slate -->
