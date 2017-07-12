# Errors

Catenis Enterprise uses conventional HTTP response codes to indicate the success or failure of an API request. In general, codes in the 2xx range indicate success, codes in the 4xx range indicate an error that failed given the information provided (e.g., a required parameter was omitted, an invalid transaction ID was supplied, etc.), and codes in the 5xx range indicate an error with Blockchain of Things servers. Not all errors map cleanly onto HTTP response codes.

Status code | Meaning
---------- | -------
200 | OK -- Everything worked as expected.
400 | Bad Request -- The request could not be processed the way it was, and should be changed before it is resubmitted
401 | Unauthorized -- No valid API authentication request.
403 | Forbidden Access -- No Authority to access resource
404 | Not Found -- The requested resource doesn't exist.d
500, 502, 503, 504 | Server Errors -- Something went wrong on Catenis Enterprise’s end.

Error types | Meaning
----------- | -------
Invalid parameters | Parameter was improperly formed or required parameter is missing
Device is deleted | Catenis virtual device no longer exists as it has been deleted from the Catenis network
Device is not active | Catenis virtual device is not yet ready to be used
No credit to log message | Catenis logging credits have run out and need to be replenished
Invalid transaction ID | The requested transaction ID doesn't exist
Message too long to be embedded | Request specified that message should be stored embedded with the blockchain transaction (storage = 'embedded') but message is too large (over 75 bytes unencrypted or 64 bytes encrypted) to fit in the transaction
No permission to read | Device has no permission to read message 
Not a valid Catenis transaction | The blockchain transaction that was requested is not a Catenis transaction
No credit to send message | Catenis message credits have run out and and need to be replenished
No permission to retrieve message container | Device attempting to retrieve the container information is not the device who sent the message
Invalid target device | The specified device ID to send the message to is not valid.
Internal server error | Something went wrong on Catenis Enterprise’s end.
