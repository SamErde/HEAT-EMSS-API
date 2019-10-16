$APIEndpoint = "https://SERVERNAME:43470" #Base URL for the API, which uses port 43470 by default.
$UriGroups = "$APIEndpoint/api/v1/Groups" #URI to pull groups from EMSS
$UriGroupEndpoints = "$APIEndpoint/api/v1/Groups($GroupId)/Endpoints" #URI to pull a group's endpoints from EMSS
$ServerGroupMembers = @{} #Create a hash table to track each patch group and its members.

#Pull each group that matches our filter. This -like statement is based on an environment that has custom groups for both servers and workstations.
$ServerGroups = (Invoke-RestMethod -Uri $UriGroups).Value | `
    Where-Object {$_.Path -like "*,OU=Servers,OU=Custom Groups,OU=My Groups"} | `
    Select-Object Name,Path,Id,ParentId,Type

#Get the endpoints that are assigned to each group in EMSS. Add the group name as the hash table's key, and the server name as the value.
foreach ($Group in $ServerGroups) {
    $GroupId = $Group.Id
    $Members = (Invoke-RestMethod -Uri $UriGroupEndpoints).Value|Select-Object Name
    $ServerGroupMembers.Add($Group.Name,$Members)
    }

#Show the results. 
$ServerGroupMembers

#Future work: switching to a PSCustomObject instead of a hash table will make this more flexible, allowing other attributes such as endpoint Guid to be pulled at the same time.