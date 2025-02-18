<h1 align="center">Powershell ile authOrig yetkilendirmesi</h1>
<h2 align="center">User'ın Group adına mail gönderme yetkisi</h2>


[![N|PowerShell](https://delta-dev-software.fr/wp-content/uploads/2024/02/831-8318055_february-5-windows-powershell-logo.png)](https://github.com/aliyildirim/powershell)

## Sorun
Bazen authOrig attribute'üne user eklemek isteriz ama aşağıdaki hatayı alabiliriz.

Bunu aşmak için aşağıdaki adımları izleyebilirsiniz.

![alt text](https://github.com/aliyildirim/powershell/blob/main/autOrig/error.png?raw=true)

## Uygulama

Active Directory  sunucusunda powershell administrator olarak çalıştırılır.

```sh
Set-ADGroup -Identity ["X Group"] -Server domain.local -Add @{authOrig=@('CN=[DisplayName],OU=[OU],DC=[DOMAIN,DC=LOCAL]’)}
```

- "X Group" > Yetki atanacak grup adı.
- -Server domain tam adını yazmalısınız.
- CN > user'ın Tam adı. (DisplayName)
- OU > yetki vereceğiniz kullanıcı hangi OU altındaysa yazmalısınız. Birden fazla OU altında OU'da da olabilir. User hangi OU'ların altındaysa tersten yazmalsınız.

Artık yetkilendirdiğiniz kullanıcı X Group adına mail gönderebilecektir.

```diff
- [] işaretlerini kaldırmalsınız. Örnek ifade olarak kullanılmıştır.
```

> [!CAUTION]
> Negative potential consequences of an action.