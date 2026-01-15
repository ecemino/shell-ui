# MP3 Çalar Projesi

## 1️⃣ Proje Tanıtımı

Bu proje, Linux ortamında çalışan bir **MP3 çalar** uygulamasıdır.  
Amaç, kullanıcıların **terminal komutları bilmeden** müzik dinleyebilmesini sağlamaktır.  

Projede iki farklı arayüz geliştirilmiştir:

- **GUI (Grafiksel Kullanıcı Arayüzü)**: Masaüstünde butonlarla çalışan arayüz  
- **TUI (Terminal Tabanlı Kullanıcı Arayüzü)**: Terminal menüsü ile çalışan arayüz  

Özellikler:

- Playlist: `/home/beyza/Müzik` klasöründeki tüm MP3 dosyaları  
- Oynatma / Durdurma  
- Önceki / Sonraki şarkı  
- 5 saniye ileri / geri (mpg123 kısıtlaması nedeniyle yaklaşık)  
- Hem GUI hem TUI PARDUS uyumlu  

---

## 2️⃣ GUI (YAD) Kullanımı

1. Terminalde GUI scriptini çalıştırın:

```bash
chmod +x mp3_gui.sh
./mp3_player_gui.sh
```
2. Açılan pencere üzerinde butonları kullanarak:

▶ Oynat

⏹ Durdur

⏭ Sonraki

⏮ Önceki

⏩ +5 sn

⏪ -5 sn

❌ Çıkış

Ekran Görüntüsü Örneği:

## 3️⃣ TUI (whiptail) Kullanımı

1. Terminalde TUI scriptini çalıştırın:

```bash
chmod +x mp3_tui.sh
./mp3_player_tui.sh
```

2. Menü üzerinden seçim yapabilirsiniz:

Oynat

Durdur

Önceki / Sonraki şarkı

+5 / -5 saniye sarma

Çıkış

Ekran Görüntüsü (Örnek – ekleyeceğiniz):

## 4️⃣ Kurulum Talimatları ve Sistem Gereksinimleri

### Sistem Gereksinimleri:
- İşletim Sistemi: PARDUS Linux
- Bash shell (default)
- Paketler:
- sudo apt install mpg123 yad whiptail

### Kurulum ve Çalıştırma:

Paketleri kurun (yukarıdaki komut)

Script dosyalarına çalıştırma izni verin:
```bash
chmod +x mp3_gui.sh mp3_tui.sh
```

Arayüzlerden birini çalıştırın:

GUI:
```bash
./mp3_player_gui.sh
```

TUI:
```bash
./mp3_player_tui.sh
```

## 6️⃣ Tanıtım Videosu
🎬 YouTube tanıtım videosu için [tıklayın](https://youtu.be/zmgPd-T1y8g)
