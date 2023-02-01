# embedded RPi projekt
## plán
- skompilovať RPi OS ktorý automaticky spustí prehrávanie z USB.

v hlavnom priečinku stačí spustiť
```
make
```

príkazom
```
sudo dd if=buildroot/output/images/sdcard.img of=/dev/[SDkarta]
```
viete nahrať OS na SD kartu.

Skript ktorý spúšťa hudbu 
```
play.sh
```
a mediaplayer.patch obsahuje všetky potrebné nastavenia ako napr inštaláciu mpg123 programu pre spúšťanie hudby a ovládače pre USB disk a Usb zvukovú kartu. 