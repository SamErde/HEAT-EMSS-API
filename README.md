# HEAT-EMSS-API
Tools to gather data from the HEAT EMSS (Lumension) API about server patching.

# Get-EMSSCustomPatchGroups.ps1
This script is a foundating for connecting to the API via SSL and port 43470. It will pull all custom groups that start with the word "server" due to the fact that it was created in an environment with custom groups for servers and for workstations, each of which have custom groups specific to those node types. After pulling the groups, it uses the group ID to pull the name of every endpoint that is a member of that custom group.
