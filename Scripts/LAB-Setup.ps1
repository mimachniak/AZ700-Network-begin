#Connect-AzureAD
$domain = "sys4ops.pl"
$suffix_arraya = @(
    '01'
    '02'
    '03'
    '04'
    '05'
    '06'
    '07'
    '08'
    '09'
    '10'
    '11'
    '12'
    '13'
    '14'
    '15'
    '16'
    '17'
)



foreach ($suffix in $suffix_arraya)
{

    $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
    $PasswordProfile.Password = "P@ssw0rd"+$suffix

    $upn = "labuser"+$suffix+"@"+$domain
    $mailnick = "lab.user"+$suffix
    $DisplayName = "LAB User-"+$suffix
    $rgName = "LAB-"+$suffix


    Start-Sleep -second 10


    New-AzureADUser -DisplayName $DisplayName -PasswordProfile $PasswordProfile -UserPrincipalName $upn -AccountEnabled $true -MailNickName $mailnick

    Start-Sleep -second 15

    write-host "User created: " $upn

    $user = Get-AzureADUser -ObjectId $upn     

    New-AzResourceGroup -Name $rgName -Location 'North Europe'

    write-host "Resource Group created: " $rgName
    Start-Sleep -second 15

    New-AzRoleAssignment -ObjectId $user.ObjectId -RoleDefinitionName "Owner" -ResourceGroupName "$rgName"

    write-host "Role assigned: " $rgName

}