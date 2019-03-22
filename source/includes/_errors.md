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
| 413 | Payload Too Large - The data sent with the request is too large and cannot be processed. |
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
| <span id="error_msg_3">Amount to issue is too large</span> | The specified amount of asset to be issued is larger than the largest allowed amount (2^53 - 1), or the total available amount of the asset, after the issuance, would be larger than the largest allowed amount. |
| <span id="error_msg_5">Amount to transfer is too large</span> | The specified amount of asset to be transferred is larger than the largest allowed amount (2^53 - 1). |
| <span id="error_msg_7">Asset cannot be reissued</span> | The specified asset does not allow for more units of it to be issued after its first issuance. |
| <span id="error_msg_10">Authorization failed; authorization value not well formed</span> | Request could not be authorized because the contents of the Authorization HTTP header is not as expected. |
| <span id="error_msg_20">Authorization failed; invalid device or signature</span> | Request could not be authorized because the device ID and/or the signature included in the credentials (Authorization header contents) are not valid. |
| <span id="error_msg_30">Authorization failed; missing required HTTP headers</span> | Request could not be authorized because one or more of the required HTTP headers are missing. |
| <span id="error_msg_40">Authorization failed; signature date not well formed</span> | Request could not be authorized because the format of the date included in the credentials (Authorization header contents) is not correct. |
| <span id="error_msg_50">Authorization failed; signature date out of bounds</span> | Request could not be authorized because the date included in the credentials (Authorization header contents) is not within 7 days of the current date. |
| <span id="error_msg_60">Authorization failed; timestamp not well formed</span> | Request could not be authorized because the contents of the X-BCoT-Timestamp HTTP header is not a valid timestamp or it is not in the correct format. |
| <span id="error_msg_70">Authorization failed; timestamp not within acceptable time variation</span> | Request could not be authorized because its timestamp (X-BCoT-Timestamp header contents) is not within +/-5 minutes of the current Catenis Enterprise server time. |
| <span id="error_msg_80">Device is deleted</span> | Virtual device no longer exists as it has been deleted. |
| <span id="error_msg_90">Device is not active</span> | Virtual device is not yet ready to be used. |
| <span id="error_msg_95">Insufficient balance to transfer asset</span> | Virtual device does not currently hold enough units of the asset to fulfill the transfer. |
| <span id="error_msg_100">Internal server error</span> | An unexpected situation prevented Catenis Enterprise from correctly processing the request. |
| <span id="error_msg_105">Invalid asset ID</span> | The supplied asset ID is invalid or no asset with that ID could be found. |
| <span id="error_msg_110">Invalid device</span> | The ID (either the device ID or the product unique ID) for the virtual device to hold the issued assets is not valid or there is no virtual device with that ID. |
| <span id="error_msg_115">Invalid holding device</span> | The ID (either the device ID or the product unique ID) for the virtual device to hold the issued asset amount is not valid or there is no virtual device with that ID. |
| <span id="error_msg_120">Invalid message ID</span> | The supplied message ID is invalid or no message with that ID could be found. |
| <span id="error_msg_125">Invalid or unexpected continuation token</span> | The supplied ID is not a valid continuation token, or that is not the ID that Catenis Enterprise expects to continue processing the message. |
| <span id="error_msg_127">Invalid or expired ephemeral message</span> | The supplied ID is not a valid ephemeral message, or the asynchronous processing status cannot be retrieved for the given ephemeral message. |
| <span id="error_msg_130">Invalid parameters</span> | One or more of the parameters are not well formed or required parameter is missing. |
| <span id="error_msg_135">Invalid receiving device</span> | The ID (either the device ID or the product unique ID) for the virtual device to receive the transferred assets is not valid or there is no virtual device with that ID. |
| <span id="error_msg_140">Invalid target device</span> | The ID (either the device ID or the product unique ID) for the virtual device to receive the message is not valid or there is no virtual device with that ID. |
| <span id="error_msg_142">Message already read</span> | The message, which has been requested to be read asynchronously or in chunks, has already been fully read. |
| <span id="error_msg_144">Message already complete</span> | Catenis Enterprise has already received the full message's contents, and an additional message chunk cannot be accepted. |
| <span id="error_msg_146">Message expired</span> | The maximum time expected for the next message chunk to be passed/retrieved has elapsed and Catenis Enterprise cannot fulfill the request. |
| <span id="error_msg_148">Message not available</span> | The message, which has been requested to be read asynchronously, is not yet ready to be read. |
| <span id="error_msg_149">Message too large for reading at once</span> | The contents of the message being read is too large for Catenis Enterprise to returned it in a single call. |
| <span id="error_msg_150">Message too long to be embedded</span> | Request specified that message should be stored embedded in the blockchain transaction but it is too large (over 75 bytes unencrypted or 64 bytes encrypted) to fit in. |
| <span id="error_msg_155">Not enough credits to pay for issue asset service</span> | The client service account balance is too low to cover the issue asset service's expense. |
| <span id="error_msg_160">Not enough credits to pay for log message service</span> | The client service account balance is too low to cover the log message service's expense. |
| <span id="error_msg_170">Not enough credits to pay for send message service</span> | The client service account balance is too low to cover the send message service's expense. |
| <span id="error_msg_172">Not enough credits to pay for transfer asset service</span> | The client service account balance is too low to cover the transfer asset service's expense. |
| <span id="error_msg_175">No permission to assign issued asset to holding device</span> | Virtual device has no permission to assign the amount of the asset to be issued to the specified holding device. |
| <span id="error_msg_177">No permission to list asset holders</span> | Virtual device has no permission to list holders of the requested asset. |
| <span id="error_msg_180">No permission to read message</span> | Virtual device has no permission to read the requested message. |
| <span id="error_msg_185">No permission to reissue asset</span> | Virtual device attempting to issue more units of the asset is not the device that issued the initial amount of that asset. |
| <span id="error_msg_187">No permission to retrieve asset info</span> | Virtual device has no permission to retrieve information about the requested asset. |
| <span id="error_msg_188">No permission to retrieve asset issuance history</span> | Virtual device has no permission to retrieve issuance history of the requested asset. |
| <span id="error_msg_190">No permission to retrieve info</span> | Virtual device has no permission to retrieve information about the requested device. |
| <span id="error_msg_200">No permission to retrieve message container</span> | Virtual device attempting to retrieve the message container information is not the device that sent/logged the message. |
| <span id="error_msg_205">No permission to transfer asset to receiving device</span> | Virtual device has no permission to transfer an amount of the asset to the specified receiving device. |
| <span id="error_msg_207">Progress not available</span> | Asynchronous processing status not yet available for the given ephemeral message. |
| <span id="error_msg_210">Invalid entity ID: <i>[ctnNodeIdx: …][; clientId: …][; deviceId: …][; prodUniqueId: …]</i></span> | One or more of the supplied entity IDs (Catenis Node index, client ID, device ID, or product unique ID) are not valid or there are no entities (Catenis Node, client, or virtual device) with those IDs. |
| <span id="error_msg_215">Request data too large to be processed</span> | Catenis Enterprise refuses to process the request because the data sent with the request (typically a message's contents) is too large. |
| <span id="error_msg_220">System currently not available; please try again at a later time</span> | Catenis Enterprise is not currently ready to process requests. |

<aside class="notice">
The terms within <b>square brackets ([ ])</b> in the <b>Invalid entity ID: </b> error message above are only displayed (without the square brackets) if IDs of the corresponding type are invalid, and the <b>eliipsis (...)</b> represent a comma-seprated list of invalid IDs.<br>
Example of a complete error message: <b>Invalid entity ID: clientId: xyz001, xyz002; deviceId: abc001</b>
</aside>
