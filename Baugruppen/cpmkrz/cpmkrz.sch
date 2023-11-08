EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L power:GND #PWR02
U 1 1 654B8EBA
P 2600 3900
F 0 "#PWR02" H 2600 3650 50  0001 C CNN
F 1 "GND" H 2605 3727 50  0000 C CNN
F 2 "" H 2600 3900 50  0001 C CNN
F 3 "" H 2600 3900 50  0001 C CNN
	1    2600 3900
	1    0    0    -1  
$EndComp
$Comp
L power:+5P #PWR01
U 1 1 654B9330
P 2700 1450
F 0 "#PWR01" H 2700 1300 50  0001 C CNN
F 1 "+5P" H 2715 1623 50  0000 C CNN
F 2 "" H 2700 1450 50  0001 C CNN
F 3 "" H 2700 1450 50  0001 C CNN
	1    2700 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	2350 1950 2700 1950
Wire Wire Line
	2700 1950 2700 1450
Wire Wire Line
	2350 3400 2700 3400
Wire Wire Line
	2700 3400 2700 1950
Connection ~ 2700 1950
$Comp
L 74xx:7400 U1
U 1 1 654B9DE6
P 4400 2000
F 0 "U1" H 4400 2325 50  0000 C CNN
F 1 "7400" H 4400 2234 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_LongPads" H 4400 2000 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn7400" H 4400 2000 50  0001 C CNN
	1    4400 2000
	1    0    0    -1  
$EndComp
$Comp
L 74xx:7400 U1
U 5 1 654BB367
P 4200 5650
F 0 "U1" H 4430 5696 50  0000 L CNN
F 1 "7400" H 4430 5605 50  0000 L CNN
F 2 "Package_DIP:DIP-14_W7.62mm_LongPads" H 4200 5650 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn7400" H 4200 5650 50  0001 C CNN
	5    4200 5650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR04
U 1 1 654BE0D0
P 4200 6150
F 0 "#PWR04" H 4200 5900 50  0001 C CNN
F 1 "GND" H 4205 5977 50  0000 C CNN
F 2 "" H 4200 6150 50  0001 C CNN
F 3 "" H 4200 6150 50  0001 C CNN
	1    4200 6150
	1    0    0    -1  
$EndComp
$Comp
L power:+5P #PWR03
U 1 1 654BE5D4
P 4200 5150
F 0 "#PWR03" H 4200 5000 50  0001 C CNN
F 1 "+5P" H 4215 5323 50  0000 C CNN
F 2 "" H 4200 5150 50  0001 C CNN
F 3 "" H 4200 5150 50  0001 C CNN
	1    4200 5150
	1    0    0    -1  
$EndComp
$Comp
L Device:C C2
U 1 1 654BF2BD
P 5000 5700
F 0 "C2" H 5115 5746 50  0000 L CNN
F 1 "100n" H 5115 5655 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 5038 5550 50  0001 C CNN
F 3 "~" H 5000 5700 50  0001 C CNN
	1    5000 5700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR07
U 1 1 654BF5F4
P 5000 5850
F 0 "#PWR07" H 5000 5600 50  0001 C CNN
F 1 "GND" H 5005 5677 50  0000 C CNN
F 2 "" H 5000 5850 50  0001 C CNN
F 3 "" H 5000 5850 50  0001 C CNN
	1    5000 5850
	1    0    0    -1  
$EndComp
$Comp
L power:+5P #PWR06
U 1 1 654BF82D
P 5000 5550
F 0 "#PWR06" H 5000 5400 50  0001 C CNN
F 1 "+5P" H 5015 5723 50  0000 C CNN
F 2 "" H 5000 5550 50  0001 C CNN
F 3 "" H 5000 5550 50  0001 C CNN
	1    5000 5550
	1    0    0    -1  
$EndComp
Wire Wire Line
	3550 2050 3550 2100
Wire Wire Line
	3550 2100 4100 2100
Wire Wire Line
	2350 2050 3550 2050
Wire Wire Line
	4100 1900 3550 1900
Wire Wire Line
	3550 1900 3550 2050
Connection ~ 3550 2050
Wire Wire Line
	4900 2000 4700 2000
Wire Wire Line
	2350 2150 3500 2150
Wire Wire Line
	3500 2150 3500 2200
Wire Wire Line
	3500 2200 5650 2200
Wire Wire Line
	5650 2100 4900 2100
Wire Wire Line
	4900 2100 4900 2000
Wire Wire Line
	2350 2250 4900 2250
Wire Wire Line
	4900 2250 4900 2300
Wire Wire Line
	4900 2300 5650 2300
Wire Wire Line
	2350 2350 4900 2350
Wire Wire Line
	4900 2350 4900 2400
Wire Wire Line
	4900 2400 5650 2400
Wire Wire Line
	2350 2450 4900 2450
Wire Wire Line
	4900 2450 4900 2500
Wire Wire Line
	4900 2500 5650 2500
Text Label 5000 2100 0    50   ~ 0
MEMDI1_VRAM
Text Label 4800 2200 0    50   ~ 0
~MEMDI1_4000_H-RAM
Text Label 2850 2050 0    50   ~ 0
~MEMDI1_VRAM
Text Label 4950 2300 0    50   ~ 0
~MEMDI1_8000_ABS
Text Label 4950 2400 0    50   ~ 0
~MEMDI2_8000_RAM
Text Label 4950 2500 0    50   ~ 0
~MEMDI_C000_RAM
$Comp
L Connector_Generic:Conn_01x06 J3
U 1 1 654C0F42
P 5850 2300
F 0 "J3" H 5930 2292 50  0000 L CNN
F 1 "Conn_01x06" H 5930 2201 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x06_P2.54mm_Horizontal" H 5850 2300 50  0001 C CNN
F 3 "~" H 5850 2300 50  0001 C CNN
	1    5850 2300
	1    0    0    -1  
$EndComp
Wire Wire Line
	2350 2550 2600 2550
Wire Wire Line
	2600 2550 2600 3600
$Comp
L Connector_Generic:Conn_01x07 J1
U 1 1 654C772D
P 2150 2250
F 0 "J1" H 2068 2767 50  0000 C CNN
F 1 "Conn_01x07" H 2068 2676 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x07_P2.54mm_Horizontal" H 2150 2250 50  0001 C CNN
F 3 "~" H 2150 2250 50  0001 C CNN
	1    2150 2250
	-1   0    0    -1  
$EndComp
$Comp
L Device:CP C1
U 1 1 654C991F
P 3300 3750
F 0 "C1" H 3418 3796 50  0000 L CNN
F 1 "4u7" H 3418 3705 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D6.3mm_P2.50mm" H 3338 3600 50  0001 C CNN
F 3 "~" H 3300 3750 50  0001 C CNN
	1    3300 3750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR05
U 1 1 654CA121
P 3300 3900
F 0 "#PWR05" H 3300 3650 50  0001 C CNN
F 1 "GND" H 3305 3727 50  0000 C CNN
F 2 "" H 3300 3900 50  0001 C CNN
F 3 "" H 3300 3900 50  0001 C CNN
	1    3300 3900
	1    0    0    -1  
$EndComp
Wire Wire Line
	2350 3500 3300 3500
Wire Wire Line
	3300 3500 3300 3600
$Comp
L Connector_Generic:Conn_01x03 J2
U 1 1 654CACB6
P 2150 3500
F 0 "J2" H 2068 3817 50  0000 C CNN
F 1 "Conn_01x03" H 2068 3726 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Horizontal" H 2150 3500 50  0001 C CNN
F 3 "~" H 2150 3500 50  0001 C CNN
	1    2150 3500
	-1   0    0    -1  
$EndComp
Wire Wire Line
	2350 3600 2600 3600
Connection ~ 2600 3600
Wire Wire Line
	2600 3600 2600 3900
$Comp
L Connector_Generic:Conn_01x02 J4
U 1 1 654CCB3E
P 5850 3000
F 0 "J4" H 5930 2992 50  0000 L CNN
F 1 "Conn_01x02" H 5930 2901 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Horizontal" H 5850 3000 50  0001 C CNN
F 3 "~" H 5850 3000 50  0001 C CNN
	1    5850 3000
	1    0    0    -1  
$EndComp
Wire Wire Line
	3300 3500 3300 3000
Connection ~ 3300 3500
$Comp
L power:GND #PWR09
U 1 1 654CD85C
P 5650 3100
F 0 "#PWR09" H 5650 2850 50  0001 C CNN
F 1 "GND" H 5655 2927 50  0000 C CNN
F 2 "" H 5650 3100 50  0001 C CNN
F 3 "" H 5650 3100 50  0001 C CNN
	1    5650 3100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR08
U 1 1 654CDAB7
P 5650 2600
F 0 "#PWR08" H 5650 2350 50  0001 C CNN
F 1 "GND" H 5655 2427 50  0000 C CNN
F 2 "" H 5650 2600 50  0001 C CNN
F 3 "" H 5650 2600 50  0001 C CNN
	1    5650 2600
	1    0    0    -1  
$EndComp
$Comp
L Device:R R1
U 1 1 654CDE25
P 4250 3000
F 0 "R1" V 4043 3000 50  0000 C CNN
F 1 "10" V 4134 3000 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 4180 3000 50  0001 C CNN
F 3 "~" H 4250 3000 50  0001 C CNN
	1    4250 3000
	0    1    1    0   
$EndComp
Wire Wire Line
	5650 3000 4400 3000
Wire Wire Line
	3300 3000 4100 3000
$EndSCHEMATC
