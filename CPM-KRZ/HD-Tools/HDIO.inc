type message     = string [80];
     string2     = string[2];

var  HDPARAM: text;
     PORT_BAS: byte; {I/O-Basis-Adresse fuer Controller}
     DRIVE_CHARACTERISTICS: array [0..9] of byte;
     CFIELD:  record
                COMAND:  byte;
                ADRESS:  byte;
                SECTOR:  byte;
                TRACK:   byte;
                BCOUNT:  byte;
                TERMIN:  byte;
              end;

     CFARRAY:            array [0..5] of byte absolute CFIELD;
     RES:                array [1..5] of integer;
     BUFFER:             array [0..511] of byte;
     ERROR:              boolean;

{     Die wichtigstens Kommandos des OMTI-Kontrollers:

      Kommando   |  Bedeutung
      ___________________________________________________________
         $00     |  'Drive fertig' Abfrage
         $01     |  Zylinder 0 anfahren
         $03     |  Kontroller: Zustandsanforderung
         $04     |  Ganzes Laufwerk formatieren
         $05     |  Formatvorgang ($04) ueberpruefen
         $06     |  Eine Spur neu formatieren
         $07     |  Fehlerhafte Spur formatieren
         $08     |  Sektoren lesen     (1-256)
         $0A     |  Sektoren schreiben (1-256)
         $0B     |  Spezifizierte Spur anfahren
         $0C     |  'Drive Characteristics' an Kontroller
         $0E     |  Daten aus dem Sektorpuffer lesen
         $0F     |  Daten in den Sektorpuffer schreiben
         $11     |  Alternative Spur anweisen
         $1B     |  Platte wechseln
         $20     |  Kopieren zwischen versch. Laufwerken
         $E0     |  Ausloesen der internen RAM Diagnostik
         $E5     |  Sektoren lesen     mit ECC
         $E6     |  Sektoren schreiben mit ECC

         ( Diese Tabelle soll lediglich eine Uebersicht der mog-
           lichen Kommandos sein. Um sie zu benutzen wird zur Ver-
           meidung fehlerhafter Anwendung ausdruecklich auf das
           Handbuch zu OMTI Kontroller verwiesen. )  }

procedure stop (TXT: message);
begin
  writeln (TXT);
  inline ($C3/0/0);
end;

function hexd(hd:byte):char;
const hdig: array [0..15] of char ='0123456789ABCDEF';
begin
  hexd:=hdig[hd and $f];
end;

function hex(h:byte):string2;
begin
  hex:=hexd(h shr 4)+hexd(h);
end;

function hexin(var s:string2):integer;
var i,h:integer;
  function hexdin(c:char):integer;
  begin
    c:=upcase(c);
    if c<='9' then
      hexdin:=ord(c)-ord('0')
    else
      hexdin:=ord(c)-ord('A')+10;
  end;
begin
  h:=0;
  for i:= 1 to length(s) do h:=h*16+hexdin(s[i]);
  hexin:=h;
end;

procedure put_param;
begin
rewrite(HDPARAM);
writeln(HDPARAM,hex(PORT_BAS),' controller port (hex!)');
writeln(HDPARAM,DRIVE_CHARACTERISTICS[0]*256+DRIVE_CHARACTERISTICS[1],
        ' cyls (1..1024)');
writeln(HDPARAM,DRIVE_CHARACTERISTICS[2],' heads (1..8)');
writeln(HDPARAM,DRIVE_CHARACTERISTICS[3]*256+DRIVE_CHARACTERISTICS[4],
        ' start-cyl reduced write current (0..1024)');
writeln(HDPARAM,DRIVE_CHARACTERISTICS[5]*256+DRIVE_CHARACTERISTICS[6],
        ' start-cyl write precompensation (0..1024)');
writeln(HDPARAM,DRIVE_CHARACTERISTICS[7],' max ECC data burst length (5..11)');
writeln(HDPARAM,hex(DRIVE_CHARACTERISTICS[8]),' drive step option (hex!)');
writeln(HDPARAM,DRIVE_CHARACTERISTICS[9],' sectors per track (1..26)');
close(HDPARAM);
end;

procedure get_param;
var I: integer;
    C: char;
    S: string2;
begin
 writeln;
 write('controller port (hex!, i.a. 40):                     '); readln(S);
 PORT_BAS:=hexin(S);

 write('cylinder (1..1024, i.a. 612):                        '); readln(I);
 DRIVE_CHARACTERISTICS[0]:=I div 256;
 DRIVE_CHARACTERISTICS[1]:=I mod 256;

 write('heads (1..8, i.a. 4):                                '); readln(I);
 DRIVE_CHARACTERISTICS[2]:=I;

 write('start-cyl reduced write current (0..1024, i.a. 450): '); readln(I);
 DRIVE_CHARACTERISTICS[3]:=I div 256;
 DRIVE_CHARACTERISTICS[4]:=I mod 256;

 write('start-cyl write precompensation (0..1024, i.a. 450): '); readln(I);
 DRIVE_CHARACTERISTICS[5]:=I div 256;
 DRIVE_CHARACTERISTICS[6]:=I mod 256;

 write('max ECC data burst length (5..11, i.a. 11):          '); readln(I);
 DRIVE_CHARACTERISTICS[7]:=I;

 write('drive step option (hex!, i.a. 05):                   '); readln(S);
 DRIVE_CHARACTERISTICS[8]:=hexin(S);

 write('sectors per track (1..26, i.a. 17):                  '); readln(I);
 DRIVE_CHARACTERISTICS[9]:=I;
 put_param; (* Parameter in Datei HDPARAM.DAT schreiben *)
end;

procedure param;
var I: integer;
    C: char;
    S: string2;
begin
assign(HDPARAM,'HDPARAM.DAT');
{$I-}reset(HDPARAM);{$I+}
if ioresult<>0 then begin
  writeln('Datei HDPARAM.DAT nicht auf dem Standardlaufwerk gefunden.');
  write('Bitte ESC fuer Abbruch oder ENTER fuer Erzeugen HDPARAM.DAT: ');
  read(kbd,C);
  if C=#$1b then stop('') else writeln;
  get_param;                   (* Parameter von Tastatur lesen    *)
end else begin                 (* Parameter von HDPARAM.DAT lesen *)
  readln(HDPARAM,S);                    (* Portadresse  *)
  PORT_BAS:=hexin(S);
  readln(HDPARAM,I);                    (* Anzahl der Cylinder *)
  DRIVE_CHARACTERISTICS[0]:=I div 256;
  DRIVE_CHARACTERISTICS[1]:=I mod 256;
  readln(HDPARAM,I);                    (* Anzahl der Koepfe *)
  DRIVE_CHARACTERISTICS[2]:=I;
  readln(HDPARAM,I);                    (* RWC *)
  DRIVE_CHARACTERISTICS[3]:=I div 256;
  DRIVE_CHARACTERISTICS[4]:=I mod 256;
  readln(HDPARAM,I);                    (* WP *)
  DRIVE_CHARACTERISTICS[5]:=I div 256;
  DRIVE_CHARACTERISTICS[6]:=I mod 256;
  readln(HDPARAM,I);                    (* ECC length *)
  DRIVE_CHARACTERISTICS[7]:=I;
  readln(HDPARAM,S);                    (* step option *)
  DRIVE_CHARACTERISTICS[8]:=hexin(S);
  readln(HDPARAM,I);                    (* Anzahl Sektoren pro Spur *)
  DRIVE_CHARACTERISTICS[9]:=I;
end;
end;

procedure wait_controller_ready;
var
   STATUS : byte;
   i      : integer;
begin
  i:=0;
  repeat
      STATUS:=PORT[PORT_BAS+1] and 1;
      i:=succ(i);
  until (STATUS=1) or (ERROR and (i>=1000));
  if STATUS<>1 then begin
   writeln('Basis-I/O-Adresse fuer Controller: ',hex(PORT_BAS));
   stop('Controller defekt oder nicht vorhanden, Abbruch!');
  end;
end;

procedure send_comand;
var
  I : byte;
begin
   PORT[PORT_BAS+2]:=0;               { Select OMTI 5510           }
   for I:=0 to 5 do begin             { Uebertragung des Kommandos }
      wait_controller_ready;          { und der fuenf Parameter    }
      PORT[PORT_BAS+0]:=CFARRAY[I];
   end;
end;

procedure read_result;
var
  I : integer;
begin
  for I:=1 to 5 do begin
    wait_controller_ready;
    if I=4 then
      RES[4]:=RES[4]+PORT[PORT_BAS+0]
    else
      RES[I]:=PORT[PORT_BAS+0];
    if I=3 then
      if RES[3] >= 64 then begin
        RES[4]:=(RES[3] div 64)*256;
        RES[3]:=RES[3] mod 64;
      end
      else
        RES[4]:=0;;
  end;
end;

function error_check: boolean;
var   ERR:            boolean;
      STATUS:         byte;
      i:              integer;
begin
  wait_controller_ready;     { Warten bis Kontroller bereit }
  STATUS:=PORT[PORT_BAS+0];  { Jetzt wird der aktuelle      }

  ERR:=false;                { Status gelesen               }
  if STATUS and 2 <> 0 then begin
    CFIELD.COMAND:=3;        { Im Fehlerfall wird mit dem   }
    CFIELD.ADRESS:=0;        { Zustandsanforderung die      }
    CFIELD.SECTOR:=0;        { Fehlerinformation eingelesen }
    CFIELD.TRACK :=0;
    CFIELD.BCOUNT:=0;
    CFIELD.TERMIN:=0;
    send_comand;             { Kommando abschicken          }
    read_result;             { Das Ergebnis lesen           }
    write('Fehler! - status,head,sector,cylinder:');
        for i:=1 to 5 do write(res[i]:5);
    writeln;
    ERR:=true;               { Fehlerflag setzen.           }
  end;
  error_check:=ERR;
end;

procedure set_characteristics (var ERR: boolean);
var I:  integer;
begin
  PORT[PORT_BAS+1]:=0;        { Ausloesen der 'Reset'-Funktion }
  PORT[PORT_BAS+3]:=0;        { Interrupt Maske 0 setzen       }
  for i:=1 to 1000 do; {wait reset}
  ERROR:=true; {mit timeout Ueberwachung fuer Controller}
(*
  if (PORT[PORT_BAS+2] and $F0)=$F0 then begin
                               { Ausfuehrung nur wenn Jumper    }
                               { richtig gesetzt                }
*)
    CFIELD.COMAND:=$C;
    CFIELD.ADRESS:=0;
    CFIELD.SECTOR:=0;
    CFIELD.TRACK :=0;
    CFIELD.TERMIN:=0;
    CFIELD.BCOUNT:=0;
    send_comand;               { Kommando abschicken         }
    for I:=0 to 7 do begin     { Laufwerksinformation an den }
      wait_controller_ready;   { Kontroller senden           }
      PORT[PORT_BAS+0]:=DRIVE_CHARACTERISTICS[I];
    end;
    ERR:=error_check;
(*
  end else
    ERR:=true;
*)
  if ERR then
    stop ('Controller meldet Fehler bei Initialisierung, Abbruch!');

end;

procedure write_hd_sector (CYL,HEAD,SECT: integer; var ERR: boolean);
var     STATUS:     byte;
        I:          integer;
begin
  CFIELD.COMAND:=$A;       { Parameterblock richtig vorbesetzen }
  CFIELD.ADRESS:=HEAD;
  CFIELD.SECTOR:=((CYL div 4) and $C0) + SECT -1;
  CFIELD.TRACK :=CYL mod 256;
  CFIELD.BCOUNT:=1;
  CFIELD.TERMIN:=DRIVE_CHARACTERISTICS[8];
  send_comand;                        { Kommando abschicken     }
  wait_controller_ready;              { Warten auf Startmeldung }
  STATUS:=PORT[PORT_BAS+1];
  if (STATUS and 4) = 0 then begin    { O.K. Uebertragung kann  }
    for I:=0 to 511 do begin          { beginnen                }
      wait_controller_ready;
      PORT[PORT_BAS+0]:=BUFFER[I];
    end;
  end;
  ERR:=error_check;
end;

procedure read_hd_sector (CYL,HEAD,SECT: integer; var ERR: boolean);
var     STATUS:    byte;
        I:         integer;
begin
  CFIELD.COMAND:=$8;        { Parameterblock richtig vorbesetzen }
  CFIELD.ADRESS:=HEAD;
  CFIELD.SECTOR:=((CYL div 4) and $C0) + SECT -1;
  CFIELD.TRACK :=CYL mod 256;
  CFIELD.BCOUNT:=1;
  CFIELD.TERMIN:=DRIVE_CHARACTERISTICS[8];
  send_comand;                         { Kommando abschicken     }
  wait_controller_ready;               { Warten auf Startmeldung }
  STATUS:=PORT[PORT_BAS+1];
  if (STATUS and 4) = 0 then begin     { O.K. Uebertragung kann  }
    for I:=0 to 511 do begin           { beginnen                }
      wait_controller_ready;
      BUFFER[I]:=PORT[PORT_BAS+0];
    end;
  end;

  ERR:=error_check;
end;

procedure fill_sector_buffer (PATTERN: byte; var ERR: boolean);
var     STATUS:     byte;
        I:          integer;
begin                         { Sektorpuffer mit vorgegebenen    }
  CFIELD.COMAND:=$F;          { Daten auffuellen                 }
  CFIELD.ADRESS:=0;
  CFIELD.SECTOR:=0;
  CFIELD.TRACK :=0;
  CFIELD.BCOUNT:=0;
  CFIELD.TERMIN:=0;
  send_comand;                      { Kommando abschicken     }
  wait_controller_ready;            { Warten auf Startmeldung }
  STATUS:=PORT[PORT_BAS+1];
  if (STATUS and 4) = 0 then begin  { O.K.Uebertragung kann   }
    for I:=0 to 511 do begin        { beginnen                }
      wait_controller_ready;
      PORT[PORT_BAS+0]:=PATTERN;
    end;
  end;
  ERR:=error_check;
end;

procedure format_the_drive (SKEW: byte; var ERR: boolean);
begin
  CFIELD.COMAND:=4;
  CFIELD.ADRESS:=0;
  CFIELD.TRACK :=0;
  CFIELD.SECTOR:=0;
  CFIELD.BCOUNT:=SKEW and $1F;
  CFIELD.TERMIN:=DRIVE_CHARACTERISTICS[8] or $C0; {Fehlerwiederholung aus}
  send_comand;
  ERR:=error_check;
end;
      %Ø4h∑]  MOUSE   COM           fåmt   MOUSE   EXE               w   MOV     COM           Tgbz C  