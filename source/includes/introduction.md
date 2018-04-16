# Introduction

The Catenis Enterprise API is organized around REST. The API has predictable, resource-oriented URLs, and uses HTTP
response status codes to indicate the outcome of an API method request.

It uses built-in HTTP features, like HTTP
verbs and headers, which are understood by off-the-shelf HTTP clients. It supports cross-origin resource sharing,
allowing you to securely interact with the Catenis Enterprise API from a client-side web application —
though you should never expose your API access secret in any public website's client-side code.

A JSON is returned in response to any API method request, even when an error takes place.
