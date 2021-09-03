# Errors

Catenis Enterprise uses conventional HTTP response status codes to indicate the general outcome of an API request.

## HTTP status codes

The following HTTP status codes are returned by the Catenis Enterprise API.

| Status&nbsp;code | Explanation |
| ---------- | ------- |
| 200 | OK - The request succeeded. |
| 400 | Bad Request - The request could not be processed the way it was, and should be changed before it is resubmitted. |
| 401 | Unauthorized - The request requires user authentication, or authorization has been refused for the supplied credentials. |
| 403 | Forbidden - The request cannot be fulfilled. |
| 500 | Internal Server Error - The server encountered an unexpected condition which prevented it from fulfilling the request. |
| 503 | Service Unavailable - The server is currently unable to handle the request. |

<aside class="warning">
Any returned status code different than <b>200</b> indicates an error when processing an API request.
</aside>

## Error response

> Error response:

```json
{
  "status": "error",
  "message": "Invalid parameters"
}
```

To better describe the condition that led to the error, a JSON with the following properties is returned for all failed API requests.

| Property | Type | Description |
| -------- | ---- | ----------- |
| `status` | String | The value **`error`**, indicating that the request has failed. |
| `message` | String | Error message |

## Error messages

The following is a comprehensive list of the error messages returned by the Catenis Enterprise API.

| Error&nbsp;message | Explanation |
| ----------- | ------- |
| <span id="error_msg_10">Authorization failed; authorization value not well formed</span> | Request could not be authorized because the contents of the Authorization HTTP header is not as expected. |
| <span id="error_msg_20">Authorization failed; invalid device or signature</span> | Request could not be authorized because the device ID and/or the signature included in the credentials (Authorization header contents) are not valid. Note that a deleted or inactive device will trigger this error. |
| <span id="error_msg_30">Authorization failed; missing required HTTP headers</span> | Request could not be authorized because one or more of the required HTTP headers are missing. |
| <span id="error_msg_40">Authorization failed; signature date not well formed</span> | Request could not be authorized because the format of the date included in the credentials (Authorization header contents) is not correct. |
| <span id="error_msg_50">Authorization failed; signature date out of bounds</span> | Request could not be authorized because the date included in the credentials (Authorization header contents) is not within 7 days of the current date. |
| <span id="error_msg_60">Authorization failed; timestamp not well formed</span> | Request could not be authorized because the contents of the X-BCoT-Timestamp HTTP header is not a valid timestamp or it is not in the correct format. |
| <span id="error_msg_70">Authorization failed; timestamp not within acceptable time variation</span> | Request could not be authorized because its timestamp (X-BCoT-Timestamp header contents) is not within +/-5 minutes of the current Catenis Enterprise server time. |
| <span id="error_msg_100">Internal server error</span> | An unexpected situation prevented Catenis Enterprise from correctly processing the request. |
| <span id="error_msg_110">Invalid device</span> | The ID (either the device ID or the product unique ID) for the specified virtual device is not valid or there is no virtual device with that ID. |
| <span id="error_msg_120">Invalid message ID</span> | The supplied message ID is invalid or no message with that ID could be found. |
| <span id="error_msg_130">Invalid parameters</span> | One or more of the parameters are not well formed or required parameter is missing. |
| <span id="error_msg_140">Invalid target device</span> | The ID (either the device ID or the product unique ID) for the virtual device to receive the message is not valid or there is no virtual device with that ID. |
| <span id="error_msg_150">Message too long to be embedded</span> | Request specified that message should be stored embedded in the blockchain transaction but it is too large (over 75 bytes unencrypted or 64 bytes encrypted) to fit in. |
| <span id="error_msg_160">Not enough credits to pay for log message service</span> | The client service account balance is too low to cover the log message service's expense. |
| <span id="error_msg_170">Not enough credits to pay for send message service</span> | The client service account balance is too low to cover the send message service's expense. |
| <span id="error_msg_180">No permission to read message</span> | Virtual device has no permission to read the requested message. |
| <span id="error_msg_190">No permission to retrieve info</span> | Virtual device has no permission to retrieve information about the requested device. |
| <span id="error_msg_200">No permission to retrieve message container</span> | Virtual device attempting to retrieve the message container information is not the device who sent/logged the message. |
| <span id="error_msg_210">Invalid entity ID: <i>[ctnNodeIdx: …][; clientId: …][; deviceId: …][; prodUniqueId: …]</i></span> | One or more of the supplied entity IDs (Catenis Node index, client ID, device ID, or product unique ID) are not valid or there are no entities (Catenis Node, client, or virtual device) with those IDs. |
| <span id="error_msg_220">System currently not available; please try again at a later time</span> | Catenis Enterprise is not currently ready to process requests. |

<aside class="notice">
The terms within <b>square brackets ([ ])</b> in the <b>Invalid entity ID: </b> error message above are only displayed (without the square brackets) if IDs of the corresponding type are invalid, and the <b>eliipsis (...)</b> represent a comma-seprated list of invalid IDs.<br>
Example of a complete error message: <b>Invalid entity ID: clientId: xyz001, xyz002; deviceId: abc001</b>
</aside>
