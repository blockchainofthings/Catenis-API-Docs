# Authentication

## General

The Catenis Enterprise API methods require authentication on each request. The authentication mechanism used is a SHA-256 Keyed-Hash Message Authentication Code (HMAC-SHA256).
It is based on the <a href="http://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-header-based-auth.html" target="_blank">AWS Signature version 4</a> authentication scheme, although it is not the same, and thus libraries that implement the AWS authentication scheme cannot be used with the Catenis Enterprise API.

With HMAC-SHA256, the server and the client share a secret signing key. The signing key lives in the respective client application and is never transmitted across the line. Instead, the key is used to generate a hash for signing the message contents.

To authenticate and use the services provided by the Catenis Enterprise API methods, one must have an active client account, and use one of their virtual devices to actually consume the service. The virtual device's **device ID** and **API access secret** are then used to generate the authentication token that needs to be sent with every request.

<aside class="warning">
The virtual device's API access secret carries many privileges, so be sure to keep it secret! Do not share it in publicly accessible areas such as GitHub, client-side code, and so forth.
</aside>

## Usage

To properly call a Catenis Enterprise API method, the client application must authenticate the request before sending it, for which the following general steps must be taken:

1. Constructs an HTTP request for the API method that needs to be called;
2. Signs the request using the virtual device's *API access secret*;
3. Adds an *Authorization* header containing, amongst other things, the virtual device's *device ID* and the calculated signature.

<aside class="notice">
The <a href="#detailed-specification">Catenis HMAC-SHA256 authentication specification</a> should be used as a reference when performing the tasks listed above.
</aside>

Alternatively, one of the supplied [Catenis API client libraries](#client-libraries) can be used, which makes issuing and authenticating Catenis Enterprise API requests much simpler.

<aside class="notice">
When accessing the Catenis Enterprise API using one of the Catenis API client libraries, the authentication process is handled by the library itself.
</aside>

## Detailed specification

This section describes how to issue and authenticate an HTTP request that conforms with the Catenis HMAC-SHA256 authentication scheme used by the Catenis Enterprise API.

### HTTP headers

> Not yet authenticated request (used in following examples):

```http
POST /api/0.8/messages/log HTTP/1.1
Host: sandbox.catenis.io
User-Agent: Paw/3.1.5 (Macintosh; OS X/10.13.3) GCDHTTPRequest
X-BCoT-Timestamp: 20180127T121358Z
Content-Type: application/json; charset=utf-8
Connection: close
Content-Length: 95

{"message":"This is only a test","options":{"encoding":"utf8","encrypt":true,"storage":"auto"}}
```

<span href="#essential-headers">The HTTP request that needs to be authenticated must include at least the following HTTP headers, known as the **essential headers**:</span>

| Header | Contents |
| ------ | ----------- |
| `Host` | The host name. Example: *sandbox.catenis.io* |
| `X-BCoT-Timestamp` | The current UTC time in ISO 8601 format. Example: *20170125T000000Z* |

Aside from the essential headers, after the request is authenticated, it will include an HTTP ***Authorization*** header, since the authentication itself consists of adding that header to the request.

The following sections describe the elements that are needed for composing the contents of the *Authorization* header.

<aside class="notice">
<b>Convention</b>: the folowing text conventions are used in the following sections:
<p style="margin-left:2em; margin-bottom:0"><b>"this is it"</b> - any text in double quotes specifies a string literal containing the text within quotes.</p>
<p style="margin-left:2em; margin-bottom:0"><b>"\n"</b> - a backslash immediately followed by a lowercase <i>n</i> letter in a string literal specifies a newline (or linefeed, ASCII 0x0a) character.</p>
<p style="margin-left:2em; margin-bottom:0"><b>"\x0f"</b> - a backslash immediately followed by a lowercase <i>x</i> letter and two hexadecimal digits specifies a single byte the value of which is the two-digit hexadecimal number.</p>
<p style="margin-left:2em; margin-bottom:0"><b>+</b> - a plus sign denotes string concatenation.</p>
<p style="margin-left:2em; margin-bottom:0"><b>&lt;name&gt;</b> - a name surrounded by angle brackets specifies a term the contents of which is defined elsewhere.</p>
<p style="margin-left:2em; margin-bottom:0"><b>HEX(SHA256(<i>data</i>))</b> - the SHA256 hash of the <i>data</i> in hex format (a 64-character string containing only hexadecimal characters).</p>
<p style="margin-left:2em; margin-bottom:0"><b>HMAC-SHA256(<i>data</i>, <i>key</i>)</b> - the computed HMAC, using the SHA256 algorithm, of the <i>data</i> using <i>key</i> as the key.</p>
</aside>

### Conformed request

> String literal:

```c
  "POST\n/api/0.8/message/send\nhost:api.catenis.com\nx-bcot-timestamp:20180127T121358Z\n\n792cdbeef04dc33e8ebb4974070ec5a75bd1e3a6c5ef49b1c3ec1b87152694c6\n"
```

> Printed text:

```text
  POST
  api/0.8/message/send
  host:api.catenis.com
  x-bcot-timestamp:20180127T121358Z

  792cdbeef04dc33e8ebb4974070ec5a75bd1e3a6c5ef49b1c3ec1b87152694c6

```

The conformed request is defined as:

`<http_verb> + "\n" + <api_endpoint_path> + "\n" + <essential_headers> + "\n" + <payload_hash> + "\n"`

Where:

| Term | Description |
| ---- | ----------- |
| `<http_verb>` | The HTTP method of the request. One of: `GET`, `POST`, `PUT`, `HEAD`, or `DELETE`. |
| `<api_endpoint_path>` | The complete path of the URL of the API method endpoint. Example: */api/0.8/message/send* |
| `<essential_headers>` | A list showing the <a href="#essential-headers">essential headers<a> with their respective contents. Each item is defined as: <code style="white-space:normal">&lt;header_name&gt; + ":" + &lt;header_contents&gt; + "\n"</code>; where `<header_name>` is the lowercase name of the header, and `<header_contents>` is the contents of the header. Example: *host:sandbox.catenis.io\nx-bcot-timestamp:20170125T103246Z\n* |
| `<payload_hash>` | Defined as: <code style="white-space:normal">HEX(SHA256(&lt;payload&gt;))</code>; where `<payload>` is the payload (or body) of the HTTP request. If the request has no payload, an empty string should be used in its place. |

<aside class="notice">
When composing the <code>&lt;essential_headers&gt;</code> element above, the headers must appear in the order as they are defined in the <a href="#http-headers">HTTP headers</a> section above.
</aside>

### String to sign

> String literal:

```c
  "CTN1-HMAC-SHA256\n20180127T121358Z\n20180127/ctn1_request\n6c5a53a5aed35fe4dc27146c7d01d548cd810b644b0dcada1d1416fe82cad6f0\n"
```

> Printed text:

```text
  CTN1-HMAC-SHA256
  20180127T121358Z
  20180127/ctn1_request
  6c5a53a5aed35fe4dc27146c7d01d548cd810b644b0dcada1d1416fe82cad6f0

```

The string to sign is defined as:

`"CTN1-HMAC-SHA256" + "\n" + <timestamp> + "\n" + <scope> + "\n" + <conformed_request_hash> + "\n"`

Where:

| Term | Description |
| ---- | ----------- |
| `<timestamp>` | Current UTC time in ISO 8601 format. Example: <i>20180127T121358Z</i> |
| `<scope>` | Defined as: <code style="white-space:normal">&lt;date&gt; + “/ctn1_request”</code>; where `<date>` is a date formatted as YYYYMMDD. Example: <i>20180127/ctn1_request</i> |
| `<conformed_request_hash>` | Defined as: <code style="white-space:normal">HEX(SHA256(&lt;conformed_request&gt;))</code>; where `<conformed_request>` is the <code style="white-space:normal">conformed request</code> element as defined in the <a href="#conformed-request">Conformed request</a> section above. |

<aside class="notice">
The <code>&lt;timestamp&gt;</code> element above must match the contents of the X-BCoT-Timestamp HTTP header of the request.
</aside>

<aside class="notice">
The signature will be valid for seven days from the date of the <code>&lt;date&gt;</code> component of the <code>&lt;scope&gt;</code> element as defined above.
</aside>

### Signing key

> String literal:

```c
  "\xe9\x94\x04\xc8\xbb\xc2\x5d\x02\x56\xff\xa5\x8f\x6e\x72\x17\x9d\xe5\xdc\x7f\x67\xf9\xe5\x8f\x84\x32\xaf\x76\x18\xbb\xb7\x99\xe5"
```

The signing key is defined as:

`HMAC-SHA256(<date_key>, “ctn1_request”)`

| Term | Description |
| ---- | ----------- |
| `<date_key>` | Defined as: <code style="white-space:normal">HMAC-SHA256(“CTN1" + &lt;api_access_secret&gt;, &lt;scope_date&gt;)</code>; where `<api_access_secret>` is the virtual device's API access secret, and `<scope_date>` is the `<date>` component of the `<scope>` element as defined in <a href="#string-to-sign">String to sign</a> section above. |

### Signature

> String literal:

```c
  "70db4ecb53a69dfdc8dcef5934a4d12df93c14f3178fe7797261c4f66144a44b"
```

> Printed text:

```text
  70db4ecb53a69dfdc8dcef5934a4d12df93c14f3178fe7797261c4f66144a44b
```

The signature is defined as:

`HEX(HMAC-SHA256(<signing_key>, <string_to_sign>))`

| Term | Description |
| ---- | ----------- |
| `<signing_key>` | The signing key element as defined in the <a href="#signing-key">Signing key</a> section above |
| `<string_to_sign>` | The string to sign element as defined in the <a href="#string-to-sign">String to sign</a> section above |

### Authorization header

> Authenticated request:

```http
POST /api/0.8/messages/log HTTP/1.1
Host: sandbox.catenis.io
User-Agent: Paw/3.1.5 (Macintosh; OS X/10.13.3) GCDHTTPRequest
X-BCoT-Timestamp: 20180127T121358Z
Authorization: CTN1-HMAC-SHA256 Credential=dnN3Ea43bhMTHtTvpytS/20180127/ctn1_request,Signature=70db4ecb53a69dfdc8dcef5934a4d12df93c14f3178fe7797261c4f66144a44b
Content-Type: application/json; charset=utf-8
Connection: close
Content-Length: 95

{"message":"This is only a test","options":{"encoding":"utf8","encrypt":true,"storage":"auto"}}
```

The contents of the Authorization header is defined as:

`"CTN1-HMAC-SHA256" + <space> + "Credential=" + <device_id> + "/" + <scope> + "," + "Signature=" + <signature>`

Where:

| Term | Description |
| ---- | ----------- |
| `<space>` | A sequence of one or more whitespace characters. |
| `<device_id>` | The virtual device's device ID. Example: <i>dnN3Ea43bhMTHtTvpytS</i> |
| `<scope>` | The `<scope>` element as defined in the <a href="#string-to-sign">String to sign</a> section above. Example: <i>20180127/ctn1_request</i> |
| `<signature>` | The `signature` element as defined in the <a href="#signature">Signature</a> section above. |

## Authentication related errors

| Status&nbsp;code | Error&nbsp;message |
| -------------- | ------------------ |
| 401 | <a href="#error_msg_10">Authorization failed; authorization value not well formed</a><br><a href="#error_msg_20">Authorization failed; invalid device or signature</a><br><a href="#error_msg_30">Authorization failed; missing required HTTP headers</a><br><a href="#error_msg_40">Authorization failed; signature date not well formed</a><br><a href="#error_msg_50">Authorization failed; signature date out of bounds</a><br><a href="#error_msg_60">Authorization failed; timestamp not well formed</a><br><a href="#error_msg_70">Authorization failed; timestamp not within acceptable time variation</a> |
