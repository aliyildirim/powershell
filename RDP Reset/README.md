<h1 align="center">Powershell ile 120 Gün Licence Resetleme</h1>


[![N|PowerShell](https://delta-dev-software.fr/wp-content/uploads/2024/02/831-8318055_february-5-windows-powershell-logo.png)](https://github.com/aliyildirim/powershell)

## Sorun
![alt text](https://www.virtualizationhowto.com/wp-content/uploads/2020/10/Error-after-120-day-grace-period-has-expired-for-Remote-Desktop-Services.png?raw=true)
<br>
RDP sunucularınızda CAL licence yok ise, 120 sonra licence hakkınız dolacaktır. 
Dolayısıyla sunucunuza uzak bağlantı sağlanamayacaktır.

Bunu aşmak için aşağıdaki adımları izleyebilirsiniz.


## Uygulama

Active Directory sunucusunda powershell'i Administrator olarak çalıştırmalısınız.

```sh
$keyPath = 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\RCM\GracePeriod'
Remove-ItemProperty -Path $keyPath -Name '*L$RTMTIME*'
shutdown /r  /t 60 /c "Lütfen açık olan ve çalışmakta olduğunuz xxxx gibi uygulamalarınızı veri kaybı yaşamamak için kaydedip çıkış yapınız. 60 sn içerisinde uzak sunucuyu yeniden başlatma devreye girecektir."
```
> [!TIP]
> Server'a bir scheduler yazmak ve belirli periyotlarla özellikle gece saatlerinde tetiklettirmek çok daha mantıklı olaraktır.

