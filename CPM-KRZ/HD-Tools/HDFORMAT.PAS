(******************************************************************
   05.11.1988 Willi Dames
   06.11.1988 Manfred Krzikalla
   12.02.1989 Manfred Krzikalla

   zum Programm gehoeren folgende Dateien:

   HDPARK.PAS        Quelle Parkprogramm
   HDFORMAT.PAS      Quelle Formatprogramm
   HDIO.INC          include-Datei fuer HDFORMAT.PAS und HDPARK.PAS
   HDPARM.DAT        Harddisk-Parameter-Beschreibungsdatei

*******************************************************************)

program hdformat;

{$U+}
{$R+}

const
        hdmboot : array [0..511] of byte = (
$FA, $33, $C0, $8E, $D0, $BC, $00, $7C,$8B, $F4, $50, $07, $50, $1F, $FB, $FC,
$BF, $00, $06, $B9, $00, $01, $F2, $A5,$EA, $1D, $06, $00, $00, $BE, $BE, $07,
$B3, $04, $80, $3C, $80, $74, $0E, $80,$3C, $00, $75, $1C, $83, $C6, $10, $FE,
$CB, $75, $EF, $CD, $18, $8B, $14, $8B,$4C, $02, $8B, $EE, $83, $C6, $10, $FE,
$CB, $74, $1A, $80, $3C, $00, $74, $F4,$BE, $8B, $06, $AC, $3C, $00, $74, $0B,
$56, $BB, $07, $00, $B4, $0E, $CD, $10,$5E, $EB, $F0, $EB, $FE, $BF, $05, $00,
$BB, $00, $7C, $B8, $01, $02, $57, $CD,$13, $5F, $73, $0C, $33, $C0, $CD, $13,
$4F, $75, $ED, $BE, $A7, $06, $EB, $D3,$BE, $CE, $06, $BF, $FE, $7D, $81, $3D,
$55, $AA, $75, $C7, $8B, $F5, $EA, $00,$7C, $00, $00, $55, $6E, $67, $81, $6C,
$74, $69, $67, $65, $20, $50, $61, $72,$74, $69, $74, $69, $6F, $6E, $73, $74,
$61, $62, $65, $6C, $6C, $65, $00, $46,$65, $68, $6C, $65, $72, $20, $62, $65,
$69, $6D, $20, $4C, $61, $64, $65, $6E,$20, $64, $65, $73, $20, $42, $65, $74,
$72, $69, $65, $62, $73, $73, $79, $73,$74, $65, $6D, $73, $20, $00, $4B, $65,
$69, $6E, $20, $42, $65, $74, $72, $69,$65, $62, $73, $73, $79, $73, $74, $65,
$6D, $20, $20, $20, $20, $20, $00, $00,$00, $00, $00, $00, $00, $00, $00, $00,
$00, $00, $00, $00, $00, $00, $00, $00,$00, $00, $00, $00, $00, $00, $00, $00,
$00, $00, $00, $00, $00, $00, $00, $00,$00, $00, $00, $00, $00, $00, $00, $00,
$00, $00, $00, $00, $00, $00, $00, $00,$00, $00, $00, $00, $00, $00, $00, $00,
$00, $00, $00, $00, $00, $00, $00, $00,$00, $00, $00, $00, $00, $00, $00, $00,
$00, $00, $00, $00, $00, $00, $00, $00,$00, $00, $00, $00, $00, $00, $00, $00,
$00, $00, $00, $00, $00, $00, $00, $00,$00, $00, $00, $00, $00, $00, $00, $00,
$00, $00, $00, $00, $00, $00, $00, $00,$00, $00, $00, $00, $00, $00, $00, $00,
$00, $00, $00, $00, $00, $00, $00, $00,$00, $00, $00, $00, $00, $00, $00, $00,
$00, $00, $00, $00, $00, $00, $00, $00,$00, $00, $00, $00, $00, $00, $00, $00,
$00, $00, $00, $00, $00, $00, $00, $00,$00, $00, $00, $00, $00, $00, $00, $00,
$00, $00, $00, $00, $00, $00, $00, $00,$00, $00, $00, $00, $00, $00, $00, $00,
$00, $00, $00, $00, $00, $00, $00, $00,$00, $00, $00, $00, $00, $00, $00, $00,
$00, $00, $00, $00, $00, $00, $00, $00,$00, $00, $00, $00, $00, $00, $80, $01,
$01, $00, $01, $03, $1A, $F9, $1A, $00,$00, $00, $76, $65, $00, $00, $00, $00,
$00, $00, $00, $00, $00, $00, $00, $00,$00, $00, $00, $00, $00, $00, $00, $00,
$00, $00, $00, $00, $00, $00, $00, $00,$00, $00, $00, $00, $00, $00, $00, $00,
$00, $00, $00, $00, $00, $00, $00, $00,$00, $00, $00, $00, $00, $00, $55, $AA);

{$IHDIO.INC}

var  SKEW_FACTOR,CODE,K:   integer;
     ANSW:                 char;
     SKEW:                 byte;
     CYLCPM,
     CYLS,HEADS,SECTORS:   integer;
     junk:                 integer;

(*------------------------------------------------------------------------*)
procedure getLWparam;
begin
  repeat   (* solange, bis Laufwerksparameter in Ordnung sind *)
    param; (* Parameter aus Datei HDPARAM.DAT holen *)
    CYLS   := DRIVE_CHARACTERISTICS[0]*256 + DRIVE_CHARACTERISTICS[1];
    HEADS  := DRIVE_CHARACTERISTICS[2];
    SECTORS:= DRIVE_CHARACTERISTICS[9];

    writeln;
    writeln('Eingestellte Laufwerk-Parameter:',
             CYLS:5,' Zylinder,',HEADS:2,' Koepfe,',
             SECTORS:3,' Sektoren');
    writeln;

    write  ('Sind diese Parameter richtig? (j/n): ');
    repeat
      readln(ANSW); ANSW:=upcase(ANSW);
    until ANSW in ['J','N'];

    if ANSW='N' then
      get_param;    (* Laufwerksparameter von Tastatur holen *)
  until ANSW='J';

  set_characteristics(ERROR);
end;

(*------------------------------------------------------------------------*)
procedure formatLW;
begin
  writeln;
  write('Soll die HardDisk physisch formatiert werden? (j/n): ');
  repeat
    readln(ANSW); ANSW:=upcase(ANSW);
  until ANSW in ['J','N'];

  if ANSW='J' then begin
    if paramcount <>0 then begin
      val (paramstr(1),SKEW_FACTOR,CODE);
      SKEW:=byte(SKEW_FACTOR);
    end else begin
      writeln('Aufruf: "hdformat [skew]", skew=3 angenommen');
      SKEW:=3;
    end;

    fill_sector_buffer ($E5,ERROR);
    if ERROR then
      stop ('Controller meldet Fehler bei Sektor-Puffer-Fuellen.');

    repeat
      writeln;
      writeln('Achtung!! Alle Daten auf der HardDisk werden zerstoert!!');
      write  ('Soll wirklich formatiert werden ??? (J/N)');
      readln(ANSW); ANSW:=upcase(ANSW);
    until ANSW in ['J','N'];

    writeln;
    if ANSW='N' then
      stop ('Formatierung abgebrochen');

    writeln('HardDisk wird formatiert, bitte Geduld... (mehrere Minuten)');
    format_the_drive(SKEW,ERROR);
    if ERROR then
      stop('Fehler beim Formatieren. HardDisk und Controller pruefen.');

    writeln('physische Formatierung erfolgreich!.');
  end;
end;

(*------------------------------------------------------------------------*)
procedure makePartitionEntry(entryNr:integer;
                             startcyl, starthead:integer;
                             endcyl, endhead:integer;
                             aktiv:integer;              (* $00, $80      *)
                             ptype:integer);             (* $02, $04, $f5 *)
var index             : integer;
    r, rr             : real;
    longlow, longhigh : integer;
begin
    index := $1be + entryNr*16;
    BUFFER[index+00] := aktiv;

    BUFFER[index+01] := starthead;
    BUFFER[index+02] := 1 +((startcyl shr 2) and $c0);
    BUFFER[index+03] := startcyl and $ff;

    BUFFER[index+04] := ptype;           (* 4 = 16-Bit-FAT; 1 = 12-Bit-FAT *)

    BUFFER[index+05] := endhead;
    BUFFER[index+06] := SECTORS or ((endcyl shr 2) and $C0);
    BUFFER[index+07] := endcyl and $ff;

    r:=(startcyl*heads+starthead)*sectors;
    rr:=r-trunc(r/65536.0)*65536.0;
    if rr < 32768.0 then
      longlow := trunc(rr)
    else
      longlow := trunc(rr-32768.0) or $8000;
    longhigh := trunc(r/65536.0);
    BUFFER[index+08] := longlow and $ff;
    BUFFER[index+09] := (longlow shr 8) and $ff;
    BUFFER[index+10] := longhigh and $ff;
    BUFFER[index+11] := (longhigh shr 8) and $ff;

    r:=((endcyl-startcyl)*HEADS+endhead-starthead+1)*SECTORS;
    rr:=r-trunc(r/65536.0)*65536.0;
    if rr < 32768.0 then
      longlow := trunc(rr)
    else
      longlow := trunc(rr-32768.0) or $8000;
    longhigh := trunc(r/65536.0);
    BUFFER[index+12] := longlow and $ff;
    BUFFER[index+13] := (longlow shr 8) and $ff;
    BUFFER[index+14] := longhigh and $ff;
    BUFFER[index+15] := (longhigh shr 8) and $ff;
end;

(*------------------------------------------------------------------------*)
procedure writeBootSector;
var
  schonwegCyl : integer;
  starthead   : integer;
  ptype       : integer;
  aktiv       : integer;
  nochmeg     : real;
  antw        : char;
begin
  writeln;
  write('Soll ein MasterBootSektor geschrieben werden? (j/n): ');
  repeat
    readln(antw); antw:=upcase(antw);
  until antw in ['J','N'];

  if antw='J' then begin
    for junk := 0 to 511 do
      BUFFER[junk] := hdmboot[junk];
    writeln;writeln(
    'Die HardDisk kann in max. 4 Bereiche fuer DOS und CP/M aufgeteilt werden.');
    junk := 0; schonwegCyl := 0; starthead := 1;
    repeat
      repeat
        nochmeg := 1.0/2048.0*(CYLS-schonwegCyl)*HEADS*SECTORS;
        writeln;
        writeln('Es stehen noch', (CYLS-schonwegCyl):5, ' Zylinder (= ',
                 nochmeg:5:1, 'M) zur Verfuegung.');
        write('Wieviele Zylinder sollen davon fuer ');
        if junk=0 then
          write('MS/DOS')
        else
          write('CP/M  ');
        write(' benutzt werden? (>=0) ');
        readln(CYLCPM);
      until (0<=CYLCPM) and ((CYLCPM+schonwegCyl) <= CYLS);

      if junk<>0 then
        ptype := $f5
      else
        ptype := 4;

      if (ptype = $f5) and (CYLCPM<>0) and (HEADS<>4) then begin
        writeln;
        stop('CP/M-Partition z. Zt. nur fuer Laufwerke mit 4 Koepfen!!!');
      end;

      if ptype=$f5 then
        aktiv := 0
      else
        aktiv := $80;
      makePartitionEntry(junk,schonwegCyl,starthead,
                              schonwegCyl+CYLCPM-1,heads-1,aktiv,ptype);
      starthead := 0;
      schonwegCyl := schonwegCyl + CYLCPM;
      junk := junk +1;
    until (junk > 3) or (schonwegCyl >= CYLS);

    (* fuer evtl. autom. HardDisk-Anpassung Characteristik hinterlegen *)
    move(DRIVE_CHARACTERISTICS[0],BUFFER[$1ad],10);
    BUFFER[$1bd] := $ff; (* direkt vor PartionTable, i.a. steht dort 00 *)

    write_hd_sector(0,0,1,ERROR);
    if ERROR then
      stop('Fehler beim Schreiben MasterBootSector. HardDisk nicht einsetzbar!');
  end;
end;
(*------------------------------------------------------------------------*)

begin
  clrscr;
  writeln('HardDisk formatieren, Version 12.02.89');
  writeln('======================================');
  writeln;

  getLWparam;
  formatLW;
  writeBootSector;

  writeln;
  writeln('Formatierung erfolgreich, HardDisk ist nach Kaltstart bereit!');
  if BUFFER[$1be+4]<>$f5 then begin
    writeln('Die DOS-Partition muss nun unter DOS mit "format c:/s" noch');
    writeln('logisch formatiert und mit dem System versehen werden.');
  end;
  writeln
end.
