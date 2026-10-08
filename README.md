# Mehmet Ceylan akademik web sitesi

Bu klasör, onaylanan Round 4.1 “Margin” tasarımının Quarto kaynak projesidir. Site GitHub Pages üzerinden `mehmetceylan.org` alan adında yayımlanmak üzere yapılandırılmıştır.

## Yerel önizleme

Bilgisayarda Quarto kuruluysa proje klasöründe şu komut çalıştırılır:

```powershell
quarto preview
```

Yalnızca statik siteyi oluşturmak için:

```powershell
quarto render
```

Oluşturulan site `_site` klasörüne yazılır.

Erişilebilirlik denetimi için ayrı profil kullanılabilir:

```powershell
quarto preview --profile a11y
```

Bu profil axe-core sonuçlarını tarayıcı konsoluna JSON olarak yazar; varsayılan üretim renderına test kodu eklemez.

## Üretim ayarları

- Tüm sayfalarda `index, follow` meta etiketi etkindir.
- `robots.txt` taramaya izin verir ve üretim site haritasını bildirir.
- `CNAME` dosyası `mehmetceylan.org` alan adını GitHub Pages yayınına taşır.
- `_quarto-staging.yml`, gerektiğinde varsayılan GitHub Pages adresinde deneme yayını almak için korunur.

## Sonraki tasarım turu

- “Çalışmalar / Research” bölümüne mevcut Margin yönünü bozmadan daha fazla renk ve görsel ayrım eklemek.

Onaylanan portre, üç iletişim adresi, Web of Science/ResearchGate/LinkedIn bağlantıları, Ağustos 2026–Nisan 2027 ziyaret tarihleri ve TÜBİTAK 2214-A destek ifadesi eklenmiştir. AEQ-PE-ES ve Türkçe AEQ-PE ölçekleri yeniden barındırılmadan, CC BY 4.0 lisanslı resmî makalelerin Ek 1 bölümlerine bağlanmıştır; AEQ-PE-ES için OSF bağlantısı veri, kod kitabı ve analiz çıktıları amacıyla korunmuştur.

