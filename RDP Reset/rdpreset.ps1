$keyPath = 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\RCM\GracePeriod'
Remove-ItemProperty -Path $keyPath -Name '*L$RTMTIME*'
shutdown /r  /t 60 /c "Lütfen açık olan ve çalışmakta olduğunuz xxxx gibi uygulamalarınızı veri kaybı yaşamamak için kaydedip çıkış yapınız. 60 sn içerisinde uzak sunucuyu yeniden başlatma devreye girecektir."