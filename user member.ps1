$users = Get-ADUser -Filter * -Properties physicalDeliveryOfficeName, MemberOf, DistinguishedName
$groups = Get-ADGroup -Filter *

$logFolderPath = "C:\User Group Logs"

foreach ($user in $users) {
    $userOffice = $user.physicalDeliveryOfficeName
    $memberOfGroups = $user.MemberOf | ForEach-Object { ($_ -split ',')[0] -replace '^CN=' }
    
    $userGroupsString = $groups | Where-Object { $userOffice -eq $_.Name } | ForEach-Object { $_.Name }
    $userDN = $user.DistinguishedName
    $ouParts = ($userDN -split ',OU=')[1..$($userDN -split ',OU=').Length] | ForEach-Object { ($_ -replace '^OU=', '') }
    $ouPath = $ouParts -join ' / '
    
    if ($userGroupsString.Count -gt 0) {
        $isMember = $false
        foreach ($group in $userGroupsString) {
            if ($user.MemberOf -contains (Get-ADGroup $group).DistinguishedName) {
                $isMember = $true
                break
            }
        }
        
        if (-not $isMember) {
            $result = Add-ADGroupMember -Identity $userGroupsString -Members $user.SamAccountName -ErrorAction SilentlyContinue
            if ($result -eq $null) {
                $duyuruAdded = $false
                if ($memberOfGroups -notcontains "Duyuru") {
                    Add-ADGroupMember -Identity "Duyuru" -Members $user.SamAccountName -ErrorAction SilentlyContinue
                    Add-ADGroupMember -Identity "Genel Duyuru" -Members $user.SamAccountName -ErrorAction SilentlyContinue
                    Start-ADSyncSyncCycle -PolicyType Delta
                    $duyuruAdded = $true
                    
                }
                
                $logMessage = "--------------------------------------------------------------------------------------------------------" + "`n"
                $logMessage += "Tarih / Saat : $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" + "`n"
                $logMessage += "Hedef Kullanıcı : $($user.SamAccountName)" + "`n"
                $logMessage += "Hedef Kullanıcı OU : $ouPath" + "`n"
                $logMessage += "Üye Olduğu Gruplar : $($memberOfGroups -join ', ')" + "`n"
                $logMessage += "Üye Edildiği Grup : $($userGroupsString -join ', '), " + $(if ($duyuruAdded) { "Duyuru" } else { "" }) + "`n"
                $logMessage += "--------------------------------------------------------------------------------------------------------" + "`n"
                
                $logFileName = "$($user.SamAccountName) - $(Get-Date -Format 'dd-MM-yyyy HH-mm').txt"
                $logFilePath = Join-Path -Path $logFolderPath -ChildPath $logFileName
                $logMessage | Out-File -FilePath $logFilePath -Encoding UTF8
            } else {
                $logMessage = "Hata: $($result.Exception.Message)" + "`n"
            }
         }
    }
}
