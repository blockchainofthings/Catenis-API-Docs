# API methods

The following is a comprehensive list of the methods that comprise the Catenis API ver. 0.11.

- Message methods
  - [Log Message](#log-message)
  - [Send Message](#send-message)
  - [Read Message](#read-message)
  - [Retrieve Message Container](#retrieve-message-container)
  - [Retrieve Message Origin *](#retrieve-message-origin)
  - [Retrieve Message Progress](#retrieve-message-progress)
  - [List Messages](#list-messages)
- Asset methods
  - [Issue Asset](#issue-asset)
  - [Reissue Asset](#reissue-asset)
  - [Transfer Asset](#transfer-asset)
  - [Retrieve Asset Info](#retrieve-asset-info)
  - [Get Asset Balance](#get-asset-balance)
  - [List Owned Assets](#list-owned-assets)
  - [List Issued Assets](#list-issued-assets)
  - [Retrieve Asset Issuance History](#retrieve-asset-issuance-history)
  - [List Asset Holders](#list-asset-holders)
- Asset export methods
  - [Export Asset](#export-asset)
  - [Migrate Asset](#migrate-asset)
  - [Asset Export Outcome](#asset-export-outcome)
  - [Asset Migration Outcome](#asset-migration-outcome)
  - [List Exported Assets](#list-exported-assets)
  - [List Asset Migrations](#list-asset-migrations)
- Permission methods
  - [List Permission Events](#list-permission-events)
  - [Retrieve Permission Rights](#retrieve-permission-rights)
  - [Set Permission Rights](#set-permission-rights)
  - [Check Effective Permission Right](#check-effective-permission-right)
- Notification methods
  - [List Notification Events](#list-notification-events)
- Miscellaneous methods
  - [Retrieve Device Identification Info](#retrieve-device-identification-info)

<aside class="notice">
All API method requests return an HTTP response with status code <b>200</b> when successful.
</aside>

<aside class="notice">
To help identify the <b>public</b> API methods, an asterisk (*) is appended to their name.
</aside>

<!-- Methods in separate include modules -->
