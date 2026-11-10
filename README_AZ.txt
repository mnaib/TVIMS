TTNDATVIMS - LOGIN responsive ve MAIN applicationDPI (AIR 51.4 / Android 35)

Paketin ici:
  TTNDATVIMS/src/TTNDATVIMS.mxml       - TEHLUKESIZ DEFAULT: 160 qalir + DPI/screen olcu loglari
  TTNDATVIMS/src/views/Login.mxml      - adaptiv Login, portrait/landscape, scroller, merkezlenme
  OPTIONAL_AUTO_DPI/TTNDATVIMS.mxml    - TEST UCUN ALTERNATIV: applicationDPI parametrsiz

NE UCUN IKI VARIANT:
  * Flex 4.6 applicationDPI yalniz root MXML-de evvelceden teyin olunur.
  * applicationDPI=160 Flex-in runtimeDPI-ni istifade ederek UI-ni avtomatik scale edir.
  * applicationDPI parametrini SILMEK Flex avtomatik scaling-i sondurur, buna gore diger
    hele responsive edilmeyen View-lerde ekran olculeri/ikonlar deyise biler.
  * ONA GORE birinci test ucun default ROOT-u (160) istifade etmek daha tehlukesizdir.
  * Diger View-ler adaptiv hale getirildikden sonra OPTION_AUTO_DPI variantini test et.

KONKRET TETBIQ:
  1) C:\FXWS47\TTNDATVIMS\src\TTNDATVIMS.mxml ve src\views\Login.mxml backup et.
  2) ZIP-deki TTNDATVIMS qovlugunu C:\FXWS47 icine cixart.
  3) Flash Builder 4.7: Project > Clean, Build Project.
  4) Hazir isleyen AIR 51.4.1.2 DocOpen release scriptiyle APK yarat.
  5) Samsung planşetde portrait ve landscape rejimlerini, login, klaviaturani yoxla.
  6) Lazim olarsa bu 2-ci varianti sına: OPTIONAL_AUTO_DPI/TTNDATVIMS.mxml
     faylini src/TTNDATVIMS.mxml kimi koy (ancaq backup saxla).

REAL OLCULER:
  Loglarda 'TVIMS screen' ve 'TTNDATVIMS responsive LOGIN' bildirisleri:
    width/height, stage width/height, screenDPI, runtimeDPI ve applicationDPI.
  ADB ile ayrica: adb shell wm size  ve adb shell wm density
  Flex content width/height root scaled view olculeridir; fiziki ekran olcusu ile
  eyni olmaya biler. Stage-deki olculeri birbasa layout px sayma.

DIQQET:
  Paketde yalniz 2 MXML source deyisir; APK / signing certificate daxil deyil.
  Android descriptor <autoOrients>true</autoOrients> saxlanmalidir.
  XML parse yoxlanilib, Flash Builder-da compile ve fiziki cihaz testi edilmeyib.
  Login View `actionBarVisible=false` edir; diger View-lerin actionBar-i deyismir.
  Login redizayninda background/agency banner images saxlanir.
  Real cihazda display density ferqi oldugu ucun vizual ince tuning teleb oluna biler.
