   program hdpark;

   {$U+}
   {$R+}

   {$I HDIO.INC }

   var  ANSW         : char;
        cyl,head,sec : integer;
        i            : integer;
        c            : char;

   begin
     param;
     set_characteristics (ERROR);
     cyl:=DRIVE_CHARACTERISTICS[0]*256+DRIVE_CHARACTERISTICS[1] -1;
     head:=DRIVE_CHARACTERISTICS[2]-1;
     sec:=DRIVE_CHARACTERISTICS[9];
     read_hd_sector(cyl,head,sec,ERROR);
     if ERROR then
       writeln('Parken nicht moeglich!')
     else begin
       writeln ('Hard disk geparkt auf Cyl,Head,Sec',cyl:5,head:2,sec:3);
       writeln ('Rechner ausschalten oder ENTER fuer Fortsetzung druecken');
       readln(c);
     end;
  end.
}£oËEÊFÿÿÍ›ÍÍÍ ÿÍM9CP/M-Partition z. Zt. nur fuer Lau