Das sind 6 Karten, damit fällt ein 5er Einschubrahmen (vorläufig) aus.
Im Einschubrahmen stecken bei mir von links nach rechts folgende Karten (Blick auf die Front der Karten, Systembus X1 unten)

Links 64K OPS K3526
ABS K7024
frei (reserviert AKB K5020)
ATS K7028.20
OPS K3525
ZVE K2521
Rechts AFS K5122

Aus dem Modul um.mac der Quelle geht die notwendige Speicherumschaltmimik hervor:




     Legende Speichersteuerung
     -------------------------
  
    System-PIO Port B
 
    |7|6|5|4|3|2|1|0|
    | | | | | | | |
    | | | | | | | +---  /MEMDI1 ZRE
    | | | | | | +-----  negiert /MEMDI1 0 RAM und 4000 RAM (CP/M)
    | | | | | +-------  /MEMDI1 4000 RAM (Hintergr.verzeichnisse)
    | | | | +---------  frei
    | | | +-----------  /MEMDI1 8000 ABS
    | | +-------------  /MEMDI2 8000 RAM
    | +---------------  /MEMDI  C000 RAM
    +-----------------  frei



das heißt, es wird mit diversen MEMDI Signalen hantiert. Ich habe die ZVE auf /MEMDI 1 gewickelt, d.h. X2:A21 mit X2:A11 verbunden. Pio Port PB1 X2:C11 führt über einen zusätzlich anzubringenden Negator
(bei mir ein D100 mit Stützkondensator auf einem Schnipsel Lochraster an der Rückverdrahtung angespaxt) auf /MEMDI X1:C9 irgendwo auf dem durchverbundenen Systembus. /MEMDI schaltet den Speicherbereich von 0-7fffh des Hauptspeichers. PIO Port PB2 X2:A10 führt zu zu X1:A21 /MEMDI2 des 16K Hintergrundspeichers OPS K3525. PIO Port PB4 X2:A9 führt zur ABS K7024 X2:A21 die ich leicht modifiziert habe, normalerweise läßt sich /MEMDI dieser Karten nicht woanders hin legen, aber man hat nur die Wahl entweder die K3526 umzubauen oder die K7024 wenn man die Systembusverdrahtung nicht auftrennen möchte. Jedenfalls habe ich den Leiterzug zu X1:C9 der K7024 aufgetrennt und den betreffenden Gattereingang mit X2:A21 verbunden. PB5 X2:C9 der ZVE führt zu X2:A21 der OPS K3526, und PB6 zu X2:C21 der K3526. Diese Bits schalten die Bereiche 8000 und C000 des Hauptspeichers.
Der unbenutze Pin PB7 wird vom BIOS als Eingang initialisiert..

So viel zu Speicherumschaltung. Die AMF K5122 wird nach der Betriebsdokumentation auf Waitbetrieb umgewicklet/umgelötet. Wenn man eine Version mit Wickel- und nicht Lötbrücken hat ist das eine feine Sache... die Adressen sind Standard.

Bei der ZVE muß man X6-X7 für interne Taktversorgung, X14.2-X15.2 für /IEI auf X1:C10 und die Kaskadierung des CTC Kanals 0 und 1 ZC/TO0 und CLK/TRG1 mit X10.3 zu X11.3.
Zwischen den Zeilen im Bios habe ich gelesen, dass der Interrupt Ausgang der ATS Karte (X2:C14) für das Parallelinterface mit dem Eingang CLK/TRG3 X1.A22 verbunden werden muß. Darüber kann die Tastatur bei Betätigung Interrupts auslösen.


Die OPS K3525 muß auf die Adresse 4000h gewickelt werden X8.2 auf X9.3, arbeitet bei mir ohne Wait
also X10-X11 gewickelt sowie mit /MEMDI2 X6.2-X7.2. Die Lötbrücken für die Blockabschaltung stehen alle 3 rechts (Auf die Bestückung gesehen, Steckverbinder unten), also alle Blöcke eingeschaltet.
Diese RAM Karte dient als CCP Kopie im Hintergrund und für Inhaltsverzeichnisse der Bandlaufwerke oder RAM Floppy aus weiteren K3526, ggf. tut es hier auch eine andere Speicherkarte wie sinnlos herumliegende 4K CMOS RAMs oder so.
Diese Karte läßt sicher sicherlich heraus generieren wenn der CCP beim Warmstart irgendwo anders her geladen wird (CP/M Standard ist von der Floppy (Warmstart=Kaltstart) , CP/A hat eine meist Kopie im BIOS was aber den TPA verkleinert, eine Kopie in einem verfügbaren ROM ist natürlich auch möglich, man kann das ganze System aus dem ROM hochziehen)

Als nächstes die ATS. Es gibnt von der ATS zwei Versionen, eine .10 mit 2 Stück IFSS Schnittstellen und eine .20 mit einer IFSS und einer V.24 Schnittstelle. Hier kan man machen was man denkt, ich habe mehrere .10 habe aber die Einzige .20 benutzt, da ich für den Ur-Boot des Systems das CP/M irgendwie in den Hauptspeicher schmuggeln mußte, ich habe einen Lader geschrieben der ein Intel-HEX File über die V.24 vom PC herunter lädt und dieses Startet, da kam mir die V.24 entgegen, ich mußte keinen Adepten von IFSS auf V.24 basteln. Im Endeffekt tut es beim Boot über Floppy natürlich auch die 2x IFSS Version. Das System unterstützt auch irgend eine ATD, das Ding kenne ich aber gar nicht, habe IMHO noch Keine gesehen. Benutzt wird vorläufig nur die Parallelschnittstelle analog der auf der K2526 die wie oben angedeutet über CLK/TRG3 des ZVE CTC interruptfähig ist.

Meine K7028.20 ist wie folgt gewickelt:

    X13.1-X14.1 ..ist bedeutungslos, ein "konfigurationsport" der gelesen werden kann.

Kartenadresse:
   
   X15.1-X16.1
   X15.3-X16.3
   X15.5-X16.5

= Basisadresse E0h

   X6.1-X6.2
   X7.1-X7.2

IEI und IEO über Systembus X1

   X11.1-X12.1 - Keine Ahnung, war so
   X9.1-X10.1 - Keine Ahnung, war so

   X17.1-X18.1 CTCK3 auf Koppelbus X1:A22 .. war so, unbenutzes Feature

   X19.1-X20.1 SIO Bondvariante 0 (UB8560D)
   X28.1-X29.1 - Keine Ahnung, war so

   X21.1-X21.2
   X22.1-X22.1
   X21.3-X21.4
   X22.3-X22.4

= Beide IFSS Kanäle aktiv, war so..

   X9.1-X10.1 Festlegen der Baudrate durch Modem (Käse, unbenutzt, war so).

Ich habe nur ein "Wurschtblatt" als Doku, was die keine Ahnung-war so Wickelbrücken so treiben geht daraus nicht hervor, ich muß da den Schaltplan noch mal erforschen. Da ich aber derzeit keinen Drucker dran habe ist das erst mal irrelevant.

Auf der K7024 gibts nur eine relevante Wickelbrücke, das ist die Adresse. Da wird die 2. Brücke von oben gewickelt (Adresse 8000h), ich habe hier eine Version mit 4 Stück U214D, die Brücken sind aber IMHO identisch zur alten Version mit U202. Die anderen Brücken auf der Karte machen wohl Blinken und/oder Inverssteuerung, das habe ich mir nicht angesehen oder weiß es nicht mehr genau.
Ich habe noch eine neuere Karte mit U214 und 2716 ROMs, (braucht nur 5V), die hat die selben Brücken für die Adresse, muß aber anders belegt sein...

K3526

Auf der K3526 gibts 3 Dip-Schalter lins, der oberste ist A10, darunter A7 und darunter A5.

   Von Links nach rechts
   A10: 01010000
    A7: 00101000
    A5: 10010001

   1=On
   0=Off
