�`\Floppyinitialisierung mit�K5122�an K2521
========================================
      (c) M. Krzikalla  23.04.1987

In welchem Laufwerk soll initialisiert werden?
 (0, 1, 2, 3) $

Bitte zu initialisierende Diskette in Laufwerk  
und Format auswaehlen (^C fuer ABORT):

     0  5x1024x40   = 200k (KRZ)
     1  16x256x37   = 148k (SCP)
     2  26x128x38   = 123k (BCU)
     3  5x1024x80   = 400k (KRZ)
     4  5x1024x160  = 800k (KRZ)
     5  9x512x160   = 711k (Vortex)
     6  9x512x40    = 171k (Schneider System)
     7  9x512x40    = 180k (Schneider Daten)
     8  8x512x39    = 156k (CP/M-86 einseitig)
     9  16x256x158  = 624k (Soemmerda)
     A  5x1024x40x2 = 400k (KRZ)
     B  9x512x40x2  = 360k (MS-DOS)

     @  frei waehlbares Format

$(0,1,2,3,4,5,6,7,8,9,A,B,@): 0$
Ist das Laufwerk wirklich ein 80spuriges? (j/n) j$
Ist das Laufwerk wirklich ein doppelseitiges? (j/n) j$

WARNUNG! Es werden alle Daten geloescht!
fortsetzen? (j,n) n$         einmaliges Initialisieren mit Kontrollesen
---------------------------------------------------------------
            init-Sollzahl:  6248 bytes/Umdrehung

 Spur 0,4,8...   Spur 1,5,9...   Spur 2,6,10...  Spur 3,7,11...
$

Weitere Diskette initialisieren? (j/n) j$
Es traten Fehler beim Initialisieren auf.$
Ende
$        cbr������!<<LL0123456789AaBbdddd 0�b( p 'x 4( �	
  �b( �	
 0�bP p0�bP p�@	DP �	 �@	D( �AFBGCHDIE �@	D( ���������� �@b( V'x 4P �	
0�b( p14253�@	b( �	1�	� (
� :)� �:*�08��40�2��02]o& ^	~2Y�	� 		� (
� :)�>0(:*�@ ͟�!P�(#��y�
� �o& )2	~#fo~2�#�(�_��~#2�^#V#�S�~2�#~2�#~2�#~2��P �*��#~2�#^#V�S�#"��	� (
� :)= :*���J �	� ���(�	� �	� 
(� :)��`:*�_�J�`	� �  	�	� �	�0�2c	�	� �	�0�2d� >!�b= > !'x= >@!�>�!02g"e	�	� �	2h	)
� �	2k	\
� �	<2j	�
� �	==2i:g!  � 	� �:iO 	@ 	T]:hG!  �F 	"lh��R8
	�
� �!n:hG>2,w:,�(��	�
� �8��8w~<#��
Anzahl der zu initialisierenden Seiten (0,1): 0$
Sektorlaenge (0-128, 1-256, 2-512, 3-1024):   0$
Anzahl der Sektoren pro Seite:                0$
Nummer der ersten zu initialisierenden Spur:  0$
Nummer der letzten zu initialisierenden Spur: 0$
Gap-Groesse nach Daten-ID:                    0$
Sektornummer (hex, CR=fortlaufende Nummern) : 1$
Gap ist zu gross.$
+� :,O !-	6 !- ~�(#�����������G�x�
+� :,�7�O !-	6 !-~�(&#�a8�{0���0�
8�����������������G֯x�	� (
� :)�(:*���J��>���0>�>��:��� ��A���               �2a:�2�:]<G>�����͚�ͬ  �(
 ����`� ��A����o��`�2^:�G:^�8�2b�w:��(2b�w!^:�=�(#>�>8>�>��>?�>��d�A4�x2a>�͚>��>�:a�:b�  :^�(� � 
� :^�� � >2_*�"�!�:^w#:bw#�[��S�w#:�w+++�0~�_��_O��Wy��Wy��ZW#�s#r#:_G<2_:�� �!����:b�(!����"5�S�S5>
2\>��:�2_�� !�>������Y>N�          (��         ����         ��         >���Q         �         �         >���Y>N�         ����         ��         >���Q         �         �         >���Y��          ���>N�         ����         ��         >���Q         �         �         >���Y:�G>��         �         �         �         �         �         �         �     �:��:�         �>N �         ��:_=2_>N����>N��!  ��#(�>��y>�������R8��Y���*���Hd �H
 �H}�Q � ���	�� :\=�'>2a:^���	� :^��
0��
�>0�_� ��0_� �	� � Spur $ defekt $:�o�Wgs#rɷ��M$�� � ��(G�	�� ��� �$:�2_�>��(�2ͬ!�������Q�Y�� ����(����7���Q�Y�� ����(����7���7#���7#���7#���7#���7#���7#�:�G��Q�Y�� ����(����7����7      ����7      ����7      ����7      ����7      ����7      ����7      ����7�      �W       �_>��:���7:���7:_=2_�2>��ͬ���͹��&>���<� ��ɯ�R8<��0_�� ��       �������������������������������������������������������������������������������������������������������������������������������������������������������������