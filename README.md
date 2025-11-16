# Gelişmiş Windows Sistem Raporu

Bilgisayarınızın anlık durumu hakkında hızlı ve detaylı bir "gösterge paneli" sunan gelişmiş bir PowerShell script'i.

## 🚀 Raporun İçeriği

Bu script, tek bir komutla size aşağıdaki kritik bilgileri sunar:
* **Temel Bilgiler:** Bilgisayar adı ve o anki kullanıcı adı.
* **Ağ Bilgisi:** Aktif yerel IP adresi.
* **Sistem Çalışma Süresi:** Bilgisayarın en son ne zaman yeniden başlatıldığı ve ne kadar süredir açık olduğu.
* **CPU Sıcaklığı:** O anki işlemci sıcaklığını gösterir. (*Donanıma bağlıdır.*)
* **Bellek (RAM) Kullanımı:** Toplam, kullanılan ve boşta olan RAM miktarını gösterir.
* **En Çok RAM Kullanan 3 İşlem:** O anda en fazla bellek tüketen 3 programı listeler.
* **Disk (C:) Kullanımı:** Ana diskinizin doluluk oranını, boş alanını ve görsel bir ilerleme çubuğunu gösterir.

## 📂 Proje Dosyaları

1.  **`Rapor.ps1`**:
    * Tüm raporlama mantığını ve komutları içeren ana PowerShell script'idir.
    * WMI ve CIM sorgularını kullanarak sistem bilgilerini toplar ve biçimlendirir.

2.  **`RaporCalistir.bat`**:
    * PowerShell script'ini çalıştırmak için kullanılan basit bir "başlatıcı" dosyasıdır.
    * Gerekli `ExecutionPolicy` ayarını (`-ExecutionPolicy Bypass`) sadece o anlık atlayarak script'in çalışmasını sağlar.
    * Raporun ekranda kalması için `pause` komutunu içerir.

## 🛠️ Nasıl Kullanılır?

1.  `Rapor.ps1` ve `RaporCalistir.bat` dosyalarının **ikisinin de aynı klasörde** olduğundan emin olun.
2.  `RaporCalistir.bat` dosyasına **çift tıklayın**.
3.  Rapor anında komut istemi penceresinde görünecektir.
4.  Raporu inceledikten sonra "Devam etmek için bir tuşa basın..." mesajını gördüğünüzde herhangi bir tuşa basarak pencereyi kapatabilirsiniz.

> **⚠️ ÖNEMLİ NOT:**
> **CPU Sıcaklığı** özelliği her sistemde çalışmayabilir. Script, `root\WMI` üzerinden standart sensörleri okumayı dener. Eğer sisteminiz bu bilgiyi sağlamıyorsa veya farklı bir sensör kullanıyorsa, "Sıcaklık sensörleri okunamadı" mesajını görebilirsiniz. Bu bir hata değil, donanımsal bir kısıtlamadır.