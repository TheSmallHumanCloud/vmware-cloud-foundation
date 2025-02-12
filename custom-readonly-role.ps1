#Get the privileges of the Readonly role.
$readOnlyPrivileges = Get-VIPrivilege -Role Readonly

#Create a new role with custom privileges.
$role1 = New-VIRole -Privilege $readOnlyPrivileges -Name ReadOnlyPlusStorageView

#Add the StorageView privileges to the new role.
$storagePrivileges = Get-VIPrivilege -Name "View VM storage policies"
$role1 = Set-VIRole –Role $role1 –AddPrivilege $storagePrivileges