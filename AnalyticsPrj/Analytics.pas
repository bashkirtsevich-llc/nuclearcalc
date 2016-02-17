unit Analytics;

{
  This Unit is created by Sergey L. Gladkiy.

  E-mail : lrndlrnd@mail.ru
}

interface

uses GenTypes, Math,
     Windows;

const MaxConst=3;

TYPE TCalculationType=(ctAnalytical,ctNumerical);

TYPE TVariable=record
     Name:string;
     Value:extended;
     end;{TVariable}

     TVariables=array of TVariable;

TYPE TStrVariable=record
     Name:string;
     Value:string;
     end;{TStrVariable}

     TStrVariables=array of TStrVariable;

TYPE TNamedArray=record
     Name:string;
     mi1:integer;
     A:TArray;
     end;{TNamedArray}

     TNamedMatrix=record
     Name:string;
     mi1,mi2:integer;
     M:TMatr;
     end;{TNamedMatrix}

     TNamedArrays=array of TNamedArray;
     TNamedMatrices=array of TNamedMatrix;

     TStandFunction=(sfNone,
                     sfSin,sfCos,sfTan,sfArcSin,sfArcCos,sfArcTan,
                     sfSinh,sfCosh,sfTanh,sfArcSinh,sfArcCosh,sfArcTanh,
                     sfLn,sfLog,sfExp,sfAbs,sfSign,sfDelta,sfHeaviside,
                     sfRound,sfTrunc,sfFrac,sfNot);
     TBooleanOperator=(boNone,boEqual,boInEqual,boLess,boMore,boAnd,boOr,boXor);
     TNamesSF=array[Low(TStandFunction)..High(TStandFunction)] of string;
     TNamesBO=array[Low(TBooleanOperator)..High(TBooleanOperator)] of string;
     TFormulError=(feNone,feEmpty,feWSign,feLBrckt,feMBrckt,feNotTwice,feUnknown,feUnConstr,fePower,feArgLost,feMoreArg);
     TConstNames=array[0..MaxConst] of string;
     TConstValues=array[0..MaxConst] of extended;

     TSpecialFunction=(spfNone,
                       spfLegendrePn,
                       spfBesJ0,spfBesY0,spfBesJ1,spfBesY1,
                       spfBesI0,spfBesK0,spfBesI1,spfBesK1,
                       spfBesJnu,spfBesYnu,spfBesInu,spfBesKnu);
     TSpecialFunctionNames=array[Low(TSpecialFunction)..High(TSpecialFunction)] of string;
     TSpecialFunctionAttribute=array[Low(TSpecialFunction)..High(TSpecialFunction)] of integer;

 const ArgumentName = '_ARG_';
       DerivativeError = '_DERIVATIVE_ERROR_';
       DerivativeNotAllowedFunction = '_FUNCTION_DERIVATIVE_NOT_ALLOWED_';
       DerivativeUnknown = '_DERIVATIVE_UNKNOWN_';
 const NamesSF:TNamesSF=('NONE',
                         'sin','cos','tan','arcsin','arccos','arctan',
                         'sinh','cosh','tanh','arcsinh','arccosh','arctanh',
                         'ln','log','exp','abs','sign','delta','Heaviside',
                         'round','trunc','frac','not');

       NamesBO:TNamesBO=('BOOLNONE','equal','inequal','less','more','and','or','xor');
       SpecialFunctionNames:TSpecialFunctionNames=('SPECNONE',
                                                   'LegendrePn',
                                                   'BesselJ0','BesselY0','BesselJ1','BesselY1',
                                                   'BesselI0','BesselK0','BesselI1','BesselK1',
                                                   'BesselJ','BesselY','BesselI','BesselK');
       SpecialFunctionParameters:TSpecialFunctionAttribute=(-1,
                                                            2,
                                                            1,1,1,1,
                                                            1,1,1,1,
                                                            2,2,2,2 );

 TYPE TStrFunction=(strNone,strDerivative,strSubstring,strConcatenate,
                    strDelete,strInsert,strReplace);
      TStrFunctionNames=array[Low(TStrFunction)..High(TStrFunction)] of string;

 const StrFunctionNames:TStrFunctionNames=('STRNONE',
                                           'Derivative',
                                           'Substring',
                                           'Concatenate',
                                           'Delete',
                                           'Insert',
                                           'Replace');

 const LeftBrckt='(';
       RightBrckt=')';
       MultSign='*';
       DivSign='/';
       AddSign='+';
       SubsSign='-';
       DegreeName='deg';
       DegreeSep=':';
       PowerOp='^';// Power operator
       BoSep=':';
       SpecFuncSep=':';
       ExpSign:TCharSet=['e','E'];
       WrongChars:TCharSet=[';','!','&','?',' ','%','"','@','#','¹',
                            '>','<','à'..'ÿ','À'..'ß'];
       Digits:TCharSet=['0'..'9'];
       LeftNot:TCharSet=[MultSign,DivSign,PowerOp];
       RightMust:TCharSet=[RightBrckt,MultSign,DivSign,AddSign,SubsSign,PowerOp,BOSep];
       BeforeRightNot:TCharSet=[LeftBrckt,MultSign,DivSign,AddSign,SubsSign,PowerOp];
       CannotBeginWith:TCharSet=[MultSign,DivSign,PowerOp,BOSep];
       CannotEndBy:TCharSet=[MultSign,DivSign,PowerOp,BOSep,AddSign,SubsSign];
       BooleanTrueString = 'true';
       BooleanFalseString = 'false';
       PowerBracketsMustFollow:TCharSet=[MultSign,DivSign,AddSign,SubsSign];
       ConstNames:TConstNames=('Pi','E1',BooleanFalseString,BooleanTrueString);
       ConstValues:TConstValues=(Pi,2.71828182845905,0.0,1.0);
       Dividers:TCharSet=[LeftBrckt,RightBrckt,MultSign,DivSign,
                          AddSign,SubsSign,DegreeSep,BOSep];
       NotTwice:TCharSet=[MultSign,DivSign,AddSign,SubsSign,PowerOp];
 const EmptyBrackets = '()';
       UnitStringChar = '1';
       BracketedUnit = '(1)';
       UnitStringFloat = '1.0';
       BracketedUnitFloat = '(1.0)';
       ZeroStringChar = '0';
       BracketedZero = '(0)';
       ZeroStringFloat = '0.0';
       BracketedZeroFloat = '(0.0)';

 TYPE TOperationType=(otValue,otAlgebraic,otFunction,otSpecFunction,otLogical,otPower);
      TAlgebraicOperation=(aoUnknown,aoSum,aoDifference,aoProduct,aoDivision);
      TValueType=(vtValue,vtConst,vtVariable,vtArray,vtMatrix,vtResult);

      TValue=record
      Typ:TValueType;
      index,index1,index2:integer;
      Value:extended;
      end;{TValue}

      TSpecFuncParams=record
      FuncType:TSpecialFunction;
      indexes:TIArray;
      end;{TSpecFuncParams}

      TFormulaOperation=record
      Typ:TOperationType;
      Algebraic:TAlgebraicOperation;
      Func:TStandFunction;
      SpecFunc:TSpecFuncParams;
      Logical:TBooleanOperator;
      Value:TValue;
      Result:extended;
      end;{TFormulaOperation}

      TFormulaOperations=array of TFormulaOperation;

 TYPE TFormula=record
      Operations:TFormulaOperations;
      Number:integer;
      end;{TFormula}

      TFormulaVec=array[1..MKV] of TFormula;
      TFormulaTenz=array[1..MKT] of TFormula;
      TFormulaArray=array of TFormula;
      TFormulaMatrix=array of TFormulaArray;

CONST NILFormula:TFormula=(Operations:nil; Number:0;);
CONST NILFormulaVec:TFormulaVec=((Operations:nil; Number:0;),
                                 (Operations:nil; Number:0;),
                                 (Operations:nil; Number:0;));
CONST NILFormulaTenz:TFormulaTenz=((Operations:nil; Number:0;),
                                  (Operations:nil; Number:0;),
                                  (Operations:nil; Number:0;),
                                  (Operations:nil; Number:0;),
                                  (Operations:nil; Number:0;),
                                  (Operations:nil; Number:0;),
                                  (Operations:nil; Number:0;),
                                  (Operations:nil; Number:0;),
                                  (Operations:nil; Number:0;));

TYPE TFormulaError=(feNoerror,feEmptyFormula,feWrongSymbol,
                    feRightBracket,feLeftBracket,
                    feSubsequentSymbols,
                    feUnknownFunction,feArgumentLost,
                    feWrongPower,
                    feWrongConstruction);

TYPE TFormulaType=(ftUnknown, ftError,
                   ftValue, ftConst, ftName, ftArrayItem, ftMatrixItem,
                   ftStandardFunction, ftSpecialFunction, ftBoolean, ftPower, ftProduct, ftComposition);
     TFormulaAttributes=record
     TheFormula : string;
     TheType: TFormulaType;
     Error : TFormulError;
     Name : string;
     Index :integer;
     Value : extended;
     TheFunction : TStandFunction;
     Argument : string;
     TheSpecial : TSpecialFunction;
     SpecialArguments : TSArray;
     TheBoolean : TBooleanOperator;
     LOperand, ROperand : string;
     Index1, Index2 : string;
     SubFunctions : TSArray;
     Operators : TCharArray;
     end;{TFormulaAttributes}

CONST NILFormulaAttributes:TFormulaAttributes=(TheFormula : '';
                                               TheType: ftUnknown;
                                               Error : feNone;
                                               Name : '';
                                               Index : -1;
                                               Value : NAN;
                                               TheFunction : sfNone;
                                               Argument : '';
                                               TheSpecial : spfNone;
                                               SpecialArguments : nil;
                                               TheBoolean : boNone;
                                               LOperand : ''; ROperand : '';
                                               Index1 : ''; Index2 : '';
                                               SubFunctions : nil;
                                               Operators : nil;);

 const ParSep:char=';';
       AssignSign='=';
       CycleBW='for';
       CycleEW='endfor';
       CycleNP=4;
       BreakW='break';
       ContinueW='continue';
       ExitW='exit';
       IfBW='if';
       IfEW='endif';
       IfNP=1;
       ElseW='else';
       FLB='(';
       FRB=')';
       FSep=':';
       AILB='[';
       AIRB=']';
       StringQuote='''';
       StrFuncSep:char=':';
       CommentSign='!';
       MacVarContrain='\';
       CaseBegin='caseof';
       CaseEnd='endcase';
       CaseChoice='case';
       CaseElse='elsecase';
       CaseBeginNP=1;

 const MaxOper=5;
 TYPE  TOperNames=array[0..MaxOper] of string;
 const OperNames:TOperNames=     ('Cycle',
                                  'Condition',
                                  'Break',
                                  'Continue',
                                  'Exit',
                                  'Case Of');
       OperConstructions:TOperNames=(
                                     CycleBW+' ; ; ; ;'+#13+#13+CycleEW,
                                     IfBW+' ;'+#13+#13+ElseW+#13+#13+IfEW,
                                     BreakW,ContinueW,ExitW,
                                     CaseBegin+' ;'+#13+CaseChoice+' ;'+#13+#13+CaseElse+#13+#13+CaseEnd);

const FiguresChars:TCharSet=['0'..'9'];
      AllowedNameChars:TCharSet=['_',
                                 '0'..'9',
                                 'a'..'z',
                                 'A'..'Z'];

      AssignArrayOper='Array';
      AssignMatrixOper='Matrix';
      AssignStringOper='String';

TYPE TAssignMode=(amNone,amName,amFormula,amVariable,
                  amAssignArray,amArray,amArrayItem,
                  amAssignMatrix,amMatrix,amMatrixItem,amMatrixRow,amMatrixColumn,
                  amAssignString,amString,amStringFunction);

TYPE TTranslatorParameterType=(tptUnknown, tptVariable, tptArray, tptMatrix, tptString);

TYPE TTranslatorCommand=( tcUnknown,
                          tcExit, tcBreak, tcContinue,
                          tcBeginCycle, tcEndCycle,
                          tcBeginIf,tcElseIf,tcEndIf,
                          tcBeginCase, tcChoiceCase, tcElseCase, tcEndCase,
                          tcFunction,
                          tcSimpleCommand,
                          tcUserCommand
                          );
{-----------------------------------------}
   { TTranslator TYPE begin }

TYPE TStructuredStatement=class;

     TStructuredStatements=array of TStructuredStatement;

     TTranslator=class
     private
     protected
     fMaxVar,fMaxArr,fMaxMatr,fMaxStr:integer;
     fVariables:TVariables;
     fArrays:TNamedArrays;
     fMatrices:TNamedMatrices;
     fStrings:TStrVariables;
     {}
     fStatements:TStructuredStatements;
     {}
     procedure DetMaxVar;
     procedure DetMaxArr;
     procedure DetMaxMatr;
     procedure DetMaxStr;
     procedure DetAllMaxParameters;
     function CheckVariableNum(num:integer):boolean;
     function CheckArrayNum(num:integer):boolean;
     function CheckMatrixNum(num:integer):boolean;
     function CheckStringNum(num:integer):boolean;
     function CheckVariableName(var name:string;var num:integer):boolean;
     function CheckArrayName(var name:string;var num:integer):boolean;
     function CheckMatrixName(var name:string;var num:integer):boolean;
     function CheckNameExists(var name:string;var typ:TTranslatorParameterType):boolean;
     function DeleteButVariable(name:string):boolean;
     function DeleteButArray(name:string):boolean;
     function DeleteButMatrix(name:string):boolean;
     function DeleteButString(name:string):boolean;
     function NewVariable(name,val:string):boolean;
     function NewVariableValue(num:integer;val:string):boolean;
     function NewArray(name,len:string):boolean;
     function NewArrayLength(num:integer;len:string):boolean;
     function NewMatrix(name,len1,len2:string):boolean;
     function NewMatrixSizes(num:integer;len1,len2:string):boolean;
     function NewString(name,val:string):boolean;
     function NewStringValue(num:integer;val:string):boolean;
     function AssignMode(s:string;var name,p1,p2:string;var num:integer):TAssignMode;
     function AssignArrayItemValue(name,index,value:string):boolean;overload;
     function AssignArrayItemValue(num:integer;index,value:string):boolean;overload;
     function AssignArrayValue(name,value:string):boolean;overload;
     function AssignArrayValue(num:integer;value:string):boolean;overload;
     function AssignMatrixItemValue(name,index1,index2,value:string):boolean;overload;
     function AssignMatrixItemValue(num:integer;index1,index2,value:string):boolean;overload;
     function AssignMatrixValue(name,value:string):boolean;overload;
     function AssignMatrixValue(num:integer;value:string):boolean;overload;
     function AssignMatrixRowValue(num:integer;row,value:string):boolean;overload;
     function AssignMatrixRowValue(name,row,value:string):boolean;overload;
     function AssignMatrixColumnValue(num:integer;col,value:string):boolean;overload;
     function AssignMatrixColumnValue(name,col,value:string):boolean;overload;
     function AssignToArray(ln,rn:string):boolean;
     function AssignArrays(ln,rn:integer):boolean;overload;
     function AssignArrays(ln,rn:string):boolean;overload;
     function AssignToMatrix(ln,rn:string):boolean;
     function AssignToMatrixRow(ln,rn,row:string):boolean;
     function AssignToMatrixColumn(ln,rn,col:string):boolean;
     function AssignMatrices(ln,rn:integer):boolean;overload;
     function AssignMatrices(ln,rn:string):boolean;overload;
     function AssignArrayWithMatrixRow(ln,rn:integer;num:string):boolean;overload;
     function AssignArrayWithMatrixRow(ln,rn,num:string):boolean;overload;
     function AssignArrayWithMatrixColumn(ln,rn:integer;num:string):boolean;overload;
     function AssignArrayWithMatrixColumn(ln,rn,num:string):boolean;overload;
     function AssignMatrixRowWithArray(ln,rn:integer;num:string):boolean;overload;
     function AssignMatrixRowWithArray(ln,rn,num:string):boolean;overload;
     function AssignMatrixColumnWithArray(ln,rn:integer;num:string):boolean;overload;
     function AssignMatrixColumnWithArray(ln,rn,num:string):boolean;overload;
     function AssignMatrixRowWithMatrixRow(ln,rn,numl,numr:string):boolean;overload;
     function AssignMatrixColWithMatrixCol(ln,rn,numl,numr:string):boolean;overload;
     function AssignMatrixRowWithMatrixCol(ln,rn,numl,numr:string):boolean;overload;
     function AssignMatrixColWithMatrixRow(ln,rn,numl,numr:string):boolean;overload;

     function TransformStrFunctionParameters(var params:TSArray):boolean;
     function AssignStringFunction(name,fname,params:string):boolean;
     function AssignStrings(left,right:string):boolean;
     function AssignStringToOther(left,right,ln,lp1,lp2:string;lmode:TAssignMode;lnum:integer):boolean;

     function GetVariableNames(index:integer):string;
     function GetVariableValues(index:string):extended;
     procedure SetVariableValues(index:string;value:extended);
     function GetVariablesNumber:integer;
     function GetVariableStringValues(index: string): string;
     procedure SetVariableStringValues(index: string; const Value: string);

     {language procedures}
     class function CommandCase(str:string;var command,params:string):TTranslatorCommand;
     function LastStatement:integer;
     function AddCycle(params:TSArray;bline,eline:integer):boolean;
     function AddIfStatement(params:TSArray;bline,elseline,eline:integer):boolean;
     {language procedures}

     public
     {}
     class function CheckAllowedLength(var len:integer):boolean;
     class procedure SetArrayLength(len:integer;var z:TNamedArray);
     class procedure SetMatrixSizes(len1,len2:integer;var z:TNamedMatrix);
     class function CheckArrayIndex(a:TNamedArray;index:integer):boolean;
     class function CheckMatrixIndexes(m:TNamedMatrix;index1,index2:integer):boolean;
     class procedure AssignArray(source:TNamedArray;setlen:boolean;var res:TNamedArray);
     class procedure AssignMatrix(source:TNamedMatrix;setlen:boolean;var res:TNamedMatrix);
     class procedure AssignArrayWithMatrixRow(source:TNamedMatrix;num:integer;setlen:boolean;var res:TNamedArray);overload;
     class procedure AssignArrayWithMatrixColumn(source:TNamedMatrix;num:integer;setlen:boolean;var res:TNamedArray);overload;
     class procedure AssignMatrixRowWithArray(source:TNamedArray;num:integer;setlen:boolean;var res:TNamedMatrix);overload;
     class procedure AssignMatrixColumnWithArray(source:TNamedArray;num:integer;setlen:boolean;var res:TNamedMatrix);overload;
     class procedure AssignMatrixRowWithMatrixRow(source:TNamedMatrix;nums,numr:integer;setlen:boolean;var res:TNamedMatrix);overload;
     class procedure AssignMatrixColWithMatrixCol(source:TNamedMatrix;nums,numr:integer;setlen:boolean;var res:TNamedMatrix);overload;
     class procedure AssignMatrixRowWithMatrixCol(source:TNamedMatrix;nums,numr:integer;setlen:boolean;var res:TNamedMatrix);overload;
     class procedure AssignMatrixColWithMatrixRow(source:TNamedMatrix;nums,numr:integer;setlen:boolean;var res:TNamedMatrix);overload;
     {}
     constructor Create;
     destructor Destroy;override;
     function VariableExists(var name:string;var num:integer):boolean;
     function ArrayExists(var name:string;var num:integer):boolean;
     function MatrixExists(var name:string;var num:integer):boolean;
     function StringExists(var name:string;var num:integer):boolean;
     function SomethingExists(var name:string;var typ:TTranslatorParameterType;var num:integer):boolean;overload;
     function SomethingExists(var name:string;var typ:TTranslatorParameterType):boolean;overload;
     function AddVariable(name,val:string):boolean;
     function AddVariables(names,vals:TSArray):boolean;
     function AddArray(name,len:string):boolean;
     function AddMatrix(name,len1,len2:string):boolean;
     function AddString(name,val:string):boolean;
     procedure CopyVariablesFlom(source:TTranslator; deleteold:boolean);
     function AddingVariable:boolean;
     function AddingString:boolean;
     function AddingArray:boolean;
     function AddingMatrix:boolean;
     function DeleteVariable(num:integer):boolean;overload;
     function DeleteVariable(name:string):boolean;overload;
     function DeleteArray(num:integer):boolean;overload;
     function DeleteArray(name:string):boolean;overload;
     function DeleteMatrix(num:integer):boolean;overload;
     function DeleteMatrix(name:string):boolean;overload;
     function DeleteString(num:integer):boolean;overload;
     function DeleteString(name:string):boolean;overload;
     function DeleteAnything(name:string):boolean;
     procedure DeleteAllVariables;
     procedure DeleteAllArrays;
     procedure DeleteAllMatrices;
     procedure DeleteAllStrings;
     procedure DeleteEverything;
     function ChangingArrayLength(num:integer):boolean;
     function ChangingMatrixSizes(num:integer):boolean;
     function EditingVariable(num:integer):boolean;
     function EditingString(num:integer):boolean;
     function SetVariableValue(num:integer;value:extended):boolean;overload;
     function SetVariableValue(name:string;value:extended):boolean;overload;
     function SetArrayValues(num:integer;beginindex:integer;values:array of extended):boolean;overload;
     function SetArrayValues(name:string;beginindex:integer;values:array of extended):boolean;overload;
     function SetArrayValues(num:integer;beginindex:integer;values:TArray):boolean;overload;
     function SetArrayValues(name:string;beginindex:integer;values:TArray):boolean;overload;
     function EditingArray(num,n1,n2:integer):boolean;
     function EditingMatrix(num,m1,m2,n1,n2:integer):boolean;
     function Assign(left,right:string;lm,rm:TAssignMode;
                     ln,lp1,lp2,rn,rp1,rp2:string;lnum,rnum:integer):boolean;overload;
     function Assign(left,right:string):boolean;overload;
     function Assign(assstr:string):boolean;overload;
     class function ReadingContinueAsk:boolean;
     class function QueryingContinueAsk:boolean;
     function ReadCommands(var coms:TSArray):boolean;
     function CalculateValue(formula:string):extended;overload;
     function CalculateValue(formula:TSVec):TVec;overload;
     function CalculateValue(formula:TSArray):TArray;overload;
     function CalculateValue(formula:TSMatr):TMatr;overload;
     function CalculateBoolean(formula:string):boolean;overload;
     function ControlFormulaError(formula:string):boolean;overload;
     function ControlFormulaError(formula:TSVec):boolean;overload;
     function ControlFormulaError(formula:TSArray):boolean;overload;
     function ControlFormulaError(formula:TSMatr):boolean;overload;
     function FindError(formula:string;var description:string):boolean;overload;
     function FindError(formula:TSVec;var description:string):boolean;overload;
     function MakeTheFormula(s:string;var formula:TFormula):boolean;overload;
     function MakeTheFormula(s:TSVec;var formula:TFormulaVec):boolean;overload;
     function MakeTheFormula(s:TSTenz;var formula:TFormulaTenz):boolean;overload;
     function MakeTheFormula(s:TSArray;var formula:TFormulaArray):boolean;overload;
     function MakeTheFormula(s:TSMatr;var formula:TFormulaMatrix):boolean;overload;
     function CalculateValue(formula:TFormula):extended;overload;
     function CalculateValue(formula:TFormulaVec):TVec;overload;
     function CalculateValue(formula:TFormulaArray):TArray;overload;
     function CalculateValue(formula:TFormulaMatrix):TMatr;overload;
     function ControlDerivativeFunction(const func:string):boolean;overload;
     function FindErrorInDerivativeFunction(const func:string;var description:string):boolean;overload;
     function Derivative(formula,variable:string;var resformula:string):boolean;overload;
     function Derivative(funcs:TSArray;variable:string;var resfuncs:TSArray):boolean;overload;
     function Derivative(func:TSVec;variable:string;var resfunc:TSVec):boolean;overload;
     function Derivative(func,variable:TSVec;var resfunc:TSTenz):boolean;overload;
     procedure VariablesInfo(var vi:TSArray);
     procedure StringsInfo(var si:TSArray);
     procedure ArraysInfo(var ai:TSArray);
     function ArrayInfo(num:integer;var name:string;var len:integer;var a:TSArray):boolean;
     procedure MatricesInfo(var mi:TSArray);
     function MatrixInfo(num:integer;var name:string;var len1,len2:integer;var m:TSMatr):boolean;

     property VariableNames[index:integer]:string
              read GetVariableNames;
     property VariableValues[index:string]:extended
              read GetVariableValues
              write SetVariableValues;
     property VariableStringValues[index:string]:string
              read GetVariableStringValues
              write SetVariableStringValues;
     property VariablesNumber:integer
              read GetVariablesNumber;
     end;{TTranslator}
   { TTranslator TYPE end   }
{-----------------------------------------}

{---------------------TStructuredStatement Interface begin---------------------}
     TStructuredStatement=class
     protected
     fOwner:TTranslator;
     fBeginLine,fEndLine:integer;
     fCreationError:boolean;
     constructor Create(owner:TTranslator);overload;virtual;
     public
     function BeginStatement:boolean;virtual;
     procedure EndStatement;virtual;
     destructor Destroy;override;
     class function IsItBeginOfCycle(str:string):boolean;
     class function IsItEndOfCycle(str:string):boolean;
     class function IsItBreakStatement(str:string):boolean;
     class function IsItContinueStatement(str:string):boolean;
     class function IsItExitStatement(str:string):boolean;
     class function IsItBeginOfIf(str:string):boolean;
     class function IsItEndOfIf(str:string):boolean;
     class function IsItElseOfIf(str:string):boolean;
     class procedure AddStatement(var stmnts:TStructuredStatements);
     class function DeleteStatement(num:integer;var stmnts:TStructuredStatements):boolean;
     class function DeleteStatements(from_,_to:integer;var stmnts:TStructuredStatements):boolean;overload;
     class function DeleteStatements(from_:integer;var stmnts:TStructuredStatements):boolean;overload;
     class procedure DeleteAllStatements(var stmnts:TStructuredStatements);
     class function LastCycleStatement(stmnts:TStructuredStatements):integer;
     class function LastIfStatement(stmnts:TStructuredStatements):integer;
     class function FindCycle(commands:TSArray;beginpos:integer;
                    var bcycle,ecycle:integer;var error:boolean):boolean;
     class function FindIf(commands:TSArray;beginpos:integer;
                    var bif,eif,elseif:integer;var error:boolean):boolean;
     class function FindCase(commands:TSArray;beginpos:integer;
                    var bcase,ecase,elsecase:integer;
                    var cvalue:string;
                    var cases:TIArray;var cvalues:TSArray;
                    var error:boolean):boolean;
     property CreationError:boolean
              read fCreationError;
     property BeginLine:integer
              read fBeginLine;
     property EndLine:integer
              read fEndLine;
     end;{TStructuredStatement}
{---------------------TStructuredStatement Interface end-----------------------}

{---------------------TForCycle Interface begin--------------------------------}
     TForCycle=class (TStructuredStatement)
     protected
     fParameter:string;
     fBeginValue,fEndValue,fStep:extended;
     fIsOver:boolean;
     procedure DetIsOver;
     function GetCurrentValue:extended;
     procedure SetCurrentValue(val:extended);
     constructor Create(owner:TTranslator);overload;override;
     public
     constructor Create(owner:TTranslator;param:string;bv,ev,stp:string;bline,eline:integer);overload;
     function BeginStatement:boolean;override;
     procedure DoIteration;virtual;
     procedure EndStatement;override;
     destructor Destroy;override;
     property Parameter:string
              read fParameter;
     property BeginValue:extended
              read fBeginValue;
     property EndValue:extended
              read fEndValue;
     property CurrentValue:extended
              read GetCurrentValue
              write SetCurrentValue;
     property IsOver:boolean
              read fIsOver;
     end;{TForCycle}
{---------------------TForCycle Interface end----------------------------------}

{---------------------TIfStatement Interface begin-----------------------------}
     TIfStatement=class (TStructuredStatement)
     protected
     fElseLine:integer;
     fCondition:boolean;
     fElseSection:boolean;
     procedure DetElseSection;
     constructor Create(owner:TTranslator);overload;override;
     public
     constructor Create(owner:TTranslator;expression:string;bline,elseline,eline:integer);overload;
     function BeginStatement:boolean;override;
     procedure EndStatement;override;
     destructor Destroy;override;
     property ElseLine:integer
              read fElseLine;
     property ElseSection:boolean
              read fElseSection;
     property Condition:boolean
              read fCondition;
     end;{TIfStatement}
{---------------------TIfStatement Interface end-------------------------------}

procedure Information(var mfuncs,procs,opers,oconstrs:TSArray);
function DeleteBlanks(var s:string):boolean;
function BooleanValue(const x:extended):boolean;
function RealValue(const b:boolean):extended;
function FormulaValue(formula:string;const vars:TVariables;
                                     const arrs:TNamedArrays;
                                     const matrs:TNamedMatrices):extended;overload;
function FormulaValue(formula:TSVec; const vars:TVariables;
                                     const arrs:TNamedArrays;
                                     const matrs:TNamedMatrices):TVec;overload;
function FormulaBooleanValue(formula:string;const vars:TVariables;
                                            const arrs:TNamedArrays;
                                            const mats:TNamedMatrices):boolean;
function ConstantFormulaValue(formula:string):extended;overload;
function ValueF1(const formula:string;const varn:string;const val:extended):extended;
function ValueF(const formula:string;const varns:array of string;const vals:array of extended):extended;
function SIsEmpty(s:string):boolean;
function ErrorInFormula(const s:string;const vars:TVariables;
                                       const arrs:TNamedArrays;
                                       const matrs:TNamedMatrices;
                        var fe:TFormulError;var es:string):boolean; overload;
function ErrorInFormula(const sv:TSVec;const vars:TVariables;
                                       const arrs:TNamedArrays;
                                       const matrs:TNamedMatrices;
                        var fe:TFormulError;var ef,es:string):boolean; overload;
function FormulaControlE(var formula:string;const vars:TVariables;
                                            const arrs:TNamedArrays;
                                            const mats:TNamedMatrices):boolean;overload;
function FormulaControlE(var formula:TSVec; const vars:TVariables;
                                            const arrs:TNamedArrays;
                                            const mats:TNamedMatrices):boolean;overload;
function FormulaControlE(var formulae:array of string;const vars:TVariables;
                                                      const arrs:TNamedArrays;
                                                      const mats:TNamedMatrices):boolean;overload;
function FormulaControlE(var formula:string;const vars,res:TVariables;
                                            const arrs:TNamedArrays;
                                            const mats:TNamedMatrices ):boolean;overload;
function FindErrorInFormula(var formula:string;const vars:TVariables;
                                               const arrs:TNamedArrays;
                                               const mats:TNamedMatrices;
                            var description:string ):boolean;overload;
function FindErrorInFormula(var formula:TSVec; const vars:TVariables;
                                               const arrs:TNamedArrays;
                                               const mats:TNamedMatrices;
                            var description:string ):boolean;overload;
procedure CreateVars(const varns:array of string;const vals:array of extended;
                    var vars:TVariables);
function FirstWord(var s:string;var fw,ew:string):boolean;
function FindPair(s:string;l,r:char;bi:integer;var li,ri:integer):boolean;overload;
function FindPair(var strs:TSArray;b,e,inter:string;bline,eline:integer;findint:boolean;
                  var bpos,epos:integer;var brest,erest:string; var pairerror:boolean;
                  var intpos:TIArray;var intrests:TSArray):boolean;overload;
function FindPair(var strs:TSArray;b,e:string;bline,eline:integer;
                  var bpos,epos:integer;var brest,erest:string; var pairerror:boolean):boolean;overload;
function ExistVar(const vn:string;const vars:TVariables;var vnum:integer):boolean;
procedure AddVar(const varn:string;const varv:extended;var vars:TVariables);
procedure AddArr(const name:string;const len:integer;var arrs:TNamedArrays);
procedure AddMatr(const name:string;const len1,len2:integer;var matrs:TNamedMatrices);
procedure AddStr(const strn,strv:string;var strs:TStrVariables);
function DelVar(const vn:integer;var vars:TVariables):boolean;
function DelArr(const an:integer;var arrs:TNamedArrays):boolean;
function DelMatr(const mn:integer;var matrs:TNamedMatrices):boolean;
function DelStr(const sn:integer;var strs:TStrVariables):boolean;
procedure MathFunctionsPre(var pres:TSArray);
procedure Evaluate(const res,vars:TVariables;var formula:string);
procedure FormulaeValues(var formulae:array of string;const vars:TVariables;
                          var values:array of extended);
function BooleanConst(b:boolean):string;

function MakeFormula(s:string;const vars:TVariables;
                              const arrs:TNamedArrays;
                              const matrs:TNamedMatrices;
                              var formula:TFormula):boolean;
function FormulaValue(f:TFormula;const vars:TVariables;
                                 const arrs:TNamedArrays;
                                 const matrs:TNamedMatrices):extended;overload;

function Derivative(func,variable:string;var resfunc:string):boolean;overload;
function Derivative(funcs:TSArray;variable:string;var resfuncs:TSArray;var errordescription:string):boolean;overload;
function Derivative(funcs:TSArray;variable:string;var resfuncs:TSArray):boolean;overload;
function Derivative(func:TSVec;variable:string;var resfunc:TSVec):boolean;overload;
function Derivative(func,variable:TSVec;var resfunc:TSTenz):boolean;overload;

function StrFunctionDerivative(params:TSArray;var resfunc:string):boolean;
function StrFunctionSubstring(params:TSArray;var resfunc:string):boolean;
function StrFunctionConcatenate(params:TSArray;var resfunc:string):boolean;
function StrFunction(funcname:string;params:TSArray;var resfunc:string):boolean;

implementation

uses SpecFunc,
     SysUtils,StrUtils,Dialogs;

procedure Information(var mfuncs,procs,opers,oconstrs:TSArray);
var i:integer;
begin
MathFunctionsPre(mfuncs);
setlength(opers,MaxOper+1);
setlength(oconstrs,MaxOper+1);
for i:=0 to MaxOper do begin
opers[i]:=OperNames[i];
oconstrs[i]:=OperConstructions[i];
end;{for i}
end;{Information}

function CInS(const c:char;const s:string):integer;
var i,n:integer;
begin
result:=0;
n:=length(s);
for i:=1 to n do
if s[i]=c then result:=result+1;
end;{CInS}

function WrongCharInS(const s:string;var c:char):boolean;
var i,n:integer;
begin
result:=false;
n:=length(s);
for i:=1 to n do
if (s[i] in WrongChars) then begin
                             result:=true;
                             c:=s[i];
                             break;
                             end;
end;{WrongCharInS}

function Brackets(const s:string;var lp,rp:integer):boolean;
var i,n,nr:integer;
    bl,br:boolean;
begin
n:=length(s);
lp:=-1;
rp:=-1;
bl:=false;
br:=false;
for i:=1 to n do
if s[i]=LeftBrckt then begin
                       bl:=true;
                       lp:=i;
                       break;
                       end;{if}
if bl then  Begin
nr:=0;
for i:=lp+1 to n do begin
if s[i]=RightBrckt then nr:=nr+1
else if s[i]=LeftBrckt then nr:=nr-1;
if nr>0 then begin
             br:=true;
             rp:=i;
             break;
             end;
end;{for i}
End;{if bl}
result:=bl and br;
end;{Brackets}

function DeleteBlanks(var s:string):boolean;
var i,n,k1,k2:integer;
begin
result:=false;
n:=length(s);
if (n=0) then exit;
k1:=0;
k2:=n+1;
for i:=1 to n do
if (s[i]<>' ') then begin
                    k1:=i;
                    break;
                    end;
for i:=n downto 1 do
if (s[i]<>' ') then begin
                    k2:=i;
                    break;
                    end;
if (k1>1)or(k2<n) then begin
                       result:=true;
                       s:=System.Copy(s,k1,k2-k1+1);
                       end{if}
else if (k1=0)and(k2=n+1) then begin
                               s:='';
                               result:=true;
                               end;
end;{DeleteBlanks}

function BracketsError(const s:string;var err:TFormulaError):boolean;overload;
var i,len,rn,ln:integer;
begin
result:=true;
rn:=0;
ln:=0;
len:=Length(s);
err:=feNoerror;
for i:=1 to len do Begin
if s[i]=LeftBrckt then ln:=ln+1
else if s[i]=RightBrckt then rn:=rn+1;
if rn>ln then begin
              err:=feRightBracket;
              exit;
              end;{if}
End;{for i}
if rn<ln then begin
              err:=feLeftBracket;
              exit;
              end;{if}
result:=false;
end;{BracketsError}

function BracketsError(const s:string;var err:TFormulError):boolean;overload;
var e:TFormulaError;
begin
result:=BracketsError(s,e);
if result then
case e of
feLeftBracket:err:=feLBrckt;
feRightBracket:err:=feMBrckt;
end;{case}
end;{BracketsError}

function NotTwiceInS(const s:string;var c:string):boolean;
var i,n:integer;
    c1,c2:char;
    b1,b2:boolean;
begin
result:=false;
n:=length(s);
if n=0 then exit;
c1:=s[1];
b1:=c1 in NotTwice;
for i:=2 to n do begin
c2:=s[i];
b2:=c2 in NotTwice;
if (b1 and b2)
then begin
     c:=c1+c2;
     result:=true;
     exit;
     end;
c1:=c2;
b1:=b2;
end;{for i}
end;{NotTwiceInS}

function SIsAssign(const s:string;var left,right:string):boolean;
var p:integer;
begin
p:=Pos(AssignSign,s);
result:=p>0;
if result then begin
               left:=Copy(s,1,p-1);
               right:=Copy(s,p+1,length(s)-p);
               end;
DeleteBlanks(left);
DeleteBlanks(right);
end;{SIsAssign}

function NameIsAllowed(name:string;var wrong:TCharSet):boolean;
var i:integer;
begin
result:=true;
wrong:=[];
for i:=0 to length(name)-1 do
if not(name[i] in AllowedNameChars) then begin
                                         result:=false;
                                         wrong:=wrong+[name[i]];
                                         end;{if}
end;{NameIsAllowed}

function SIsArrayIndex(const s:string;var index:string):boolean;
var n,li,ri:integer;
begin
result:=false;
index:='';
n:=length(s);
if ((n<2)or( not FindPair(s,AILB,AIRB,1,li,ri)))  then exit;
result:=(li=1)and(ri=n);
if result then index:=Copy(s,2,n-2);
end;{SIsArrayIndex}

function SIsMatrixIndex(const s:string;var index1,index2:string):boolean;
var n,li1,ri1,li2,ri2:integer;
begin
result:=false;
index1:='';
index2:='';
li1:=0;
li2:=0;
ri1:=0;
ri2:=0;
n:=length(s);
if ((n<4)or( not FindPair(s,AILB,AIRB,1,li1,ri1))
         or( not FindPair(s,AILB,AIRB,ri1+1,li2,ri2)))  then exit;
result:=(li1=1)and(ri1=(li2-1))and(ri2=n);
if result then begin
               index1:=Copy(s,2,ri1-li1-1);
               index2:=Copy(s,li2+1,ri2-li2-1);
               end;{if}
end;{SIsMatrixIndex}

function SIsStringConst(s:string;var value:string):boolean;
var len:integer;
begin
len:=Length(s);
value:='';
if len=0 then begin
              result:=false;
              exit;
              end;{0}
result:=(s[1]=StringQuote)and(s[len]=StringQuote);
if result then value:=Copy(s,2,len-2);
end;{SIsStringConst}

function SIsStringParam(s:string;var value:string):boolean;
var len:integer;
begin
len:=Length(s);
value:='';
if len=0 then begin
              result:=false;
              exit;
              end;{0}
result:=(s[1]=LeftBrckt)and(s[len]=RightBrckt);
if result then begin
               s:=Copy(s,2,len-2);
               result:=SIsStringConst(s,value);
               end;{if}
end;{SIsStringParam}

function SelectAllowedName(s:string;var name,rest:string):boolean;
var n,i,k1,k2:integer;
begin
result:=false;
name:='';
rest:='';
n:=length(s);
if (n=0) then exit;
k1:=-1;
k2:=-1;
for i:=1 to n do
if (s[i] in AllowedNameChars) then begin
                                   k1:=i;
                                   break;
                                   end;{if}
if (k1=n) then k2:=n
else
for i:=k1+1 to n do
if not(s[i] in AllowedNameChars) then begin
                                      k2:=i-1;
                                      break;
                                      end;{if}
if (k2<0) then k2:=n;                                      
if (k1<0) then exit;
name:=Copy(s,k1,k2-k1+1);
rest:=Copy(s,k2+1,n+1-k2);
result:=true;
end;{SelectAllowedName}

function SIsOfFunctionForm(s:string;var func,arg:string):boolean;
var lp,rp,l:integer;
begin
result:=false;
func:='';
arg:='';
if    (length(s)<>0)
   and(s[1] in AllowedNameChars)
   and(SelectAllowedName(s,func,arg))
then Begin
l:=Length(arg);
result:=Brackets(arg,lp,rp) and (lp=1) and (rp=l);
if result then arg:=copy(arg,2,l-2);
End;{if}
end;{SIsOfFunctionForm}

function FirstWord(var s:string;var fw,ew:string):boolean;
var n,i,k1,k2:integer;
begin
result:=false;
n:=length(s);
fw:='';
ew:='';
if (n=0) then exit;
k1:=-1;
k2:=-1;
for i:=1 to n do
if (s[i] in AllowedNameChars) then begin
                                   k1:=i;
                                   break;
                                   end;{if}
if (k1=n) then k2:=n
else
for i:=k1+1 to n do
if not(s[i] in AllowedNameChars) then begin
                                      k2:=i-1;
                                      break;
                                      end;{if}
if (k2<0) then k2:=n;
if (k1<0) then exit;
fw:=Copy(s,k1,k2-k1+1);
ew:=Copy(s,k2+1,n+1-k2);
result:=true;
end;{FirstWord}

function FindPair(s:string;l,r:char;bi:integer;var li,ri:integer):boolean;
var i,n:integer;
    ls,rs:integer;
begin
result:=false;
li:=-1;
ri:=-1;
n:=length(s);
ls:=0;
rs:=0;
for i:=bi to n do BEGIN
if (s[i]=l) then begin
                 ls:=ls+1;
                 if (ls=1) then li:=i;
                 end{if l}
else
if (s[i]=r) then begin
                 rs:=rs+1;
                 if (rs>ls) then exit;
                 if (rs=ls) then begin
                                 ri:=i;
                                 result:=true;
                                 exit;
                                 end;{if =}
                 end;{if r}
END;{for i}
end;{FindPair}

procedure AddItem(item:integer;var A:TIArray);overload;
var n:integer;
begin
n:=length(A);
setlength(A,n+1);
A[n]:=item;
end;{AddItem}

procedure AddItem(item:string;var A:TSArray);overload;
var n:integer;
begin
n:=length(A);
setlength(A,n+1);
A[n]:=item;
end;{AddItem}

function FindPair(var strs:TSArray;b,e,inter:string;bline,eline:integer;findint:boolean;
                  var bpos,epos:integer;var brest,erest:string; var pairerror:boolean;
                  var intpos:TIArray;var intrests:TSArray):boolean;overload;
var i,j,bn,en:integer;
    str,rest:string;
begin
FreeMemory(intrests);
FreeMemory(intpos);
bpos:=-1;
epos:=-1;
result:=false;
pairerror:=false;
brest:='';
erest:='';
bn:=0;
en:=0;
for i:=bline to eline do Begin
FirstWord(strs[i],str,rest);
if (str=b) then Begin
bn:=1;
bpos:=i;
brest:=rest;
for j:=i+1 to eline do begin
FirstWord(strs[j],str,rest);
if (str=b) then bn:=bn+1
else if (str=e) then en:=en+1
else begin
     if ( findint and(str=inter) and (bn=1) )
        then begin
             AddItem(j,intpos);
             AddItem(rest,intrests);
             end;{if}
     end;{else}
if (en=bn) then begin
                epos:=j;
                erest:=rest;
                result:=true;
                break;
                end;
end;{for j}
End;{if }
if result then break;
End;{for i}
if (bn<>en) then pairerror:=true;
end;{FindPair}

function FindPair(var strs:TSArray;b,e:string;bline,eline:integer;
                  var bpos,epos:integer;var brest,erest:string;var pairerror:boolean):boolean;overload;
var i,j,bn,en:integer;
    str,rest:string;
begin
bpos:=-1;
epos:=-1;
result:=false;
pairerror:=false;
brest:='';
erest:='';
bn:=0;
en:=0;
for i:=bline to eline do Begin
FirstWord(strs[i],str,rest);
if (str=b) then Begin
bn:=1;
bpos:=i;
brest:=rest;
for j:=i+1 to eline do begin
FirstWord(strs[j],str,rest);
if (str=b) then bn:=bn+1
else if (str=e) then en:=en+1;
if (en=bn) then begin
                epos:=j;
                erest:=rest;
                result:=true;
                break;
                end;
end;{for j}
End;{if }
if result then break;
End;{for i}
if (bn<>en) then pairerror:=true;
end;{FindPair}

function DetParameters(ps:string;const sep:string;var prms:TSArray):integer;
var i,n,n1,len,k:integer;
begin
result:=0;
FreeMemory(prms);
n:=length(ps);
n1:=1;
k:=-1;
for i:=1 to n do Begin
len:=-1;
if (ps[i]=Sep) then len:=i-n1
else if i=n then len:=i-n1+1;
if len>=0 then begin
               k:=length(prms);
               setlength(prms,k+1);
               prms[k]:=copy(ps,n1,len);
               n1:=i+1;
               end;
End;{for i}
result:=k+1;
end;{DetParameters}

function ExistVar(const vn:string;const vars:TVariables;var vnum:integer):boolean;
var i,n:integer;
begin
result:=false;
n:=length(vars)-1;
for i:=0 to n do
if vars[i].Name=vn then begin
                        result:=true;
                        vnum:=i;
                        exit;
                        end;
end;{ExistVar}

function ExistArr(const an:string;const ars:TNamedArrays;var anum:integer):boolean;
var i,n:integer;
begin
result:=false;
n:=length(ars)-1;
for i:=0 to n do
if (ars[i].Name=an) then begin
                         result:=true;
                         anum:=i;
                         exit;
                         end;
end;{ExistArr}

function ExistMatr(const mn:string;const matrs:TNamedMatrices;var mnum:integer):boolean;
var i,n:integer;
begin
result:=false;
n:=length(matrs)-1;
for i:=0 to n do
if (matrs[i].Name=mn) then begin
                           result:=true;
                           mnum:=i;
                           exit;
                           end;
end;{ExistMatr}

function ExistStr(const sn:string;const strs:TStrVariables;var snum:integer):boolean;
var i,n:integer;
begin
result:=false;
n:=length(strs)-1;
for i:=0 to n do
if (strs[i].Name=sn) then begin
                          result:=true;
                          snum:=i;
                          exit;
                          end;
end;{ExistStr}

function SIsVar(const s:string;const vars:TVariables;var v:TVariable;var num:integer):boolean;overload;
var i,n:integer;
begin
result:=false;
num:=-1;
n:=length(vars)-1;
for i:=0 to n do
if vars[i].Name=s then begin
                  v:=vars[i];
                  result:=true;
                  num:=i;
                  break;
                  end;
end;{SIsVar}

function SIsVar(const s:string;const vars:TVariables;var v:TVariable):boolean;overload;
var num:integer;
begin
result:=SIsVar(s,vars,v,num);
end;{SIsVar}

function SIsVar(const s:string;const vars:TVariables;var num:integer):boolean;overload;
var v:TVariable;
begin
result:=SIsVar(s,vars,v,num);
end;{SIsVar}

function SIsVar(const s:string):boolean;overload;
var name,rest : string;
begin
result:=    SelectAllowedName(s,name,rest)
        and (name=s)
        and (rest='');
end;{SIsVar}

function SIsArrayItem(const s:string;const arrs:TNamedArrays;
                      var a:TNamedArray;var index:string;var num:integer):boolean;overload;
var name,rest:string;
begin
result:=false;
if (not SelectAllowedName(s,name,rest)) then exit;
result:=( ExistArr(name,arrs,num)
         and SIsArrayIndex(rest,index) );
if result then a:=arrs[num];
end;{SIsArrayItem}

function SIsArrayItem(const s:string;const arrs:TNamedArrays;
                      var a:TNamedArray;var index:string):boolean;overload;
var num:integer;
begin
Result:=SIsArrayItem(s,arrs,a,index,num);
end;{SIsArrayItem}

function SIsArrayItem(const s:string;const arrs:TNamedArrays;
                      var index:string;var num:integer):boolean;overload;
var a:TNamedArray;
begin
Result:=SIsArrayItem(s,arrs,a,index,num);
end;{SIsArrayItem}

function SIsArrayItem(const s:string; var name,index:string):boolean;overload;
var rest:string;
begin
index:='';
result:=    SelectAllowedName(s,name,rest)
        and SIsArrayIndex(rest,index) ;
end;{SIsArrayItem}

function SIsMatrixItem(const s:string;const matrs:TNamedMatrices;
                       var m:TNamedMatrix;var index1,index2:string;var num:integer):boolean;overload;
var name,rest:string;
begin
result:=false;
if (not SelectAllowedName(s,name,rest)) then exit;
result:=( ExistMatr(name,matrs,num)
         and SIsMatrixIndex(rest,index1,index2) );
if result then m:=matrs[num];
end;{SIsMatrixItem}

function SIsMatrixItem(const s:string;const matrs:TNamedMatrices;
                       var m:TNamedMatrix;var index1,index2:string):boolean;overload;
var num:integer;
begin
result:=SIsMatrixItem(s,matrs,m,index1,index2,num);
end;{SIsMatrixItem}

function SIsMatrixItem(const s:string;const matrs:TNamedMatrices;
                       var index1,index2:string;var num:integer):boolean;overload;
var m:TNamedMatrix;
begin
result:=SIsMatrixItem(s,matrs,m,index1,index2,num);
end;{SIsMatrixItem}

function SIsMatrixItem(const s:string; var name,index1,index2:string):boolean;overload;
var rest:string;
begin
result:=    SelectAllowedName(s,name,rest)
        and SIsMatrixIndex(rest,index1,index2) ;
end;{SIsMatrixItem}

function ArrayItemValue(a:TNamedArray;index:integer):extended;
begin
if TTranslator.CheckArrayIndex(a,index)
then result:=NAN
else result:=a.A[index];
end;{ArrayItemValue}

function MatrixItemValue(M:TNamedMatrix;index1,index2:integer):extended;
begin
if TTranslator.CheckMatrixIndexes(m,index1,index2)
then result:=NAN
else result:=m.M[index1,index2];
end;{MatrixItemValue}

function SIsReal(const s:string;var value:extended):boolean;
begin
value:=0;
try
value:=StrToFloat(s);
result:=true;
except
{on EConvertError do }result:=false;
end;{except}
end;{SIsReal}

function SIsConst(const s:string;var val:extended;var index:integer):boolean;overload;
var i:integer;
begin
result:=false;
index:=-1;
for i:=0 to MaxConst do
if s=ConstNames[i] then begin
                        result:=true;
                        val:=ConstValues[i];
                        index:=i;
                        exit;
                        end;
end;{SIsConst}

function SIsConst(const s:string;var val:extended):boolean;overload;
var index:integer;
begin
result:=SIsConst(s,val,index);
end;{SIsConst}

function SIsSFName(const s:string;var sft:TStandFunction):boolean;
var sf:TStandFunction;
begin
result:=false;
sft:=sfNone;
for sf:=Low(TStandFunction) to High(TStandFunction) do
if s=NamesSF[sf] then begin
                      result:=true;
                      sft:=sf;
                      break;
                      end;
end;{SIsSFName}

function SIsSpecFName(const s:string;var spft:TSpecialFunction):boolean;
var sf:TSpecialFunction;
begin
result:=false;
spft:=spfNone;
for sf:=Low(TSpecialFunction) to High(TSpecialFunction) do
if s=SpecialFunctionNames[sf] then begin
                                   result:=true;
                                   spft:=sf;
                                   break;
                                   end;
end;{SIsSpecFName}

function SIsStrFName(const s:string;var strf:TStrFunction):boolean;overload;
var sf:TStrFunction;
begin
result:=false;
for sf:=Low(TStrFunction) to High(TStrFunction) do
if s=StrFunctionNames[sf] then begin
                               result:=true;
                               strf:=sf;
                               break;
                               end;
end;{SIsStrFName}

function SIsStrFName(const s:string):boolean;overload;
var strf:TStrFunction;
begin
result:=SIsStrFName(s,strf);
end;{SIsStrFName}

function SIsBOName(const s:string;var bot:TBooleanOperator):boolean;
var bo:TBooleanOperator;
begin
result:=false;
for bo:=Low(TBooleanOperator) to High(TBooleanOperator) do
if s=NamesBO[bo] then begin
                      result:=true;
                      bot:=bo;
                      break;
                      end;
end;{SIsBOName}

function SIsSF(const s:string;var stf:TStandFunction; var name,subs:string):boolean;overload;
begin
name:='';
subs:='';
stf:=sfNone;
result:=SIsOfFunctionForm(s,name,subs);
if not result then exit;
result:=SIsSFName(name,stf);
end;{SIsSF}

function SIsSF(const s:string;var stf:TStandFunction; var subs:string):boolean;overload;
var name:string;
begin
result:=SIsSf(s,stf,name,subs);
end;{SIsSF}

function SIsSpecF(const s:string;var spf:TSpecialFunction; var name,subs:string):boolean;overload;
begin
name:='';
subs:='';
spf:=spfNone;
result:=SIsOfFunctionForm(s,name,subs);
if not result then exit;
result:=SIsSpecFName(name,spf);
end;{SIsSpecF}

function SIsSpecF(const s:string;var spf:TSpecialFunction; var subs:string):boolean;overload;
var name:string;
begin
result:=SIsSpecF(s,spf,name,subs);
end;{SIsSpecF}

function SIsStrF(const s:string;var strf:TStrFunction; var name,subs:string):boolean;overload;
begin
result:=SIsOfFunctionForm(s,name,subs);
if not result then exit;
result:=SIsStrFName(name,strf);
end;{SIsStrF}

function SIsStrF(const s:string;var strf:TStrFunction; var subs:string):boolean;overload;
var name:string;
begin
result:=SIsStrF(s,strf,name,subs);
end;{SIsStrF}

function BrcktsSpcDelete(var s:string):boolean;
var i,n,nr,nl:integer;
    b:boolean;
begin
result:=false;
n:=length(s);
if (n=0) then exit;
b:=false;
if (s[1]=LeftBrckt)then begin
nr:=0; b:=true;
for i:=2 to n-1 do begin
if s[i]=RightBrckt then nr:=nr+1
else if s[i]=LeftBrckt then nr:=nr-1;
if nr>0 then begin
             b:=false;
             break;
             end;
end;{for }
end;{if}
if b then begin
          s:=copy(s,2,n-2);
          result:=true;
          n:=length(s);
          end;
nl:=1; nr:=n;
for i:=1 to n do
if s[i]<>' ' then begin
                  nl:=i;
                  break;
                  end;
for i:=n downto 1 do
if s[i]<>' ' then begin
                  nr:=i;
                  break;
                  end;
if (nl<>1)or(nr<>n)then begin
                        s:=Copy(s,nl,nr-nl+1);
                        result:=true;
                        end;{if}
end;{BrcktsSpcDelete}

function DeleteAllSuperfluousBracketsAndBlanks(var func:string):boolean;
begin
repeat
result:=BrcktsSpcDelete(func);
result:=result or DeleteBlanks(func);
until (not result);
end;{DeleteAllSuperfluousBracketsAndBlanks}

procedure DivideFormula(const formula:string;var ss:TSArray;
                        var nn,counts:TIArray);
var i,n,len,n1,count:integer;
    s:string;
    b,b1:boolean;
begin
s:=formula;
//BrcktsSpcDelete(s);
n:=length(s);
ss:=nil;
nn:=nil;
counts:=nil;
len:=0;
n1:=0;
for i:=1 to n do begin
count:=i-n1-1;
b:=s[i] in Dividers;
b1:=(s[i-1] in ExpSign)and(s[i-2] in Digits);
if (b)and(count>0)and(not b1) then begin
len:=len+1;
setlength(ss,len);
ss[len-1]:=Copy(s,n1+1,count);
setlength(nn,len);
setlength(counts,len);
nn[len-1]:=n1+1;
counts[len-1]:=count;
n1:=i;
end
else if (b and (not b1)) then n1:=i;
end;{for i}
if n1<n then begin
             setlength(ss,len+1);
             setlength(nn,len+1);
             setlength(counts,len+1);
             ss[len]:=Copy(s,n1+1,n-n1);
             nn[len]:=n1+1;
             counts[len]:=n-n1;
             end;
end;{DivideFormula}

function Delta(const x:extended):extended;
begin
if x=0 then result:=1
else result:=0;
end;{Delta}

function Heaviside(const x:extended):extended;
begin
if x>=0 then result:=1
else result:=0;
end;{Heaviside}

function BooleanValue(const x:extended):boolean;
begin
result:=(x>=1);
end;{BooleanValue}

function RealValue(const b:boolean):extended;
begin
result:=Ord(b);
end;{RealValue}

function RealNot(const x:extended):extended;
begin
result:=RealValue(not BooleanValue(x));
end;{RealNot}

function RealLess(const xl,xr:extended):extended;
begin
result:=RealValue(xl<xr);
end;{RealLess}

function RealMore(const xl,xr:extended):extended;
begin
result:=RealValue(xl>xr);
end;{RealMore}

function RealEquality(const xl,xr:extended):extended;
begin
result:=RealValue(xl=xr);
end;{RealEquality}

function RealInEquality(const xl,xr:extended):extended;
begin
result:=RealValue(xl<>xr);
end;{RealInEquality}

function RealOr(const xl,xr:extended):extended;
begin
result:=RealValue((BooleanValue(xl))or(BooleanValue(xr)));
end;{RealOr}

function RealAnd(const xl,xr:extended):extended;
begin
result:=RealValue((BooleanValue(xl))and(BooleanValue(xr)));
end;{RealAnd}

function RealXor(const xl,xr:extended):extended;
begin
result:=RealValue((BooleanValue(xl))xor(BooleanValue(xr)));
end;{RealXor}

function StandFunction(const sf:TStandFunction;const x:extended):extended;
begin
case sf of
sfSin:result:=sin(x);
sfCos:result:=cos(x);
sfTan:result:=tan(x);
sfArcSin:result:=Arcsin(x);
sfArcCos:result:=Arccos(x);
sfArcTan:result:=ArcTan(x);
sfSinh:result:=sinh(x);
sfCosh:result:=cosh(x);
sfTanh:result:=tanh(x);
sfArcSinh:result:=arcsinh(x);
sfArcCosh:result:=arccosh(x);
sfArcTanh:result:=arctanh(x);
sfLn:result:=ln(x);
sfLog:result:=log10(x);
sfExp:result:=exp(x);
sfAbs:result:=abs(x);
sfSign:result:=sign(x);
sfDelta:result:=Delta(x);
sfHeaviside:result:=Heaviside(x);
sfRound:result:=round(x);
sfTrunc:result:=trunc(x);
sfFrac:result:=frac(x);
sfNot:result:=RealNot(x);
else result:=0.0;
end;{case}
end;{StandFunction}

function BOValue(const xl,xr:extended;const bo:TBooleanOperator):extended;
begin
case bo of
boEqual:result:=RealEquality(xl,xr);
boInEqual:result:=RealInEquality(xl,xr);
boLess:result:=RealLess(xl,xr);
boMore:result:=RealMore(xl,xr);
boAnd:result:=RealAnd(xl,xr);
boOr:result:=RealOr(xl,xr);
boXor:result:=RealXor(xl,xr);
else result:=0;
end;{case bo}
end;{BOValue}

function SpecialFunction(const spf:TSpecialFunction;p,x:extended):extended;
var n:integer;
begin
case spf of
spfLegendrePn:begin
              n:=trunc(p);
              result:=LegPn(n,x);
              end;{spfLegendrePn}
spfBesJ0: result:=BesJ0(x);
spfBesY0: result:=BesY0(x);
spfBesI0: result:=BesI0(x);
spfBesK0: result:=BesK0(x);
spfBesJ1: result:=BesJ1(x);
spfBesY1: result:=BesY1(x);
spfBesI1: result:=BesI1(x);
spfBesK1: result:=BesK1(x);
spfBesJnu: result:=BesJnu(p,x);
spfBesYnu: result:=BesYnu(p,x);
spfBesInu: result:=BesInu(p,x);
spfBesKnu: result:=BesKnu(p,x);
else result:=0.0;
end;{case}
end;{SpecialFunction}

function RIsInt(const x:extended;var int:integer):boolean;
begin
int:=round(x);
result:=(int=x);
end;{RIsInt}

function Degree(const x,d:extended):extended;
var n,i:integer;
begin
if x=0.0 then begin
              if d=0.0 then result:=1
              else result:=0.0
              end{x=0}
else if x<0 then begin
                 if RIsInt(d,n) then begin
                 result:=1;
                 if n<0 then for i:=-1 downto n do result:=result/x
                 else for i:=1 to n do result:=result*x;
                 end{RIsInt}
                 else result:=NaN;
                 end{x<0}
     else result:=exp(d*ln(x));
end;{Degree}

function FirstPos(const s:string;const c:char):integer;
var i,n,nr:integer;
begin
result:=-1;
n:=length(s);
nr:=-1;
for i:=1 to n do
if (s[i]=c)and(nr=0)then begin
                         result:=i;
                         exit;
                         end
else begin
     if s[i]=LeftBrckt then nr:=nr+1
     else if s[i]=RightBrckt then nr:=nr-1;
     end;{else}
end;{FirstPos}

function FirstFreePos(const s:string;const c:char):integer;
var i,n,nr:integer;
begin
result:=-1;
n:=length(s);
nr:=-1;
for i:=1 to n do Begin
if (s[i]=c)and(nr=-1)then begin
                          result:=i;
                          exit;
                          end{if}
else begin
     if s[i]=LeftBrckt then nr:=nr+1
     else if s[i]=RightBrckt then nr:=nr-1;
     end;{else}
if (nr<-1) then exit;
End;{for i}
end;{FirstFreePos}

function SIsDeg(const s:string;var name,sx,sd:string):boolean;overload;
var lp,rp,n,sp:integer;
begin
n:=length(s);
result:=false;
name:='';
sx:='';
sd:='';
if ((Brackets(s,lp,rp))and(rp=n)) then begin
name:=Copy(s,1,lp-1);
if (name=DegreeName) then begin
result:=true;
sp:=FirstPos(s,DegreeSep);
if (sp>0) then begin
sx:=Copy(s,lp+1,sp-lp-1);
sd:=Copy(s,sp+1,rp-sp-1);
result:=true;
end{sp}
else Begin
     sx:=Copy(s,lp+1,rp-lp-1);
     sd:='';
     End;{else}
end;{s1=DegreeName}
end;{if}
end;{SIsDeg}

function SIsDeg(const s:string;var sx,sd:string):boolean;overload;
var name:string;
begin
result:=SIsDeg(s,name,sx,sd);
end;{SIsDeg}

// Power is the function of form ( argument )^( power )
// Brackets are obligatory.
function FuncIsPower(const func:string;var name,arg,pow:string):boolean;overload;
var pop,len,lp,rp:integer;
begin
result:=false;
name:='';
arg:='';
pow:='';
pop:=FirstFreePos(func,PowerOp);
if (pop<0) then exit;
name:=PowerOp;
arg:=copy(func,1,pop-1);
if (not Brackets(arg,lp,rp))or(lp<>1)or(rp<>Length(arg)) then exit
else arg:=copy(arg,2,Length(arg)-2);
len:=length(func);
pow:=copy(func,pop+1,len-pop);
if (not Brackets(pow,lp,rp))or(lp<>1)or(rp<>Length(pow)) then exit
else pow:=copy(pow,2,Length(pow)-2);
result:=true;
end;{FuncIsPower}

function FuncIsPower(const func:string;var arg,pow:string):boolean;overload;
var name:string;
begin
result:=FuncIsPower(func,name,arg,pow);
end;{FuncIsPower}

function SIsBO(name,arg:string;var bot:TBooleanOperator;sxl,sxr:string):boolean;overload;
var sp:integer;
begin
result:=false;
bot:=boNone;
sxl:='';
sxr:='';
sp:=FirstFreePos(arg,BOSep);
if (sp>0)and(SIsBOName(name,bot)) then begin
sxl:=Copy(arg,1,sp-1);
sxr:=Copy(arg,sp+1,length(arg)-sp);
result:=true;
end;{if}
end;{SIsBO}

function SIsBO(const s:string;var bot:TBooleanOperator;var name,sxl,sxr:string):boolean;overload;
var arg:string;
begin
name:='';
sxl:='';
sxr:='';
result:=SIsOfFunctionForm(s,name,arg);
if not result then exit;
result:=SIsBO(name,arg,bot,sxl,sxr);
end;{SIsBO}

function SIsBO(const s:string;var bot:TBooleanOperator;var sxl,sxr:string):boolean;overload;
var name:string;
begin
result:=SIsBO(s,bot,name,sxl,sxr);
end;{SIsBO}

function SIsMultFunc(const s:string):boolean;
var i,n,nb:integer;
begin
result:=true;
n:=length(s);
nb:=0;
for i:=1 to n do begin
if s[i]=LeftBrckt then nb:=nb+1;
if s[i]=RightBrckt then nb:=nb-1;
if ((s[i]=AddSign)or(s[i]=SubsSign))and(nb=0)and(not(s[i-1] in ExpSign))
then begin
     result:=false;
     break;
     end;{if}
end;{for i}
end;{SIsMultFunc}

procedure DeFact(const s:string;var fa:TSArray;var sa:TCharArray);
var i,n,nb,ns,nf:integer;
begin
fa:=nil;
sa:=nil;
nf:=0;
n:=length(s);
nb:=0;
ns:=1;
for i:=1 to n do begin
if s[i]=LeftBrckt then nb:=nb+1;
if s[i]=RightBrckt then nb:=nb-1;
if ((s[i]=MultSign)or(s[i]=DivSign))and(nb=0)then
Begin
nf:=nf+1;
setlength(fa,nf);
setlength(sa,nf);
sa[nf-1]:=s[i];
fa[nf-1]:=Copy(s,ns,i-ns);
ns:=i+1;
End{if}
else if i=n then begin
                 nf:=nf+1;
                 setlength(fa,nf);
                 fa[nf-1]:=Copy(s,ns,i-ns+1);
                 end;
end;{for i}
end;{DeFact}

procedure DeCompose(const s:string;var ca:TSArray;var sa:TCharArray);
var i,i1,n,nb,ns,nf:integer;
    c:char;
begin
ca:=nil;
sa:=nil;
nf:=0;
n:=length(s);
if n=0 then exit;

if (s[1]=SubsSign)or(s[1]=AddSign) then begin
                                        c:=s[1];
                                        i1:=2;
                                        end
else begin
     c:=AddSign;
     i1:=1;
     end;
setlength(sa,1);
sa[0]:=c;
nb:=0;
ns:=i1;
for i:=i1 to n do begin
if s[i]=LeftBrckt then nb:=nb+1;
if s[i]=RightBrckt then nb:=nb-1;
if ((s[i]=AddSign)or(s[i]=SubsSign))and(nb=0)
and(not((s[i-1] in ExpSign)and(s[i-2] in Digits)))then
Begin
nf:=nf+1;
setlength(ca,nf);
setlength(sa,nf+1);
sa[nf]:=s[i];
ca[nf-1]:=Copy(s,ns,i-ns);
ns:=i+1;
End{if}
else if i=n then begin
                 nf:=nf+1;
                 setlength(ca,nf);
                 ca[nf-1]:=Copy(s,ns,i-ns+1);
                 end;
end;{for i}
end;{DeCompose}

function Factor(const s:string;vars:TVariables;
                               arrs:TNamedArrays;
                               mats:TNamedMatrices):extended;overload;forward;
function Factor(fa:TSArray;sa:TCharArray;
                vars:TVariables;
                arrs:TNamedArrays;
                mats:TNamedMatrices):extended;overload;forward;
function Composition(const s:string;vars:TVariables;
                                    arrs:TNamedArrays;
                                    mats:TNamedMatrices):extended;overload;forward;
function Composition(ca:TSArray;sa:TCharArray;
                     vars:TVariables;
                     arrs:TNamedArrays;
                     mats:TNamedMatrices):extended;overload;forward;

function FormulaAttributes(func:string; DecomposeComplex:boolean):TFormulaAttributes;overload;forward;
function FormulaAttributes(func:string; DecomposeComplex:boolean;
                           const vars:TVariables;
                           const arrs:TNamedArrays;
                           const matrs:TNamedMatrices):TFormulaAttributes;overload;forward;

function FormulaValue(formula:string;const vars:TVariables;
                                     const arrs:TNamedArrays;
                                     const matrs:TNamedMatrices):extended;overload;
var attributes : TFormulaAttributes;
    p,x:extended;
    len:integer;
begin
DeleteAllSuperfluousBracketsAndBlanks(formula);
if formula='' then begin
                   result:=0.0;
                   exit;
                   end;
result:=NaN;
attributes:=FormulaAttributes(formula,true,vars,arrs,matrs);
case attributes.TheType of
ftUnknown : Begin
            exit;
            End;{ftUnknown}
ftError : Begin
          exit;
          End;{ftError}
ftValue : Begin
          Result:=attributes.Value;
          End;{ftValue}
ftConst : Begin
          Result:=attributes.Value;
          End;{ftConst}
ftName : Begin
         if attributes.Index<0 then exit;
         Result:=vars[attributes.Index].Value;
         End;{ftName}
ftArrayItem : Begin
              if attributes.Index<0 then exit;
              Result:=ArrayItemValue(arrs[attributes.Index],
                                     round(FormulaValue(attributes.Index1,vars,arrs,matrs)));
              End;{ftArrayItem}
ftMatrixItem : Begin
               if attributes.Index<0 then exit;
               Result:=MatrixItemValue(matrs[attributes.Index],
                                       round(FormulaValue(attributes.Index1,vars,arrs,matrs)),
                                       round(FormulaValue(attributes.Index2,vars,arrs,matrs)));
               End;{ftMatrixItem}
ftStandardFunction : Begin
                     Result:=StandFunction(attributes.TheFunction,
                                           FormulaValue(attributes.Argument,
                                           vars,arrs,matrs));
                     End;{ftStandardFunction}
ftSpecialFunction : Begin
                    len:=SpecialFunctionParameters[attributes.TheSpecial];
                    if len=1 then begin
                                  p:=0.0;
                                  x:=FormulaValue(attributes.SpecialArguments[0],
                                                  vars,arrs,matrs);
                                  end{1}
                    else begin
                         p:=FormulaValue(attributes.SpecialArguments[0],
                                         vars,arrs,matrs);
                         x:=FormulaValue(attributes.SpecialArguments[1],
                                         vars,arrs,matrs);
                         end;{2}
                    Result:=SpecialFunction(attributes.TheSpecial,p,x);
                    End;{ftSpecialFunction}
ftPower : Begin
          Result:=Degree(FormulaValue(attributes.LOperand,vars,arrs,matrs),
                         FormulaValue(attributes.ROperand,vars,arrs,matrs));
          End;{ftPower}
ftBoolean : Begin
            Result:=BOValue(FormulaValue(attributes.LOperand,vars,arrs,matrs),
                            FormulaValue(attributes.ROperand,vars,arrs,matrs),
                            attributes.TheBoolean);
            End;{ftBoolean}
ftProduct : Begin
            Result:=Factor(attributes.SubFunctions,attributes.Operators,vars,arrs,matrs);
            End;{ftProduct}
ftComposition : Begin
                Result:=Composition(attributes.SubFunctions,attributes.Operators,vars,arrs,matrs);
                End;{ftComposition}
end;{case TheType}
end;{FormulaValue}

function FormulaValue(formula:TSVec; const vars:TVariables;
                                     const arrs:TNamedArrays;
                                     const matrs:TNamedMatrices):TVec;overload;
var i:integer;
begin
for i:=1 to MKV do Result[i]:=FormulaValue(formula[i],vars,arrs,matrs); 
end;{FormulaValue}

function ConstantFormulaValue(formula:string):extended;overload;
begin
result:=FormulaValue(formula,nil,nil,nil);
end;{ConstantFormulaValue}

function FormulaBooleanValue(formula:string;const vars:TVariables;
                                            const arrs:TNamedArrays;
                                            const mats:TNamedMatrices):boolean;
begin
result:=BooleanValue(FormulaValue(formula,vars,arrs,mats));
end;{FormulaBooleanValue}

function Factor(fa:TSArray;sa:TCharArray;
                vars:TVariables;
                arrs:TNamedArrays;
                mats:TNamedMatrices):extended;overload;
var i,n:integer;
    z:extended;
begin
n:=length(fa)-1;
case n of
-1:result:=0.0;
0:result:=FormulaValue(fa[0],vars,arrs,mats);
else begin
     z:=FormulaValue(fa[0],vars,arrs,mats);
     for i:=1 to n do
     if sa[i-1]=MultSign then z:=z*FormulaValue(fa[i],vars,arrs,mats)
     else if sa[i-1]=DivSign then z:=z/FormulaValue(fa[i],vars,arrs,mats);
     result:=z;
     end;{else}
end;{case}
end;{Factor}

function Factor(const s:string;vars:TVariables;
                               arrs:TNamedArrays;
                               mats:TNamedMatrices):extended;overload;
var fa:TSArray;
    sa:TCharArray;
begin
DeFact(s,fa,sa);
result:=Factor(fa,sa,vars,arrs,mats);
end;{Factor}

function Composition(ca:TSArray;sa:TCharArray;
                     vars:TVariables;
                     arrs:TNamedArrays;
                     mats:TNamedMatrices):extended;overload;
var i,n:integer;
    z:extended;
begin
n:=length(ca)-1;
z:=0.0;
for i:=0 to n do
if sa[i]=AddSign then z:=z+FormulaValue(ca[i],vars,arrs,mats)
else if sa[i]=SubsSign then z:=z-FormulaValue(ca[i],vars,arrs,mats);
result:=z;
end;{Composition}

function Composition(const s:string;vars:TVariables;
                                    arrs:TNamedArrays;
                                    mats:TNamedMatrices):extended;overload;
var ca:TSArray;
    sa:TCharArray;
begin
DeCompose(s,ca,sa);
result:=Composition(ca,sa,vars,arrs,mats);
end;{Composition}

function ValueF1(const formula:string;const varn:string;const val:extended):extended;
var v:TVariables;
begin
setlength(v,1);
v[0].Name:=varn;
v[0].Value:=val;
result:=FormulaValue(formula,v,nil,nil);
end;{ValueF1}

function ValueF(const formula:string;const varns:array of string;const vals:array of extended):extended;
var vars:TVariables;
begin
CreateVars(varns,vals,vars);
ValueF:=FormulaValue(formula,vars,nil,nil);
end;{ValueF}

function UnKnownFunc(const formulae,func:string;const vars:TVariables;
                                                const arrs:TNamedArrays;
                                                const matrs:TNamedMatrices;
                     n,count:integer;var fe:TFormulError):boolean;
var v:TVariable;
    a:TNamedArray;
    m:TNamedMatrix;
    z:extended;
    len,li,ri:integer;
    sft:TStandFunction;
    spf:TSpecialFunction;
    bot:TBooleanOperator;
    index1,index2,arg:string;
    prms:TSArray;
begin
if (SIsSFName(func,sft)
    or(func=DegreeName)) then Begin
result:=(n+count>=length(formulae))or(formulae[n+count]<>LeftBrckt);
if result then fe:=feArgLost;
End{if}
else
if SIsSpecFName(func,spf) then Begin
if not FindPair(formulae,LeftBrckt,RightBrckt,n+count,li,ri)
then begin
     fe:=feArgLost;
     result:=true;
     exit;
     end;{brackets not found}
arg:=copy(formulae,li+1,ri-li-1);
DetParameters(arg,SpecFuncSep,prms);
len:=Length(prms);
if (SpecialFunctionParameters[spf]>=0)
    and(SpecialFunctionParameters[spf]<>len) then begin
                                                  if len>SpecialFunctionParameters[spf] then fe:=feMoreArg
                                                  else fe:=feArgLost;
                                                  result:=true;
                                                  exit;
                                                  end;{arguments not found}
End{special function}
else Begin
result:=   (not SIsReal(func,z))
        and(not SIsConst(func,z))
        and( func<>PowerOp )
        and(not SIsBOName(func,bot))
        and(not SIsVar(func,vars,v))
        and(not SIsArrayItem(func,arrs,a,index1))
        and(not SIsMatrixItem(func,matrs,m,index1,index2))
        ;
if result then fe:=feUnknown;
End;{else}
end;{UnKnownFunc}

function UnKnownFuncInF(const formula:string;const vars:TVariables;
                                             const arrs:TNamedArrays;
                                             const matrs:TNamedMatrices;
         var ukf:string;var fe:TFormulError):boolean;
var i,n:integer;
    ss:TSArray;
    nn,counts:TIArray;
    fe1:TFormulError;
begin
result:=false;
DivideFormula(formula,ss,nn,counts);
n:=length(ss)-1;
for i:=0 to n do
if UnKnownFunc(formula,ss[i],vars,arrs,matrs,nn[i],counts[i],fe1)
then begin
     result:=true;
     ukf:=ss[i];
     fe:=fe1;
     exit;
     end;
end;{UnKnownFuncInF}

function UnKnownConstruction(const s:string;var unc:string):boolean;
var i,n,k:integer;
    c,c1:char;
begin
result:=false;
n:=length(s);
if n=0 then exit;
if s[1] in CannotBeginWith
then begin
     unc:=copy(s,1,3);
     result:=true;
     exit;
     end;{if}
if s[n] in CannotEndBy
then begin
     if (n<3) then k:=n
     else k:=3;
     unc:=copy(s,n-k+1,k);
     result:=true;
     exit;
     end;{if}
c:=s[1];
for i:=1 to n-1 do begin
c1:=s[i+1];
if   ((c=LeftBrckt)and(c1 in LeftNot))
   or((c=RightBrckt)and(not(c1 in RightMust)))
   or((c1=RightBrckt)and(c in BeforeRightNot))
then Begin
     result:=true;
     unc:=c+c1;
     exit;
     End;{if}
c:=c1;
end;{for i}
end;{UnKnownConstruction}

function PowerError(const s:string;var errpart:string):boolean;
var i,len,k : integer;
    li1,ri1,li2,ri2: Integer;
begin
result:=false;
errpart:='';
len:=Length(s);

// first valid symbol cannot be '^';
for i:=1 to len do Begin
if (s[i]<>' ')and(s[i]<>PowerOp) then break;
if (s[i]=PowerOp) then begin
                       result:=true;
                       errpart:=copy(s,1,i+3);
                       exit;
                       end;
End;{for i}

// last valid symbol cannot be '^';
for i:=len downto 1 do Begin
if (s[i]<>' ')and(s[i]<>PowerOp) then break;
if (s[i]=PowerOp) then begin
                       result:=true;
                       if i<4 then k:=1 else k:=i-3;
                       errpart:=copy(s,k,len-k+1);
                       exit;
                       end;
End;{for i}

// checking power construction ')^('
for i:=2 to len-1 do
if (s[i]=PowerOp)and((s[i-1]<>RightBrckt)or(s[i+1]<>LeftBrckt))
then Begin
     result:=true;
     errpart:=copy(s,i-1,3);
     exit;
     End;{brackets}

// previous checking will not find error in sin(x)^(x)
// so check for all pairs of '()' if ()^() then
// brackets or signs must be before and after
for i:=1 to len do
if (s[i]=LeftBrckt) then Begin
if not FindPair(s,LeftBrckt,RightBrckt,i,li1,ri1)
then begin
     exit;
     end;{if brackets error}
if (ri1=len)or(s[ri1+1]<>PowerOp) then continue;
if not FindPair(s,LeftBrckt,RightBrckt,ri1+2,li2,ri2)
then begin
     exit;
     end;{if brackets error}
if   ( (li1<>1)and
       ((s[li1-1]<>LeftBrckt)and( not (s[li1-1] in PowerBracketsMustFollow))) )
then begin
     result:=true;
     errpart:=copy(s,li1-1,ri2-li1+2);
     end;{error}
if  ( (ri2<>len)and
       ((s[ri2+1]<>RightBrckt)and( not (s[ri2+1] in PowerBracketsMustFollow))) )
then begin
     result:=true;
     errpart:=copy(s,li1,ri2-li1+2);
     end;{error}
if result then exit;
End;{if}
end;{PowerError}

function ErrorInFormula(const s:string;const vars:TVariables;
                                       const arrs:TNamedArrays;
                                       const matrs:TNamedMatrices;
         var fe:TFormulError;var es:string):boolean;overload;
var c:char;
    cs:string;
    fe1:TFormulError;
begin
result:=false;
if (SIsEmpty(s)) then begin
                      result:=true;
                      fe:=feEmpty;
                      es:=s;
                      exit;
                      end;
if WrongCharInS(s,c) then begin
                          result:=true;
                          fe:=feWSign;
                          es:=c;
                          exit;
                          end;
if BracketsError(s,fe) then begin
                            result:=true;
                            exit;
                            end;
if NotTwiceInS(s,cs) then begin
                          result:=true;
                          fe:=feNotTwice;
                          es:=cs;
                          exit;
                          end;
if UnKnownFuncInF(s,vars,arrs,matrs,cs,fe1)
then begin
     result:=true;
     fe:=fe1;
     es:=cs;
     exit;
     end;
if UnKnownConstruction(s,cs) then begin
                                  result:=true;
                                  fe:=feUnConstr;
                                  es:=cs;
                                  exit;
                                  end;
if PowerError(s,cs) then begin
                         result:=true;
                         fe:=fePower;
                         es:=cs;
                         exit;
                         end;
end;{ErrorInFormula}

function ErrorInFormula(const sv:TSVec;const vars:TVariables;
                                       const arrs:TNamedArrays;
                                       const matrs:TNamedMatrices;
                        var fe:TFormulError;var ef,es:string):boolean;overload;
var i:integer;
begin
result:=true;
ef:='';
for i:=1 to MKV do
if ErrorInFormula(sv[i],vars,arrs,matrs,fe,es) then begin
                                                    ef:=sv[i];
                                                    exit;
                                                    end;{error}
result:=false;
end;{ErrorInFormula}

function FormulaErrorString(const fe:TFormulError;const formula,es:string):string;
var s:string;
begin
case fe of
feEmpty:s:='Empty formula.';
feWSign:s:='Invalid simbol "'+es+'".';
feLBrckt:s:='"'+RightBrckt+'" is expected.';
feMBrckt:s:='There is a superfluous "'+RightBrckt+'".';
feNotTwice:s:='There is a wrong part in formula "'+es+'".';
feUnknown:s:='Unknown function "'+es+'".';
feUnConstr:s:='Unknown construction "'+es+'".';
fePower:s:='Wrong part in power construction "'+es+'".';
feArgLost:s:='Function arguments lost ("'+es+'").';
feMoreArg:s:='More Function arguments ("'+es+'").';
end;{case}
result:='Error in formula "'+formula+'".'+#13+s;
end;{FormulaErrorString}

procedure MessageFE(const fe:TFormulError;const formula,es:string);
var s:string;
begin
s:=FormulaErrorString(fe,formula,es);
MessageDLG(s,mtError,[mbOk],0);
end;{MessageFE}

function SIsEmpty(s:string):boolean;
var i:integer;
begin
result:=true;
for i:=1 to length(s) do
if (s[i]<>' ') then begin
                    result:=false;
                    exit;
                    end;
end;{SIsEmpty}

function FormulaControlE(var formula:string;const vars:TVariables;
                                            const arrs:TNamedArrays;
                                            const mats:TNamedMatrices):boolean;overload;
var fe:TFormulError;
    es,s:string;
begin
s:=formula;
BrcktsSpcDelete(s);
result:=ErrorInFormula(s,vars,arrs,mats,fe,es);
if result then MessageFE(fe,formula,es)
else formula:=s;
end;{FormulaControlE}

function FormulaControlE(var formula:TSVec; const vars:TVariables;
                                            const arrs:TNamedArrays;
                                            const mats:TNamedMatrices):boolean;overload;
var fe:TFormulError;
    ef,es:string;
begin
result:=ErrorInFormula(formula,vars,arrs,mats,fe,ef,es);
if result then MessageFE(fe,ef,es);
end;{FormulaControlE}

function FormulaControlE(var formulae:array of string;const vars:TVariables;
                                                      const arrs:TNamedArrays;
                                                      const mats:TNamedMatrices):boolean;overload;
var i:integer;
begin
result:=false;
for i:=Low(formulae) to High(formulae) do
if FormulaControlE(formulae[i],vars,arrs,mats) then begin
                                                    result:=true;
                                                    exit;
                                                    end;
end;{FormulaControlE}

function FormulaControlE(var formula:string;const vars,res:TVariables;
                                            const arrs:TNamedArrays;
                                            const mats:TNamedMatrices):boolean;overload;
var i,n:integer;
    nv:TVariables;
begin
n:=length(vars);
setlength(nv,n);
for i:=0 to n-1 do nv[i]:=vars[i];
n:=length(res)-1;
for i:=0 to n do AddVar(res[i].Name,0.0,nv);
result:=FormulaControlE(formula,nv,arrs,mats);
end;{FormulaControlE}

function FindErrorInFormula(var formula:string;const vars:TVariables;
                                               const arrs:TNamedArrays;
                                               const mats:TNamedMatrices;
                            var description:string ):boolean;overload;
var fe:TFormulError;
    es:string;
begin
result:=ErrorInFormula(formula,vars,arrs,mats,fe,es);
if result then description:=FormulaErrorString(fe,formula,es)
else description:='';
end;{FindErrorInFormula}

function FindErrorInFormula(var formula:TSVec; const vars:TVariables;
                                               const arrs:TNamedArrays;
                                               const mats:TNamedMatrices;
                            var description:string ):boolean;overload;
var i:integer;
    s:string;
begin
result:=false;
description:='';
for i:=1 to MKV do
if FindErrorInFormula(formula[i],vars,arrs,mats,s)
then begin
     result:=true;
     description:=description+#13+s;
     end;{found}
end;{FindErrorInFormula}

procedure CreateVars(const varns:array of string;const vals:array of extended;
                    var vars:TVariables);
var i,n:integer;
begin
n:=length(varns)-1;
setlength(vars,n+1);
for i:=0 to n do begin
                 vars[i].Name:=varns[i];
                 vars[i].Value:=vals[i];
                 end;
end;{CreateVars}

procedure AddVar(const varn:string;const varv:extended;var vars:TVariables);
var n:integer;
begin
if ExistVar(varn,vars,n) then vars[n].Value:=varv
else begin
     n:=length(vars);
     setlength(vars,n+1);
     vars[n].Name:=varn;
     vars[n].Value:=varv;
     end;
end;{AddVar}

procedure AddArr(const name:string;const len:integer;var arrs:TNamedArrays);
var n:integer;
begin
n:=length(arrs);
setlength(arrs,n+1);
arrs[n].Name:=name;
setlength(arrs[n].A,len);
arrs[n].mi1:=len-1;
end;{AddArr}

procedure AddMatr(const name:string;const len1,len2:integer;var matrs:TNamedMatrices);
var n:integer;
begin
n:=length(matrs);
setlength(matrs,n+1);
matrs[n].Name:=name;
setlength(matrs[n].M,len1,len2);
matrs[n].mi1:=len1-1;
matrs[n].mi2:=len2-1;
end;{AddArr}

procedure AddStr(const strn,strv:string;var strs:TStrVariables);
var len:integer;
begin
len:=length(strs);
setlength(strs,len+1);
strs[len].Name:=strn;
strs[len].Value:=strv;
end;{AddStr}

function DelVar(const vn:integer;var vars:TVariables):boolean;
var max,i:integer;
begin
result:=false;
max:=length(vars)-1;
if (vn<0)or(vn>max)then exit;
for i:=vn to max-1 do vars[i]:=vars[i+1];
setlength(vars,max);
result:=true;
end;{DelVar}

function DelArr(const an:integer;var arrs:TNamedArrays):boolean;
var max,i:integer;
begin
result:=false;
max:=length(arrs)-1;
if (an<0)or(an>max)then exit;
SetLength(arrs[an].A,0);
for i:=an to max-1 do arrs[i]:=arrs[i+1];
setlength(arrs,max);
result:=true;
end;{DelArr}

function DelMatr(const mn:integer;var matrs:TNamedMatrices):boolean;
var max,i,len:integer;
begin
result:=false;
max:=length(matrs)-1;
if (mn<0)or(mn>max)then exit;
len:=Length(matrs[mn].M);
for i:=0 to len-1 do SetLength(matrs[mn].M[i],0);
SetLength(matrs[mn].M,0);
for i:=mn to max-1 do matrs[i]:=matrs[i+1];
setlength(matrs,max);
result:=true;
end;{DelMatr}

function DelStr(const sn:integer;var strs:TStrVariables):boolean;
var i,len:integer;
begin
result:=false;
len:=Length(strs);
if (sn<0)or(sn>=len) then exit;
for i:=sn to len-2 do strs[i]:=strs[i+1];
SetLength(strs,len-1);
result:=true;
end;{DelStr}

procedure MathFunctionsPre(var pres:TSArray);
var i,nsf,nbo,k:integer;
    s1:string;
begin
nsf:=Ord(High(TStandFunction));
nbo:=Ord(High(TBooleanOperator));
setlength(pres,nsf+1+1+nbo+1);
s1:=LeftBrckt+RightBrckt;
for i:=0 to nsf do begin
pres[i]:=NamesSF[TStandFunction(i)]+s1;
end;{for i}
pres[nsf+1]:=DegreeName+LeftBrckt+DegreeSep+RightBrckt;
s1:=LeftBrckt+BOSep+RightBrckt;
for i:=0 to nbo do begin
k:=nsf+2+i;
pres[k]:=NamesBO[TBooleanOperator(i)]+s1;
end;{for i}
end;{MathFunctionsPre}

procedure Evaluate(const res,vars:TVariables;var formula:string);
var nn,counts:TIArray;
    ss:TSArray;
    add,i,n,k,l:integer;
    br,bv:boolean;
    v:TVariable;
    si:string;
begin
DivideFormula(formula,ss,nn,counts);
n:=length(ss)-1;
add:=0;
for i:=0 to n do Begin
br:=SIsVar(ss[i],res,v);
if br then continue;
bv:=SIsVar(ss[i],vars,v);
if bv then begin
k:=nn[i]+add;
Delete(formula,k,counts[i]);
si:=FloatToStr(v.Value);
l:=length(si)-counts[i];
add:=add+l;
Insert(si,formula,k);
end;{bv}
End;{for i}
end;{Evaluate}

procedure FormulaeValues(var formulae:array of string;const vars:TVariables;
                          var values:array of extended);
var i:integer;
begin
for i:=Low(formulae) to High(formulae) do
values[i]:=FormulaValue(formulae[i],vars,nil,nil);
end;{FormulaeValues}

function BooleanConst(b:boolean):string;
begin
if b then result:=BooleanTrueString
else result:=BooleanFalseString;
end;{BooleanConst}

{-----------------------------------------}
   { Formula Translation }
procedure AddOperation(operation:TFormulaOperation;var operations:TFormulaOperations);
var n:integer;
begin
n:=length(operations);
setlength(operations,n+1);
operations[n]:=operation;
end;{AddOperation}

function ValueValueOperation(z:extended):TFormulaOperation;
begin
result.Typ:=otValue;
result.Value.Typ:=vtValue;
result.Value.Value:=z;
end;{ValueValueOperation}

function ValueConstOperation(z:extended):TFormulaOperation;
begin
result.Typ:=otValue;
result.Value.Typ:=vtConst;
result.Value.Value:=z;
end;{ValueConstOperation}

function ValueVarOperation(num:integer):TFormulaOperation;
begin
result.Typ:=otValue;
result.Value.Typ:=vtVariable;
result.Value.Index:=num;
end;{ValueVarOperation}

function ValueArrayOperation(num:integer;index1:integer):TFormulaOperation;
begin
result.Typ:=otValue;
result.Value.Typ:=vtArray;
result.Value.Index:=num;
result.Value.Index1:=index1;
end;{ValueArrayOperation}

function ValueMatrixOperation(num:integer;index1,index2:integer):TFormulaOperation;
begin
result.Typ:=otValue;
result.Value.Typ:=vtMatrix;
result.Value.Index:=num;
result.Value.Index1:=index1;
result.Value.Index2:=index2;
end;{ValueMatrixOperation}

function FunctionOperation(stf:TStandFunction):TFormulaOperation;
begin
result.Typ:=otFunction;
result.Func:=stf;
end;{FunctionOperation}

function SpecialFunctionOperation(spf:TSpecialFunction):TFormulaOperation;
begin
result.Typ:=otSpecFunction;
result.SpecFunc.FuncType:=spf;
result.SpecFunc.indexes:=nil;
end;{FunctionOperation}

function PowerOperation(index1,index2:integer):TFormulaOperation;
begin
result.Typ:=otPower;
result.Value.Index1:=index1;
result.Value.Index2:=index2;
end;{PowerOperation}

function LogicalOperation(operation:TBooleanOperator;index1,index2:integer):TFormulaOperation;
begin
result.Typ:=otLogical;
result.Logical:=operation;
result.Value.Index1:=index1;
result.Value.Index2:=index2;
end;{LogicalOperation}

function AlgebraicOperation(operation:TAlgebraicOperation;index1,index2:integer):TFormulaOperation;
begin
result.Typ:=otAlgebraic;
result.Algebraic:=operation;
result.Value.Index1:=index1;
result.Value.Index2:=index2;
end;{AlgebraicOperation}

function CharToAlgebraic(c:char):TAlgebraicOperation;
begin
case c of
MultSign:result:=aoProduct;
DivSign:result:=aoDivision;
AddSign:result:=aoSum;
SubsSign:result:=aoDifference;
else result:=aoUnknown;
end;{case}
end;{CharToAlgebraic}

function Algebraic(opeartion:TAlgebraicOperation;x1,x2:extended):extended;
begin
case opeartion of
aoSum:result:=x1+x2;
aoDifference:result:=x1-x2;
aoProduct:result:=x1*x2;
aoDivision:result:=x1/x2;
else {aoUnknown:} result:=NAN;
end;{case}
end;{Algebraic}

function MakeFormula(s:string;const vars:TVariables;
                              const arrs:TNamedArrays;
                              const matrs:TNamedMatrices;
                              var formula:TFormula):boolean;overload;
//     example 1     x+2*x
//     number        0 1 2 3 4 5 6
//     operation     + + 0 * x 2 x
//     reference (1) 1 2   5
//               (2) 3 6   4

//     example 2     x+2*x-sin(x/0,1)
//     number        0 1 2  3 4   5 6   7 8  9 10 11
//     operation     - + +  0 sin / 0,1 x *  x  2  x
//     reference (1) 1 2 3        7       10
//               (2) 4 8 11       6       9


//     example 3     x/2*3
//     number        0 1 2 3 4
//     operation     * / 3 2 x
//     reference (1) 1 4
//               (2) 2 3

// Note : Multiplication procedures (* and /) must be performed
// from LEFT to RIGHT to avoid bad division result when after
// division other operations follow (e.g X/Y*Z).
// It's so for sum procedures (+ and -) too.

var operation:TFormulaOperation;
    num,n,i:integer;
    attributes : TFormulaAttributes;
begin
result:=false;
DeleteAllSuperfluousBracketsAndBlanks(s);
if s='' then exit;
attributes:=FormulaAttributes(s,true,vars,arrs,matrs);

case attributes.TheType of
ftUnknown : Begin

            exit;
            End;{ftUnknown}
ftError : Begin

          exit;
          End;{ftError}
ftValue : Begin
          operation:=ValueValueOperation(attributes.Value);
          AddOperation(operation,formula.Operations);
          End;{ftValue}
ftConst : Begin
          operation:=ValueConstOperation(attributes.Value);
          AddOperation(operation,formula.Operations);
          End;{ftConst}
ftName : Begin
         if (attributes.Index<0) then exit;
         operation:=ValueVarOperation(attributes.Index);
         AddOperation(operation,formula.Operations);
         End;{ftName}
ftArrayItem : Begin
              operation:=ValueArrayOperation(attributes.Index,length(formula.Operations)+1);
              AddOperation(operation,formula.Operations);
              MakeFormula(attributes.Index1,vars,arrs,matrs,formula);
              End;{ftArrayItem}
ftMatrixItem : Begin
               operation:=ValueMatrixOperation(attributes.Index,length(formula.Operations)+1,-1);
               num:=length(formula.Operations);
               AddOperation(operation,formula.Operations);
               MakeFormula(attributes.Index1,vars,arrs,matrs,formula);
               formula.Operations[num].Value.Index2:=length(formula.Operations);
               MakeFormula(attributes.Index2,vars,arrs,matrs,formula);
               End;{ftMatrixItem}
ftStandardFunction : Begin
                     operation:=FunctionOperation(attributes.TheFunction);
                     AddOperation(operation,formula.Operations);
                     MakeFormula(attributes.Argument,vars,arrs,matrs,formula);
                     End;{ftStandardFunction}
ftSpecialFunction : Begin
                    operation:=SpecialFunctionOperation(attributes.TheSpecial);
                    n:=Length(attributes.SpecialArguments);
                    if (SpecialFunctionParameters[attributes.TheSpecial]>=0)
                       and(SpecialFunctionParameters[attributes.TheSpecial]<>n)
                       then exit;
                    AddOperation(operation,formula.Operations);
                    num:=length(formula.Operations)-1;
                    SetLength(formula.Operations[num].SpecFunc.indexes,n);
                    for i:=0 to n-1 do begin
                    formula.Operations[num].SpecFunc.indexes[i]:=Length(formula.Operations);
                    MakeFormula(attributes.SpecialArguments[i],vars,arrs,matrs,formula);
                    end;{for i}
                    End;{ftSpecialFunction}
ftPower : Begin
          num:=length(formula.Operations);
          operation:=PowerOperation(num+1,-1);
          AddOperation(operation,formula.Operations);
          MakeFormula(attributes.LOperand,vars,arrs,matrs,formula);
          formula.Operations[num].Value.Index2:=length(formula.Operations);
          MakeFormula(attributes.ROperand,vars,arrs,matrs,formula);
          End;{ftPower}
ftBoolean : Begin
            num:=length(formula.Operations);
            operation:=LogicalOperation(attributes.TheBoolean,num+1,-1);
            AddOperation(operation,formula.Operations);
            MakeFormula(attributes.LOperand,vars,arrs,matrs,formula);
            formula.Operations[num].Value.Index2:=length(formula.Operations);
            MakeFormula(attributes.ROperand,vars,arrs,matrs,formula);
            End;{ftBoolean}
ftProduct : Begin
            n:=length(attributes.Operators);
            operation:=AlgebraicOperation(aoUnknown,-1,-1);
            num:=length(formula.Operations);
            for i:=0 to n-1 do begin
                               operation.Algebraic:=CharToAlgebraic(attributes.Operators[n-i-1]);
                               operation.Value.Index1:=num+i+1;
                               AddOperation(operation,formula.Operations);
                               end;{for i}
            for i:=0 to n-1 do begin
                               formula.Operations[num+i].Value.index2:=length(formula.Operations);
                               MakeFormula(attributes.SubFunctions[n-i],vars,arrs,matrs,formula);
                               end;{for i}
            formula.Operations[num+n-1].Value.index1:=length(formula.Operations);
            MakeFormula(attributes.SubFunctions[0],vars,arrs,matrs,formula);
            End;{ftProduct}
ftComposition : Begin
                n:=length(attributes.Operators);
                operation:=AlgebraicOperation(aoUnknown,-1,-1);
                num:=length(formula.Operations);
                for i:=0 to n-1 do begin
                                   operation.Algebraic:=CharToAlgebraic(attributes.Operators[n-i-1]);
                                   operation.Value.index1:=num+i+1;
                                   AddOperation(operation,formula.Operations);
                                   end;{for i}
                operation:=ValueValueOperation(0.0); {for the first sign, see DeCompose}
                AddOperation(operation,formula.Operations);
                for i:=0 to n-1 do begin
                                   formula.Operations[num+i].Value.index2:=length(formula.Operations);
                                   MakeFormula(attributes.SubFunctions[n-i-1],vars,arrs,matrs,formula);
                                   end;{for i}
                End;{ftComposition}
end;{case TheType}

formula.Number:=length(formula.Operations);
result:=true;
end;{MakeFormula}

function FormulaValue(f:TFormula;const vars:TVariables;
                                 const arrs:TNamedArrays;
                                 const matrs:TNamedMatrices):extended;overload;
var i,n:integer;
    p,x:extended;
begin
result:=0.0;
if f.Number=0 then exit;
for i:=f.Number-1 downto 0 do
case f.Operations[i].Typ of
otValue:case f.Operations[i].Value.Typ of
        vtValue,
        vtConst:f.Operations[i].Result:=f.Operations[i].Value.Value;
        vtVariable:f.Operations[i].Result:=vars[f.Operations[i].Value.index].Value;
        vtArray:f.Operations[i].Result:=arrs[f.Operations[i].Value.index].A[round(f.Operations[f.Operations[i].Value.index1].Result)];
        vtMatrix:f.Operations[i].Result:=matrs[f.Operations[i].Value.index].M[round(f.Operations[f.Operations[i].Value.index1].Result),round(f.Operations[f.Operations[i].Value.index2].Result)];
        end;{case Value.Typ}
otFunction:begin
           f.Operations[i].Result:=StandFunction(f.Operations[i].Func,f.Operations[i+1].Result);
           end;{otFunction}
otSpecFunction:begin
               n:=Length(f.Operations[i].SpecFunc.indexes);
               if n=1 then begin
                           x:=f.Operations[f.Operations[i].SpecFunc.indexes[0]].Result;
                           p:=0.0;
                           end{1}
               else begin
                    p:=f.Operations[f.Operations[i].SpecFunc.indexes[0]].Result;
                    x:=f.Operations[f.Operations[i].SpecFunc.indexes[1]].Result;
                    end;{2}
               f.Operations[i].Result:=SpecialFunction(f.Operations[i].SpecFunc.FuncType,p,x);
               end;{otSpecFunction}
otPower:begin
        f.Operations[i].Result:=Degree(f.Operations[f.Operations[i].Value.index1].Result,
                                       f.Operations[f.Operations[i].Value.index2].Result);
        end;{otPower}
otLogical:begin
          f.Operations[i].Result:=BOValue(f.Operations[f.Operations[i].Value.index1].Result,
                                          f.Operations[f.Operations[i].Value.index2].Result,
                                          f.Operations[i].Logical);
          end;{otPower}
otAlgebraic:begin
            f.Operations[i].Result:=Algebraic(f.Operations[i].Algebraic,
                                              f.Operations[f.Operations[i].Value.index1].Result,
                                              f.Operations[f.Operations[i].Value.index2].Result);
            end;{otAlgebraic}
end;{case TOperationType}
result:=f.Operations[0].Result;
end;{FormulaValue}

{---------------------Derivative Implementation begin--------------------------}
function ZeroString(func:string):boolean;
begin
result:=   (func='')
         or(func=ZeroStringChar)
         or(func=ZeroStringFloat)
         or(func=EmptyBrackets)
         or(func=BracketedZero)
         or(func=BracketedZeroFloat);
end;{ZeroString}

function UnitString(func:string):boolean;
begin
result:=   (func=UnitStringChar)
         or(func=UnitStringFloat)
         or(func=BracketedUnit)
         or(func=BracketedUnitFloat);
end;{UnitString}

function IsFunctionConstByVariable(func,variable : string):boolean;
var i, flen, vlen, last :integer;
    sub : string;
    d : boolean;
begin
result:=true;
flen:=Length(func);
vlen:=Length(variable);
last:=flen-vlen+1;
if (last<=0)or(vlen=0) then exit;
if (last=1) then begin
                 result:=not(func=variable);
                 exit;
                 end;
for i:=1 to last do Begin
sub:=copy(func,i,vlen);
if (sub=variable) then begin
                       if (i=1) then d:=(func[i+vlen] in Dividers)
                       else
                       if (i=last) then d:=(func[i-1] in Dividers)
                       else d:=(func[i+vlen] in Dividers)and(func[i-1] in Dividers);
                       if d then begin
                                 result:=false;
                                 exit;
                                 end;{if d}
                       end;{if =}
End;{for i}
end;{IsFunctionConstByVariable}

function FunctionProduct(func1,func2:string):string;
var z1,z2 : extended;
begin
DeleteAllSuperfluousBracketsAndBlanks(func1);
DeleteAllSuperfluousBracketsAndBlanks(func2);
if (ZeroString(func1))or(ZeroString(func2)) then result := ZeroStringChar
else
if (UnitString(func1))and(UnitString(func2)) then result := UnitStringChar
else
if (UnitString(func1)) then result := LeftBrckt+func2+RightBrckt
else
if (UnitString(func2)) then result := LeftBrckt+func1+RightBrckt
else
if (SIsReal(func1,z1) and SIsReal(func2,z2))
then Begin
     result:=LeftBrckt+FloatToStr(z1*z2)+RightBrckt;
     End{real}
else Begin
     result:=LeftBrckt+func1+RightBrckt+MultSign+LeftBrckt+func2+RightBrckt;
     End;{else}
end;{FunctionProduct}

function FunctionDivision(numerator,denominator:string):string;
var zn,zd : extended;
begin
DeleteAllSuperfluousBracketsAndBlanks(numerator);
DeleteAllSuperfluousBracketsAndBlanks(denominator);
if (ZeroString(numerator)) then result := ZeroStringChar
else
if (ZeroString(denominator)) then result := FloatToStr(Infinity)
else
if (UnitString(denominator)) then result := LeftBrckt+numerator+RightBrckt
else
if (SIsReal(numerator,zn) and SIsReal(denominator,zd))
then Begin
     result:=LeftBrckt+FloatToStr(zn/zd)+RightBrckt;
     End{real}
else Begin
     result:=LeftBrckt+numerator+RightBrckt+DivSign+LeftBrckt+denominator+RightBrckt;
     End;{else}
end;{FunctionDivision}

function FunctionSum(func1,func2:string):string;
var z1,z2 : extended;
begin
DeleteAllSuperfluousBracketsAndBlanks(func1);
DeleteAllSuperfluousBracketsAndBlanks(func2);
if func1='' then func1:=ZeroStringChar;
if func2='' then func2:=ZeroStringChar;
if (ZeroString(func1))and(ZeroString(func2)) then result := ZeroStringChar
else
if (ZeroString(func1)) then result := LeftBrckt+func2+RightBrckt
else
if (ZeroString(func2)) then result := LeftBrckt+func1+RightBrckt
else
if (SIsReal(func1,z1) and SIsReal(func2,z2))
then Begin
     result:=LeftBrckt+FloatToStr(z1+z2)+RightBrckt;
     End{real}
else Begin
     result:=LeftBrckt+func1+RightBrckt+AddSign+LeftBrckt+func2+RightBrckt;
     End;{else}
end;{FunctionSum}

function FunctionDifference(func1,func2:string):string;
var z1,z2 : extended;
begin
DeleteAllSuperfluousBracketsAndBlanks(func1);
DeleteAllSuperfluousBracketsAndBlanks(func2);
if func1='' then func1:=ZeroStringChar;
if func2='' then func2:=ZeroStringChar;
if (func1=func2) then result := ZeroStringChar
else
if (ZeroString(func2)) then result := LeftBrckt+func1+RightBrckt
else
if (ZeroString(func1)) then result := LeftBrckt+SubsSign+LeftBrckt+func2+RightBrckt+RightBrckt
else
if (SIsReal(func1,z1) and SIsReal(func2,z2))
then Begin
     result:=LeftBrckt+FloatToStr(z1-z2)+RightBrckt;
     End{real}
else Begin
     result:=LeftBrckt+func1+RightBrckt+SubsSign+LeftBrckt+func2+RightBrckt;
     End;{else}
end;{FunctionDifference}

function FunctionComposition(funcs:TSArray;operators:TCharArray):string;
var i, len :integer;
begin
len := Length(funcs);
result := '';
for i:=0 to len-1 do Begin
                     case operators[i] of
                     AddSign : result :=FunctionSum(result,funcs[i]);
                     SubsSign : result :=FunctionDifference(result,funcs[i]);
                     end;{case}
                     End;{for i}
end;{FunctionComposition}

function FunctionProducts(funcs:TSArray;operators:TCharArray):string;
var i, len :integer;
begin
len := Length(operators);
result := funcs[0];
for i:=0 to len-1 do Begin
                     case operators[i] of
                     MultSign : result :=FunctionProduct(result,funcs[i+1]);
                     DivSign : result :=FunctionDivision(result,funcs[i+1]);
                     end;{case}
                     End;{for i}
end;{FunctionProducts}

function FunctionPower(arg,pow:string):string;
begin
DeleteAllSuperfluousBracketsAndBlanks(arg);
DeleteAllSuperfluousBracketsAndBlanks(pow);
if ZeroString(pow) then result:=UnitStringChar
else
if ZeroString(arg) then result:=ZeroStringChar
else
if UnitString(pow) then result:=LeftBrckt+arg+RightBrckt
else result:=LeftBrckt+arg+RightBrckt+PowerOp+LeftBrckt+pow+RightBrckt;
end;{FunctionPower}

function FunctionSQR(arg:string):string;
begin
result:=FunctionPower(arg,'2');
end;{FunctionSQR}

function FunctionSQRT(arg:string):string;
var SQRTPOW:string;
begin
SQRTPOW:='0'+DecimalSeparator+'5';
result:=FunctionPower(arg,SQRTPOW);
end;{FunctionSQRT}

function StandardFunctionDerivativeFunction(stf:TStandFunction):string;
var arg : string;
begin
case stf of
sfSin : begin
        Result := NamesSF[sfCos]+LeftBrckt+ArgumentName+RightBrckt;
        end;{sfSin}
sfCos : begin
        Result := SubsSign+NamesSF[sfSin]+LeftBrckt+ArgumentName+RightBrckt;
        end;{sfCos}
sfTan : begin
        arg := NamesSF[sfTan]+LeftBrckt+ArgumentName+RightBrckt;
        Result := UnitStringChar+ AddSign + FunctionSQR(arg);
        end;{sfTan}
sfArcSin : begin
           arg := UnitStringChar+ SubsSign + FunctionSQR(ArgumentName);
           Result := UnitStringChar+DivSign+LeftBrckt+FunctionSQRT(arg)+RightBrckt;
           end;{sfArcSin}
sfArcCos : begin
           arg := UnitStringChar+ SubsSign + FunctionSQR(ArgumentName);
           Result := FunctionDivision(SubsSign+UnitStringChar,FunctionSQRT(arg));
           end;{sfArcCos}
sfArcTan : begin
           arg := UnitStringChar+ AddSign + FunctionSQR(ArgumentName);
           Result := UnitStringChar+DivSign+LeftBrckt+arg+RightBrckt;
           end;{sfArcTan}
sfSinh : begin
         Result := NamesSF[sfCosh]+LeftBrckt+ArgumentName+RightBrckt;
         end;{sfSinh}
sfCosh : begin
         Result := NamesSF[sfSinh]+LeftBrckt+ArgumentName+RightBrckt;
         end;{sfCosh}
sfTanH : begin
         arg := NamesSF[sfTanH]+LeftBrckt+ArgumentName+RightBrckt;
         Result := UnitStringChar+ SubsSign + FunctionSQR(arg);
         end;{sfTanH}
sfArcSinH : begin
            arg := UnitStringChar+ AddSign + FunctionSQR(ArgumentName);
            Result := UnitStringChar+DivSign+LeftBrckt+FunctionSQRT(arg)+RightBrckt;
            end;{sfArcSinH}
sfArcCosH : begin     { ? }
            arg := FunctionSQR(ArgumentName)+SubsSign+UnitStringChar;
            Result := UnitStringChar+DivSign+LeftBrckt+FunctionSQRT(arg)+RightBrckt;
            end;{sfArcCosH}
sfArcTanH : begin
            arg := UnitStringChar+ SubsSign + FunctionSQR(ArgumentName);
            Result := UnitStringChar+DivSign+LeftBrckt+arg+RightBrckt;
            end;{sfArcTanH}
sfLn : begin
       Result := UnitStringChar+DivSign+LeftBrckt+ArgumentName+RightBrckt;
       end;{sfLn}
sfLog : begin
        arg:=NamesSF[sfLn]+LeftBrckt+'10'+RightBrckt;
        Result := UnitStringChar+DivSign
                 +LeftBrckt+arg+MultSign
                 +LeftBrckt+ArgumentName+RightBrckt+RightBrckt;
        end;{sfLog}
sfExp : begin
        Result := NamesSF[sfExp]+LeftBrckt+ArgumentName+RightBrckt;
        end;{sfExp}
else Result := DerivativeNotAllowedFunction+'('+NamesSF[stf]+')';
end;{case stf}
end;{StandardFunctionDerivativeFunction}

function StandardFunctionAntiDerivativeFunction(stf:TStandFunction):string;
var arg : string;
begin
case stf of
sfSin : begin
        Result := SubsSign+NamesSF[sfCos]+LeftBrckt+ArgumentName+RightBrckt;
        end;{sfSin}
sfCos : begin
        Result := NamesSF[sfSin]+LeftBrckt+ArgumentName+RightBrckt;
        end;{sfCos}
sfTan : begin
        Result := SubsSign+NamesSF[sfLn]+LeftBrckt+NamesSF[sfAbs]+LeftBrckt+ArgumentName+RightBrckt+RightBrckt;
        end;{sfTan}
(*sfArcSin : begin
           arg := UnitStringChar+ SubsSign + FunctionSQR(ArgumentName);
           Result := UnitStringChar+DivSign+LeftBrckt+FunctionSQRT(arg)+RightBrckt;
           end;{sfArcSin}
sfArcCos : begin
           arg := UnitStringChar+ SubsSign + FunctionSQR(ArgumentName);
           Result := FunctionDivision(SubsSign+UnitStringChar,FunctionSQRT(arg));
           end;{sfArcCos}
sfArcTan : begin
           arg := UnitStringChar+ AddSign + FunctionSQR(ArgumentName);
           Result := UnitStringChar+DivSign+LeftBrckt+arg+RightBrckt;
           end;{sfArcTan}   *)
sfSinh : begin
         Result := NamesSF[sfCosh]+LeftBrckt+ArgumentName+RightBrckt;
         end;{sfSinh}
sfCosh : begin
         Result := NamesSF[sfSinh]+LeftBrckt+ArgumentName+RightBrckt;
         end;{sfCosh}
sfTanH : begin
         Result := SubsSign+NamesSF[sfLn]+LeftBrckt+NamesSF[sfCosh]+LeftBrckt+ArgumentName+RightBrckt+RightBrckt;
         end;{sfTanH}
(*sfArcSinH : begin
            arg := UnitStringChar+ AddSign + FunctionSQR(ArgumentName);
            Result := UnitStringChar+DivSign+LeftBrckt+FunctionSQRT(arg)+RightBrckt;
            end;{sfArcSinH}
sfArcCosH : begin     { ? }
            arg := FunctionSQR(ArgumentName)+SubsSign+UnitStringChar;
            Result := UnitStringChar+DivSign+LeftBrckt+FunctionSQRT(arg)+RightBrckt;
            end;{sfArcCosH}
sfArcTanH : begin
            arg := UnitStringChar+ SubsSign + FunctionSQR(ArgumentName);
            Result := UnitStringChar+DivSign+LeftBrckt+arg+RightBrckt;
            end;{sfArcTanH}    *)
sfLn : begin
       Result := ArgumentName+NamesSF[sfLn]+LeftBrckt+ArgumentName+RightBrckt+SubsSign+ArgumentName;
       end;{sfLn}
sfLog : begin
        Result:=ArgumentName+NamesSF[sfLog]+LeftBrckt+ArgumentName+RightBrckt+SubsSign+NamesSF[sfLog]+LeftBrckt+'Exp(1)'+RightBrckt;
        end;{sfLog}
sfExp : begin
        Result := NamesSF[sfExp]+LeftBrckt+ArgumentName+RightBrckt;
        end;{sfExp}
else Result := DerivativeNotAllowedFunction+'('+NamesSF[stf]+')';
end;{case stf}
end;{StandardFunctionDerivativeFunction}

function FuncIsDerivativeErrorFunction(func:string):boolean;
begin
result:=  (pos(DerivativeError,func)>0)
        or(pos(DerivativeNotAllowedFunction,func)>0)
        or(pos(DerivativeUnknown,func)>0);
end;{FuncIsDerivativeErrorFunction}

function ReplaceAllSubstrings(source,substr,replace:string):string;
begin
Result := StringReplace (source,substr,replace,[rfReplaceAll])
end;{ReplaceAllSubstrings}

function StandardFunctionDerivative(stf:TStandFunction;arg,variable:string;var resfunc:string):boolean;
var argresfunc,funcresfunc:string;
begin
result:=false;
funcresfunc := StandardFunctionAntiDerivativeFunction(stf);
if FuncIsDerivativeErrorFunction(funcresfunc)
then  begin
      resfunc:=funcresfunc;
      exit;
      end;{if error}
funcresfunc:=ReplaceAllSubstrings(funcresfunc,ArgumentName,arg);
if not Derivative(arg,variable,argresfunc)
then begin
     resfunc:=argresfunc;
     exit;
     end;{not }
resfunc:=FunctionProduct(funcresfunc,argresfunc);
result:=true;
end;{StandardFunctionDerivative}

function SpecialFunctionDerivativeFunction(spf:TSpecialFunction):string;
begin
case spf of
spfNone : Result := DerivativeUnknown+'('+SpecialFunctionNames[spf]+')';
else Result := DerivativeNotAllowedFunction+'('+SpecialFunctionNames[spf]+')';
end;{case spf}
end;{SpecialFunctionDerivativeFunction}

function SpecialFunctionDerivative(spf:TSpecialFunction;args:TSArray;variable:string;var resfunc:string):boolean;
var argresfunc,funcresfunc:string;
begin
result:=false;
funcresfunc := SpecialFunctionDerivativeFunction(spf);
if FuncIsDerivativeErrorFunction(funcresfunc)
then  begin
      resfunc:=funcresfunc;
      exit;
      end;{if error}
funcresfunc:=ReplaceAllSubstrings(funcresfunc,ArgumentName,args[0]);
if not Derivative(args[0],variable,argresfunc)
then begin
     resfunc:=argresfunc;
     exit;
     end;{not }
resfunc:=FunctionProduct(funcresfunc,argresfunc);
result:=true;
end;{SpecialFunctionDerivative}

function Simplify(var formula:string):boolean;
var len : integer;
begin
len := Length(formula);
DeleteAllSuperfluousBracketsAndBlanks(formula);
result:= (Length(formula)<>len);
end;{Simplify}

// (func1 * func2)' = (func1' * func2)+(func1 * func2')
function MultDerivative(func1,func2,variable:string;var resfunc:string):boolean;
var der1, der2, item1, item2 :string;
begin
resfunc:='';
result := Derivative(func1,variable,der1);
if (not result) then begin
                     resfunc:=der1;
                     exit;
                     end;{error 1}
result := Derivative(func2,variable,der2);
if (not result) then begin
                     resfunc:=der2;
                     exit;
                     end;{error 2}
item1:=FunctionProduct(der1,func2);
item2:=FunctionProduct(func1,der2);
resfunc:=FunctionSum(item1,item2);
end;{MultDerivative}

// (func1 * func2) = F(func1) * F(func2)
function MultAntiDerivative(func1,func2,variable:string;var resfunc:string):boolean;
var der1, der2 :string;
begin
resfunc:='';
result := Derivative(func1,variable,der1);
if (not result) then begin
                     resfunc:=der1;
                     exit;
                     end;{error 1}
result := Derivative(func2,variable,der2);
if (not result) then begin
                     resfunc:=der2;
                     exit;
                     end;{error 2}
resfunc:=FunctionProduct(der1,der2);
end;{MultAntiDerivative}

// (numerator / denominator)' =
// = ((numerator' * denominator)-(numerator * denominator'))/(denominator^2)
function DivisionDerivative(numerator,denominator,variable:string;var resfunc:string):boolean;
var dern, derd, item1, item2, resn, resd :string;
begin
resfunc:='';
result := Derivative(numerator,variable,dern);
if (not result) then begin
                     resfunc:=dern;
                     exit;
                     end;{numerator error}
result := Derivative(denominator,variable,derd);
if (not result) then begin
                     resfunc:=derd;
                     exit;
                     end;{denominator error}
item1:=FunctionProduct(dern,denominator);
item2:=FunctionProduct(numerator,derd);
resn:=FunctionDifference(item1,item2);
resd:=FunctionProduct(denominator,denominator);
resfunc:=FunctionDivision(resn,resd);
end;{MultDerivative}

function ProductDerivative(subfuncs:TSArray; operators:TCharArray; variable:string;var resfunc:string):boolean;overload;
var len : integer;
    op : char;
    func1, func2:string;
begin
resfunc:='';
len := Length(operators);
case len of
0: begin
   result:=false;
   resfunc:=DerivativeError+'(in Product Derivative)';
   exit;
   end;{0}
1:begin
  op:=operators[0];
  func1:=subfuncs[0];
  func2:=subfuncs[1];
  end;{1}
else begin
     op:=operators[len-1];
     func2:=subfuncs[len];
     Setlength(operators,len-1);
     Setlength(subfuncs,len);
     func1:=FunctionProducts(subfuncs,operators);
     end;{else}
end;{case len}
case op of
MultSign : begin
           result:=MultAntiDerivative(func1,func2,variable,resfunc);
           end;{MultSign}
DivSign : begin
          result:=DivisionDerivative(func1,func2,variable,resfunc);
          end;{DivSign}
else result:=false;
end;{case op}
end;{ProductDerivative}

function ProductDerivative(func,variable:string;var resfunc:string):boolean;overload;
var subfuncs : TSArray;
    operators : TCharArray;
begin
DeFact(func,subfuncs,operators);
result:=ProductDerivative(subfuncs,operators,variable,resfunc);
end;{ProductDerivative}

function SumDerivative(func,variable:string;var resfunc:string):boolean;
var subfuncs, subders : TSArray;
    operators : TCharArray;
    errordescription:string;
begin
resfunc:='';
DeCompose(func,subfuncs,operators);
Result := Derivative(subfuncs,variable,subders,errordescription);
if not Result then begin
                   resfunc:=errordescription;
                   exit;
                   end;{error}
resfunc:=FunctionComposition(subders,operators);
end;{SumDerivative}

// ( f(x)^a )' = a * f(x)^(a-1) * f'(x) where a=const
// ( a^f(x) )' = ln(a)*a^f(x) * f'(x) where a=const
// ( f(x)^g(x) )' =  ln(f(x)) * f(x)^g(x) * g'(x) +
//                 + g(x) * f(x)^(g(x)-1) * f'(x)
function PowerDerivative(arg,pow,variable:string;var resfunc:string):boolean;
var zpow,zarg:extended;
    dpow,darg,mult,item1,item2,thepow:string;
begin
result:=false;
resfunc:='';
DeleteAllSuperfluousBracketsAndBlanks(arg);
DeleteAllSuperfluousBracketsAndBlanks(pow);
if SIsReal(pow,zpow) then Begin
                          if not Derivative(arg,variable,darg) then begin
                                                                    resfunc:=darg;
                                                                    exit;
                                                                    end;{error}
                          dpow:=FloatToStr(zpow-1.0);
                          dpow:=FunctionPower(arg,dpow);
                          dpow:=FunctionProduct(pow,dpow);
                          resfunc:=FunctionProduct(dpow,darg);
                          End{ Power is real}
else
if IsFunctionConstByVariable(pow,variable)
then Begin
     if not Derivative(arg,variable,darg) then begin
                                               resfunc:=darg;
                                               exit;
                                               end;{error}
     dpow:=FunctionDifference(pow,UnitStringChar);
     dpow:=FunctionPower(arg,dpow);
     dpow:=FunctionProduct(pow,dpow);
     resfunc:=FunctionProduct(dpow,darg);
     End{ Power is const function}
else
if SIsReal(arg,zarg)
   or IsFunctionConstByVariable(arg,variable)
   then Begin
        if not Derivative(pow,variable,dpow) then begin
                                                  resfunc:=dpow;
                                                  exit;
                                                  end;{error}
        darg:=FunctionPower(arg,pow);
        mult:=NamesSF[sfLn]+LeftBrckt+arg+RightBrckt;
        darg:=FunctionProduct(mult,darg);
        resfunc:=FunctionProduct(darg,dpow);
        End{ Argument is real or const function}
else Begin
     dpow:='';
     darg:='';
     if (not Derivative(pow,variable,dpow)) then begin
                                                 resfunc:=dpow;
                                                 exit;
                                                 end;{error}
     if (not Derivative(arg,variable,darg)) then begin
                                                 resfunc:=darg;
                                                 exit;
                                                 end;{error}
     thepow:=FunctionPower(arg,pow);
     mult:=NamesSF[sfLn]+LeftBrckt+arg+RightBrckt;
     item1:=FunctionProduct(thepow,dpow);
     item1:=FunctionProduct(mult,item1);
     mult:=FunctionDifference(pow,UnitStringChar);
     thepow:=FunctionPower(arg,mult);
     item2:=FunctionProduct(pow,thepow);
     item2:=FunctionProduct(item2,darg);
     resfunc:=FunctionSum(item1,item2);
     End;{else}
result:=true;
end;{PowerDerivative}

function FormulaAttributes(func:string; DecomposeComplex:boolean):TFormulaAttributes;
var value : extended;
    index,len : integer;
    index1,index2,name,arg,opl,opr : string;
    stf : TStandFunction;
    spf : TSpecialFunction;
    bot : TBooleanOperator;
    subs : TSArray;
    opers : TCharArray;
    prms : TSArray;
begin
result:=NILFormulaAttributes;
result.TheFormula:=func;
if SIsReal(func,value) then Begin
                            result.TheType:=ftValue;
                            result.Name:=func;
                            result.Value:=value;
                            End{real}
else
if SIsConst(func,value,index) then Begin
                                   result.TheType:=ftConst;
                                   result.Name:=func;
                                   result.Index:=index;
                                   result.Value:=value;
                                   End{const}
else
if SIsVar(func) then Begin
                     result.TheType:=ftName;
                     result.Name:=func;
                     End{variable}
else
if SIsArrayItem(func,name,index1) then Begin
                                       result.TheType:=ftArrayItem;
                                       result.Name:=name;
                                       result.Index1:=index1;
                                       End{array item}
else
if SIsMatrixItem(func,name,index1,index2) then Begin
                                               result.TheType:=ftMatrixItem;
                                               result.Name:=name;
                                               result.Index1:=index1;
                                               result.Index2:=index2;
                                               End{matrix item}
else
if SIsOfFunctionForm(func,name,arg) then BEGIN
result.Name:=name;
if SIsSFName(name,stf) then Begin
                            result.TheType:=ftStandardFunction;
                            result.Name:=name;
                            result.TheFunction:=stf;
                            result.Argument:=arg;
                            End{standard function}
else
if SIsSpecFName(name,spf) then Begin
                               result.TheType:=ftSpecialFunction;
                               result.TheSpecial:=spf;
                               result.Name:=name;
                               DetParameters(arg,SpecFuncSep,prms);
                               result.SpecialArguments:=prms;
                               len:=Length(prms);
                               if (SpecialFunctionParameters[spf]>=0)
                                  and(len<>SpecialFunctionParameters[spf])
                                  then result.Error:=feArgLost;
                               End{special function}
else
if SIsDeg(func,name,opl,opr) then Begin
                                  result.TheType:=ftPower;
                                  result.Name:=name;
                                  result.LOperand:=opl;
                                  result.ROperand:=opr;
                                  End{power}
else
if SIsBO(name,arg,bot,opl,opr) then Begin
                                    result.TheType:=ftBoolean;
                                    result.Name:=name;
                                    result.TheBoolean:=bot;
                                    result.LOperand:=opl;
                                    result.ROperand:=opr;
                                    End{bollean operator}
else Begin
     result.TheType:=ftUnknown;
     End{ unknown function form }
END{ func of function form }
else
if   FuncIsPower(func,name,opl,opr) then Begin
                                         result.TheType:=ftPower;
                                         result.Name:=name;
                                         result.LOperand:=opl;
                                         result.ROperand:=opr;
                                         End{power}
else
if SIsMultFunc(func) then Begin
                          result.TheType:=ftProduct;
                          if DecomposeComplex then begin
                          DeFact(func,subs,opers);
                          result.SubFunctions:=subs;
                          result.Operators:=opers;
                          end;{decompose complex}
                          End{product}
else Begin
     result.TheType:=ftComposition;
     if DecomposeComplex then begin
     DeCompose(func,subs,opers);
     result.SubFunctions:=subs;
     result.Operators:=opers;
     end;{decompose complex}
     End;{sum}
end;{FormulaAttributes}

function FormulaAttributes(func:string; DecomposeComplex:boolean;
                           const vars:TVariables;
                           const arrs:TNamedArrays;
                           const matrs:TNamedMatrices):TFormulaAttributes;overload;
var indx : integer;
begin
Result := FormulaAttributes(func,DecomposeComplex);
case Result.TheType of
ftName : Begin
         if not ExistVar(Result.Name,vars,indx) then exit;
         Result.Index:=indx;
         End;{ftName}
ftArrayItem : Begin
              if not ExistArr(Result.Name,arrs,indx) then exit;
              Result.Index:=indx;
              End;{ftArrayItem}
ftMatrixItem : Begin
               if not ExistMatr(Result.Name,matrs,indx) then exit;
               Result.Index:=indx;
               End;{ftMatrixItem}
end;{case TheType}
end;{FormulaAttributes}

function ErrorInDerivativeFunction(const func:string;var error:TFormulaError;
                                   var wrongpart,wrong:string):boolean;
var s:string;
    c:char;
begin
result:=false;
error:=feNoerror;
wrongpart:='';
wrong:='';
s:=func;

if (SIsEmpty(s)) then begin
                      result:=true;
                      error:=feEmptyFormula;
                      wrongpart:=func;
                      end{empty}
else
if WrongCharInS(s,c) then begin
                          result:=true;
                          error:=feWrongSymbol;
                          wrong:=c;
                          wrongpart:=func;
                          end{ wrong symbol }
else
if NotTwiceInS(s,wrong) then begin
                             result:=true;
                             error:=feSubsequentSymbols;
                             wrongpart:=func;
                             end{ subsequent symbols }
else
if BracketsError(s,error) then Begin
                               result:=true;
                               wrongpart:=func;
                               End{brackets}
else
if PowerError(s,wrongpart) then Begin
                                result:=true;
                                error:=feWrongPower;
                                End{power error}
else
if UnKnownConstruction(s,wrong) then Begin
                                     result:=true;
                                     wrongpart:=func;
                                     error:=feWrongConstruction;
                                     End{construction}

else ;
end;{ErrorInDerivativeFunction}

function DerivativeFunctionErrorString(error:TFormulaError;func,wrongpart,wrong:string):string;
var s:string;
begin
case error of
feNoerror : s:='';
feEmptyFormula : s:='Empty formula.';
feWrongSymbol : s:='Wrong symbol "'+wrong+'" in formula part "'+wrongpart+'".';
feSubsequentSymbols : s:='Not allowed subsequent symbols "'+wrong+'" in "'+wrongpart+'".';
feLeftBracket : s:='Right bracket "'+RightBrckt+'" is expected in "'+wrongpart+'".';
feRightBracket : s:='Unexpected right bracket "'+RightBrckt+'" in "'+wrongpart+'".';
feWrongPower : s:='Wrong power construction in "'+wrongpart+'".';
feUnknownFunction : s:='Unknown function "'+wrong+'" in "'+wrongpart+'".';
feArgumentLost : s:='Argument lost in "'+wrongpart+'".';
feWrongConstruction : s:='Wrong construction "'+wrong+'" in "'+wrongpart+'".';
end;{case error}
result:='Error in formula "'+func+'".'+#13+s;
end;{DerivativeFunctionErrorString}

procedure ShowDerivativeFunctionErrorMessage(error:TFormulaError;func,wrongpart,wrong:string);
var s:string;
begin
s:=DerivativeFunctionErrorString(error,func,wrongpart,wrong);
MessageDlg(s,mtInformation,[mbOk],0);
end;{ShowDerivativeFunctionErrorMessage}

function FindErrorInDerivativeFunction(const func:string;var description:string):boolean;
var wrong, wrongpart :string;
    error : TFormulaError;
begin
description:='';
result:=ErrorInDerivativeFunction(func,error,wrongpart,wrong);
if result then description:=DerivativeFunctionErrorString(error,func,wrongpart,wrong);
end;{FindErrorInDerivativeFunction}

function ControlDerivativeFunction(const func:string):boolean;overload;
var wrong, wrongpart :string;
    error : TFormulaError;
begin
result:=ErrorInDerivativeFunction(func,error,wrongpart,wrong);
if result then ShowDerivativeFunctionErrorMessage(error,func,wrongpart,wrong);
end;{ControlDerivativeFunction}

function Derivative(func,variable:string;var resfunc:string):boolean;overload;
var attributes : TFormulaAttributes;
begin
result:=false;
resfunc:='';
DeleteBlanks(variable);
DeleteAllSuperfluousBracketsAndBlanks(func);
attributes:=FormulaAttributes(func,false);
case attributes.TheType of
ftUnknown : Begin
            resfunc:=DerivativeUnknown;
            exit;
            End;{ftUnknown}
ftError : Begin
          resfunc:=DerivativeError;
          exit;
          End;{ftError}
ftValue,
ftConst : Begin
          resfunc:=Func+MultSign+Variable;
          End;{ftValue,ftConst}
ftName,
ftArrayItem,
ftMatrixItem : Begin
               if (attributes.TheFormula=variable)
               then resfunc:=LeftBrckt+variable+PowerOp+'2'+RightBrckt+DivSign+LeftBrckt+'2'+RightBrckt
               else resfunc:=ZeroStringChar;
               End;{ftName,ftArrayItem,ftMatrixItem}
ftStandardFunction : Begin
                     result:=StandardFunctionDerivative(attributes.TheFunction,
                                                        attributes.Argument,
                                                        variable,resfunc);
                     if (not result) then exit;
                     End;{ftStandardFunction}
ftSpecialFunction :  Begin
                     result:=SpecialFunctionDerivative(attributes.TheSpecial,
                                                        attributes.SpecialArguments,
                                                        variable,resfunc);
                     if not result then exit;
                     End;{ftSpecialFunction}
ftPower : Begin
          Result:=PowerDerivative(attributes.LOperand,attributes.ROperand,variable,resfunc);
          if (not result) then exit;
          End;{ftPower}
ftProduct : Begin
            result := ProductDerivative(attributes.TheFormula,variable,resfunc);
            if (not result) then exit;
            End;{ftProduct}
ftComposition : Begin
                result:=SumDerivative(attributes.TheFormula,variable,resfunc);
                if (not result) then exit;
                End;{ftComposition}
ftBoolean : Begin
            resfunc:=DerivativeNotAllowedFunction+'('+NamesBO[attributes.TheBoolean]+')';
            exit;
            End;{ftBoolean}
end;{case TheType}

Simplify(resfunc);
result:=true;
end;{Derivative}

function Derivative(funcs:TSArray;variable:string;var resfuncs:TSArray;var errordescription:string):boolean;overload;
var i, len :integer;
begin
result:=false;
errordescription:='';
len := Length(funcs);
setlength(resfuncs,len);
for i:=0 to len-1 do begin
                     Result := Derivative(funcs[i],variable,resfuncs[i]);
                     if not result then begin
                                        errordescription:=resfuncs[i];
                                        exit;
                                        end;{error}
                     end;{for i}
end;{Derivative}

function Derivative(funcs:TSArray;variable:string;var resfuncs:TSArray):boolean;overload;
var errordescription:string;
begin
result:=Derivative(funcs,variable,resfuncs,errordescription);
end;{Derivative}

function Derivative(func:TSVec;variable:string;var resfunc:TSVec):boolean;overload;
var i :integer;
begin
for i:=1 to MKV do begin
                   Result := Derivative(func[i],variable,resfunc[i]);
                   if not result then exit;
                   end;{for i}
end;{Derivative}

function Derivative(func,variable:TSVec;var resfunc:TSTenz):boolean;overload;
var i, j :integer;
begin
for i:=1 to MKV do
for j:=1 to MKV do begin
                   Result := Derivative(func[i],variable[j],resfunc[(i-1)*MKV+j]);
                   if not result then exit;
                   end;{for i}
end;{Derivative}
{---------------------Derivative Implementation end----------------------------}

function StrFunctionDerivative(params:TSArray;var resfunc:string):boolean;
begin
resfunc:='';
result:=(Length(params)=2);
if not result then exit;
result:=Derivative(params[0],params[1],resfunc);
end;{StrFunctionDerivative}

function StrFunctionSubstring(params:TSArray;var resfunc:string):boolean;
begin
resfunc:='';
result:=(Length(params)=3);
if not result then exit;
resfunc:=Copy(params[0],StrToInt(params[1]),StrToInt(params[2]));
end;{StrFunctionSubstring}

function StrFunctionConcatenate(params:TSArray;var resfunc:string):boolean;
var i,len:integer;
begin
len:=Length(params);
resfunc:='';
for i:=0 to len-1 do resfunc:=resfunc+params[i];
result:=true;
end;{StrFunctionConcatenate}

function StrFunctionDelete(params:TSArray;var resfunc:string):boolean;
begin
resfunc:='';
result:=(Length(params)=3);
if not result then exit;
resfunc:=params[0];
Delete(resfunc,StrToInt(params[1]),StrToInt(params[2]));
end;{StrFunctionDelete}

function StrFunctionInsert(params:TSArray;var resfunc:string):boolean;
begin
resfunc:='';
result:=(Length(params)=3);
if not result then exit;
resfunc:=params[1];
Insert(params[0],resfunc,StrToInt(params[2]));
end;{StrFunctionInsert}

function StrFunctionReplace(params:TSArray;var resfunc:string):boolean;
begin
resfunc:='';
result:=(Length(params)=3);
if not result then exit;
resfunc:=ReplaceAllSubstrings(params[0],params[1],params[2]);
end;{StrFunctionReplace}

function StrFunction(funcname:string;params:TSArray;var resfunc:string):boolean;
var strf:TStrFunction;
begin
result:=false;
resfunc:='';
if not SIsStrFName(funcname,strf) then exit;
case strf of
strNone: ;
strDerivative: begin
               result:=StrFunctionDerivative(params,resfunc);
               end;{strDerivative}
strSubstring: begin
              result:=StrFunctionSubstring(params,resfunc);
              end;{strSubstring}
strConcatenate: begin
                result:=StrFunctionConcatenate(params,resfunc);
                end;{strConcatenate}
strDelete: begin
           result:=StrFunctionDelete(params,resfunc);
           end;{strDelete}
strInsert: begin
           result:=StrFunctionInsert(params,resfunc);
           end;{strInsert}
strReplace: begin
            result:=StrFunctionReplace(params,resfunc);
            end;{strReplace}
else exit;
end;{case strf}
end;{StrFunction}

{-----------------------------------------}
   { TTranslator IMPLEMENTATION begin }
procedure TTranslator.DetMaxVar;
begin
fMaxVar:=length(fVariables)-1;
end;{DetMaxVar}

procedure TTranslator.DetMaxArr;
begin
fMaxArr:=length(fArrays)-1;
end;{DetMaxArr}

procedure TTranslator.DetMaxMatr;
begin
fMaxMatr:=length(fMatrices)-1;
end;{DetMaxMatr}

procedure TTranslator.DetMaxStr;
begin
fMaxStr:=length(fStrings)-1;
end;{DetMaxStr}

procedure TTranslator.DetAllMaxParameters;
begin
DetMaxVar;
DetMaxArr;
DetMaxMatr;
DetMaxStr;
end;{DetMaxStr}

function TTranslator.CheckVariableNum(num:integer):boolean;
begin
result:=(num<0)or(num>fMaxVar);
if result then MessageDLG('Error of Variable number ('+IntToStr(num)+').',
                          mtInformation,[mbOk],0);
end;{CheckVariableNum}

function TTranslator.CheckArrayNum(num:integer):boolean;
begin
result:=(num<0)or(num>fMaxArr);
if result then MessageDLG('Error of Array number ('+IntToStr(num)+').',
                          mtInformation,[mbOk],0);
end;{CheckArrayNum}

function TTranslator.CheckMatrixNum(num:integer):boolean;
begin
result:=(num<0)or(num>fMaxMatr);
if result then MessageDLG('Error of Matrix number ('+IntToStr(num)+').',
                          mtInformation,[mbOk],0);
end;{CheckMatrixNum}

function TTranslator.CheckStringNum(num:integer):boolean;
begin
result:=(num<0)or(num>fMaxStr);
if result then MessageDLG('Error of String number ('+IntToStr(num)+').',
                           mtInformation,[mbOk],0);
end;{CheckStringNum}

function TTranslator.CheckVariableName(var name:string;var num:integer):boolean;
begin
result:=not VariableExists(name,num);
if result then MessageDLG('Error of Variable Name "'+name+'".',
               mtError,[mbOk],0);
end;{CheckVariableName}

function TTranslator.CheckArrayName(var name:string;var num:integer):boolean;
begin
result:=not ArrayExists(name,num);
if result then MessageDLG('Error of Array Name "'+name+'".',
               mtError,[mbOk],0);
end;{CheckArrayName}

function TTranslator.CheckMatrixName(var name:string;var num:integer):boolean;
begin
result:=not MatrixExists(name,num);
if result then MessageDLG('Error of Matrix Name "'+name+'".',
               mtError,[mbOk],0);
end;{CheckMatrixName}

function TTranslator.CheckNameExists(var name:string;var typ:TTranslatorParameterType):boolean;
begin
result:= SomethingExists(name,typ);
if result then MessageDLG('Variable, Array, Matrix or String with name "'+name+'" already exists.',
               mtError,[mbOk],0);
end;{CheckNameExists}

function TTranslator.DeleteButVariable(name:string):boolean;
var num:integer;
begin
if ArrayExists(name,num) then result:=DeleteArray(num)
else if MatrixExists(name,num) then result:=DeleteMatrix(num)
else if StringExists(name,num) then result:=DeleteString(num)
else result:=false;
end;{DeleteButVariable}

function TTranslator.DeleteButArray(name:string):boolean;
var num:integer;
begin
if VariableExists(name,num) then result:=DeleteVariable(num)
else if MatrixExists(name,num) then result:=DeleteMatrix(num)
else if StringExists(name,num) then result:=DeleteString(num)
else result:=false;
end;{DeleteButArray}

function TTranslator.DeleteButMatrix(name:string):boolean;
var num:integer;
begin
if VariableExists(name,num) then result:=DeleteVariable(num)
else if ArrayExists(name,num) then result:=DeleteArray(num)
else if StringExists(name,num) then result:=DeleteString(num)
else result:=false;
end;{DeleteButMatrix}

function TTranslator.DeleteButString(name:string):boolean;
var num:integer;
begin
if VariableExists(name,num) then result:=DeleteVariable(num)
else if ArrayExists(name,num) then result:=DeleteArray(num)
else if MatrixExists(name,num) then result:=DeleteMatrix(num)
else result:=false;
end;{DeleteButString}

function TTranslator.NewVariable(name,val:string):boolean;
var z:extended;
begin
result:=false;
if FormulaControlE(val,fVariables,fArrays,fMatrices) then exit;
z:=FormulaValue(val,fVariables,fArrays,fMatrices);
AddVar(name,z,fVariables);
DetMaxVar;
DeleteButVariable(fVariables[fMaxVar].Name);
result:=true;
end;{NewVariable}

function TTranslator.NewVariableValue(num:integer;val:string):boolean;
var z:extended;
begin
result:=false;
if CheckVariableNum(num) then exit;
if FormulaControlE(val,fVariables,fArrays,fMatrices) then exit;
z:=FormulaValue(val,fVariables,fArrays,fMatrices);
fVariables[num].Value:=z;
result:=true;
end;{NewVariableValue}

function TTranslator.NewArray(name,len:string):boolean;
var n:integer;
begin
result:=false;
if FormulaControlE(len,fVariables,fArrays,fMatrices) then exit;
n:=round(FormulaValue(len,fVariables,fArrays,fMatrices));
AddArr(name,n,fArrays);
DetMaxArr;
DeleteButArray(fArrays[fMaxArr].Name);
result:=true;
end;{NewArrayLength}

function TTranslator.NewArrayLength(num:integer;len:string):boolean;
var n:integer;
begin
result:=false;
if CheckArrayNum(num) then exit;
if FormulaControlE(len,fVariables,fArrays,fMatrices) then exit;
n:=round(FormulaValue(len,fVariables,fArrays,fMatrices));
if CheckAllowedLength(n) then exit;
SetArrayLength(n,fArrays[num]);
result:=true;
end;{NewArrayLength}

function TTranslator.NewMatrix(name,len1,len2:string):boolean;
var n1,n2:integer;
begin
result:=false;
if (FormulaControlE(len1,fVariables,fArrays,fMatrices)
    or FormulaControlE(len2,fVariables,fArrays,fMatrices)) then exit;
n1:=round(FormulaValue(len1,fVariables,fArrays,fMatrices));
n2:=round(FormulaValue(len2,fVariables,fArrays,fMatrices));
AddMatr(name,n1,n2,fMatrices);
DetMaxMatr;
DeleteButMatrix(fMatrices[fMaxMatr].Name);
result:=true;
end;{NewMatrix}

function TTranslator.NewMatrixSizes(num:integer;len1,len2:string):boolean;
var n1,n2:integer;
begin
result:=false;
if CheckMatrixNum(num) then exit;
if (FormulaControlE(len1,fVariables,fArrays,fMatrices)
    or FormulaControlE(len2,fVariables,fArrays,fMatrices)) then exit;
n1:=round(FormulaValue(len1,fVariables,fArrays,fMatrices));
n2:=round(FormulaValue(len2,fVariables,fArrays,fMatrices));
if (CheckAllowedLength(n1) or CheckAllowedLength(n2)) then exit;
SetMatrixSizes(n1,n2,fMatrices[num]);
result:=true;
end;{NewMatrixSizes}

function TTranslator.NewString(name,val:string):boolean;
begin
AddStr(name,val,fStrings);
DetMaxStr;
DeleteButString(fStrings[fMaxStr].Name);
result:=true;
end;{NewString}

function TTranslator.NewStringValue(num:integer;val:string):boolean;
begin
result:=false;
if CheckStringNum(num) then exit;
fStrings[num].Value:=val;
result:=true;
end;{NewStringValue}

function TTranslator.AssignMode(s:string;var name,p1,p2:string;var num:integer):TAssignMode;
var rest:string;
    sel,rempty:boolean;
begin
name:='';
p1:='';
p2:='';
num:=-1;
if ( SIsEmpty(s) ) then result:=amNone
else result:=amFormula;
sel:=SelectAllowedName(s,name,rest);
rempty:=SIsEmpty(rest);
IF sel THEN BEGIN
if rempty then Begin
if (VariableExists(name,num)) then result:=amVariable
else
if (ArrayExists(name,num)) then result:=amArray
else
if (MatrixExists(name,num)) then result:=amMatrix
else
if (StringExists(name,num)) then result:=amString
else
if ((name=s) and (not(s[1] in Digits))) then result:=amName;
End{ rempty }
else Begin
if (name=AssignArrayOper)and(SIsArrayIndex(rest,p1)) then result:=amAssignArray
else
if (name=AssignMatrixOper)and(SIsMatrixIndex(rest,p1,p2)) then result:=amAssignMatrix
else
if (name=AssignStringOper)and(SIsStringParam(rest,p1)) then result:=amAssignString
else
if (SIsArrayIndex(rest,p1)) then result:=amArrayItem
else
if (SIsMatrixIndex(rest,p1,p2)) then begin
                                     if ((p1='')and(p2<>'')) then result:=amMatrixColumn
                                     else
                                     if ((p2='')and(p1<>'')) then result:=amMatrixRow
                                     else result:=amMatrixItem;
                                     end{SIsMatrixIndex}
else
if SIsOfFunctionForm(s,name,p1) then Begin
if (SIsStrFName(Name)) then begin
                            result:=amStringFunction;
                            end{String Function}
End{Function Form}
else ;
End;{ else rempty }
END {IF sel}
ELSE BEGIN

END{ELSE sel};
end;{AssignMode}

function TTranslator.AssignArrayItemValue(num:integer;index,value:string):boolean;
var ind:integer;
    val:extended;
begin
result:=false;
if CheckArrayNum(num) then exit;
if (FormulaControlE(index,fVariables,fArrays,fMatrices)
    or FormulaControlE(value,fVariables,fArrays,fMatrices))
    then exit;
ind:=round(FormulaValue(index,fVariables,fArrays,fMatrices));
if CheckArrayIndex(fArrays[num],ind) then exit;
val:=FormulaValue(value,fVariables,fArrays,fMatrices);
fArrays[num].A[ind]:=val;
result:=true;
end;{AssignArrayItemValue}

function TTranslator.AssignArrayItemValue(name,index,value:string):boolean;
var num:integer;
begin
result:=false;
if CheckArrayName(name,num) then exit;
result:=AssignArrayItemValue(num,index,value);
end;{AssignArrayItemValue}

procedure ConstValue(value:extended;var z:TArray);overload;
var i:integer;
begin
for i:=0 to length(z)-1 do z[i]:=value;
end;{ConstValue}

function TTranslator.AssignArrayValue(num:integer;value:string):boolean;
var val:extended;
begin
result:=false;
if CheckArrayNum(num) then exit;
if FormulaControlE(value,fVariables,fArrays,fMatrices) then exit;
val:=FormulaValue(value,fVariables,fArrays,fMatrices);
ConstValue(val,fArrays[num].A);
result:=true;
end;{AssignArrayValue}

function TTranslator.AssignArrayValue(name,value:string):boolean;
var num:integer;
begin
result:=false;
if CheckArrayName(name,num) then exit;
result:=AssignArrayValue(num,value);
end;{AssignArrayValue}

function TTranslator.AssignMatrixItemValue(num:integer;index1,index2,value:string):boolean;
var ind1,ind2:integer;
    val:extended;
begin
result:=false;
if CheckMatrixNum(num) then exit;
if (FormulaControlE(index1,fVariables,fArrays,fMatrices)
    or FormulaControlE(index2,fVariables,fArrays,fMatrices)
    or FormulaControlE(value,fVariables,fArrays,fMatrices))
    then exit;
ind1:=round(FormulaValue(index1,fVariables,fArrays,fMatrices));
ind2:=round(FormulaValue(index2,fVariables,fArrays,fMatrices));
if CheckMatrixIndexes(fMatrices[num],ind1,ind2) then exit;
val:=FormulaValue(value,fVariables,fArrays,fMatrices);
fMatrices[num].M[ind1][ind2]:=val;
result:=true;
end;{AssignMatrixItemValue}

function TTranslator.AssignMatrixItemValue(name,index1,index2,value:string):boolean;
var num:integer;
begin
result:=false;
if CheckMatrixName(name,num) then exit;
result:=AssignMatrixItemValue(num,index1,index2,value);
end;{AssignMatrixItemValue}

procedure ConstValue(value:extended;var z:TMatr);overload;
var i,m,j,n:integer;
begin
m:=length(z)-1;
for i:=0 to m do Begin
n:=length(z[i])-1;
for j:=0 to n do z[i,j]:=value;
End;{for i}
end;{ConstValue}


function TTranslator.AssignMatrixValue(num:integer;value:string):boolean;
var val:extended;
begin
result:=false;
if CheckMatrixNum(num) then exit;
if FormulaControlE(value,fVariables,fArrays,fMatrices) then exit;
val:=FormulaValue(value,fVariables,fArrays,fMatrices);
ConstValue(val,fMatrices[num].M);
result:=true;
end;{AssignMatrixValue}

function TTranslator.AssignMatrixValue(name,value:string):boolean;
var num:integer;
begin
result:=false;
if CheckMatrixName(name,num) then exit;
result:=AssignMatrixValue(num,value);
end;{AssignMatrixValue}

procedure ConstRowValue(value:extended;num:integer;var z:TMatr);
var m,j,n:integer;
begin
m:=length(z)-1;
if ((num<0)or(num>m)) then exit;
n:=length(z[num])-1;
for j:=0 to n do z[num,j]:=value;
end;{ConstRowValue}

procedure ConstColumnValue(value:extended;num:integer;var z:TMatr);
var i,m,n:integer;
begin
m:=length(z)-1;
if ((num<0)or(m<0)) then exit;
for i:=0 to m do Begin
n:=length(z[i])-1;
if (num>n) then continue;
z[i,num]:=value;
End;{for i}
end;{ConstValue}

procedure ConstValue(value:extended;index,num:integer;var z:TMatr);overload;
begin
case index of
1:ConstRowValue(value,num,z);
2:ConstColumnValue(value,num,z);
end;{case index}
end;{ConstValue}

function TTranslator.AssignMatrixRowValue(num:integer;row,value:string):boolean;
var val:extended;
    rn:integer;
begin
result:=false;
if CheckMatrixNum(num) then exit;
if (FormulaControlE(row,fVariables,fArrays,fMatrices)
    or FormulaControlE(value,fVariables,fArrays,fMatrices) ) then exit;
val:=FormulaValue(value,fVariables,fArrays,fMatrices);
rn:=round(FormulaValue(row,fVariables,fArrays,fMatrices));
ConstValue(val,1,rn,fMatrices[num].M);
result:=true;
end;{AssignMatrixRowValue}

function TTranslator.AssignMatrixRowValue(name,row,value:string):boolean;
var num:integer;
begin
result:=false;
if CheckMatrixName(name,num) then exit;
result:=AssignMatrixRowValue(num,row,value);
end;{AssignMatrixRowValue}

function TTranslator.AssignMatrixColumnValue(num:integer;col,value:string):boolean;
var val:extended;
    cn:integer;
begin
result:=false;
if CheckMatrixNum(num) then exit;
if (FormulaControlE(col,fVariables,fArrays,fMatrices)
    or FormulaControlE(value,fVariables,fArrays,fMatrices) ) then exit;
val:=FormulaValue(value,fVariables,fArrays,fMatrices);
cn:=round(FormulaValue(col,fVariables,fArrays,fMatrices));
ConstValue(val,2,cn,fMatrices[num].M);
result:=true;
end;{AssignMatrixColumnValue}

function TTranslator.AssignMatrixColumnValue(name,col,value:string):boolean;
var num:integer;
begin
result:=false;
if CheckMatrixName(name,num) then exit;
result:=AssignMatrixColumnValue(num,col,value);
end;{AssignMatrixColumnValue}

function TTranslator.AssignToArray(ln,rn:string):boolean;
var rnum:integer;
begin
result:=false;
if ( CheckArrayName(rn,rnum) ) then exit;
result:=AddArray(ln,IntToStr(fArrays[rnum].mi1+1));
if result then result:=AssignArrays(ln,rn);
end;{AssignToArray}

function TTranslator.AssignArrays(ln,rn:integer):boolean;
begin
result:=false;
if ( CheckArrayNum(ln)
    or CheckArrayNum(rn) ) then exit;
AssignArray(fArrays[rn],true,fArrays[ln]);
result:=true;
end;{AssignArrays}

function TTranslator.AssignArrays(ln,rn:string):boolean;
var lnum,rnum:integer;
begin
result:=false;
if ( CheckArrayName(ln,lnum)
    or CheckArrayName(rn,rnum) ) then exit;
result:=AssignArrays(lnum,rnum);
end;{AssignArrays}

function TTranslator.AssignToMatrix(ln,rn:string):boolean;
var rnum:integer;
begin
result:=false;
if ( CheckMatrixName(rn,rnum) ) then exit;
result:=AddMatrix(ln,IntToStr(fMatrices[rnum].mi1+1),IntToStr(fMatrices[rnum].mi2+1));
if result then result:=AssignMatrices(ln,rn);
end;{AssignToMatrix}

function TTranslator.AssignToMatrixRow(ln,rn,row:string):boolean;
var rnum:integer;
begin
result:=false;
if ( CheckMatrixName(rn,rnum) ) then exit;
result:=AddArray(ln,IntToStr(fMatrices[rnum].mi2+1));
if result then result:=AssignArrayWithMatrixRow(ln,rn,row);
end;{AssignToMatrixRow}

function TTranslator.AssignToMatrixColumn(ln,rn,col:string):boolean;
var rnum:integer;
begin
result:=false;
if ( CheckMatrixName(rn,rnum) ) then exit;
result:=AddArray(ln,IntToStr(fMatrices[rnum].mi1+1));
if result then result:=AssignArrayWithMatrixColumn(ln,rn,col);
end;{AssignToMatrixRow}

function TTranslator.AssignMatrices(ln,rn:integer):boolean;
begin
result:=false;
if ( CheckMatrixNum(ln)
    or CheckMatrixNum(rn) ) then exit;
AssignMatrix(fMatrices[rn],true,fMatrices[ln]);
result:=true;
end;{AssignMatrices}

function TTranslator.AssignMatrices(ln,rn:string):boolean;
var lnum,rnum:integer;
begin
result:=false;
if ( CheckMatrixName(ln,lnum)
    or CheckMatrixName(rn,rnum) ) then exit;
result:=AssignMatrices(lnum,rnum);
end;{AssignMatrices}

function TTranslator.AssignArrayWithMatrixRow(ln,rn:integer;num:string):boolean;
var n:integer;
begin
result:=false;
if ( CheckArrayNum(ln)
    or CheckMatrixNum(rn) ) then exit;
if FormulaControlE(num,fVariables,fArrays,fMatrices) then exit;
n:=round(FormulaValue(num,fVariables,fArrays,fMatrices));
if CheckMatrixIndexes(fMatrices[rn],n,0) then exit;
AssignArrayWithMatrixRow(fMatrices[rn],n,true,fArrays[ln]);
result:=true;
end;{AssignArrayWithMatrixRow}

function TTranslator.AssignArrayWithMatrixRow(ln,rn,num:string):boolean;
var lnum,rnum:integer;
begin
result:=false;
if ( CheckArrayName(ln,lnum)
    or CheckMatrixName(rn,rnum) ) then exit;
result:=AssignArrayWithMatrixRow(lnum,rnum,num);
end;{AssignArrayWithMatrixRow}

function TTranslator.AssignArrayWithMatrixColumn(ln,rn:integer;num:string):boolean;
var n:integer;
begin
result:=false;
if ( CheckArrayNum(ln)
    or CheckMatrixNum(rn) ) then exit;
if FormulaControlE(num,fVariables,fArrays,fMatrices) then exit;
n:=round(FormulaValue(num,fVariables,fArrays,fMatrices));
if CheckMatrixIndexes(fMatrices[rn],0,n) then exit;
AssignArrayWithMatrixColumn(fMatrices[rn],n,true,fArrays[ln]);
result:=true;
end;{AssignArrayWithMatrixColumn}

function TTranslator.AssignArrayWithMatrixColumn(ln,rn,num:string):boolean;
var lnum,rnum:integer;
begin
result:=false;
if ( CheckArrayName(ln,lnum)
    or CheckMatrixName(rn,rnum) ) then exit;
result:=AssignArrayWithMatrixColumn(lnum,rnum,num);
end;{AssignArrayWithMatrixColumn}

function TTranslator.AssignMatrixRowWithArray(ln,rn:integer;num:string):boolean;
var n:integer;
begin
result:=false;
if ( CheckMatrixNum(ln)
    or CheckArrayNum(rn) ) then exit;
if FormulaControlE(num,fVariables,fArrays,fMatrices) then exit;
n:=round(FormulaValue(num,fVariables,fArrays,fMatrices));
if CheckMatrixIndexes(fMatrices[ln],n,0) then exit;
AssignMatrixRowWithArray(fArrays[rn],n,false,fMatrices[ln]);
result:=true;
end;{AssignMatrixRowWithArray}

function TTranslator.AssignMatrixRowWithArray(ln,rn,num:string):boolean;
var lnum,rnum:integer;
begin
result:=false;
if ( CheckMatrixName(ln,lnum)
    or CheckArrayName(rn,rnum) ) then exit;
result:=AssignMatrixRowWithArray(lnum,rnum,num);
end;{AssignMatrixRowWithArray}

function TTranslator.AssignMatrixColumnWithArray(ln,rn:integer;num:string):boolean;
var n:integer;
begin
result:=false;
if ( CheckMatrixNum(ln)
    or CheckArrayNum(rn) ) then exit;
if FormulaControlE(num,fVariables,fArrays,fMatrices) then exit;
n:=round(FormulaValue(num,fVariables,fArrays,fMatrices));
if CheckMatrixIndexes(fMatrices[ln],0,n) then exit;
AssignMatrixColumnWithArray(fArrays[rn],n,false,fMatrices[ln]);
result:=true;
end;{AssignMatrixColumnWithArray}

function TTranslator.AssignMatrixColumnWithArray(ln,rn,num:string):boolean;
var lnum,rnum:integer;
begin
result:=false;
if ( CheckMatrixName(ln,lnum)
    or CheckArrayName(rn,rnum) ) then exit;
result:=AssignMatrixColumnWithArray(lnum,rnum,num);
end;{AssignMatrixColumnWithArray}

function TTranslator.AssignMatrixRowWithMatrixRow(ln,rn,numl,numr:string):boolean;
var lnum,rnum:integer;
    numln,numrn:integer;
begin
result:=false;
if ( CheckMatrixName(ln,lnum)
    or CheckMatrixName(rn,rnum) ) then exit;
if ( ControlFormulaError(numl)
    or ControlFormulaError(numr) ) then exit;
numln:=round(CalculateValue(numl));
if CheckMatrixIndexes(fMatrices[lnum],numln,0) then exit;
numrn:=round(CalculateValue(numr));
if CheckMatrixIndexes(fMatrices[rnum],numrn,0) then exit;
AssignMatrixRowWithMatrixRow(fMatrices[rnum],numrn,numln,false,fMatrices[lnum]);
result:=true;
end;{AssignMatrixRowWithMatrixRow}

function TTranslator.AssignMatrixColWithMatrixCol(ln,rn,numl,numr:string):boolean;
var lnum,rnum:integer;
    numln,numrn:integer;
begin
result:=false;
if ( CheckMatrixName(ln,lnum)
    or CheckMatrixName(rn,rnum) ) then exit;
if ( ControlFormulaError(numl)
    or ControlFormulaError(numr) ) then exit;
numln:=round(CalculateValue(numl));
if CheckMatrixIndexes(fMatrices[lnum],0,numln) then exit;
numrn:=round(CalculateValue(numr));
if CheckMatrixIndexes(fMatrices[rnum],0,numrn) then exit;
AssignMatrixColWithMatrixCol(fMatrices[rnum],numrn,numln,false,fMatrices[lnum]);
result:=true;
end;{AssignMatrixColWithMatrixCol}

function TTranslator.AssignMatrixRowWithMatrixCol(ln,rn,numl,numr:string):boolean;
var lnum,rnum:integer;
    numln,numrn:integer;
begin
result:=false;
if ( CheckMatrixName(ln,lnum)
    or CheckMatrixName(rn,rnum) ) then exit;
if ( ControlFormulaError(numl)
    or ControlFormulaError(numr) ) then exit;
numln:=round(CalculateValue(numl));
if CheckMatrixIndexes(fMatrices[lnum],numln,0) then exit;
numrn:=round(CalculateValue(numr));
if CheckMatrixIndexes(fMatrices[rnum],0,numrn) then exit;
AssignMatrixRowWithMatrixCol(fMatrices[rnum],numrn,numln,false,fMatrices[lnum]);
result:=true;
end;{AssignMatrixRowWithMatrixCol}

function TTranslator.AssignMatrixColWithMatrixRow(ln,rn,numl,numr:string):boolean;
var lnum,rnum:integer;
    numln,numrn:integer;
begin
result:=false;
if ( CheckMatrixName(ln,lnum)
    or CheckMatrixName(rn,rnum) ) then exit;
if ( ControlFormulaError(numl)
    or ControlFormulaError(numr) ) then exit;
numln:=round(CalculateValue(numl));
if CheckMatrixIndexes(fMatrices[lnum],0,numln) then exit;
numrn:=round(CalculateValue(numr));
if CheckMatrixIndexes(fMatrices[rnum],numrn,0) then exit;
AssignMatrixColWithMatrixRow(fMatrices[rnum],numrn,numln,false,fMatrices[lnum]);
result:=true;
end;{AssignMatrixColWithMatrixRow}

function TTranslator.TransformStrFunctionParameters(var params:TSArray):boolean;
var i,len,num:integer;
    z:extended;
    typ: TTranslatorParameterType;
    value:string;
    desc: string;
begin
result:=false;
len:=length(params);
for i:=0 to len-1 do Begin
if SomethingExists(params[i],typ,num) then begin
                                           if typ=tptString // if String suppose value use
                                           then params[i]:=fStrings[num].Value
                                           else ; // else suppose name use
                                           end{name exists}
else
if SIsStringConst(params[i],value) then begin
                                        params[i]:=value;
                                        end{str parameter}
else begin // else suppose formula
     if FindErrorInFormula(params[i],fVariables,fArrays,fMatrices,desc) then exit;
     z:=CalculateValue(params[i]);
     params[i]:=IntToStr(round(z));
     end{formula}
End;{for i}
result:=true;
end;{TransformStrFunctionParameters}

function TTranslator.AssignStringFunction(name,fname,params:string):boolean;
var aparams:TSArray;
    len:integer;
    resfunc: string;
begin
len:=DetParameters(params,StrFuncSep,aparams);
result:=TransformStrFunctionParameters(aparams);
if not result then exit;
result:=StrFunction(fname,aparams,resfunc);
if not result then exit;
result:=AddString(name,resfunc);
end;{AssignStringFunction}

function TTranslator.AssignStrings(left,right:string):boolean;
var lnum,rnum:integer;
begin
result:=false;
if not StringExists(left,lnum) then exit;
if not StringExists(right,rnum) then exit;
fStrings[lnum].Value:=fStrings[rnum].Value;
result:=true;
end;{AssignStrings}

function TTranslator.AssignStringToOther(left,right,ln,lp1,lp2:string;lmode:TAssignMode;lnum:integer):boolean;
var rnum:integer;
begin
result:=false;
if not StringExists(right,rnum) then exit;
result:=Assign(left,fStrings[rnum].Value,lmode,amFormula,ln,lp1,lp2,right,'','',lnum,rnum);
end;{AssignStringToOther}

function TTranslator.GetVariableNames(index:integer):string;
begin
if ( (index<0)or(index>=length(fVariables)) ) then result:=''
else result:=fVariables[index].Name;
end;{GetVariableNames}

function TTranslator.GetVariableValues(index:string):extended;
var num:integer;
begin
if VariableExists(index,num) then result:=fVariables[num].Value
else result:=NAN;
end;{GetVariableValues}

procedure TTranslator.SetVariableValues(index:string;value:extended);
var num:integer;
begin
if VariableExists(index,num) then begin
                                  fVariables[num].Value:=value;
                                  end;
end;{SetVariableValues}

function TTranslator.GetVariableStringValues(index: string): string;
begin
result:=FloatToStr(VariableValues[index]);
end;{GetVariableStringValues}

procedure TTranslator.SetVariableStringValues(index: string;
  const Value: string);
var evalue:extended;
    num:integer;
begin
if (not (VariableExists(index,num)))
   or ControlFormulaError(value) then exit;
evalue:=CalculateValue(value);
VariableValues[index]:=evalue;
end;{SetVariableStringValues}

function TTranslator.GetVariablesNumber:integer;
begin
result:=length(fVariables);
end;{GetVariablesNumber}

class function TTranslator.CommandCase(str:string;var command,params:string):TTranslatorCommand;
begin
result:=tcUnknown;
FirstWord(str,command,params);

if TStructuredStatement.IsItBeginOfCycle(command) then Begin
result:=tcBeginCycle;
exit;
End;{IsItBeginOfCycle}

if TStructuredStatement.IsItEndOfCycle(command) then Begin
result:=tcEndCycle;
exit;
End;{IsItEndOfCycle}

if TStructuredStatement.IsItContinueStatement(command) then Begin
result:=tcContinue;
exit;
End;{IsItContinueStatement}

if TStructuredStatement.IsItBreakStatement(command) then Begin
result:=tcBreak;
exit;
End;{IsItBreakStatement}

if TStructuredStatement.IsItExitStatement(command) then Begin
result:=tcExit;
exit;
End;{IsItExitStatement}

if TStructuredStatement.IsItBeginOfIf(command) then Begin
result:=tcBeginIf;
exit;
End;{IsItBeginOfIf}

if TStructuredStatement.IsItEndOfIf(command) then Begin
result:=tcEndIf;
exit;
End;{IsItEndOfIf}

if TStructuredStatement.IsItElseOfIf(command) then Begin
result:=tcElseIf;
exit;
End;{IsItElseOfIf}

end;{CommandCase}


function TTranslator.LastStatement:integer;
begin
result:=length(fStatements)-1;
end;{LastStatement}

function TTranslator.AddCycle(params:TSArray;bline,eline:integer):boolean;
var cycle:TForCycle;
begin
result:=false;
cycle:=TForCycle.Create(self,params[0],params[1],params[2],params[3],bline,eline);
if cycle.CreationError then Begin
cycle.Destroy;
End{if error}
else Begin
TStructuredStatement.AddStatement(fStatements);
fStatements[LastStatement]:=cycle;
End;{else}
end;{AddCycle}

function TTranslator.AddIfStatement(params:TSArray;bline,elseline,eline:integer):boolean;
var ifst:TIfStatement;
begin
result:=false;
ifst:=TIfStatement.Create(self,params[0],bline,elseline,eline);
if ifst.CreationError then Begin
ifst.Destroy;
End{if error}
else Begin
TStructuredStatement.AddStatement(fStatements);
fStatements[LastStatement]:=ifst;
End;{else}
end;{AddCycle}

{}
class function TTranslator.CheckAllowedLength(var len:integer):boolean;
begin
result:=true;
if (len<0) then Begin
                MessageDLG('Error of Array/MAtrix length ('
                           +IntToStr(len)+')'+#13
                           +'Value 0 is assigned.',
                           mtInformation,[mbOk],0);
                len:=0;
                End{if}
else result:=false;
end;{CheckAllowedLength}

class procedure TTranslator.SetArrayLength(len:integer;var z:TNamedArray);
begin
z.mi1:=len-1;
SetLength(z.A,len);
end;{SetArrayLength}

class procedure TTranslator.SetMatrixSizes(len1,len2:integer;var z:TNamedMatrix);
begin
z.mi1:=len1-1;
z.mi2:=len2-1;
SetLength(z.M,len1,len2);
end;{SetMatrixSizes}

class function TTranslator.CheckArrayIndex(a:TNamedArray;index:integer):boolean;
begin
result:=(index<0)or(index>a.mi1);
end;{CheckArrayIndex}

class function TTranslator.CheckMatrixIndexes(m:TNamedMatrix;index1,index2:integer):boolean;
begin
result:=  (index1<0)or(index1>m.mi1)
        or (index2<0)or(index2>m.mi2);
end;{CheckMatrixIndexes}

procedure AssignArray(source:TArray;setlen:boolean;var res:TArray);
var i,n,sl,rl:integer;
begin
sl:=length(source);
if setlen then SetLength(res,sl);
rl:=length(res);
if (rl<sl) then n:=rl-1
else n:=sl-1;
for i:=0 to n do res[i]:=source[i];
end;{AssignArray}

procedure AssignMatrix(source:TMatr;setlen:boolean;var res:TMatr);
var i,n,sl,rl:integer;
begin
sl:=length(source);
if setlen then SetLength(res,sl);
rl:=length(res);
if (rl<sl) then n:=rl-1
else n:=sl-1;
for i:=0 to n do AssignArray(source[i],setlen,res[i]);
end;{AssignMatrix}

procedure FreeMemory(var x:TArray);overload;
begin
SetLength(x,0);
end;{FreeMemory}

procedure FreeMemory(var x:TMatr);overload;
var i,n:integer;
begin
n:=length(x);
for i:=0 to n-1 do FreeMemory(x[i]);
SetLength(x,0);
end;{FreeMemory}

procedure AssignArrayWithMatrixRow(source:TMatr;num:integer;setlen:boolean;var res:TArray);
var n:integer;
begin
FreeMemory(res);
n:=length(source)-1;
if (n<0)or(num<0)or(num>n) then exit;
AssignArray(source[num],setlen,res);
end;{AssignArrayWithMatrixRow}

procedure AssignArrayWithMatrixColumn(source:TMatr;num:integer;setlen:boolean;var res:TArray);
var sl,rl,i,n:integer;
begin
sl:=length(source);
if setlen then SetLength(res,sl);
rl:=length(res);
if (rl<sl) then n:=rl-1
else n:=sl-1;
if (n<0)or(num<0)or(num>n) then  FreeMemory(res)
else Begin
for i:=0 to n do res[i]:=source[i][num];
End;{else}
end;{AssignArrayWithMatrixColumn}

procedure AssignMatrixRowWithArray(source:TArray;num:integer;setlen:boolean;var res:TMatr);
var n:integer;
begin
n:=length(res)-1;
if (n<0)or(num<0)or(num>n) then exit;
AssignArray(source,setlen,res[num]);
end;{AssignMatrixRowWithArray}

procedure AssignMatrixColumnWithArray(source:TArray;num:integer;setlen:boolean;var res:TMatr);
var sl,rl,i,n,k:integer;
begin
sl:=length(source);
if setlen then SetLength(res,sl);
rl:=length(res);
if (rl<sl) then n:=rl-1
else n:=sl-1;
if (n<0)or(num<0) then exit
else
for i:=0 to n do Begin
                 k:=length(res[i]);
                 if (k>num) then res[i][num]:=source[i];
                 End;{for i}
end;{AssignMatrixColumnWithArray}

class procedure TTranslator.AssignArray(source:TNamedArray;setlen:boolean;var res:TNamedArray);
begin
Analytics.AssignArray(source.A,setlen,res.A);
res.mi1:=length(res.A)-1;
end;{AssignArray}

class procedure TTranslator.AssignMatrix(source:TNamedMatrix;setlen:boolean;var res:TNamedMatrix);
var n:integer;
begin
Analytics.AssignMatrix(source.M,setlen,res.M);
n:=length(res.M)-1;
res.mi1:=n;
if (n<0) then res.mi2:=-1
else res.mi2:=length(res.M[0])-1;
end;{AssignArray}

class procedure TTranslator.AssignArrayWithMatrixRow(source:TNamedMatrix;num:integer;setlen:boolean;var res:TNamedArray);
begin
Analytics.AssignArrayWithMatrixRow(source.M,num,setlen,res.A);
res.mi1:=length(res.A)-1;
end;{AssignArrayWithMatrixRow}

class procedure TTranslator.AssignArrayWithMatrixColumn(source:TNamedMatrix;num:integer;setlen:boolean;var res:TNamedArray);
begin
Analytics.AssignArrayWithMatrixColumn(source.M,num,setlen,res.A);
res.mi1:=length(res.A)-1;
end;{AssignArrayWithMatrixColumn}

class procedure TTranslator.AssignMatrixRowWithArray(source:TNamedArray;num:integer;setlen:boolean;var res:TNamedMatrix);
begin
Analytics.AssignMatrixRowWithArray(source.A,num,setlen,res.M);
res.mi1:=length(res.M)-1;
end;{AssignMatrixRowWithArray}

class procedure TTranslator.AssignMatrixColumnWithArray(source:TNamedArray;num:integer;setlen:boolean;var res:TNamedMatrix);
begin
Analytics.AssignMatrixColumnWithArray(source.A,num,setlen,res.M);
res.mi1:=length(res.M)-1;
end;{AssignMatrixColumnWithArray}

class procedure TTranslator.AssignMatrixRowWithMatrixRow(source:TNamedMatrix;nums,numr:integer;setlen:boolean;var res:TNamedMatrix);
var inter:TNamedArray;
begin
AssignArrayWithMatrixRow(source,nums,true,inter);
AssignMatrixRowWithArray(inter,numr,setlen,res);
end;{AssignMatrixRowWithMatrixRow}

class procedure TTranslator.AssignMatrixColWithMatrixCol(source:TNamedMatrix;nums,numr:integer;setlen:boolean;var res:TNamedMatrix);
var inter:TNamedArray;
begin
AssignArrayWithMatrixColumn(source,nums,true,inter);
AssignMatrixColumnWithArray(inter,numr,setlen,res);
end;{AssignMatrixColWithMatrixCol}

class procedure TTranslator.AssignMatrixRowWithMatrixCol(source:TNamedMatrix;nums,numr:integer;setlen:boolean;var res:TNamedMatrix);
var inter:TNamedArray;
begin
AssignArrayWithMatrixColumn(source,nums,true,inter);
AssignMatrixRowWithArray(inter,numr,setlen,res);
end;{AssignMatrixRowWithMatrixCol}

class procedure TTranslator.AssignMatrixColWithMatrixRow(source:TNamedMatrix;nums,numr:integer;setlen:boolean;var res:TNamedMatrix);
var inter:TNamedArray;
begin
AssignArrayWithMatrixRow(source,nums,true,inter);
AssignMatrixColumnWithArray(inter,numr,setlen,res);
end;{AssignMatrixColWithMatrixRow}

{}


constructor TTranslator.Create;
begin
DetAllMaxParameters;
end;{Create}

destructor TTranslator.Destroy;
begin
  DeleteEverything;
  inherited;
end;{Destroy}

function TTranslator.VariableExists(var name:string;var num:integer):boolean;
begin
DeleteBlanks(name);
result:=ExistVar(name,fVariables,num);
end;{VariableExists}

function TTranslator.ArrayExists(var name:string;var num:integer):boolean;
begin
DeleteBlanks(name);
result:=ExistArr(name,fArrays,num);
end;{ArrayExists}

function TTranslator.MatrixExists(var name:string;var num:integer):boolean;
begin
DeleteBlanks(name);
result:=ExistMatr(name,fMatrices,num);
end;{MatrixExists}

function TTranslator.StringExists(var name:string;var num:integer):boolean;
begin
DeleteBlanks(name);
result:=ExistStr(name,fStrings,num);
end;{StringExists}

function TTranslator.SomethingExists(var name:string;var typ:TTranslatorParameterType;var num:integer):boolean;
begin
typ:=tptUnknown;
num:=-1;
result:= VariableExists(name,num);
if result then begin
               typ:=tptVariable;
               exit;
               end;

result:= ArrayExists(name,num);
if result then begin
               typ:=tptArray;
               exit;
               end;

result:= MatrixExists(name,num);
if result then begin
               typ:=tptMatrix;
               exit;
               end;

result:= StringExists(name,num);
if result then begin
               typ:=tptString;
               exit;
               end;

end;{SomethingExists}

function TTranslator.SomethingExists(var name:string;var typ:TTranslatorParameterType):boolean;
var num:integer;
begin
result:=SomethingExists(name,typ,num);
end;{SomethingExists}

function TTranslator.AddVariable(name,val:string):boolean;
var num:integer;
begin
if VariableExists(name,num)
then result:=NewVariableValue(num,val)
else result:=NewVariable(name,val);
end;{AddVariable}

function TTranslator.AddVariables(names,vals:TSArray):boolean;
var i,n,m:integer;
begin
result:=false;
n:=length(names);
m:=length(vals);
if (m<n) then n:=m;
for i:=0 to (n-1) do if ( AddVariable(names[i],vals[i]) ) then result:=true;
end;{AddVariables}

function TTranslator.AddArray(name,len:string):boolean;
var num:integer;
begin
if ArrayExists(name,num)
then result:=NewArrayLength(num,len)
else result:=NewArray(name,len);
end;{AddArray}

function TTranslator.AddMatrix(name,len1,len2:string):boolean;
var num:integer;
begin
if MatrixExists(name,num)
then result:=NewMatrixSizes(num,len1,len2)
else result:=NewMatrix(name,len1,len2);
end;{AddMatrix}

function TTranslator.AddString(name,val:string):boolean;
var num:integer;
begin
if StringExists(name,num)
then result:=NewStringValue(num,val)
else result:=NewString(name,val);
end;{AddString}

procedure TTranslator.CopyVariablesFlom(source: TTranslator; deleteold:boolean);
var i,len:integer;
    name:string;
begin
if deleteold then DeleteAllVariables;
len:=source.VariablesNumber;
for i:=0 to len-1 do begin
                     name:=source.VariableNames[i];
                     AddVariable(name,FloatToStr(source.VariableValues[name]));
                     end;{for i}
end;{CopyVariablesFlom}

function TTranslator.AddingVariable:boolean;
var s,v:string;
    typ:TTranslatorParameterType;
begin
result:=false;
s:=InputBox('Adding Variable','Input variable name','');
if SIsEmpty(s)
   or CheckNameExists(s,typ) then exit;
v:=InputBox('Adding Variable','Input variable value','');
if SIsEmpty(v) then exit;
result:=AddVariable(s,v);
end;{AddingVariable}

function TTranslator.AddingString:boolean;
var s,v:string;
    typ:TTranslatorParameterType;
begin
result:=false;
s:=InputBox('Adding String','Input string name','');
if SIsEmpty(s)
   or CheckNameExists(s,typ) then exit;
v:=InputBox('Adding String','Input string value','');
if SIsEmpty(v) then exit;
result:=AddString(s,v);
end;{AddingString}

function TTranslator.AddingArray:boolean;
var s,v:string;
    typ:TTranslatorParameterType;
begin
result:=false;
s:=InputBox('Adding Array','Input Array name','');
if SIsEmpty(s)
   or CheckNameExists(s,typ) then exit;
v:=InputBox('Adding Array','Input array length','');
if SIsEmpty(v) then exit;
result:=AddArray(s,v);
end;{AddingArray}

function TTranslator.AddingMatrix:boolean;
var s,v1,v2:string;
    typ:TTranslatorParameterType;
begin
result:=false;
s:=InputBox('Adding Matrix','Input Matrix name','');
if SIsEmpty(s)
   or CheckNameExists(s,typ) then exit;
v1:=InputBox('Adding Matrix','Input matrix rows number','');
if SIsEmpty(v1) then exit;
v2:=InputBox('Adding Matrix','Input matrix columns number','');
if SIsEmpty(v2) then exit;
result:=AddMatrix(s,v1,v2);
end;{AddingMatrix}

function TTranslator.DeleteVariable(num:integer):boolean;
begin
if CheckVariableNum(num) then result:=false
else result:=DelVar(num,fVariables);
DetMaxVar;
end;{DeleteVariable}

function TTranslator.DeleteVariable(name:string):boolean;
var num:integer;
begin
if VariableExists(name,num) then result:=DeleteVariable(num)
else result:=false;
end;{DeleteVariable}

function TTranslator.DeleteArray(num:integer):boolean;
begin
if CheckArrayNum(num) then result:=false
else result:=DelArr(num,fArrays);
DetMaxArr;
end;{DeleteArray}

function TTranslator.DeleteArray(name:string):boolean;
var num:integer;
begin
if ArrayExists(name,num) then result:=DeleteArray(num)
else result:=false;
end;{DeleteArray}

function TTranslator.DeleteMatrix(num:integer):boolean;
begin
if CheckMatrixNum(num) then result:=false
else result:=DelMatr(num,fMatrices);
DetMaxMatr;
end;{DeleteMatrix}

function TTranslator.DeleteMatrix(name:string):boolean;
var num:integer;
begin
if MatrixExists(name,num) then result:=DeleteMatrix(num)
else result:=false;
end;{DeleteMatrix}

function TTranslator.DeleteString(num:integer):boolean;
begin
if CheckStringNum(num) then result:=false
else result:=DelStr(num,fStrings);
DetMaxStr;
end;{DeleteString}

function TTranslator.DeleteString(name:string):boolean;
var num:integer;
begin
if StringExists(name,num) then result:=DeleteString(num)
else result:=false;
end;{DeleteString}

function TTranslator.DeleteAnything(name:string):boolean;
var num:integer;
begin
if VariableExists(name,num) then result:=DeleteVariable(num)
else if ArrayExists(name,num) then result:=DeleteArray(num)
else if MatrixExists(name,num) then result:=DeleteMatrix(num)
else if StringExists(name,num) then result:=DeleteString(num)
else result:=false;
end;{DeleteAnything}

procedure TTranslator.DeleteAllVariables;
begin
SetLength(fVariables,0);
DetMaxVar;
end;{DeleteAllVariables}

procedure TTranslator.DeleteAllArrays;
var i:integer;
begin
for i:=0 to  fMaxArr do SetLength(fArrays[i].A,0);
SetLength(fArrays,0);
DetMaxArr;
end;{DeleteAllArrays}

procedure TTranslator.DeleteAllMatrices;
var i,j,len:integer;
begin
for i:=0 to  fMaxMatr do Begin
len:=Length(fMatrices[i].M);
for j:=0 to len-1 do SetLength(fMatrices[i].M[j],0);
SetLength(fMatrices[i].M,0);
End;{for i}
SetLength(fMatrices,0);
DetMaxMatr;
end;{DeleteAllMatrices}

procedure TTranslator.DeleteAllStrings;
begin
SetLength(fStrings,0);
DetMaxStr;
end;{DeleteAllStrings}

procedure TTranslator.DeleteEverything;
begin
DeleteAllVariables;
DeleteAllArrays;
DeleteAllMatrices;
DeleteAllStrings;
end;{DeleteEverything}

function TTranslator.ChangingArrayLength(num:integer):boolean;
var v,s:string;
begin
result:=false;
if CheckArrayNum(num) then exit;
s:=IntToStr(fArrays[num].mi1+1);
v:=InputBox('Changing Array Length "'+fArrays[num].Name+'"','Input array length',s);
if ((s=v)or(SIsEmpty(v))) then exit;
result:=NewArrayLength(num,v);
end;{ChangingArrayLength}

function TTranslator.ChangingMatrixSizes(num:integer):boolean;
var v1,v2,s1,s2:string;
begin
result:=false;
if CheckMatrixNum(num) then exit;
s1:=IntToStr(fMatrices[num].mi1+1);
v1:=InputBox('Changing Matrix Sizes "'+fMatrices[num].Name+'"','Input matrix row number',s1);
if SIsEmpty(v1) then exit;
s2:=IntToStr(fMatrices[num].mi2+1);
v2:=InputBox('Changing Matrix Sizes "'+fMatrices[num].Name+'"','Input matrix column number',s2);
if ( ((s2=v2)and(s1=v1)) or (SIsEmpty(v2)) ) then exit;
result:=NewMatrixSizes(num,v1,v2);
end;{ChangingMatrixSizes}

function TTranslator.EditingVariable(num:integer):boolean;
var v,s:string;
begin
result:=false;
if CheckVariableNum(num) then exit;
s:=FloatToStr(fVariables[num].value);
v:=InputBox('Editing Variable Value "'+fVariables[num].Name+'"','Input new value of the variable',s);
if (SIsEmpty(v) or (v=s)) then exit;
if (ControlFormulaError(v)) then exit
else begin
     fVariables[num].value:=CalculateValue(v);
     result:=true;
     end;{else}
end;{EditingVariable}

function TTranslator.EditingString(num:integer):boolean;
var v,s:string;
begin
result:=false;
if CheckStringNum(num) then exit;
s:=fStrings[num].value;
v:=InputBox('Editing String Value "'+fStrings[num].Name+'"','Input new value of the string',s);
if (SIsEmpty(v) or (v=s)) then exit;
fStrings[num].value:=v;
result:=true;
end;{EditingString}

function TTranslator.SetVariableValue(num:integer;value:extended):boolean;
begin
if CheckVariableNum(num) then result:=false
else begin
     fVariables[num].Value:=value;
     result:=true;
     end;{else}
end;{SetVariableValue}

function TTranslator.SetVariableValue(name:string;value:extended):boolean;
var num:integer;
begin
if CheckVariableName(name, num) then result:=false
else result:=SetVariableValue(num,value);
end;{SetVariableValue}

function TTranslator.SetArrayValues(num:integer;beginindex:integer;values:array of extended):boolean;
var l,h,k,i,n:integer;
begin
if CheckArrayNum(num) then result:=false
else begin
     l:=Low(values);
     h:=High(values);
     n:=h-l+beginindex;
     if (n>fArrays[num].mi1) then h:=h-(fArrays[num].mi1-n);
     k:=beginindex-1;
     for i:=l to h do begin
                      k:=k+1;
                      fArrays[num].A[k]:=values[i];
                      end;
     result:=true;
     end;{else}
end;{SetArrayValues}

function TTranslator.SetArrayValues(name:string;beginindex:integer;values:array of extended):boolean;
var num:integer;
begin
if CheckArrayName(name, num) then result:=false
else result:=SetArrayValues(num,beginindex,values);
end;{SetArrayValues}

function TTranslator.SetArrayValues(num:integer;beginindex:integer;values:TArray):boolean;
var h,i,n:integer;
begin
if CheckArrayNum(num) then result:=false
else begin
     h:=Length(values)-1;
     n:=h+beginindex;
     if (n>fArrays[num].mi1) then h:=h-(fArrays[num].mi1-n);
     for i:=0 to h do fArrays[num].A[i+beginindex]:=values[i];
     result:=true;
     end;{else}
end;{SetArrayValues}

function TTranslator.SetArrayValues(name:string;beginindex:integer;values:TArray):boolean;
var num:integer;
begin
if CheckArrayName(name, num) then result:=false
else result:=SetArrayValues(num,beginindex,values);
end;{SetArrayValues}

function TTranslator.EditingArray(num,n1,n2:integer):boolean;
var i:integer;
    v,s:string;
begin
result:=false;
if CheckArrayNum(num) then exit;
if (n1<0) then n1:=0;
if (n2>fArrays[num].mi1) then fArrays[num].mi1:=n2;
for i:=n1 to n2 do Begin
s:=FloatToStr(fArrays[num].A[i]);
v:=InputBox('Editing Array "'+fArrays[num].Name+'"','Input new value of item'+AILB+inttostr(i)+AIRB,s);
if SIsEmpty(v) then exit;
if (ControlFormulaError(v)) then begin
if QueryingContinueAsk then continue else exit;
end{if error}
else begin
     fArrays[num].A[i]:=CalculateValue(v);
     result:=true;
     end;{else}
End;{for i}
end;{EditingArray}

function TTranslator.EditingMatrix(num,m1,m2,n1,n2:integer):boolean;
var i,j:integer;
    v,s:string;
begin
result:=false;
if CheckMatrixNum(num) then exit;
if (m1<0) then m1:=0;
if (m2>fMatrices[num].mi1) then fMatrices[num].mi1:=m2;
if (n1<0) then n1:=0;
if (n2>fMatrices[num].mi2) then fMatrices[num].mi2:=n2;
for i:=m1 to m2 do
for j:=n1 to n2 do Begin
s:=FloatToStr(fMatrices[num].M[i,j]);
v:=InputBox('Editing Matrix "'+fMatrices[num].Name+'"',
           'Input new value of item'+AILB+inttostr(i)+AIRB+AILB+inttostr(j)+AIRB,s);
if SIsEmpty(v) then exit;
if (ControlFormulaError(v)) then begin
if QueryingContinueAsk then continue else exit;
end{if error}
else begin
     fMatrices[num].M[i,j]:=CalculateValue(v);
     result:=true;
     end;{else}
End;{for j}
end;{EditingMatrix}

function TTranslator.Assign(left,right:string;lm,rm:TAssignMode;
                            ln,lp1,lp2,rn,rp1,rp2:string;lnum,rnum:integer):boolean;
begin
result:=false;
CASE rm OF
amNone:Begin
       case lm of
       amName:     result:=DeleteAnything(left);
       amVariable: result:=DeleteVariable(lnum);
       amArray:    result:=DeleteArray(lnum);
       amMatrix:   result:=DeleteMatrix(lnum);
       amString:   result:=DeleteString(lnum);
       else ;
       end;{case lm}
       End;{amNone}
amAssignArray:begin
              case lm of
              amName,amVariable,
              amArray,amMatrix,amString: result:=AddArray(left,rp1);
              else ;
              end;{case lm}
              end;{amAssignArray}
amAssignMatrix:begin
               case lm of
               amName,amVariable,
               amArray,amMatrix,amString: result:=AddMatrix(left,rp1,rp2);
               else ;
               end;{case lm}
               end;{amAssignMatrix}

amAssignString:begin
               case lm of
               amName,amVariable,
               amArray,amMatrix,amString: result:=AddString(left,rp1);
               else ;
               end;{case lm}
               end;{amAssignMatrix}

amName,
amFormula,
amVariable,
amArrayItem,
amMatrixItem:Begin
             case lm of
             amName, amVariable: result:=AddVariable(left,right);
             amArrayItem:        result:=AssignArrayItemValue(ln,lp1,right);
             amArray:            result:=AssignArrayValue(ln,right);
             amMatrixItem:       result:=AssignMatrixItemValue(ln,lp1,lp2,right);
             amMatrix:           result:=AssignMatrixValue(ln,right);
             amMatrixRow:        result:=AssignMatrixRowValue(ln,lp1,right);
             amMatrixColumn:     result:=AssignMatrixColumnValue(ln,lp2,right);
             end;{case lm}
             End;{amFormula,amVariable,amArrayItem,amMatrixItem}
amArray:Begin
        case lm of
        amName, amVariable,
        amMatrix:           result:=AssignToArray(ln,rn);
        amArray:            result:=AssignArrays(ln,rn);
        amMatrixRow:        result:=AssignMatrixRowWithArray(ln,rn,lp1);
        amMatrixColumn:     result:=AssignMatrixColumnWithArray(ln,rn,lp2);
        end;{case lm}
        End;{amArray}
amMatrix:Begin
         case lm of
         amName, amVariable,
         amArray:            result:=AssignToMatrix(ln,rn);
         amMatrix:           result:=AssignMatrices(ln,rn);
         end;{case lm}
         End;{amMatrix}
amMatrixRow:Begin
            case lm of
            amName,
            amVariable,
            amMatrix:       result:=AssignToMatrixRow(ln,rn,rp1);
            amArray:        result:=AssignArrayWithMatrixRow(ln,rn,rp1);
            amMatrixRow:    result:=AssignMatrixRowWithMatrixRow(ln,rn,lp1,rp1);
            amMatrixColumn: result:=AssignMatrixColWithMatrixRow(ln,rn,lp2,rp1);
            end;{case lm}
            End;{amMatrixRow}
amMatrixColumn:Begin
               case lm of
               amName,
               amVariable,
               amMatrix:      result:=AssignToMatrixColumn(ln,rn,rp2);
               amArray:       result:=AssignArrayWithMatrixColumn(ln,rn,rp2);
               amMatrixColumn:result:=AssignMatrixColWithMatrixCol(ln,rn,lp2,rp2);
               amMatrixRow:   result:=AssignMatrixRowWithMatrixCol(ln,rn,lp1,rp2);
               end;{case lm}
               End;{amMatrixColumn}
amStringFunction:Begin
                 case lm of
                 amName,
                 amVariable,
                 amMatrix,
                 amArray,
                 amString:   result:=AssignStringFunction(ln,rn,rp1);
                 else begin

                      end;{else}
                 end;{case lm}
                 End;{amStringFunction}
amString:Begin
         case lm of
         amName,
         amVariable,
         amMatrix,
         amArray,
         amArrayItem,
         amMatrixItem,
         amMatrixRow,
         amMatrixColumn : result:=AssignStringToOther(left,right,ln,lp1,lp2,lm,lnum);
         amString : result:=AssignStrings(ln,rn);
         else begin

              end;{else}
         end;{case lm}
         End;{amString}
END;{CASE rm}
end;{Assign}

function TTranslator.Assign(left,right:string):boolean;
var lp1,lp2,rp1,rp2,ln,rn:string;
    lm,rm:TAssignMode;
    lnum,rnum:integer;
begin
lm:=AssignMode(left,ln,lp1,lp2,lnum);
rm:=AssignMode(right,rn,rp1,rp2,rnum);
result:=Assign(left,right,lm,rm,ln,lp1,lp2,rn,rp1,rp2,lnum,rnum);
end;{Assign}

function TTranslator.Assign(assstr:string):boolean;
var left,right:string;
begin
result:=false;
if (not SIsAssign(assstr,left,right)) then exit;
result:=Assign(left,right);
end;{Assign}

class function TTranslator.ReadingContinueAsk:boolean;
begin
result:=MessageDLG('Error occured during reading.'+#13
                   +'Do you want to continue?',
                   mtInformation,[mbYes,mbNo],0)=idYes;
end;{ReadingContinueAsk}

class function TTranslator.QueryingContinueAsk:boolean;
begin
result:=MessageDLG('Error occured during querying.'+#13
                   +'Do you want to continue?',
                   mtInformation,[mbYes,mbNo],0)=idYes;
end;{QueryingContinueAsk}

function TTranslator.ReadCommands(var coms:TSArray):boolean;
var curstr,maxstr:integer;
    left,right:string;
    command,param:string;
    params:TSArray;
    tcommand:TTranslatorCommand;
    bline,eline,intline:integer;
    error:boolean;
    stmnt:integer;
begin
result:=false;
maxstr:=length(coms)-1;
curstr:=0;
WHILE (curstr<=maxstr) DO BEGIN // Main Cycle Begin
if ( SIsAssign(coms[curstr],left,right) )
then Begin
     if ( not Assign(left,right) )
     then begin
     if (not ReadingContinueAsk ) then exit;
     end;{if not Assign}
     End{Assign}
else Begin
     tcommand:=CommandCase(coms[curstr],command,param);
     DetParameters(param,ParSep,params);
     CASE tcommand OF
     tcBeginCycle:Begin
                  if TStructuredStatement.FindCycle(coms,curstr,bline,eline,error) then Begin
                  AddCycle(params,bline,eline);
                  fStatements[LastStatement].BeginStatement;
                  End{if}
                  else Begin

                  End;{else}
                  End;{tcBeginCycle}
     tcContinue,
     tcEndCycle:Begin
                stmnt:=TStructuredStatement.LastCycleStatement(fStatements);
                if (stmnt>=0) then Begin
                (fStatements[stmnt] as TForCycle).DoIteration;
                if (fStatements[stmnt] as TForCycle).IsOver then begin
                curstr:=fStatements[stmnt].EndLine+1;
                TStructuredStatement.DeleteStatement(stmnt,fStatements);
                end{IsOver}
                else begin
                curstr:=fStatements[stmnt].BeginLine+1;
                end;{else IsOver}
                continue;
                End{if}
                else Begin

                End;{else}
                End;{tcContinue,tcEndCycle}
     tcBreak:Begin
             stmnt:=TStructuredStatement.LastCycleStatement(fStatements);
             if (stmnt>=0) then Begin
             curstr:=fStatements[stmnt].EndLine+1;
             TStructuredStatement.DeleteStatements(stmnt,fStatements);
             continue;
             End{if}
             else Begin

             End;{else}
             End;{tcBreak}
     tcExit:Begin
            TStructuredStatement.DeleteAllStatements(fStatements);
            break;
            End;{tcExit}
     tcBeginIf:Begin
               if TStructuredStatement.FindIf(coms,curstr,bline,eline,intline,error) then Begin
               AddIfStatement(params,bline,intline,eline);
               stmnt:=LastStatement;
               fStatements[stmnt].BeginStatement;
               if (fStatements[stmnt] as TIfStatement).Condition
               then curstr:=fStatements[stmnt].BeginLine+1
               else begin
                    if (fStatements[stmnt] as TIfStatement).ElseSection
                        then curstr:=(fStatements[stmnt] as TIfStatement).ElseLine+1
                        else curstr:=fStatements[stmnt].EndLine;
                    end;{else}
               continue;
               End{if}
               else Begin

               End;{else}
               End;{tcBeginIf}
     tcEndIf,
     tcElseIf:Begin
              stmnt:=TStructuredStatement.LastIfStatement(fStatements);
              if (stmnt>=0) then Begin
              curstr:=fStatements[stmnt].EndLine+1;
              TStructuredStatement.DeleteStatements(stmnt,fStatements);
              continue;
              End{if}
              else Begin

              End;{else}
              End;{tcEndIf,tcElseIf}
     tcUnknown:Begin

               End;{tcUnknown}
     END;{CASE tcommand}
     End;{else Assign}
curstr:=curstr+1;
END;{WHILE} // Main Cycle End
result:=true;
end;{ReadCommands}

function TTranslator.CalculateValue(formula:string):extended;
begin
result:=FormulaValue(formula,fVariables,fArrays,fMatrices);
end;{CalculateValue}

function TTranslator.CalculateValue(formula:TSVec):TVec;
var i:integer;
begin
for i:=1 to MKV do result[i]:=CalculateValue(formula[i]);
end;{CalculateValue}

function TTranslator.CalculateValue(formula:TSArray):TArray;
var i,n:integer;
begin
n:=length(formula);
setlength(result,n);
for i:=1 to (n-1) do result[i]:=CalculateValue(formula[i]);
end;{CalculateValue}

function TTranslator.CalculateValue(formula:TSMatr):TMatr;
var i,j,m,n:integer;
begin
m:=length(formula);
setlength(result,m);
for i:=0 to (m-1) do Begin
n:=length(formula[i]);
setlength(result[i],n);
for j:=0 to (n-1) do result[i,j]:=CalculateValue(formula[i,j]);
End;{for i}
end;{CalculateValue}

function TTranslator.CalculateBoolean(formula:string):boolean;
begin
result:=BooleanValue(CalculateValue(formula));
end;{CalculateBoolean}

function TTranslator.ControlFormulaError(formula:string):boolean;
begin
result:=FormulaControlE(formula,fVariables,fArrays,fMatrices);
end;{ControlFormulaError}

function TTranslator.ControlFormulaError(formula:TSVec):boolean;
var i:integer;
begin
result:=false;
for i:=1 to MKV do
if ControlFormulaError(formula[i]) then begin
                                        result:=true;
                                        exit;
                                        end;
end;{ControlFormulaError}

function TTranslator.ControlFormulaError(formula:TSArray):boolean;
var i,n:integer;
begin
result:=false;
n:=length(formula)-1;
for i:=1 to n do
if ControlFormulaError(formula[i]) then begin
                                        result:=true;
                                        exit;
                                        end;
end;{ControlFormulaError}

function TTranslator.ControlFormulaError(formula:TSMatr):boolean;
var i,j,m,n:integer;
begin
result:=false;
m:=length(formula)-1;
for i:=0 to m do Begin
n:=length(formula[i])-1;
for j:=0 to n do
if ControlFormulaError(formula[i,j]) then begin
                                          result:=true;
                                          exit;
                                          end;
End;{for i}
end;{ControlFormulaError}

function TTranslator.FindError(formula: string;var description: string): boolean;
begin
result:=FindErrorInFormula(formula,fVariables,fArrays,fMatrices,description);
end;{FindError}

function TTranslator.FindError(formula: TSVec;var description: string): boolean;
begin
result:=FindErrorInFormula(formula,fVariables,fArrays,fMatrices,description);
end;{FindError}

function TTranslator.MakeTheFormula(s:string;var formula:TFormula):boolean;
begin
formula:=NILFormula;
result:=MakeFormula(s,fVariables,fArrays,fMatrices,formula);
end;{MakeTheFormula}

function TTranslator.MakeTheFormula(s:TSVec;var formula:TFormulaVec):boolean;
var i:integer;
begin
for i:=1 to MKV do begin
                   result:=MakeTheFormula(s[i],formula[i]);
                   if (not result) then exit;
                   end;{for i}
end;{MakeTheFormula}

function TTranslator.MakeTheFormula(s:TSTenz;var formula:TFormulaTenz):boolean;
var i:integer;
begin
for i:=1 to MKT do begin
                   result:=MakeTheFormula(s[i],formula[i]);
                   if (not result) then exit;
                   end;{for i}
end;{MakeTheFormula}

function TTranslator.MakeTheFormula(s:TSArray;var formula:TFormulaArray):boolean;
var i,n:integer;
begin
result:=false;
n:=length(s);
setlength(formula,n);
for i:=0 to n-1 do begin
                   result:=MakeTheFormula(s[i],formula[i]);
                   if (not result) then exit;
                   end;{for i}
end;{MakeTheFormula}

function TTranslator.MakeTheFormula(s:TSMatr;var formula:TFormulaMatrix):boolean;
var i,m:integer;
begin
result:=false;
m:=length(s);
setlength(formula,m);
for i:=0 to length(s)-1 do Begin
                           result:=MakeTheFormula(s[i],formula[i]);
                           if (not result) then exit;
                           end;{for i}
end;{MakeTheFormula}

function TTranslator.CalculateValue(formula:TFormula):extended;
begin
result:=FormulaValue(formula,fVariables,fArrays,fMatrices);
end;{CalculateValue}

function TTranslator.CalculateValue(formula:TFormulaVec):TVec;
var i:integer;
begin
for i:=1 to MKV do result[i]:=CalculateValue(formula[i]);
end;{CalculateValue}

function TTranslator.CalculateValue(formula:TFormulaArray):TArray;
var i,n:integer;
begin
n:=length(formula);
setlength(result,n);
for i:=0 to n-1 do result[i]:=CalculateValue(formula[i]);
end;{CalculateValue}

function TTranslator.CalculateValue(formula:TFormulaMatrix):TMatr;
var i,m:integer;
begin
m:=length(formula);
setlength(result,m);
for i:=0 to m-1 do result[i]:=CalculateValue(formula[i]);
end;{CalculateValue}

function TTranslator.FindErrorInDerivativeFunction(const func:string;var description:string):boolean;
begin
result:=Analytics.FindErrorInDerivativeFunction(func,description);
end;{FindErrorInDerivativeFunction}

function TTranslator.ControlDerivativeFunction(const func: string): boolean;
begin
result:=Analytics.ControlDerivativeFunction(func);
end;{ControlDerivativeFunction}

function TTranslator.Derivative(formula, variable: string; var resformula: string): boolean;
begin
Result := Analytics.Derivative(formula,variable,resformula);
end;{Derivative}

function TTranslator.Derivative(funcs: TSArray; variable: string; var resfuncs: TSArray): boolean;
begin
Result := Analytics.Derivative(funcs,variable,resfuncs);
end;{Derivative}

function TTranslator.Derivative(func: TSVec; variable: string; var resfunc: TSVec): boolean;
begin
Result := Analytics.Derivative(func,variable,resfunc);
end;{Derivative}

function TTranslator.Derivative(func, variable: TSVec;var resfunc: TSTenz): boolean;
begin
Result := Analytics.Derivative(func,variable,resfunc);
end;{Derivative}

procedure TTranslator.VariablesInfo(var vi:TSArray);
var i:integer;
begin
setlength(vi,fMaxVar+1);
for i:=0 to fMaxVar do vi[i]:=fVariables[i].Name+AssignSign
                              +FloatToStr(fVariables[i].Value);
end;{VariablesInfo}

procedure TTranslator.StringsInfo(var si:TSArray);
var i:integer;
begin
setlength(si,fMaxStr+1);
for i:=0 to fMaxStr do si[i]:=fStrings[i].Name+AssignSign
                              +StringQuote+fStrings[i].Value+StringQuote;
end;{StringsInfo}

procedure TTranslator.ArraysInfo(var ai:TSArray);
var i:integer;
begin
setlength(ai,fMaxArr+1);
for i:=0 to fMaxArr do ai[i]:=fArrays[i].Name+AILB
                             +IntToStr(fArrays[i].mi1+1)+AIRB;
end;{ArraysInfo}

procedure ArrayToSArray(alignminus:boolean;prec:integer;Source:TArray;var Res:TSArray); overload;
var i,n:integer;
    sad,sads:string;
begin
n:=length(Source)-1;
setlength(Res,n+1);
if alignminus then sads:=' ' else sads:='';
for i:=0 to n do begin
if Source[i]>=0.0 then sad:=sads else sad:='';
Res[i]:=sad+FloatToStrF(Source[i],ffExponent,prec,3);
end;{for i}
end;{ArrayToSArray}

procedure ArrayToSArray(prec:integer;Source:TArray;var Res:TSArray);overload;
begin
ArrayToSArray(true,prec,Source,res);
end;{ArrayToSArray}

procedure ArrayToSArray(Source:TArray;var Res:TSArray);overload;
begin
ArrayToSArray(5,Source,Res);
end;{ArrayToSArray}


function TTranslator.ArrayInfo(num:integer;var name:string;var len:integer;var a:TSArray):boolean;
begin
result:=false;
name:='';
len:=0;
a:=nil;
if CheckArrayNum(num) then exit;
name:=fArrays[num].Name;
len:=fArrays[num].mi1+1;
ArrayToSArray(fArrays[num].A,a);
result:=true;
end;{ArrayInfo}

procedure TTranslator.MatricesInfo(var mi:TSArray);
var i:integer;
begin
setlength(mi,fMaxMatr+1);
for i:=0 to fMaxMatr do mi[i]:=fMatrices[i].Name+AILB
                              +IntToStr(fMatrices[i].mi1+1)+AIRB+AILB
                              +IntToStr(fMatrices[i].mi2+1)+AIRB;
end;{MatricesInfo}

procedure MatrToSMatr(prec:integer;Source:TMatr;var Res:TSMatr);overload;
var i,j,m,n:integer;
begin
FreeMemory(Res);
m:=length(Source)-1;
if (m<0) then exit;
n:=length(Source[0])-1;
setlength(Res,m+1,n+1);
for i:=0 to m do
for j:=0 to n do Res[i,j]:=FloatToStrF(Source[i,j],ffExponent,prec,0);
end;{}

procedure MatrToSMatr(Source:TMatr;var Res:TSMatr);overload;
begin
MatrToSMatr(5,Source,Res);
end;{MatrToSMatr}

function TTranslator.MatrixInfo(num:integer;var name:string;var len1,len2:integer;var m:TSMatr):boolean;
begin
result:=false;
name:='';
len1:=0;
m:=nil;
if CheckMatrixNum(num) then exit;
name:=fMatrices[num].Name;
len1:=fMatrices[num].mi1+1;
len2:=fMatrices[num].mi2+1;
MatrToSMatr(fMatrices[num].M,m);
result:=true;
end;{MatrixInfo}



   { TTranslator IMPLEMENTATION end   }
{-----------------------------------------}

{---------------------TStructuredStatement Implementation begin----------------}
constructor TStructuredStatement.Create(owner:TTranslator);
begin
fBeginLine:=0;
fEndLine:=0;
if (owner=nil) then fCreationError:=true
else begin
     fOwner:=owner;
     fCreationError:=false;
     end;{else}
end;{Create}

class function TStructuredStatement.IsItBeginOfCycle(str:string):boolean;
begin
DeleteBlanks(str);
result:=(str=CycleBW);
end;{IsItBeginOfCycle}

class function TStructuredStatement.IsItEndOfCycle(str:string):boolean;
begin
DeleteBlanks(str);
result:=(str=CycleEW);
end;{IsItEndOfCycle}

class function TStructuredStatement.IsItBreakStatement(str:string):boolean;
begin
DeleteBlanks(str);
result:=(str=BreakW);
end;{IsItBreakStatement}

class function TStructuredStatement.IsItContinueStatement(str:string):boolean;
begin
DeleteBlanks(str);
result:=(str=ContinueW);
end;{IsItContinueStatement}

class function TStructuredStatement.IsItExitStatement(str:string):boolean;
begin
DeleteBlanks(str);
result:=(str=ExitW);
end;{IsItExitStatement}

class function TStructuredStatement.IsItBeginOfIf(str:string):boolean;
begin
DeleteBlanks(str);
result:=(str=IfBW);
end;{IsItBeginOfIf}

class function TStructuredStatement.IsItEndOfIf(str:string):boolean;
begin
DeleteBlanks(str);
result:=(str=IfEW);
end;{IsItEndOfIf}

class function TStructuredStatement.IsItElseOfIf(str:string):boolean;
begin
DeleteBlanks(str);
result:=(str=ElseW);
end;{IsItElseOfIf}

class procedure TStructuredStatement.AddStatement(var stmnts:TStructuredStatements);
begin
setlength(stmnts,length(stmnts)+1);
end;{AddStatement}

class function TStructuredStatement.DeleteStatement(num:integer;var stmnts:TStructuredStatements):boolean;
var i,n:integer;
begin
result:=false;
n:=length(stmnts)-1;
if ((num<0)or(num>n)) then exit;
stmnts[num].Destroy;
for i:=num to (n-1) do stmnts[i]:=stmnts[i+1];
setlength(stmnts,n);
result:=true;
end;{DeleteStatement}

class function TStructuredStatement.DeleteStatements(from_,_to:integer;var stmnts:TStructuredStatements):boolean;
var i,n,k:integer;
begin
result:=false;
n:=length(stmnts)-1;
if (from_<0) then from_:=0;
if (_to>n) then _to:=n;
if (from_>_to) then exit;
for i:=from_ to _to do stmnts[i].Destroy;
k:=0;
for i:=(_to+1) to n do begin
                       stmnts[from_+k]:=stmnts[i];
                       end;{for i}
setlength(stmnts,n-(_to-from_));                       
result:=true;
end;{DeleteStatements}

class function TStructuredStatement.DeleteStatements(from_:integer;var stmnts:TStructuredStatements):boolean;
begin
result:=DeleteStatements(from_, length(stmnts)-1, stmnts);
end;{DeleteStatements}

class procedure TStructuredStatement.DeleteAllStatements(var stmnts:TStructuredStatements);
begin
DeleteStatements(0, length(stmnts)-1, stmnts);
end;{DeleteAllStatements}

class function TStructuredStatement.LastCycleStatement(stmnts:TStructuredStatements):integer;
var i,n:integer;
begin
result:=-1;
n:=length(stmnts)-1;
for i:=n downto 0 do if (stmnts[i] is TForCycle) then begin
                                                      result:=i;
                                                      exit;
                                                      end;
end;{LastCycleStatement}

class function TStructuredStatement.LastIfStatement(stmnts:TStructuredStatements):integer;
var i,n:integer;
begin
result:=-1;
n:=length(stmnts)-1;
for i:=n downto 0 do if (stmnts[i] is TIfStatement) then begin
                                                         result:=i;
                                                         exit;
                                                         end;
end;{LastIfStatement}

class function TStructuredStatement.FindCycle(commands:TSArray;beginpos:integer;
                                    var bcycle,ecycle:integer;var error:boolean):boolean;
var brest,erest:string;
begin
result:=FindPair(commands,CycleBW,CycleEW,beginpos,length(commands)-1,bcycle,ecycle,brest,erest,error);
end;{FindCycle}

class function TStructuredStatement.FindIf(commands:TSArray;beginpos:integer;
                                           var bif,eif,elseif:integer;var error:boolean):boolean;
var brest,erest:string;
    intpos:TIArray;
    intrests:TSArray;
begin
elseif:=-1;
result:=FindPair(commands,IfBW,IfEW,ElseW,beginpos,length(commands)-1,true,
                 bif,eif,brest,erest,error,intpos,intrests);
if (length(intpos)>0) then elseif:=intpos[0];
end;{FindIf}

class function TStructuredStatement.FindCase(commands:TSArray;beginpos:integer;
                                             var bcase,ecase,elsecase:integer;
                                             var cvalue:string;
                                             var cases:TIArray;var cvalues:TSArray;
                                             var error:boolean):boolean;
var brest,erest:string;
    intpos:TIArray;
    intrests:TSArray;
    i1,i2:integer;
begin
result:=FindPair(commands,CaseBegin,CaseEnd,CaseChoice,beginpos,length(commands)-1,true,
                 bcase,ecase,cvalue,erest,error,intpos,intrests);
FindPair(commands,CaseBegin,CaseEnd,CaseElse,beginpos,length(commands)-1,true,
         i1,i2,brest,erest,error,intpos,intrests);
if (length(intpos)>0) then elsecase:=intpos[0];
end;{FindCase}

function TStructuredStatement.BeginStatement:boolean;
begin
result:=( not CreationError );
end;{BeginStatement}

procedure TStructuredStatement.EndStatement;
begin
end;{EndStatement}

destructor TStructuredStatement.Destroy;
begin
fOwner:=nil;
inherited;
end;{Destroy}
{---------------------TStructuredStatement Implementation end------------------}

{---------------------TForCycle Implementation begin---------------------------}
procedure TForCycle.DetIsOver;
begin
if (fStep=0.0) then fIsOver:=false
else if(fStep>0) then fIsOver:=(CurrentValue>fEndValue)
else fIsOver:=(CurrentValue<fEndValue);
end;{DetIsOver}

function TForCycle.GetCurrentValue:extended;
begin
result:=fOwner.CalculateValue(fParameter);
end;{GetCurrentValue}

procedure TForCycle.SetCurrentValue(val:extended);
begin
fOwner.SetVariableValue(fParameter,val);
DetIsOver;
end;{SetCurrentValue}

constructor TForCycle.Create(owner:TTranslator);
begin
inherited;
fBeginValue:=0.0;
fEndValue:=0.0;
fStep:=0.0;
fParameter:='';
fIsOver:=false;
end;{Create}

constructor TForCycle.Create(owner:TTranslator;param:string;bv,ev,stp:string;bline,eline:integer);
begin
Create(owner);
fParameter:=param;
if CreationError then exit;
if ( fOwner.ControlFormulaError(bv) )
   or ( fOwner.ControlFormulaError(ev) )
    or ( fOwner.ControlFormulaError(stp) ) then exit;
fBeginValue:=fOwner.CalculateValue(bv);
fEndValue:=fOwner.CalculateValue(ev);
fStep:=fOwner.CalculateValue(stp);
fBeginLine:=bline;
fEndLine:=eline;
fCreationError:=false;
end;{Create}

function TForCycle.BeginStatement:boolean;
var num:integer;
begin
result:=inherited BeginStatement;
if (fCreationError) then exit;
if ( not fOwner.VariableExists(fParameter,num ) ) then
begin
if (not fOwner.AddVariable(fParameter,FloatToStr(fBeginValue))) then exit;
end{if}
else CurrentValue:=fBeginValue;
result:=true;
end;{BeginCycle}

procedure TForCycle.DoIteration;
begin
CurrentValue:=CurrentValue+fStep;
end;{DoIteration}

procedure TForCycle.EndStatement;
begin
inherited;
fIsOver:=true;
end;{EndCycle}

destructor TForCycle.Destroy;
begin
inherited;
end;{Destroy}

{---------------------TForCycle Implementation end-----------------------------}

{---------------------TIfStatement Implementation begin------------------------}
procedure TIfStatement.DetElseSection;
begin
fElseSection:=(ElseLine>=0);
end;{DetElseSection}

constructor TIfStatement.Create(owner:TTranslator);
begin
inherited;
fElseLine:=-1;
fElseSection:=false;
fCondition:=false;
end;{Create}

constructor TIfStatement.Create(owner:TTranslator;expression:string;bline,elseline,eline:integer);
begin
Create(owner);
if CreationError then exit;
fBeginLine:=bline;
fEndLine:=eline;
fElseLine:=elseline;
DetElseSection;
if fOwner.ControlFormulaError(expression) then begin
                                               fCreationError:=true;
                                               exit;
                                               end
else begin
     fCondition:=fOwner.CalculateBoolean(expression);
     end;
end;{Create}

function TIfStatement.BeginStatement:boolean;
begin
result:=inherited BeginStatement;
end;{BeginStatement}

procedure TIfStatement.EndStatement;
begin
inherited;
end;{EndStatement}

destructor TIfStatement.Destroy;
begin
inherited;
end;{Destroy}

{---------------------TIfStatement Implementation end--------------------------}

end.

