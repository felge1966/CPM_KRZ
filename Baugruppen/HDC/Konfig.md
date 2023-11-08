

K5504.20 über einen OMTI 5520 XT-Controller

Der Datenbus wird 1:1 verdrahtet, dann der Adreßbus A0-A4 1:1, A5 an A6 und umgekehrt, A7 an A7, und A8 an +5V, A9-A19 an 0V. AEN muss auch auf 0V. und /DACK3 an 5V, /RESET muß über einen Negator an RESET-DRV und /RD und /WR werden jeweils über ein 74LS32 Gatter zusammen mit /IORQ verknüpft und ergeben /IOR und /IOW.

Danach sollte der Controller auf Adresse 40h im IO-Adreßraum auffindbar sein.

Ich habe ein Turbopascal Programm "HDFORMAT" gefunden das die Platte physisch formatiert, einen Masterbootrecord schreibt und die Partitionierung übernimmt, dabei wird eine Partition für MSDOS reserviert, es gab ja an der AdW und der HUB eine 8086 Erweiterungskarte.. Danach sind Laufwerk F,G und H CP/M Partitionen der Festplatte. Wenn man keinen Platz für MSDOS reserviert sieht das Directory von Laufwerk F "vergriesgnaddelt" aus wenn man da was drauf kopiert hat, ich denke mal die Partitionstabelle wird in der 1. Partition eingeblendet.. ich habe 1 Zylinder für DOS reserviert und gut ist.

Ich muß mal gucken, IMHO gibts einen ROM-Lader für die Festplatte... Soweit ich in den Quellen lesen konnte werden für CP/M nur Platten mit genau 4 Köpfen unterstützt.
