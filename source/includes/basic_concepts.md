# Basic concepts

## Catenis entities

### Virtual device

The virtual device — or some times simply referred to as *device* — is the fundamental entity that is used
to interact with the Catenis system.

Each virtual device has a unique `device ID`, which is assigned by the system when a new virtual
device is created.

Optionally, a virtual device can also be identified by an end user provided `product unique ID`.

Each virtual device also has a system assigned `API access secret`, which is used for authenticating the virtual device
when making an API request.

An optional `name` can also be assigned to a virtual device. That name, however, only serves as a label and
cannot be used to select or otherwise reference a specific virtual device.

<aside class="notice">
The <code>name</code> and <code>product unique ID</code> are collectively referred to as the virtual device's main properties.
</aside>

### Client

The client is the entity that maps to an end user. A client can have one or more virtual devices.

Like virtual devices, each client has a unique `client ID`, which is assigned by the system when a new client is
created.

Each client is associated with a system provided user account. The client user account is used by the end user to
access the system and do administrative tasks, like creating new virtual devices, and adding service credits.

### Catenis node

The Catenis node is the entity used to aggregate the Catenis services for a specific region or user premises.

Catenis nodes are identified by their index. Currently, only one public, central Catenis node — referred to as the
*Catenis Hub node* — is available. The Catenis Hub node has index 0.

Clients are defined within a given Catenis node. So, a Catenis node will typically have one or more clients.

## Permission rights

Catenis provides a permission mechanism where a virtual device — the *controlling device* — can allow or
deny other virtual devices — the *controlled devices* — to interact with it in a given predefined way. Such
predefined controlled interactions are referred to as *permission events*.

### Permission events

The following permission events are currently defined:

| Event name | Description |
| ---------- | ----------- |
| `receive-notify-new-msg` | Receive notification of new message from a device |
| `receive-notify-msg-read` | Receive notification of message read by a device |
| `receive-notify-asset-of` | Receive notification of asset received for assets issued by a device |
| `receive-notify-asset-from` | Receive notification of asset received from a device |
| `receive-notify-confirm-asset-of` | Receive notification of confirmation of pending asset issued by a device |
| `receive-notify-confirm-asset-from` | Receive notification of confirmation of pending asset transferred by a device |
| `send-read-msg-confirm` | Send read message confirmation to a device |
| `receive-msg` | Receive message from a device |
| `disclose-main-props` | Disclose device's main properties (name, product unique ID) to a device |
| `disclose-identity-info` | Disclose device's basic identification information to a device |
| `receive-asset-of` | Receive an amount of an asset issued by a device |
| `receive-asset-from` | Receive an amount of an asset from a device |
| `receive-nf-token-of` | Receive a non-fungible token issued by a device |
| `receive-nf-token-from` | Receive a non-fungible token from a device |
| `disclose-nf-token-ownership` | Disclose device's non-fungible token ownership status to a device |

<aside class="notice">
The list of all system defined permission events can be programmatically retrieved by means of the <a href="#list-permission-events">List Permission Events</a> API method.
</aside>

A permission event is described as an action where the controlling device is the subject and the controlled device is
the object of such action.

Thus, taking the `receive-msg` permission event as an example, if a device is given allow right in regards to that
permission event, it means that the controlling device will be able to receive messages sent from that device. Otherwise
— if a device is given deny right instead —, the controlling device shall not receive any messages sent from
that device.

### Permission levels

For a given pair of permission event and controlling device, the permission rights can be set at four different levels:

* *System* - it is the default permission right.

* *Catenis node* - it controls the permission right for all devices that belong to any client defined for that Catenis
node.

* *Client* - it controls the permission right for all devices that belong to this client.

* *Device* - it controls the permission right for this specific device.

### Permission right evaluation

For a given pair of permission event and controlling device, the effective permission right for a given (controlled)
device is evaluated according to the following procedure:

1. Starting at the device level, we check if the permission right for that (controlled) device is set. If it is set,
this is the permission right that is in effect.

2. Otherwise, we go to the level above, and check if the permission right for the client to which the (controlled) device
belongs is set. If it is set, this is the permission right that is in effect.

3. Otherwise, we go to the level above, and check if the permission right for the Catenis node where the client to which
the (controlled) device belongs is defined is set. If it is set, this is the permission right that is in effect.

4. Otherwise, whatever permission right that is set at the system level is what is in effect.
