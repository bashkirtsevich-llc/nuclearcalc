unit SpecFunc;

interface

uses GenTypes;

{----------- Special Functions -----------}
function LegPn(n:integer;x:extended):extended;external 'SpecialFunctionsEXT.dll';
function dLegPn(n:integer;x:extended):extended;external 'SpecialFunctionsEXT.dll';
function d2LegPn(n:integer;x:extended):extended;external 'SpecialFunctionsEXT.dll';
function BesJ0(x:extended):extended;external 'SpecialFunctionsEXT.dll';
function BesY0(x:extended):extended;external 'SpecialFunctionsEXT.dll';
function BesJ1(x:extended):extended;external 'SpecialFunctionsEXT.dll';
function BJ1dx(x:extended):extended;external 'SpecialFunctionsEXT.dll';
function BesY1(x:extended):extended;external 'SpecialFunctionsEXT.dll';
function BesI0(x:extended):extended;external 'SpecialFunctionsEXT.dll';
function BesI1(x:extended):extended;external 'SpecialFunctionsEXT.dll';
function BI1dx(x:extended):extended;external 'SpecialFunctionsEXT.dll';
function BesK0(x:extended):extended;external 'SpecialFunctionsEXT.dll';
function BesK1(x:extended):extended;external 'SpecialFunctionsEXT.dll';
function dBJ0(x:extended):extended;external 'SpecialFunctionsEXT.dll';
function dBY0(x:extended):extended;external 'SpecialFunctionsEXT.dll';
function dBI0(x:extended):extended;external 'SpecialFunctionsEXT.dll';
function dBK0(x:extended):extended;external 'SpecialFunctionsEXT.dll';
function BesJnu(nu,x:extended):extended;external'SpecialFunctionsEXT.dll';
function BesYnu(nu,x:extended):extended;external'SpecialFunctionsEXT.dll';
function BesInu(nu,x:extended):extended;external'SpecialFunctionsEXT.dll';
function BesKnu(nu,x:extended):extended;external'SpecialFunctionsEXT.dll';
function dBJnu(nu,x:extended):extended;external'SpecialFunctionsEXT.dll';
function dBYnu(nu,x:extended):extended;external'SpecialFunctionsEXT.dll';
function dBInu(nu,x:extended):extended;external'SpecialFunctionsEXT.dll';
function dBKnu(nu,x:extended):extended;external'SpecialFunctionsEXT.dll';
function BJnudx(nu,x:extended):extended;external'SpecialFunctionsEXT.dll';
function BInudx(nu,x:extended):extended;external'SpecialFunctionsEXT.dll';
function STDP(n:integer;x,y:extended):extended;external'SpecialFunctionsEXT.dll';
function STDPdxdy(n:integer;x,y:extended):TVec;external'SpecialFunctionsEXT.dll';
function NTDP(n:integer;y,t,ta:extended):extended;external'SpecialFunctionsEXT.dll';
function NTDPdy(n:integer;y,t,ta:extended):extended;external'SpecialFunctionsEXT.dll';
function NTDPdt(n:integer;y,t,ta:extended):extended;external'SpecialFunctionsEXT.dll';
function NTCP(n:integer;r,t,ta:extended):extended;external'SpecialFunctionsEXT.dll';
function NTCPdr(n:integer;r,t,ta:extended):extended;external'SpecialFunctionsEXT.dll';
function NTCPdt(n:integer;r,t,ta:extended):extended;external'SpecialFunctionsEXT.dll';

implementation

end.
