# Mehmet Ceylan akademik web sitesi

Bu klasör, onaylanan Round 4.1 “Margin” tasarımının Quarto kaynak projesidir. Proje yerel inceleme içindir; henüz yayımlanmamıştır.

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

## Yayın öncesi korumalar

- Tüm sayfalarda `noindex, nofollow` meta etiketi etkindir.
- `robots.txt` bütün tarayıcı botlarını engeller.
- Bu iki koruma, yazar son içerik onayını vermeden kaldırılmamalıdır.
- GitHub Pages, alan adı ve DNS ayarları bu projede yapılmamıştır.

## Yayın öncesi tamamlanacak içerikler

- Türkçe, İspanyolca ve Çince terminoloji onayı
- Yayın özetinin yazar onayı
- Son erişilebilirlik ve bağlantı kontrolü

Onaylanan portre, üç iletişim adresi, Web of Science/ResearchGate/LinkedIn bağlantıları, Ağustos 2026–Nisan 2027 ziyaret tarihleri ve TÜBİTAK 2214-A destek ifadesi eklenmiştir. AEQ-PE-ES ve Türkçe AEQ-PE ölçekleri yeniden barındırılmadan, CC BY 4.0 lisanslı resmî makalelerin Ek 1 bölümlerine bağlanmıştır; AEQ-PE-ES için OSF bağlantısı veri, kod kitabı ve analiz çıktıları amacıyla korunmuştur.

