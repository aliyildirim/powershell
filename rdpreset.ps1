# The target registry key's full path.
$keyPath = 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\RCM\GracePeriod'

# Pass the value name pattern to Remove-ItemProperty's -Name parameter.
# Remove `-WhatIf` if the preview suggests that the operation works as intended.
Remove-ItemProperty -Path $keyPath -Name '*L$RTMTIME*'

shutdown /r  /t 60 /c "Lütfen açık olan ve çalışmakta olduğunuz ofis/netsis gibi uygulamalarınızı veri kaynı yaşamamak için kaydedip çıkış yapınız. 60 sn içerisinde uzak sunucuyu yeniden başlatma devreye girecektir."