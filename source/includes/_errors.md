# Errors

Catenis uses conventional HTTP response status codes to indicate the general outcome of an API request.

## HTTP status codes

The following HTTP status codes are returned by the Catenis API.

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

The following is a comprehensive list of the error messages returned by the Catenis API.

| Error&nbsp;message | Explanation |
| ----------- | ------- |
| <span id="error_msg_3">Amount to issue is too large</span> | The specified amount of asset to be issued is larger than the largest allowed amount (2^53 - 1), or the total available amount of the asset, after the issuance, would be larger than the largest allowed amount. |
| <span id="error_msg_4">Amount to migrate is too large</span> | The specified amount of asset to be migrated is larger than the largest allowed amount (2^53 - 1). |
| <span id="error_msg_5">Amount to transfer is too large</span> | The specified amount of asset to be transferred is larger than the largest allowed amount (2^53 - 1). |
| <span id="error_msg_6">Asset already exported</span> | The asset that one wants to export is already exported. |
| <span id="error_msg_7">Asset cannot be reissued</span> | The specified asset does not allow for additional quantities (either an asset amount or non-fungible tokens) of it to be issued after its first issuance. |
| <span id="error_msg_8">Asset is not yet exported</span> | The asset that one wants to migrate an amount of it or to retrieve its outcome is not yet exported. |
| <span id="error_msg_9">Asset migration already successfully processed</span> | The asset migration that one wants to reprocess has already been successfully processed. |
| <span id="error_msg_10">Authorization failed; authorization value not well formed</span> | Request could not be authorized because the contents of the Authorization HTTP header is not as expected. |
| <span id="error_msg_20">Authorization failed; invalid device or signature</span> | Request could not be authorized because the device ID and/or the signature included in the credentials (Authorization header contents) are not valid. Note that a deleted or inactive device will trigger this error. |
| <span id="error_msg_30">Authorization failed; missing required HTTP headers</span> | Request could not be authorized because one or more of the required HTTP headers are missing. |
| <span id="error_msg_40">Authorization failed; signature date not well formed</span> | Request could not be authorized because the format of the date included in the credentials (Authorization header contents) is not correct. |
| <span id="error_msg_50">Authorization failed; signature date out of bounds</span> | Request could not be authorized because the date included in the credentials (Authorization header contents) is not within 7 days of the current date. |
| <span id="error_msg_60">Authorization failed; timestamp not well formed</span> | Request could not be authorized because the contents of the X-BCoT-Timestamp HTTP header is not a valid timestamp or it is not in the correct format. |
| <span id="error_msg_70">Authorization failed; timestamp not within acceptable time variation</span> | Request could not be authorized because its timestamp (X-BCoT-Timestamp header contents) is not within +/-5 minutes of the current Catenis server time. |
| <span id="error_msg_80">Discarded concurrent foreign token smart contract call</span> | The foreign blockchain transaction was discarded because it had a repeated nonce. |
| <span id="error_msg_90">Foreign blockchain funds not enough to cover transaction execution price (<i>&lt;value&gt;</i>)</span> | The foreign blockchain's native coin balance of the virtual device's client foreign blockchain asset export admin account is too low to pay for the foreign blockchain transaction's execution price. |
| <span id="error_msg_91">Foreign token balance too low to in-migrate the asset amount</span> | The virtual device's client foreign blockchain asset export admin account does not currently hold a large enough quantity of the foreign token to fulfill the in-migration. |
| <span id="error_msg_275">Inconsistent number of non-fungible tokens</span> | The number of non-fungible tokens passed for the non-fungible asset issuance does not match the number of non-fungible tokens that had been passed in previous calls. |
| <span id="error_msg_93">Insufficient balance to out-migrate asset</span> | The virtual device does not currently hold a large enough quantity of the asset to fulfill the out-migration. |
| <span id="error_msg_95">Insufficient balance to transfer asset</span> | The virtual device does not currently hold a large enough quantity of the asset to fulfill the transfer. |
| <span id="error_msg_97">Insufficient migrated asset amount to in-migrate asset</span> | The total out-migrated amount of the specified asset is not large enough to fulfill the in-migration. |
| <span id="error_msg_100">Internal server error</span> | An unexpected situation prevented Catenis from correctly processing the request. |
| <span id="error_msg_105">Invalid asset ID</span> | The supplied asset ID is invalid or no asset with that ID could be found. |
| <span id="error_msg_107">Invalid asset migration ID</span> | The supplied asset migration ID is invalid or no asset migration with that ID could be found. |
| <span id="error_msg_110">Invalid device</span> | The supplied ID is not a valid device ID or product unique ID, or there is no virtual device with that ID. |
| <span id="error_msg_210">Invalid entity ID: <i>[ctnNodeIdx: …][; clientId: …][; deviceId: …][; prodUniqueId: …]</i></span> | One or more of the supplied entity IDs (Catenis Node index, client ID, device ID, or product unique ID) are not valid or there are no entities (Catenis Node, client, or virtual device) with those IDs. |
| <span id="error_msg_113">Invalid foreign blockchain destination address</span> | The supplied destination address is not a valid foreign blockchain account address. |
| <span id="error_msg_115">Invalid holding device</span> | The ID (either the device ID or the product unique ID) of the virtual device to hold the issued asset amount or non-fungible tokens is not valid, or there is no virtual device with that ID. |
| <span id="error_msg_120">Invalid message ID</span> | The supplied message ID is invalid or no message with that ID could be found. |
| <span id="error_msg_305">Invalid non-fungible asset issuance ID</span> | The supplied non-fungible asset issuance ID is invalid or no non-fungible asset issuance with that ID could be found. |
| <span id="error_msg_320">Invalid non-fungible token ID</span> | The supplied non-fungible token ID is invalid or no non-fungible token with that ID could be found. |
| <span id="error_msg_355">Invalid non-fungible token retrieval ID</span> | The supplied non-fungible token retrieval ID is invalid, no non-fungible token retrieval with that ID could be found, or it is not for the specified non-fungible token. |
| <span id="error_msg_380">Invalid non-fungible token transfer ID</span> | The supplied non-fungible token transfer ID is invalid, no non-fungible token transfer with that ID could be found, or it is not for the specified non-fungible token. |
| <span id="error_msg_127">Invalid or expired ephemeral message</span> | The supplied ID is not of a valid ephemeral message, or the asynchronous processing status cannot be retrieved for the given ephemeral message. |
| <span id="error_msg_270">Invalid or unexpected asset issuance continuation token</span> | The supplied ID is not a valid asset issuance continuation token, or that is not the ID that Catenis expects to continue processing the non-fungible asset issuance. |
| <span id="error_msg_125">Invalid or unexpected continuation token</span> | The supplied ID is not a valid continuation token, or that is not the ID that Catenis expects to continue processing the message. |
| <span id="error_msg_340">Invalid or unexpected non-fungible token retrieval continuation token</span> | The supplied ID is not a valid non-fungible token retrieval continuation token, or that is not the ID that Catenis expects to continue processing the non-fungible token retrieval. |
| <span id="error_msg_130">Invalid parameters: <i>&lt;param_list&gt;</i></span> | The listed parameters are not well formed or are missing. |
| <span id="error_msg_135">Invalid receiving device</span> | The ID (either the device ID or the product unique ID) of the virtual device to receive the transferred asset amount or non-fungible token is not valid or there is no virtual device with that ID. |
| <span id="error_msg_140">Invalid target device</span> | The ID (either the device ID or the product unique ID) of the virtual device to receive the message is not valid or there is no virtual device with that ID. |
| <span id="error_msg_144">Message already complete</span> | Catenis has already received the full message's contents, and an additional message chunk cannot be accepted. |
| <span id="error_msg_142">Message already read</span> | The message, which has been requested to be read asynchronously or in chunks, has already been fully read. |
| <span id="error_msg_146">Message expired</span> | The maximum time expected for the next message chunk to be passed/retrieved has elapsed, and Catenis cannot fulfill the request. |
| <span id="error_msg_148">Message not available</span> | The message, which has been requested to be read asynchronously, is not yet ready to be read. |
| <span id="error_msg_151">Message origin cannot be disclosed</span> | The message's origin device does not allow the disclosure of information about it. |
| <span id="error_msg_149">Message too large for reading at once</span> | The contents of the message being read is too large for Catenis to returned it in a single call. |
| <span id="error_msg_150">Message too long to be embedded</span> | Request specified that message should be stored embedded in the blockchain transaction but it is too large (over 75 bytes unencrypted or 64 bytes encrypted) to fit in. |
| <span id="error_msg_153">Mismatched asset migration</span> | The specified asset migration does not correspond to the specified asset and/or foreign blockchain. |
| <span id="error_msg_290">Missing non-fungible token contents</span> | The required contents is missing from the non-fungible token data passed for the non-fungible asset issuance. |
| <span id="error_msg_280">Missing non-fungible token data</span> | No non-fungible token data has been passed for the non-fungible asset issuance. |
| <span id="error_msg_285">Missing non-fungible token metadata</span> | The required metadata is missing from the non-fungible token data passed for the non-fungible asset issuance. |
| <span id="error_msg_175">No permission to assign issued asset to holding device</span> | The virtual device has no permission to assign the amount of the asset to be issued to the specified holding device. |
| <span id="error_msg_245">No permission to assign issued non-fungible tokens to holding device</span> | The virtual device has no permission to assign the non-fungible tokens to be issued to the specified holding device(s). |
| <span id="error_msg_176">No permission to export asset</span> | The virtual device attempting to export the asset is not the device that issued that asset. |
| <span id="error_msg_177">No permission to list asset holders</span> | The virtual device has no permission to list holders of the requested asset. |
| <span id="error_msg_178">No permission to migrate asset</span> | The virtual device attempting to migrate the asset amount is not the device that exported that asset. |
| <span id="error_msg_180">No permission to read message</span> | The virtual device has no permission to read the requested message. |
| <span id="error_msg_185">No permission to reissue asset</span> | The virtual device attempting to issue an additional quantity of the asset is not the device that issued the initial asset amount or non-fungible tokens of that asset. |
| <span id="error_msg_186">No permission to retrieve asset export outcome</span> | The virtual device attempting to retrieve information about an asset export outcome is not the device that issued that asset export. |
| <span id="error_msg_187">No permission to retrieve asset info</span> | The virtual device has no permission to retrieve information about the requested asset. |
| <span id="error_msg_188">No permission to retrieve asset issuance history</span> | The virtual device has no permission to retrieve issuance history of the requested asset. |
| <span id="error_msg_189">No permission to retrieve asset migration outcome</span> | The virtual device attempting to retrieve information about an asset migration outcome is not the device that issued that asset migration. |
| <span id="error_msg_190">No permission to retrieve info</span> | The virtual device has no permission to retrieve information about the requested device. |
| <span id="error_msg_200">No permission to retrieve message container</span> | The virtual device attempting to retrieve the message container information is not the device that sent/logged the message. |
| <span id="error_msg_310">No permission to retrieve non-fungible asset issuance progress</span> | The virtual device trying to retrieve the progress of the non-fungible asset issuance is not the device that initiated that issuance. |
| <span id="error_msg_350">No permission to retrieve non-fungible token</span> | The virtual device trying to retrieve the non-fungible token data is neither the issuer nor the current holder of the non-fungible token. |
| <span id="error_msg_360">No permission to retrieve non-fungible token retrieval progress</span> | The virtual device trying to retrieve the progress of the non-fungible token retrieval is not the device that initiated that retrieval. |
| <span id="error_msg_385">No permission to retrieve non-fungible token transfer progress</span> | The virtual device trying to retrieve the progress of the non-fungible token transfer is not the device that initiated that transfer. |
| <span id="error_msg_205">No permission to transfer asset to receiving device</span> | The virtual device has no permission to transfer an amount of the asset to the specified receiving device. |
| <span id="error_msg_365">No permission to transfer non-fungible token to receiving device</span> | The virtual device has no permission to transfer the non-fungible token to the specified receiving device. |
| <span id="error_msg_375">No possession to transfer non-fungible token</span> | The virtual device trying to transfer the non-fungible token does not currently hold it. |
| <span id="error_msg_260">Non-fungible asset issuance cannot be finalized with no tokens</span> | The non-fungible asset issuance that is trying to be finalized does not have any non-fungible tokens defined yet. |
| <span id="error_msg_315">Non-fungible asset issuance data is not yet complete</span> | Not all non-fungible token data have been passed for the non-fungible asset issuance yet (no final call yet). |
| <span id="error_msg_265">Non-fungible asset issuance is already complete</span> | The non-fungible asset issuance for which new non-fungible token data is being passed has already been finalized (final call already happened). |
| <span id="error_msg_295">Non-fungible token contents is already finalized</span> | Passing another chunk of contents data for a non-fungible token whose contents was assumed to be already complete since no contents for that non-fungible token was included in the previous call of the non-fungible asset issuance. |
| <span id="error_msg_330">Non-fungible token data retrieval not yet done</span> | The non-fungible token data is not yet ready to be delivered to the end user; the data retrieval has not finished yet. |
| <span id="error_msg_300">Not a non-fungible asset</span> | The received ID is for a regular (fungible) asset when it should be for a non-fungible asset. |
| <span id="error_msg_240">Not a regular (fungible) asset</span> | The received ID is for a non-fungible asset when it should be for a regular (fungible) asset. |
| <span id="error_msg_155">Not enough credits to pay for issue asset service</span> | The virtual device's client service account balance is too low to cover the issue asset service's expense. |
| <span id="error_msg_250">Not enough credits to pay for issue non-fungible asset service</span> | The virtual device's client service account balance is too low to cover the issue non-fungible asset service's expense. |
| <span id="error_msg_160">Not enough credits to pay for log message service</span> | The virtual device's client service account balance is too low to cover the log message service's expense. |
| <span id="error_msg_165">Not enough credits to pay for migrate asset service</span> | The virtual device's client service account balance is too low to cover the migrate asset service's expense. |
| <span id="error_msg_170">Not enough credits to pay for send message service</span> | The virtual device's client service account balance is too low to cover the send message service's expense. |
| <span id="error_msg_172">Not enough credits to pay for transfer asset service</span> | The virtual device's client service account balance is too low to cover the transfer asset service's expense. |
| <span id="error_msg_370">Not enough credits to pay for transfer non-fungible token service</span> | The virtual device's client service account balance is too low to cover the transfer non-fungible token service's expense. |
| <span id="error_msg_255">Number of non-fungible tokens to issue is too large</span> | The specified number of non-fungible tokens to be issued is larger than the largest allowed amount (2^53 - 1), or the total available non-fungible tokens of the non-fungible asset, after the issuance, would be larger than the largest allowed amount. |
| <span id="error_msg_207">Progress not available</span> | Asynchronous processing status not yet available for the given ephemeral message. |
| <span id="error_msg_215">Request data too large to be processed</span> | Catenis refuses to process the request because the data sent with the request (typically a message's contents) is too large. |
| <span id="error_msg_335">Retrieved non-fungible token data already delivered</span> | The non-fungible token data that have been retrieved have already been delivered to the end user. |
| <span id="error_msg_345">Retrieved non-fungible token data expired</span> | The maximum time expected for the retrieved non-fungible token data to be received by the end user has elapsed, and Catenis cannot fulfill the request. |
| <span id="error_msg_220">System currently not available; please try again at a later time</span> | Catenis is not currently ready to process requests. |
| <span id="error_msg_325">Unavailable or inconsistent non-fungible token</span> | The underlying Colored Coins non-fungible token is malformed or could not be found. |
| <span id="error_msg_230">Unexpected error calling foreign token smart contract</span> | An unexpected error prevented the foreign blockchain transaction to be executed. |

<aside class="notice">
The <b>&lt;value&gt;</b> term in the <b>Foreign blockchain funds not enough to cover transaction execution price</b> error
 message above states the price charged for the execution of the foreign blockchain transaction.
</aside>

<aside class="notice">
The <b>&lt;param_list&gt;</b> term in the <b>Invalid parameters: </b> error message above represents a comma-separated list of parameter names.
</aside>

<aside class="notice">
The terms within <b>square brackets ([ ])</b> in the <b>Invalid entity ID: </b> error message above are only displayed (without the square brackets) if IDs of the corresponding type are invalid, and the <b>ellipsis (...)</b> represent a comma-separated list of invalid IDs.<br>
Example of a complete error message: <b>Invalid entity ID: clientId: xyz001, xyz002; deviceId: abc001</b>
</aside>
