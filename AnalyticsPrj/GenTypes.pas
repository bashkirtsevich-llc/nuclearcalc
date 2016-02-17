unit GenTypes;

interface

Uses Graphics,Math;

{------------- General Types -------------}
CONST MKV=3;
      MKT=MKV*MKV;
TYPE TArray=array of extended;
     TVec=array[1..MKV] of extended;
     TAVec=array of TVec;
     TVArray=array[1..MKV] of TArray;
     TTenz=array[1..MKT] of extended;
     { The tenzor is really represented by vector
       of nine components and the tenzor scheme is
          x  y  z

       x  1  2  3

       y  4  5  6

       z  7  8  9    }
       
     TATenz=array of TTenz;
     TTArray=array[1..MKT] of TArray;
     TIVec=array[1..MKV] of integer;
     TAIVec=array of TIVec;
     TIArray=array of integer;
     TBArray=array of boolean;
     TMatr=array of TArray;
     TIMatr=array of TIArray;
     TAMatr=array of TMatr;
     TBMatr=array of TBArray;
     TSArray=array of string;
     TReport=TSArray;
     TSMatr=array of TSArray;
     TSVec=array[1..MKV] of string;
     TSTenz=array[1..MKT] of string;
     TCArray=array of TColor;
     TCMatr=array of TCArray;
     TACMatr=array of TCMatr;
     TMVec=array of TAVec;
     TAMVec=array of TMVec;
     TMMVec=array of TAMVec;
     TColorName=(cnRed,cnGreen,cnBlue);
     TRGBColor=array[Low(TColorName)..High(TColorName)] of Single;
     TRGBSColor=array[Low(TColorName)..High(TColorName)] of string;
     TRGBArray=array of TRGBColor;
     TRGBMatrix=array of TRGBArray;
     TVariants=array of variant;

CONST VNul:TVec=(0.0,0.0,0.0);
      VNaN:TVec=(NaN,NaN,NaN);
      VNorm:TVec=(1.0,1.0,1.0);
      VOrt1:TVec=(1.0,0.0,0.0);
      VOrt2:TVec=(0.0,1.0,0.0);
      VOrt3:TVec=(0.0,0.0,1.0);
      TNul:TTenz=(0.0,0.0,0.0,
                  0.0,0.0,0.0,
                  0.0,0.0,0.0);
      TNorm:TTenz=(1.0,0.0,0.0,
                   0.0,1.0,0.0,
                   0.0,0.0,1.0);
      TNaN:TTenz=( NaN,0.0,0.0,
                   0.0,NaN,0.0,
                   0.0,0.0,NaN);
      SequenseIVec:TIVec=(1,2,3);
      IVNul:TIVec=(0,0,0);
      SVEmpty:TSVec=('','','');
      SVZero:TSVec=('0','0','0');
      STEmpty:TSTenz=('','','','','','','','','');

VAR VNulVar:TVec = (0.0,0.0,0.0); // To use as VAR parameter
                                  // DO NOT modify this variable at RUNTIME!  

TYPE TVectorComponent=(vcFirst=1,vcSecond=2,vcThird=3);
     TVectorComponents=set of TVectorComponent;
CONST AllVectorComponents:TVectorComponents=[vcFirst,vcSecond,vcThird];

TYPE TInterval=array[0..1] of extended;
CONST NulInterval:TInterval=(0.0,0.0);
      NormInterval:TInterval=(0.0,1.0);
      SymNormInterval:TInterval=(-1.0,1.0);

TYPE TCharArray=array of char;
     TCharSet=set of char;

TYPE TObjectArray=array of TObject;
     TClassArray=array of TClass;

TYPE TAngleUnits=(auRadian,auGrad);

CONST NotAssignedString = '_NAD_';

implementation

end.
