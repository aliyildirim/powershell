# Mail Grubu
## _Kullanıcı Yetkilendirme_

[![N|PowerShell](https://delta-dev-software.fr/wp-content/uploads/2024/02/831-8318055_february-5-windows-powershell-logo.png)](https://github.com/aliyildirim/powershell)

## Sorun
Bazen authOrig attribute'üne user eklemek isteriz ama aşağıdaki hatayı alabiliriz.
Bunu aşmak için aşağıdaki adımları izleyebilirsiniz.
![alt text](https://github.com/aliyildirim/powershell/blob/main/autOrig/error.png?raw=true)

## Uygulama

Active Directory  sunucusunda powershell administrator olarak çalıştırılır.

```sh
Set-ADGroup -Identity "X Group" -Server domain.local -Add @{authOrig=@('CN=DisplayName,OU=OU,DC=DOMAIN,DC=LOCAL’)}
```

- "X Group" > Yetki atanacak grup adı.
- -Server domain tam adını yazmalısınız.
- CN > user'ın Tam adını yazmalısınız. (DisplayName)
- OU > yetki vereceğiniz kullanıcı hangi OU altındaysa yazmalısınız. OU altında OU'da olabilir. O zaman 2.OU, 1.OU olarak tersten yazmalsınız.

Artık yetkilendirdiğiniz kullanıcı X Group adına mail gönderebilecektir.


