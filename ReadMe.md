# CrowdStrike Falcon Bulk User Upload Script

## Author

leandro.iacono@crowdstrike.com

## Disclaimer

This sample scripts is not supported under any CrowdStrike standard support program or service. 

This sample script is provided AS IS without warranty of any kind. 

CrowdStrike further disclaims all implied warranties including, without limitation, any implied warranties of merchantability
or of fitness for a particular purpose. The entire risk arising out of the use or performance of the sample scripts and 
documentation remains with you. In no event shall CrowdStrike, its authors, or anyone else involved in the creation, production, 
or delivery of the script/s be liable for any damages whatsoever (including, without limitation, damages for loss of business profits, 
business interruption, loss of business information, or other pecuniary loss) arising out of the use of or inability to use the 
sample scripts or documentation, even if CrowdStrike has been advised of the possibility of such damages.

## Getting Started

This ReadMe file describes the usage of the CS Falcon User Script. 

### Prerequisites

(This Script is written for use with PowerShell.)
(No other Scripting Libraries or Packages are required for use.)

* Edit emails.txt:

1. Include full list of email addresses you'd like to add to CS Falcon.
2. Emails should be one per line.

```
example1@crowdstrike.com
example2@crowdstrike.com

```


* Edit config.json:

1. Client ID (OAuth Client ID from CS Falcon API Key Page) 
2. Client Secret (OAuth Client Secret from CS Falcon API Key Page)
3. URL is the Falcon Cloud API URL you want to connect to. 
4.

Both Client ID and Client Secret must be from the instance you'd like to Bulk Upload Users to.
Different Falcon Instances (CID) will have different Client ID and Client Secret.
Different CrowdStrike Falcon clouds use different API URLS. For example, US1 Instances should use "https://api.crowdstrike.com"
For more information on these settings, visit: https://falcon.crowdstrike.com/support/documentation/46/crowdstrike-oauth2-based-apis

* Specify what Roles you'd like the Users to be assigned as part of the Upload.

Users can be added to Falcon with one or more Roles.
Ensure you follow the specified Format. An example exists in config.json: 
Backslashes remain to escape  double quotes and commas are used if more than one role is specified:

```
"Roles": [
            "
            \"falconhost_admin\",
            \"falconhost_analyst\"
            "
           ],
```

In the above example, users added to the CS Falcon platform via the script will be assigned the Falcon Administrator and Falcon Analyst Role.
If assigning more than one role, ensure they are comma-seperated and on a new line.

Full List of supported Roles as of the creation of this Script:

```
  "Roles": 
                [
                "
                \"device_control_manager\",
                \"endpoint_manager\",
                \"event_viewer\",
                \"falconhost_admin\",
                \"falconhost_analyst\",
                \"falconhost_investigator\",
                \"falconhost_read_only\",
                \"intel_admin\",
                \"intel_all_analyst\",
                \"intel_basic_analyst\",
                \"intel_ecrime_analyst\",
                \"intel_malware_submitter\",
                \"intel_targeted_analyst\",
                \"prevention_hashes_manager\",
                \"quarantine_manager\",
                \"remote_responder\",
                \"remote_responder_one\",
                \"remote_responder_three\",
                \"samplestore_sample_submitter\",
                \"security_lead\",
                \"vulnerability_manager\"
                "
                ]
```

## Questions

* Contact your CrowdStrike Representative.
