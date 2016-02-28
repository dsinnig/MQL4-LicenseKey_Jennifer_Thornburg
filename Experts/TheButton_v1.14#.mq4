#include "../Include/License.mq4"

input string payPalEmailAddress=""; //PayPal email address
input string license=""; //License key
int productID = 65;


string DF="2016.03.31";
int   SizeLabel   = 10;
color Colour      = DodgerBlue;
int   PosX        = 5;
int   PosY        = 10;
double digit=0;
int LastSignalFound=0;
double ema0,ema00,ema000,ema4;
         double highest_ma,lowest_ma;
int MACrossingTime=0;
string font_here="Arial";
bool ShowLabelsCycle=false;
bool ShowHideSet=false;
bool UseSmallFontSize=0;
bool AllExitEntriesAreCancelled=false;
double ema3,ema33,ema333;
double hopper_signal_line,hopper_signal_line2;
 int     ArrowSize               = 4;
 int     ArrowStyle               = 108;
 bool    Look_for_Trigger_Finger       = 0;
 bool    Look_for_Reverse_Trigger_Finger       = 0;
 double  Trigger_Finger_MACD_Buffer  = 0.0000;
#property copyright "Copyright 2015, Trading Algos, LLC"
#property description "On-demand automation of Combo and Hopper Strategies."
double macd2,HiddenSL,HiddenTP,hopper_macd_line;
string LastSignal="";
int SellTicket,BuyTicket;
double ema111,ema222,hopper_macd_line2;
double actual_tp=0;
double middle,up1,up2,up3,dw1,dw2,dw3;
int AnyOrd,BuyOrd,SellOrd,PendOrd,MarketOrders;
int EntryTime,barra;
   int Lockedtime=0;
bool AllMessages     = FALSE;
string LastText="";
int ControleLog;
#define DgOneMinute                                  60
#define DgOneHour                                  3600
#define DgOneDay                                   86400
#define NOCHANGE                                     -1
#define NOFOUND                                      -1
int    GMT =  0;
int    DgGMTTime,myBars;
double MainLotSendOrder=0;
string warning=" **** ==  This version has expired . Please contact me at marcelomarkez@gmail.com == ****";
#define ERR_NO_ERROR                                  0
#define ERR_INVALID_STOPS                           130
#define ERR_SERVER_BUSY                               4
#define ERR_NO_CONNECTION                             6
#define ERR_INVALID_PRICE                           129
#define ERR_OFF_QUOTES                              136
#define ERR_BROKER_BUSY                             137
#define ERR_PRICE_CHANGED                           135
#define ERR_REQUOTE                                 138
#define ERR_INVALID_TRADE_VOLUME                    131
#define ERR_MARKET_CLOSED                           132
#define ERR_TRADE_DISABLED                          133
#define ERR_NOT_ENOUGH_MONEY                        134
#define ERR_NO_RESULT                                 1
#define ERR_COMMON_ERROR                              2
#define ERR_INVALID_TRADE_PARAMETERS                  3
#define ERR_TRADE_TOO_MANY_ORDERS                   148
#define ERR_TRADE_CONTEXT_BUSY                      146
#define ERR_OLD_VERSION                               5
#define ERR_NOT_ENOUGH_RIGHTS                         7
#define ERR_TOO_FREQUENT_REQUESTS                     8
#define ERR_MALFUNCTIONAL_TRADE                       9
#define ERR_ACCOUNT_DISABLED                         64
#define ERR_INVALID_ACCOUNT                          65
#define ERR_TRADE_TIMEOUT                           128
#define ERR_ORDER_LOCKED                            139
#define ERR_LONG_POSITIONS_ONLY_ALLOWED             140
#define ERR_TOO_MANY_REQUESTS                       141
#define ERR_TRADE_MODIFY_DENIED                     145
#define ERR_TRADE_EXPIRATION_DENIED                 147
#define ERR_NO_MQLERROR                            4000
#define ERR_WRONG_FUNCTION_POINTER                 4001
#define ERR_ARRAY_INDEX_OUT_OF_RANGE               4002
#define ERR_NO_MEMORY_FOR_FUNCTION_CALL_STACK      4003
#define ERR_RECURSIVE_STACK_OVERFLOW               4004
#define ERR_NOT_ENOUGH_STACK_FOR_PARAMETER         4005
#define ERR_NO_MEMORY_FOR_PARAMETER_STRING         4006
#define ERR_NO_MEMORY_FOR_TEMP_STRING              4007
#define ERR_NOT_INITIALIZED_STRING                 4008
#define ERR_NOT_INITIALIZED_ARRAYSTRING            4009
#define ERR_NO_MEMORY_FOR_ARRAYSTRING              4010
#define ERR_TOO_LONG_STRING                        4011
#define ERR_REMAINDER_FROM_ZERO_DIVIDE             4012
#define ERR_ZERO_DIVIDE                            4013
#define ERR_UNKNOWN_COMMAND                        4014
#define ERR_WRONG_JUMP                             4015
#define ERR_NOT_INITIALIZED_ARRAY                  4016
#define ERR_DLL_CALLS_NOT_ALLOWED                  4017
#define ERR_CANNOT_LOAD_LIBRARY                    4018
#define ERR_CANNOT_CALL_FUNCTION                   4019
#define ERR_EXTERNAL_EXPERT_CALLS_NOT_ALLOWED      4020
#define ERR_NOT_ENOUGH_MEMORY_FOR_RETURNED_STRING  4021
#define ERR_SYSTEM_BUSY                            4022
#define ERR_INVALID_FUNCTION_PARAMETERS_COUNT      4050
#define ERR_INVALID_FUNCTION_PARAMETER_VALUE       4051
#define ERR_STRING_FUNCTION_INTERNAL_ERROR         4052
#define ERR_SOME_ARRAY_ERROR                       4053
#define ERR_INCORRECT_SERIES_ARRAY_USING           4054
#define ERR_CUSTOM_INDICATOR_ERROR                 4055
#define ERR_INCOMPATIBLE_ARRAYS                    4056
#define ERR_GLOBAL_VARIABLES_PROCESSING_ERROR      4057
#define ERR_GLOBAL_VARIABLE_NOT_FOUND              4058
#define ERR_FUNCTION_NOT_ALLOWED_IN_TESTING_MODE   4059
#define ERR_FUNCTION_NOT_CONFIRMED                 4060
#define ERR_SEND_MAIL_ERROR                        4061
#define ERR_STRING_PARAMETER_EXPECTED              4062
#define ERR_INTEGER_PARAMETER_EXPECTED             4063
#define ERR_DOUBLE_PARAMETER_EXPECTED              4064
#define ERR_ARRAY_AS_PARAMETER_EXPECTED            4065
#define ERR_HISTORY_WILL_UPDATED                   4066
#define ERR_TRADE_ERROR                            4067
#define ERR_END_OF_FILE                            4099
#define ERR_SOME_FILE_ERROR                        4100
#define ERR_WRONG_FILE_NAME                        4101
#define ERR_TOO_MANY_OPENED_FILES                  4102
#define ERR_CANNOT_OPEN_FILE                       4103
#define ERR_INCOMPATIBLE_ACCESS_TO_FILE            4104
#define ERR_NO_ORDER_SELECTED                      4105
#define ERR_UNKNOWN_SYMBOL                         4106
#define ERR_INVALID_PRICE_PARAM                    4107
#define ERR_INVALID_TICKET                         4108
#define ERR_TRADE_NOT_ALLOWED                      4109
#define ERR_LONGS__NOT_ALLOWED                     4110
#define ERR_SHORTS_NOT_ALLOWED                     4111
#define ERR_OBJECT_ALREADY_EXISTS                  4200
#define ERR_UNKNOWN_OBJECT_PROPERTY                4201
#define ERR_OBJECT_DOES_NOT_EXIST                  4202
#define ERR_UNKNOWN_OBJECT_TYPE                    4203
#define ERR_NO_OBJECT_NAME                         4204
#define ERR_OBJECT_COORDINATES_ERROR               4205
#define ERR_NO_SPECIFIED_SUBWINDOW                 4206
#define ERR_SOME_OBJECT_ERROR                      4207
#define NEGATIVO -1
bool UseExpirationTime = false;
int engine,CountStopTrading,EntryIND,BarraControl,numero,dia,sinal,myBars2,Total,Tipo;
int OrdemBS=3;
bool Ftime=1;
double red,green,EB,ES,ssl1,IFRA,ActualSL,NewSl,P,D,ao0,ao1,macdHisto,macd1,emaUP,emaDW,RSii,stochs,stochf,Heik,a,b,c,d,e,f,g,h,ema1,ema2,rsi,EntryBuy,EntrySell,MINLOT,MAXLOT,sl,tp,pp,r1,r2,r3,s1,s2,s3;
string  texto2,texto,Name;
bool    UseNormalize1Double=false;
int expi,ActualPendingTicket;
string auxS="";
bool RunEA=true;
string GeralCom="";
int SSLLine=1;
int NumDigitosPar;
int     Slippage           = 0;
int MaxSpreadAllowed           = 0;
int Digits2Round=2;
bool    TradeLong           = True;
bool    TradeShort          = True;
bool    WriteLogs          = 0;
bool    JournalLogs          = true;
bool    OpenLiveOrders     = 1;
bool    DrawArrows         = 1;
bool    UseFixedLots       = 0;
double  PercentRisk        = 0.0;
bool UseReverseMode=false;
double ema11,ema22;
double     HardStopLoss       = 0  ;
string debug_ir="";
int       ExtraPip                = 5;
 bool    Use_TradeTime_Control          = 0;
 string  StartTime          = "08:00";
string  EndTime            = "20:00";
 string     StartRange1    = "00:00";
bool FTIME_RANGE1=false;
int BARSRANGE;
  bool   CloseOppositeOrder = 0;
 string Button_1_Settings = " ==Close Any Open At MACD Zero== ";
 int    Button_1_x         = 370;
 int    Button_1_y         = 400;
string buttonID_Close_AnyOpenTrade_At_MACD_ZERO="Close AnyOpenTrade At MACD ZERO";
bool Active_Close_AnyOpenTrade_At_MACD_ZERO=0;
 string Button_2_Settings = " ==Take Next Hopper Trade== ";
 int    Button_2_x         = 420;
 int    Button_2_y         = 400;
string buttonID_TakeNextHopperTrade="Take Next Hopper Trade";
bool Active_TakeNextHopperTrade=0;
 string Button_3_Settings = " ==Take Reverse Trigger Finger== ";
 int    Button_3_x         = 470;
 int    Button_3_y         = 400;
string buttonID_TakeReverseTriggerFinger="Take Reverse Trigger Finger";
bool Active_TakeReverseTriggerFinger=0;
 string Button_4_Settings = " ==Take Next Combo Hopper== ";
 int    Button_4_x         = 520;
 int    Button_4_y         = 400;
string buttonID_TakeNextComboHopper="Take Next Combo Hopper";
bool Active_TakeNextComboHopper=0;
 string Button__Settings = " == Monday Trade == ";
 int    Button_5_x         = 580;
 int    Button_5_y         = 400;
string buttonID_MondayTrade="Monday Trade";
bool Active_TakeNextComboHopper_H4=0;
bool Look_for_Hopper=1;
extern string MondayTradeSettings_Settings = "=== Monday Trade Settings ==";
extern double  HopperMACD_Buffer  = 0.0;
extern int  LookBack_Hopper  = 0.0;
int LastHopperH4TimeFound=0;
int LastHopperH4Time_Sent=0;
extern string  Filters             = " == Filters for Combo-Hopper Trade == ";
extern int     Max_X_pips_away_from_MA0        = 50;
extern int     Max_X_pips_away_from_MA1        = 50;
extern int     Min_X_pips_away_from_MA0        = 1;
extern int     Min_X_pips_away_from_MA1        = 1;
extern int     MinDistanceBetween_MA0_MA1      = 2;
 bool    Use_Trend_Detection=0;
extern int     ConfirmLookBack        = 5;
extern string  General_Settings   = " == General Settings == ";
extern bool   Show_Buttons_on_chart   = 1;
extern  int    Corner         =1;
extern int    Corner_x_pos_Adjustment         = 100;
extern color  Button_ON_color  = clrLime;
extern color  Button_OFF_color = clrGray;
extern int    Button_FontSize  = 12;
extern color  Button_FontColor = clrBlack;
extern  int Button_Height=30;
extern  int Button_Width=100;
extern  bool   Realtime = 1;
extern double  Lots               = 0.01;
extern double  TakeProfit         = 30;
extern double  StopLoss           = 45;
extern int     MagicNumber        = 1;
extern  string  EAName             = "TheButton";
extern string  MACD_Settings      = " == MACD Settings == ";
extern double    Entry_MACD1_Buffer =0.000;
extern int       FastMAPeriod=12;
extern int       SlowMAPeriod=26;
extern int       SignalMAPeriod=9;
extern string  ComboLine1_Settings           = " == ComboLine1 Settings == ";
extern int     ComboLine1_Period            = 50;
extern int     ComboLine1_Method            = 0;
extern int     ComboLine1_APrice            = 0;
extern string  ComboLine2_Settings           = " == ComboLine2 Settings == ";
extern int     ComboLine2_Period            = 100;
extern int     ComboLine2_Method            = 0;
extern int     ComboLine2_APrice            = 0;
extern string  Alert_Settings     = " == Alert Settings == ";
extern bool    PopUpAlert         = 0;
extern bool    EMailAlert         = false;
extern bool    PlaySoundAlert     = false;
extern string  PlaySoundFile      = "alert.wav";
extern bool    PushNotification   = false;
int signal=0;
int     _OrderRetry        = 10;
int     OrderRetryTimeSec  = 10;
   int Digitos ;
//so123
void ReadGV (){
Active_Close_AnyOpenTrade_At_MACD_ZERO=GlobalVariableGet(EAName+Symbol()+"Set_Button_1_OFF");
string global=EAName+Symbol()+"Button_1_x";
 if (GlobalVariableCheck(global))Button_1_x=GlobalVariableGet(global);
 global=EAName+Symbol()+"Button_1_y";
   if (GlobalVariableCheck(global))Button_1_y=GlobalVariableGet(global);
Active_TakeNextHopperTrade=GlobalVariableGet(EAName+Symbol()+"Set_Button_2_OFF");
 global=EAName+Symbol()+"Button_2_x";
  if (GlobalVariableCheck(global))Button_2_x=GlobalVariableGet(global);
 global=EAName+Symbol()+"Button_2_y";
   if (GlobalVariableCheck(global))Button_2_y=GlobalVariableGet(global);
Active_TakeReverseTriggerFinger=GlobalVariableGet(EAName+Symbol()+"Set_Button_3_OFF");
 global=EAName+Symbol()+"Button_3_x";
  if (GlobalVariableCheck(global))Button_3_x=GlobalVariableGet(global);
 global=EAName+Symbol()+"Button_3_y";
   if (GlobalVariableCheck(global))Button_3_y=GlobalVariableGet(global);
Active_TakeNextComboHopper=GlobalVariableGet(EAName+Symbol()+"Set_Button_4_OFF");
 global=EAName+Symbol()+"Button_4_x";
  if (GlobalVariableCheck(global))Button_4_x=GlobalVariableGet(global);
 global=EAName+Symbol()+"Button_4_y";
   if (GlobalVariableCheck(global))Button_4_y=GlobalVariableGet(global);
Active_TakeNextComboHopper_H4=GlobalVariableGet(EAName+Symbol()+"Set_Button_5_OFF");
 global=EAName+Symbol()+"Button_5_x";
  if (GlobalVariableCheck(global))Button_5_x=GlobalVariableGet(global);
 global=EAName+Symbol()+"Button_5_y";
   if (GlobalVariableCheck(global))Button_5_y=GlobalVariableGet(global);
}
void SetGV (){
Print("SetGV Set_Button_4_OFF:",Active_TakeNextComboHopper);
GlobalVariableSet(EAName+Symbol()+"Set_Button_1_OFF",Active_Close_AnyOpenTrade_At_MACD_ZERO);
GlobalVariableSet(EAName+Symbol()+"Button_1_x",Button_1_x);
GlobalVariableSet(EAName+Symbol()+"Button_1_y",Button_1_y);
GlobalVariableSet(EAName+Symbol()+"Set_Button_2_OFF",Active_TakeNextHopperTrade);
GlobalVariableSet(EAName+Symbol()+"Button_2_x",Button_2_x);
GlobalVariableSet(EAName+Symbol()+"Button_2_y",Button_2_y);
GlobalVariableSet(EAName+Symbol()+"Set_Button_3_OFF",Active_TakeReverseTriggerFinger);
GlobalVariableSet(EAName+Symbol()+"Button_3_x",Button_3_x);
GlobalVariableSet(EAName+Symbol()+"Button_3_y",Button_3_y);
GlobalVariableSet(EAName+Symbol()+"Set_Button_4_OFF",Active_TakeNextComboHopper);
GlobalVariableSet(EAName+Symbol()+"Button_4_x",Button_4_x);
GlobalVariableSet(EAName+Symbol()+"Button_4_y",Button_4_y);
GlobalVariableSet(EAName+Symbol()+"Set_Button_5_OFF",Active_TakeNextComboHopper_H4);
GlobalVariableSet(EAName+Symbol()+"Button_5_x",Button_5_x);
GlobalVariableSet(EAName+Symbol()+"Button_5_y",Button_5_y);
}
int init (){

if (!validateProductLicense(payPalEmailAddress, license, productID)) {
   ExpertRemove();
   return -1;
}

bool Set_Timer = EventSetTimer(4);
Print("------INIT----------  Time Broker:",TimeToStr(iTime(NULL,0,0),TIME_DATE|TIME_MINUTES)," ",AccountCompany()," ==>",AccountName(),
" TimeLocal:",TimeToStr(TimeLocal(),TIME_DATE|TIME_MINUTES)," "," isdemo:",IsDemo()," isTesting:",IsTesting());
ReadGV();
{
Button_1_x=35;
Button_1_y=10;
Button_2_x=85;
Button_2_y=10;
Button_3_x=135;
Button_3_y=10;
Button_4_x=185;
Button_4_y=10;
Button_5_x=235;
Button_5_y=10;
}
if(!Active_Close_AnyOpenTrade_At_MACD_ZERO)
{
ButtonCreate(0,buttonID_Close_AnyOpenTrade_At_MACD_ZERO,0,Button_1_y,Button_1_x,Button_Width,Button_Height,Corner,buttonID_Close_AnyOpenTrade_At_MACD_ZERO,font_here,Button_FontSize,Button_FontColor,Button_OFF_color,clrNONE);
}
else
ButtonCreate(0,buttonID_Close_AnyOpenTrade_At_MACD_ZERO,0,Button_1_y,Button_1_x,Button_Width,Button_Height,Corner,buttonID_Close_AnyOpenTrade_At_MACD_ZERO,font_here,Button_FontSize,Button_FontColor,Button_ON_color,clrNONE);
if(!Active_TakeNextHopperTrade)
{
Active_TakeNextHopperTrade=false;
ButtonCreate(0,buttonID_TakeNextHopperTrade,0,Button_2_y,Button_2_x,Button_Width,Button_Height,Corner,buttonID_TakeNextHopperTrade,font_here,Button_FontSize,Button_FontColor,Button_OFF_color,clrNONE);
}
else
{
Active_TakeNextHopperTrade=true;
ButtonCreate(0,buttonID_TakeNextHopperTrade,0,Button_2_y,Button_2_x,Button_Width,Button_Height,Corner,buttonID_TakeNextHopperTrade,font_here,Button_FontSize,Button_FontColor,Button_ON_color,clrNONE);
}
if(!Active_TakeReverseTriggerFinger)
{
Active_TakeReverseTriggerFinger=false;
ButtonCreate(0,buttonID_TakeReverseTriggerFinger,0,Button_3_y,Button_3_x,Button_Width,Button_Height,Corner,buttonID_TakeReverseTriggerFinger,font_here,Button_FontSize,Button_FontColor,Button_OFF_color,clrNONE);
}
else
{
Active_TakeReverseTriggerFinger=true;
ButtonCreate(0,buttonID_TakeReverseTriggerFinger,0,Button_3_y,Button_3_x,Button_Width,Button_Height,Corner,buttonID_TakeReverseTriggerFinger,font_here,Button_FontSize,Button_FontColor,Button_ON_color,clrNONE);
}
if(!Active_TakeNextComboHopper)
{
Active_TakeNextComboHopper=false;
ButtonCreate(0,buttonID_TakeNextComboHopper,0,Button_4_y,Button_4_x,Button_Width,Button_Height,Corner,buttonID_TakeNextComboHopper,font_here,Button_FontSize,Button_FontColor,Button_OFF_color,clrNONE);
}
else
{
Active_TakeNextComboHopper=true;
ButtonCreate(0,buttonID_TakeNextComboHopper,0,Button_4_y,Button_4_x,Button_Width,Button_Height,Corner,buttonID_TakeNextComboHopper,font_here,Button_FontSize,Button_FontColor,Button_ON_color,clrNONE);
}
if(!Active_TakeNextComboHopper_H4)
{
Active_TakeNextComboHopper_H4=false;
ButtonCreate(0,buttonID_MondayTrade,0,Button_5_y,Button_5_x,Button_Width,Button_Height,Corner,buttonID_MondayTrade,font_here,Button_FontSize,Button_FontColor,Button_OFF_color,clrNONE);
}
else
{
Active_TakeNextComboHopper=true;
ButtonCreate(0,buttonID_MondayTrade,0,Button_5_y,Button_5_x,Button_Width,Button_Height,Corner,buttonID_MondayTrade,font_here,Button_FontSize,Button_FontColor,Button_ON_color,clrNONE);
}
   if (MarketInfo(Symbol(),MODE_MINLOT)==0.1 || MarketInfo(Symbol(),MODE_MINLOT)==0.05) UseNormalize1Double=true;
   if (Ftime)
   {
    Digitos = MarketInfo(Symbol(), MODE_DIGITS);
   if (Digitos == 2 || Digitos == 4 ) NumDigitosPar = 1;
   if (Digitos == 3 || Digitos == 5 ) NumDigitosPar = 10;
   MaxSpreadAllowed = NormalizeDouble(MaxSpreadAllowed * NumDigitosPar , Digits);
   Slippage = NormalizeDouble(Slippage * NumDigitosPar , Digits);
   ExtraPip = NormalizeDouble(ExtraPip * NumDigitosPar , Digits);
   TakeProfit = NormalizeDouble(TakeProfit * NumDigitosPar , Digits);
   StopLoss = NormalizeDouble(StopLoss * NumDigitosPar , Digits);
   Max_X_pips_away_from_MA0 = NormalizeDouble(Max_X_pips_away_from_MA0 * NumDigitosPar , Digits);
   Max_X_pips_away_from_MA1 = NormalizeDouble(Max_X_pips_away_from_MA1 * NumDigitosPar , Digits);
   MinDistanceBetween_MA0_MA1 = NormalizeDouble(MinDistanceBetween_MA0_MA1 * NumDigitosPar , Digits);
   Min_X_pips_away_from_MA0 = NormalizeDouble(Min_X_pips_away_from_MA0 * NumDigitosPar , Digits);
   Min_X_pips_away_from_MA1 = NormalizeDouble(Min_X_pips_away_from_MA1 * NumDigitosPar , Digits);
   }
Print(
" Min_X_pips_away_from_MA0:",Min_X_pips_away_from_MA0," Min_X_pips_away_from_MA1:",Min_X_pips_away_from_MA1," Max_X_pips_away_from_MA0:",Max_X_pips_away_from_MA0,
" Max_X_pips_away_from_MA1:",Max_X_pips_away_from_MA1," MinDistanceBetween_MA0_MA1:",MinDistanceBetween_MA0_MA1
);
barra=Bars;
     ChartRedraw();
start();
   return(0);
}
int deinit(){
Comment("");
SetGV();
int reasonCode=UninitializeReason();
     switch(reasonCode)
     {
      case REASON_ACCOUNT:
         string text="Account was changed";break;
      case REASON_CHARTCHANGE:
         text="Symbol or timeframe was changed";break;
      case REASON_CHARTCLOSE:
         text="Chart was closed";RemoveButtons();break;
      case REASON_PARAMETERS:
         text="Input-parameter was changed";break;
      case REASON_RECOMPILE:
         text="Program "+__FILE__+" was recompiled";break;
      case REASON_REMOVE:
         text="Program "+__FILE__+" was removed from chart";RemoveButtons();break;
      case REASON_TEMPLATE:
         text="New template was applied to chart";break;
      case REASON_PROGRAM:
         text="Expert Advisor terminated its operation by calling the ExpertRemove() function";RemoveButtons();break;
      case REASON_INITFAILED:
         text="This value means that OnInit() handler has returned a nonzero value";break;
      case REASON_CLOSE:
         ResetAllButtons();
         text="Terminal has been closed";break;
      default:text="Another reason";
     }
      Print("ReasonCode==>: ",reasonCode," - ",text," Broker's time: ",TimeToStr(TimeCurrent(),TIME_DATE|TIME_MINUTES));
return(0);
}
void ResetAllButtons (){
         Active_Close_AnyOpenTrade_At_MACD_ZERO=false;
         Active_TakeNextHopperTrade=false;
         Active_TakeReverseTriggerFinger=false;
         Active_TakeNextComboHopper=false;
         Active_TakeNextComboHopper_H4=false;
         SetGV();
}
void RemoveButtons (){
ObjectDelete(0,buttonID_TakeNextComboHopper );
ObjectDelete(0,buttonID_TakeReverseTriggerFinger);
ObjectDelete(0,buttonID_TakeNextHopperTrade );
ObjectDelete(0,buttonID_Close_AnyOpenTrade_At_MACD_ZERO );
ObjectDelete(0,buttonID_MondayTrade );
ObjectDelete(0,"Settings" );
}
int start (){
                                                                                                                                                                                                                                                     string DI= "1960.1.1"; if (  (TimeCurrent()>=StrToTime(DF)) || (TimeCurrent()<StrToTime(DI)) ) { Comment("");  return(0);  }
if (!IsExpertEnabled() )
{
auxS="You need to turn on the Auto-Trading Experts button!";
Print(auxS);
Alert(auxS);
return(0);
}
criarlabelControl("Settings",
"("+FastMAPeriod+","+SlowMAPeriod+","+SignalMAPeriod+") Realtime:"+GetTrueFalseString(Realtime)
,Colour,PosX,PosY,SizeLabel,1);
if (MarketInfo(Symbol(), MODE_DIGITS)==0)digit=1.0; else digit=MarketInfo(Symbol(), MODE_DIGITS);
CheckButtons();
if (JournalLogs)      comentarios();
if (!RunEA)
{
Comment(GeralCom);
return(0);
}
UpdatedOE();
 if (isNewBar())
 {
   AtualizarInds();
   comentarios(true);
 }
   if(Realtime)
   {
   AtualizarInds();
   }
if (JournalLogs==true)      comentarios();
   return(0);
}
void CheckHopperExit (){
}
void AtualizarInds (){
signal=0;
if (Realtime)int i=0; else i=1;
   ema0= iMA(NULL,0,ComboLine1_Period,0,ComboLine1_Method,ComboLine1_APrice,i);
   ema1= iMA(NULL,0,ComboLine2_Period,0,ComboLine2_Method,ComboLine2_APrice,i);
   ema00= iMA(NULL,0,ComboLine1_Period,0,ComboLine1_Method,ComboLine1_APrice,i+1);
   ema11= iMA(NULL,0,ComboLine2_Period,0,ComboLine2_Method,ComboLine2_APrice,i+1);
if (Active_Close_AnyOpenTrade_At_MACD_ZERO)
{
UpdatedOE(true);
                  string IND="HopperMACDv5";
                  hopper_macd_line=iCustom(NULL,0,IND,
                    FastMAPeriod,SlowMAPeriod,SignalMAPeriod,ArrowSize,ArrowStyle,Look_for_Hopper,HopperMACD_Buffer,Look_for_Trigger_Finger,Look_for_Reverse_Trigger_Finger,Trigger_Finger_MACD_Buffer,
                    0,1);
                  double hopper_macd_line1=iCustom(NULL,0,IND,
                    FastMAPeriod,SlowMAPeriod,SignalMAPeriod,ArrowSize,ArrowStyle,Look_for_Hopper,HopperMACD_Buffer,Look_for_Trigger_Finger,Look_for_Reverse_Trigger_Finger,Trigger_Finger_MACD_Buffer,
                    0,2);
   if (  (BuyOrd>0 && hopper_macd_line<=0.0 && hopper_macd_line1>0.0) || (SellOrd>0 && hopper_macd_line>=0.0 && hopper_macd_line1<0.0 ) )
   {
     Print("Closing open orders due to :Close_AnyOpenTrade_At_MACD_ZERO ==> hopper_macd_line:",hopper_macd_line," hopper_macd_line1:",hopper_macd_line1," (BuyOrd>0 && hopper_macd_line<=0.0 && hopper_macd_line1>0.0) :",(BuyOrd>0 && hopper_macd_line<=0.0 && hopper_macd_line1>0.0)
     ,"  OR  (SellOrd>0 && hopper_macd_line>=0.0 && hopper_macd_line1<0.0 ):",(SellOrd>0 && hopper_macd_line>=0.0 && hopper_macd_line1<0.0 ) );
     if(BuyOrd>0 && hopper_macd_line<=0.0) closeallBS(OP_BUY,99,false,"");
      else closeallBS(OP_SELL,99,false,"");
      auxS=StringConcatenate("Closing open orders due to:Close_AnyOpenTrade_At_MACD_ZERO on "+Symbol());
         doalert(auxS,true,"","");
      ButtonCreate(0,buttonID_Close_AnyOpenTrade_At_MACD_ZERO,0,Button_1_y,Button_1_x,Button_Width,Button_Height,Corner,buttonID_Close_AnyOpenTrade_At_MACD_ZERO,font_here,Button_FontSize,Button_FontColor,Button_OFF_color,clrNONE);
     return;
   }
}
                  IND="HopperMACDv5";
                  hopper_macd_line=iCustom(NULL,0,IND,
                    FastMAPeriod,SlowMAPeriod,SignalMAPeriod,ArrowSize,ArrowStyle,Look_for_Hopper,HopperMACD_Buffer,Look_for_Trigger_Finger,Look_for_Reverse_Trigger_Finger,Trigger_Finger_MACD_Buffer,
                    0,i);
                  hopper_macd_line2=iCustom(NULL,0,IND,
                    FastMAPeriod,SlowMAPeriod,SignalMAPeriod,ArrowSize,ArrowStyle,Look_for_Hopper,HopperMACD_Buffer,Look_for_Trigger_Finger,Look_for_Reverse_Trigger_Finger,Trigger_Finger_MACD_Buffer,
                    0,i+1);
if(Active_TakeNextHopperTrade)
{
      string auxH="";
      if (hopper_macd_line2>=Entry_MACD1_Buffer && hopper_macd_line<Entry_MACD1_Buffer)
       auxH=StringConcatenate("Active_TakeNextHopperTrade SEll Signal was found");
      if (hopper_macd_line2<=Entry_MACD1_Buffer && hopper_macd_line>Entry_MACD1_Buffer)
       auxH=StringConcatenate("Active_TakeNextHopperTrade BUY Signal was found");
        if (StringLen(auxH)>5)
        {
         Print(auxH);
         Active_TakeNextHopperTrade=0;
           ButtonCreate(0,buttonID_TakeNextHopperTrade,0,Button_2_y,Button_2_x,Button_Width,Button_Height,Corner,buttonID_TakeNextHopperTrade,font_here,Button_FontSize,Button_FontColor,Button_OFF_color,clrNONE);
           if (auxH=="Active_TakeNextHopperTrade SEll Signal was found")
            {
               SendSell("TakeNextHopperTrade");
            }
            else
            {
               SendBuy("TakeNextHopperTrade");
            }
        }
}
if(Active_TakeReverseTriggerFinger)
{
   IND="HopperMACDv5";
   hopper_signal_line=iCustom(NULL,0,IND,
     FastMAPeriod,SlowMAPeriod,SignalMAPeriod,ArrowSize,ArrowStyle,Look_for_Hopper,HopperMACD_Buffer,Look_for_Trigger_Finger,Look_for_Reverse_Trigger_Finger,Trigger_Finger_MACD_Buffer,
     1,i);
   hopper_signal_line2=iCustom(NULL,0,IND,
     FastMAPeriod,SlowMAPeriod,SignalMAPeriod,ArrowSize,ArrowStyle,Look_for_Hopper,HopperMACD_Buffer,Look_for_Trigger_Finger,Look_for_Reverse_Trigger_Finger,Trigger_Finger_MACD_Buffer,
     1,i+1);
      auxH="";
      if ( hopper_macd_line>0 && hopper_macd_line2>0 &&  hopper_macd_line<=hopper_signal_line && hopper_macd_line2>hopper_signal_line2 )
       auxH=StringConcatenate("Active_TakeReverseTriggerFinger SELL Signal was found");
      if ( hopper_macd_line<0 && hopper_macd_line2<0 &&  hopper_macd_line>=hopper_signal_line && hopper_macd_line2<hopper_signal_line2 )
       auxH=StringConcatenate("Active_TakeReverseTriggerFinger BUY Signal was found");
        if (StringLen(auxH)>5)
        {
         Print(auxH);
         Active_TakeReverseTriggerFinger=0;
            ButtonCreate(0,buttonID_TakeReverseTriggerFinger,0,Button_3_y,Button_3_x,Button_Width,Button_Height,Corner,buttonID_TakeReverseTriggerFinger,font_here,Button_FontSize,Button_FontColor,Button_OFF_color,clrNONE);
           if (auxH=="Active_TakeReverseTriggerFinger SELL Signal was found")
            {
               SendSell("TakeReverseTriggerFinger");
            }
            else
            {
               SendBuy("TakeReverseTriggerFinger");
            }
        }
}
if(Active_TakeNextComboHopper)
{
      auxH="";
         highest_ma=MathMax(ema0,ema1);
         lowest_ma=MathMin(ema0,ema1);
         if (Close[1]<=lowest_ma && Open[1]>=lowest_ma)
         {
         MACrossingTime=-Time[0];
         Print(" New Crossing DW at:",ft(MathAbs(MACrossingTime)));
         }
         else if (Close[1]>=highest_ma && Open[1]<=highest_ma )
         {
         MACrossingTime=Time[0];
         Print(" New Crossing UP at:",ft(MACrossingTime));
         }
            if (iBarShift(NULL,0,MathAbs(MACrossingTime))<=ConfirmLookBack)
            {
                     if ( hopper_macd_line>0 && MACrossingTime>0) auxH=StringConcatenate("Active_TakeNextComboHopper BUY Signal was found");
                else if ( hopper_macd_line<0 && MACrossingTime<0) auxH=StringConcatenate("Active_TakeNextComboHopper SELL Signal was found");
            }
        if (StringLen(auxH)>5)
        {
         if( auxH=="Active_TakeNextComboHopper BUY Signal was found" && !CheckFilters(0))return;
         if( auxH=="Active_TakeNextComboHopper SELL Signal was found" && !CheckFilters(1))return;
         Print(auxH);
         Active_TakeNextComboHopper=0;
            ButtonCreate(0,buttonID_TakeNextComboHopper,0,Button_4_y,Button_4_x,Button_Width,Button_Height,Corner,buttonID_TakeNextComboHopper,font_here,Button_FontSize,Button_FontColor,Button_OFF_color,clrNONE);
           if (auxH=="Active_TakeNextComboHopper SELL Signal was found")
            {
               SendSell("TakeNextComboHopper");
            }
            else
            {
               SendBuy("TakeNextComboHopper");
            }
        }
}
if(Active_TakeNextComboHopper_H4 )
{
if (Period()!=PERIOD_H4)
{
   Alert("Monday Trade 4H chart only");
         Active_TakeNextComboHopper_H4=0;
           ButtonCreate(0,buttonID_MondayTrade,0,Button_5_y,Button_5_x,Button_Width,Button_Height,Corner,buttonID_MondayTrade,font_here,Button_FontSize,Button_FontColor,Button_OFF_color,clrNONE);
return;
}
auxH=GetLastSignal();
        if (StringLen(auxH)>5 &&  LastHopperH4TimeFound>LastHopperH4Time_Sent )
        {
         Print(auxH);
         LastHopperH4Time_Sent=LastHopperH4TimeFound;
         Active_TakeNextComboHopper_H4=0;
           ButtonCreate(0,buttonID_MondayTrade,0,Button_5_y,Button_5_x,Button_Width,Button_Height,Corner,buttonID_MondayTrade,font_here,Button_FontSize,Button_FontColor,Button_OFF_color,clrNONE);
           if (auxH=="Active_TakeNextComboHopper_H4 SEll Signal was found")
            {
               SendSell("Active_TakeNextComboHopper_H4");
            }
            else
            {
               SendBuy("Active_TakeNextComboHopper_H4");
            }
        }
}
}
string GetLastSignal (){
   string IND="HopperMACDv5";
   for (int i=1;i<LookBack_Hopper;i++)
   {
      int time_i_in_h4=iTime(NULL,PERIOD_H4,i);
      if(TimeDayOfWeek(time_i_in_h4)>2 || TimeDayOfWeek(time_i_in_h4)<1)continue;
      hopper_macd_line=iCustom(NULL,PERIOD_H4,IND,
        FastMAPeriod,SlowMAPeriod,SignalMAPeriod,ArrowSize,ArrowStyle,Look_for_Hopper,HopperMACD_Buffer,Look_for_Trigger_Finger,Look_for_Reverse_Trigger_Finger,Trigger_Finger_MACD_Buffer,
        0,i);
      hopper_macd_line2=iCustom(NULL,PERIOD_H4,IND,
        FastMAPeriod,SlowMAPeriod,SignalMAPeriod,ArrowSize,ArrowStyle,Look_for_Hopper,HopperMACD_Buffer,Look_for_Trigger_Finger,Look_for_Reverse_Trigger_Finger,Trigger_Finger_MACD_Buffer,
        0,i+1);
         if ( hopper_macd_line>=HopperMACD_Buffer && hopper_macd_line2<HopperMACD_Buffer)
            {
              LastHopperH4TimeFound=time_i_in_h4;
                return(StringConcatenate("Active_TakeNextComboHopper_H4 BUY Signal was found"));
            }
         if ( hopper_macd_line<=HopperMACD_Buffer && hopper_macd_line2>HopperMACD_Buffer)
            {
              LastHopperH4TimeFound=time_i_in_h4;
                return(StringConcatenate("Active_TakeNextComboHopper_H4 BUY SEll was found"));
            }
   }
return("");
}
void SendBuy (string from=""){
      EntryTime=iTime(NULL,0,0);
      comentarios(true);
      OrdemBS=2;
      if (CloseOppositeOrder && SellOrd>0)
      {
      msg(
      "Closing Sell orders due to : Opposite Signal"
      ,AllMessages);
      closeallBS(1,99,false,"");
      UpdatedOE();
      }
       msg(
       "Sending Buy order..."+from
       ,AllMessages,ControleLog);
       if(DrawArrows)_setabuy(from);
      if(OpenLiveOrders)
      BuyTicket=SendOrder(Symbol(),OP_BUY,Lots,Lots,0,EAName,StopLoss,TakeProfit,MagicNumber,false,OrdemBS,_OrderRetry,PercentRisk,MaxSpreadAllowed,OrderRetryTimeSec,true,false,false,0);
       auxS="Sending BUY order on "+Symbol()+" "+GetPeriodString(Period());
       doalert(auxS,true,"OpenOrder",OrderOpenPrice());
      }
void SendSell (string from=""){
      actual_tp=0;
      EntryTime=-iTime(NULL,0,0);
      OrdemBS=1;
      comentarios(true);
      if (CloseOppositeOrder && BuyOrd>0)
      {
      msg(
      "Closing Buy orders due to : Opposite Signal"
      ,AllMessages);
      closeallBS(0,99,false,"");
      UpdatedOE();
      }
      msg(
       "Sending Sell order..."+from
       ,AllMessages,ControleLog);
      if(DrawArrows)_setasell(from);
      if(OpenLiveOrders)
      SellTicket=SendOrder(Symbol(),OP_SELL,Lots,Lots,0,EAName,StopLoss,TakeProfit,MagicNumber,false,OrdemBS,_OrderRetry,PercentRisk,MaxSpreadAllowed,OrderRetryTimeSec,true,false,false,0);
      auxS="Sending SELL order on "+Symbol()+" "+GetPeriodString(Period());
        doalert(auxS,true,"OpenOrder",OrderOpenPrice());
}
void doalert (string text="", bool send_only_text=true,string log1="",string log2="",string log3=""){
   string M1=EAName;
   string M2=Symbol()+" "+GetPeriodString(Period());
    if (send_only_text)M2="";
   string M3="\n"+TimeToStr(TimeCurrent(),TIME_DATE|TIME_MINUTES)+"\n";
   string M4="\n"+auxS;
   string All=M1+M2+M3+M4;
   if(JournalLogs)Print("DebugPrint: EA Signal Alert - text:",text);
string str_log=StringConcatenate(
TimeToStr(TimeCurrent(),TIME_DATE|TIME_MINUTES),";",
log1,";",
Symbol(),";",
GetPeriodString(Period()),";",
DoubleToStr(Bid,Digits),";",
DoubleToStr(Ask,Digits),";",
log2,";",
log3,";"
);
if(WriteLogs)Log(Symbol()+"_"+GetPeriodString(Period())+".txt",str_log,true,false);
      if (PopUpAlert) Alert(M2+" "+text);
      if(JournalLogs)Print(" Alert GetLastError:",GetLastError());
      if (PushNotification)
      {
      SendNotification(M2+" "+text);
      if(JournalLogs)Print(" EA SendNotification GetLastError:",GetLastError());
      }
      if (EMailAlert)SendMail(M2+" "+text,M2+" "+text);
               Sleep(500);
}
void closeallBS (int BS,int NumeroMagico,bool ALERTA=false,string com=""){
int count=0;
int OK=0;
 Total = OrdersTotal();
int i;
   if (OrdersTotal()!=0 && BS==0 && NumeroMagico==0  )
         for(  i=Total-1;i>=0;i--)
         {
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
            Closetic(OrderTicket(),_OrderRetry);
         }
   Total = OrdersTotal();
   if (OrdersTotal()!=0)
         for(  i=Total-1;i>=0;i--)
         {
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
            if
            (
            (OrderMagicNumber()==NumeroMagico ||NumeroMagico==99) &&
             OrderSymbol()==Symbol() &&
            (OrderType()==BS  ||  BS==99 )  &&
            (OrderComment()==com || com=="")
            )
            Closetic(OrderTicket(),_OrderRetry);
         }
     if (OrdersTotal()!=0)
         for(  i=Total-1;i>=0;i--)
         {
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
            if
            (
            (OrderMagicNumber()==NumeroMagico ||NumeroMagico==99) &&
             OrderSymbol()==Symbol() &&
            (OrderType()==BS  ||  BS==99 )  &&
            (OrderComment()==com || com=="")
            )
            Closetic(OrderTicket(),_OrderRetry);
         }
}
bool Closetic (int T,int _OrderRetry){
int OK=0;
int count=0;
double D;
int Ticket;
double price;
bool OkFinal=false;
if(OrderSelect(T,SELECT_BY_TICKET))
   if (OrderCloseTime()==0 && OrderTicket()!=0)
   {
     while (IsTradeContextBusy()) Sleep(250);
                 if(OrderType()==OP_BUY ||  OrderType()==OP_SELL)
                  while (OK!=1)
                  {
                  RefreshRates();
                  D=MarketInfo(OrderSymbol(),MODE_DIGITS);
                  if (OrderType()==OP_BUY)price=MarketInfo(OrderSymbol(),MODE_BID);
                     else                 price=MarketInfo(OrderSymbol(),MODE_ASK);
                  Ticket = OrderClose(OrderTicket(),OrderLots(),NormalizeDouble(price,D),0,Yellow);
                     if (Ticket==true)
                     {
                     OK=1;
                     OkFinal=true;
                     }
                     else
                     {
                     EsperarServidorDisponivel();
                        msg(
                        StringConcatenate(" GetLastError: ",GetLastError())
                        ,AllMessages,ControleLog);
                     }
                     if (count>_OrderRetry)
                     {
                        OK=1;
                        msg(
                        StringConcatenate(" count : ",count," > OrderRetry ",_OrderRetry)
                        ,AllMessages,ControleLog);
                     }
                     count++;
                  }else
                      while (OK!=1)
                      {
                      RefreshRates();
                      Ticket = OrderDelete(OrderTicket());
                        if (Ticket==true){
                        OK=1;
                        OkFinal=true;
                        }
                        else  EsperarServidorDisponivel();
                        if (count>_OrderRetry)
                        {
                        OK=1;
                          msg(
                          StringConcatenate(" count : ",count," > OrderRetry ",_OrderRetry)
                          ,AllMessages,ControleLog);
                        }
                      count++;
                      }
   }
return(OkFinal);
}
      void EsperarServidorDisponivel()
      {
        Sleep(250);
        while (IsTradeContextBusy() && IsConnected() ) Sleep(250);
      }
bool isNewBar ()  {
         static datetime dt  = 0;
         if (dt != Time[0])
         {
            dt = Time[0];
            return(true);
         }
         return(false);
      }
int SendOrder (string sym,int bs,double LotePersonalizado,double LoteDefault,double Price,string com,double SL,double TP,int Magic,bool UseReverseOrder,int & OrdemBSHere,
int _OrderRetryHere, double _PercentRisk,int _MaxSpreadAllowed,int _OrderRetryTimeSec,bool debu,bool HiddenSLL,bool HiddenTPP,int expirat,color ForceCor=Honeydew){
double tp,sl,lt;
int err,count;
int count2=0;
color cor=Red;
int Ticket=-1;
int OK=0;
   double bid=MarketInfo(sym,MODE_BID);
   double ask=MarketInfo(sym,MODE_ASK);
   double dig=MarketInfo(sym,MODE_DIGITS);
   double poi=MarketInfo(sym,MODE_POINT);
if (expirat!=0)expi=TimeCurrent()+expirat*60;
               if (bs==OP_BUY)  {Price = NormalizeDouble(MarketInfo(sym,MODE_ASK), dig);   OrdemBSHere=1;}
               if (bs==OP_SELL) {Price = NormalizeDouble(MarketInfo(sym,MODE_BID), dig);   OrdemBSHere=-1;}
lt=NormalizeDouble(LotePersonalizado,Digits2Round);
 lt=FixVolume2(bs,lt,sym);
 MainLotSendOrder=lt;
if (debu)
     msg(
     " Sending "+GetCMD(bs)+ " Broker's time: "+ TimeToStr(TimeCurrent(),TIME_DATE|TIME_MINUTES)+   " Local's time: "+ TimeToStr(TimeLocal(),TIME_DATE|TIME_MINUTES)+
     " Receiving SL:"+DoubleToStr(SL,5)+" and TP:"+DoubleToStr(TP,5)   + " and Price:"+DoubleToStr(Price,5)   + " and lt:"+DoubleToStr(lt,3)
     ,AllMessages);
if (_OrderRetryHere<1) count=1;
 else              count=_OrderRetryHere;
       int       SpreadMultiplier=1;
       if (bs==0)SpreadMultiplier=2;
         if (bs==0 || bs==1)
         {
            AccountFreeMarginCheck(sym, bs, lt);
            err = GetLastError();
            if (err > 0 )
            {
               Alert("No money for new position err:"+err+" lt:"+lt+" trying again...");
               while(err>0)
               {
               lt=FixVolume2(bs,lt,sym);
               AccountFreeMarginCheck(sym, bs, lt);
                 err = GetLastError();
               Alert("No money for new position err:"+err+" lt:"+lt+" trying again...");
               count2++;
                     if (count2>10)return (-3);
               }
            }
         }
             count2=0;
             while(Ticket<0)
             {
               RefreshRates();
               if (bs==OP_BUY)  {Price = NormalizeDouble(MarketInfo(sym,MODE_ASK), dig);   OrdemBSHere=1;}
               if (bs==OP_SELL) {Price = NormalizeDouble(MarketInfo(sym,MODE_BID), dig);   OrdemBSHere=-1;}
               if (bs==OP_BUY || bs==OP_BUYSTOP ||bs==OP_BUYLIMIT)
               {
                  if (ForceCor!=Honeydew)cor=ForceCor;
                  else
                  {
                  if (bs==OP_BUY) cor=Blue;
                   else if (bs==OP_BUYSTOP) cor=Lime;
                     else cor=Green;
                  }
               }
               else
               {
                  if (ForceCor!=Honeydew)cor=ForceCor;
                  else
                  {
                  if (bs==OP_SELL) cor=Red;
                   else if (bs==OP_SELLSTOP) cor=Magenta;
                     else cor=Pink;
                  }
               }
               double ActualSpread=MarketInfo(sym,MODE_SPREAD);
                 if (ActualSpread>_MaxSpreadAllowed && _MaxSpreadAllowed!=0 )
                 {
                 if (debu)
                  msg(
                   " ActualSpread is bigger than MaxSpreadAllowed . Cancelling Buy Order."
                  ,AllMessages);
                 return(-4);
                 }
                              if (bs==OP_BUY || bs==OP_BUYSTOP ||bs==OP_BUYLIMIT)
                              {
                                 if (TP==0)tp=0; else tp=Price+(TP*poi);
                                 if (SL==0)sl=0; else sl=Price-(SL*poi);
                              }
                              else
                              {
                                 if (TP==0)tp=0; else tp=Price-(TP*poi);
                                 if (SL==0)sl=0; else sl=Price+(SL*poi);
                              }
               Print("ActualS sl:",DoubleToStr(sl,5)," SL:",DoubleToStr(SL,5)," | tp:",DoubleToStr(tp,5)," | TP:",DoubleToStr(TP,5)," bs:",bs," ..checking adjust_before_sendOrder..");
               double adjust_before_sendOrder=AdjustSLLevels(sym,bs,sl,tp,Price,true);
               if (adjust_before_sendOrder>0)
               {
                  lt=NormalizeDouble(LotePersonalizado,Digits2Round);
                  if(JournalLogs)Print("New LT has been calculated to lt:",lt," | based on adjust_before_sendOrder:",adjust_before_sendOrder);
               }
               else Print(" SL/TP OK. no need to adjust them");
               lt=NormalizeDouble(lt,Digits2Round);
   if (debu)
     msg(
     " Re-Sending "+GetCMD(bs)+ " Broker's time: "+ TimeToStr(TimeCurrent(),TIME_DATE|TIME_MINUTES)+" Receiving SL:"+DoubleToStr(SL,5)+" and TP:"+DoubleToStr(TP,5)
     +" and lt:"+DoubleToStr(lt,5) +" and expi:"+DoubleToStr(expi,5) +" Price:"+Price+" Bid:"+Bid+" Ask:"+Ask+" dig:"+dig+" Digits2Round:"+Digits2Round+" "+sym
     ,AllMessages);
    dig=MarketInfo(sym,MODE_DIGITS);
                    Ticket=OrderSend(sym,bs,NormalizeDouble(lt,Digits2Round),NormalizeDouble(Price,dig),NormalizeDouble(Slippage,0),0,0,com,NormalizeDouble(Magic,0),NormalizeDouble(expi,0),cor);
                 err = GetLastError();
                 if (debu)
                  msg(
                  StringConcatenate("  Sent Ticket: ",Ticket,"  err: ",err)
                  ,AllMessages);
                     if(Ticket<0)
                     {
                     if (debu)
                        msg(
                        StringConcatenate("Ticket:",Ticket," Bid: ",bid," Ask: ",ask," bs: ",GetCMD(bs)," lt: ",lt," Price: ",Price," com: ",com," Magic: ",Magic," tp: ",tp," sl: ",sl)
                        ,AllMessages);
                        count2++;
                        Sleep(500);
                        if (count2>10)
                        {
                           msg(
                           StringConcatenate(" count2 : ",count2," > count ",count)
                           ,AllMessages);
                        Ticket=-1;
                        return(Ticket);
                        }
                        switch (err)
                        {
                             case               ERR_NO_ERROR:
                             case          ERR_INVALID_STOPS:
                             case            ERR_SERVER_BUSY:
                             case          ERR_NO_CONNECTION:
                             case          ERR_INVALID_PRICE:
                             case             ERR_OFF_QUOTES:
                             case            ERR_BROKER_BUSY:
                             case     ERR_TRADE_CONTEXT_BUSY:
                             case          ERR_PRICE_CHANGED:
                             case                ERR_REQUOTE: continue;
                             case      ERR_TOO_MANY_REQUESTS: sleep(2000); continue;
                             case   ERR_INVALID_TRADE_VOLUME: Ticket=-ERR_INVALID_TRADE_VOLUME;  Alert(   " Invalid Lots "+DoubleToStr(lt,2)   ); return(Ticket); break;
                             case          ERR_MARKET_CLOSED: Ticket=-ERR_MARKET_CLOSED;  Alert(  " Market Close"     ); return(Ticket); break;
                             case         ERR_TRADE_DISABLED: Ticket=-ERR_TRADE_DISABLED;  Alert(  " Trades Disabled"  ); return(Ticket); break;
                             case       ERR_NOT_ENOUGH_MONEY: Ticket=-ERR_NOT_ENOUGH_MONEY;  Alert(  " Not Enough Money" ); return(Ticket); break;
                             case  ERR_TRADE_TOO_MANY_ORDERS: Ticket=-ERR_TRADE_TOO_MANY_ORDERS;  Alert(  " Too Many Orders"  );return(Ticket);  break;
                             case                        149: Ticket=-149;  Alert(  " Hedge is prohibited"  ); return(Ticket); break;
                             case              ERR_NO_RESULT:
                                                     default: Ticket = -1; if (debu)
                                                                                 msg(
                                                                                 "Unknown Error - " + err
                                                                                 ,AllMessages);
                                                                                 break;
                       }
                     count2++;
                     Sleep(500);
                     }
                     else
                     {
                        if(OrderSelect(Ticket,SELECT_BY_TICKET))
                        {
                              Price=OrderOpenPrice();
                              HiddenSL=sl;
                              HiddenTP=tp;
                              if(JournalLogs)Print("HiddenSL:",HiddenSL," HiddenTP:",HiddenTP);
                              if (debu)
                                 msg(
                                 StringConcatenate(" SL : ",sl," TP : ",tp)
                                 ,AllMessages);
                            OK=1;
                            if(JournalLogs)Print("Ticket:",Ticket," has been opened. GetLastError():",err);
                            ECN(Ticket,sym,bs,sl,tp,HiddenSLL,HiddenTPP,expi,debu,Price,_OrderRetryTimeSec);
                              auxS="Opening Order "+GetCMD(bs)+" on "+ sym;
                              doalert(auxS);
                              break;
                       }
                      }
                while (IsTradeContextBusy())
                  Sleep(_OrderRetryTimeSec*1000);
           if (count2>10){Ticket=-1;  return(Ticket);}
           }
return(Ticket);
}
void sleep (uint Miliseconds=250)
{
            uint Ini = GetTickCount();
            while ((GetTickCount()-Ini)<Miliseconds)
            {
              if (!IsConnected() || !IsTesting()) break;
              Sleep(10);
            }
}
void ECN (int Tickett,string sym,int bs, double sl,double tp,bool HiddenSLL,bool HiddenTPP,int expiration,bool debu,double Price,int _OrderRetryTimeSec){
Print(" Executing ECN.. Tickett:",Tickett," sl:",sl," tp:",tp," HiddenSLL:",HiddenSLL," HiddenTPP:",HiddenTPP," Price:",Price);
double bid=MarketInfo(sym,MODE_BID);
double ask=MarketInfo(sym,MODE_ASK);
double dig=MarketInfo(sym,MODE_DIGITS);
double poi=MarketInfo(sym,MODE_POINT);
int err2=0;
                        AdjustSLLevels(sym,bs,sl,tp,Price);
                        int errorModify=-1;
                        int countModify=0;
                        if (!HiddenSLL)
                        {
                        if (sl!=0)
                          while (errorModify<=0)
                          {
                           RefreshRates();
                           if(OrderSelect(Tickett, SELECT_BY_TICKET, MODE_TRADES)<=0)return;
                           errorModify = OrderModify(OrderTicket(),OrderOpenPrice(),NormalizeDouble(sl,dig),OrderTakeProfit(),expiration,Green);
                           err2=GetLastError();
                           if (errorModify<=0)
                           {
                           AdjustSLLevels(sym,bs,sl,tp,Price);
                           if (debu)
                                 msg(
                                 StringConcatenate(errorModify," <-errorModify GetLastError:",err2," Error modifying SL BS = ",GetCMD(bs),"Bid = ",bid," Ask = ",ask," Price: ",Price," Actual SL = ",OrderStopLoss(),
                                " OrderTicket() ",OrderTicket()," Function has tried to change the SL = ",sl," expi:",TimeToStr(expi,TIME_DATE|TIME_MINUTES))
                                 ,AllMessages);
                              while (IsTradeContextBusy())
                                 Sleep(_OrderRetryTimeSec*1000);
                           }
                            else
                            {
                            if (debu)
                                 msg(
                                 StringConcatenate(" OK! SL BS  = ",GetCMD(bs),"Bid = ",bid," Ask = ",ask," Price: ",Price," NEWSL = ",sl,"  TP = ",OrderTakeProfit()," OrderTicket() ",OrderTicket())
                                 ,AllMessages);
                            }
                          countModify++;
                           if (countModify > _OrderRetry)
                           {
                           if(JournalLogs)Print("countModify > _OrderRetry");
                           break;
                           }
                          }
                         }
                        if (!HiddenTPP)
                        {
                         errorModify=-1;
                         countModify=0;
                        if (tp!=0)
                          while (errorModify<=0   )
                          {
                           RefreshRates();
                           if(OrderSelect(Tickett, SELECT_BY_TICKET)<=0)return;
                           errorModify = OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),NormalizeDouble(tp,dig),expi,Green);
                           err2=GetLastError();
                           if (errorModify<=0)
                           {
                             AdjustSLLevels(sym,bs,sl,tp,Price);
                             if (debu)
                                 msg(
                                 StringConcatenate(errorModify," <-errorModify GetLastError:",err2,"  Error modifying TP BS = ",GetCMD(bs),"Bid = ",bid," Ask = ",ask," Price: ",Price," Actual SL = ",OrderStopLoss(),
                                 "  Function has tried to change the TP to = ",tp," OrderTicket() ",OrderTicket()," countModify: ",countModify," expi:",TimeToStr(expi,TIME_DATE|TIME_MINUTES))
                                 ,AllMessages);
                              while (IsTradeContextBusy())
                                 Sleep(_OrderRetryTimeSec*1000);
                           }
                            else
                            {
                              if (debu)
                                 msg(
                                 StringConcatenate(" OK! TP BS  = ",GetCMD(bs),"Bid = ",bid," Ask = ",ask," Price: ",Price," NEWSL = ",sl,"  TP = ",OrderTakeProfit(),
                                 " OrderTicket() ",OrderTicket()," countModify: ",countModify," expi:",TimeToStr(expi,TIME_DATE|TIME_MINUTES))
                                 ,AllMessages);
                            }
                          countModify++;
                           if (countModify > _OrderRetry)
                           {
                           if(JournalLogs)Print("countModify > _OrderRetry");
                           break;
                           }
                          }
                         }
}
void msg (string text,bool AllMessages,int & ControleLog)   {
   if (StringLen(text)>0)
   {
      if (AllMessages || LastText != text)
      {
         LastText = text;
         Print(text+" LogControl: "+ControleLog+" Broker's time: ",TimeToStr(TimeCurrent(),TIME_DATE|TIME_MINUTES));
         ControleLog=0;
      }
      else ControleLog++;
   }
}
string GetCMD (int cmd)
{
if (cmd == OP_BUY)      return("OP_BUY");
if (cmd == OP_SELL)     return("OP_SELL");
if (cmd == OP_BUYSTOP)  return("OP_BUYSTOP");
if (cmd == OP_SELLSTOP) return("OP_SELLSTOP");
if (cmd == OP_BUYLIMIT) return("OP_BUYLIMIT");
if (cmd == OP_SELLLIMIT)return("OP_SELLLIMIT");
return("(CMD== not valid) ");
}
double AdjustSLLevels (string SYM,int bs,double & sl,double & tp,double & preco,bool include_spread=true)  {
  double auxsl,auxTP,MinimalPrice;
double newSLinPips=0;
   RefreshRates();
   double p=MarketInfo(SYM,MODE_POINT);
   if (p<=0)
   {
   msg(StringConcatenate("Symbol does not exist- Symbol : ",SYM," Point: ",p),AllMessages);
   return(-1);
   }
   double StpLevel = MarketInfo(SYM, MODE_STOPLEVEL);
   double Spread_ = MarketInfo(SYM, MODE_SPREAD);
   double bid = MarketInfo(SYM, MODE_BID);
   double ask = MarketInfo(SYM, MODE_ASK);
   if(JournalLogs)Print(" AdjustSLLevels | StpLevel:",DoubleToStr(StpLevel,5)," | Spread_:",DoubleToStr(Spread_,5)," | bid:",DoubleToStr(bid,5)," | ask:",DoubleToStr(ask,5),
   " | include_spread:",include_spread," Point:",DoubleToStr(p,5)
   ," sl:",DoubleToStr(sl,5)," tp:",DoubleToStr(tp,5));
   if(!include_spread)Spread_=0;
   if (bs==OP_BUY)
   {
   auxsl=bid - (StpLevel + Spread_)*p;
   auxTP=ask + (StpLevel + Spread_)*p;
      if (sl>auxsl && sl!=0)
      {
      newSLinPips=((auxsl-bid)/p)*NumDigitosPar;
      msg("1-Adjusting OP_BUY SL from sl:"+sl+" to auxsl: "+auxsl+" <- Minimal allowed to use with this currency ->bid:"+bid+" - newSLinPips:"+newSLinPips,AllMessages);
      sl=auxsl;
      }
      if (tp<auxTP && tp!=0)
      {
      msg("2-Adjusting OP_BUY TP from tp:"+tp+" to auxTP: "+auxTP+" <- Minimal allowed to use with this currency -ask:"+ask,AllMessages);
      tp=auxTP;
      }
   }
   else if (bs==OP_SELL)
      {
         auxsl=ask + (StpLevel + Spread_)*p;
         auxTP=bid - (StpLevel + Spread_)*p;
         if (sl<auxsl && sl!=0)
         {
         newSLinPips=((auxsl-ask)/p)*NumDigitosPar;
         msg("3-Adjusting OP_SELL SL from sl:"+sl+" to auxsl: "+auxsl+" <- Minimal allowed to use with this currency which is ask::"+ask+" + newSLinPips:"+newSLinPips+" = sl:"+auxsl,AllMessages);
         sl=auxsl;
         }
         if (tp>auxTP && tp!=0)
         {
         msg("4-Adjusting OP_SELL TP from tp:"+tp+" to auxTP: "+auxTP+" <- Minimal allowed to use with this currency -bid:"+bid,AllMessages);
         tp=auxTP;
         }
      }
   else if (bs==OP_BUYLIMIT )
   {
   MinimalPrice=bid-(StpLevel + Spread_)*p;
      if (preco>MinimalPrice)
      {
      if(JournalLogs)Print("7-Adjusting OP_BUYLIMIT EntryPrice to : "+MinimalPrice+" <- Minimal allowed to use with this currency ");
      preco=MinimalPrice;
      }
      auxsl=preco - (StpLevel + Spread_)*p;
      auxTP=preco + (StpLevel + Spread_)*p;
         if (sl>auxsl && sl!=0)
         {
         newSLinPips=((auxsl-preco)/p)*NumDigitosPar;
         msg("8-Adjusting OP_BUYSTOP/OP_BUYLIMIT SL from sl:"+sl+" to auxsl: "+auxsl+" <-  Minimal allowed to use with this currency -ask:"+ask,AllMessages);
         sl=auxsl;
         }
         if (tp<auxTP && tp!=0)
         {
         msg("9-Adjusting OP_BUYSTOP/OP_BUYLIMIT TP from tp:"+tp+" to auxTP: "+auxTP+" <- Minimal allowed to use with this currency -ask:"+ask,AllMessages);
         tp=auxTP;
         }
   }
   else if (bs==OP_BUYSTOP )
   {
   MinimalPrice=ask+(StpLevel + Spread_)*p;
      if (preco<MinimalPrice)
      {
      if(JournalLogs)Print("10-Adjusting OP_BUYSTOP EntryPrice to : "+MinimalPrice+" <- Minimal allowed to use with this currency ");
      preco=MinimalPrice;
      }
      auxsl=preco - (StpLevel + Spread_)*p;
      auxTP=preco + (StpLevel + Spread_)*p;
         if (sl>auxsl && sl!=0)
         {
         newSLinPips=((auxsl-preco)/p)*NumDigitosPar;
         msg("11-Adjusting OP_BUYSTOP/OP_BUYLIMIT SL from sl:"+sl+" to auxsl: "+auxsl+" <- Minimal allowed to use with this currency -ask:"+ask,AllMessages);
         sl=auxsl;
         }
         if (tp<auxTP && tp!=0)
         {
         msg("12-Adjusting OP_BUYSTOP/OP_BUYLIMIT TP from tp:"+tp+" to auxTP: "+auxTP+" <- Minimal allowed to use with this currency -ask:"+ask,AllMessages);
         tp=auxTP;
         }
   }
   else if (bs==OP_SELLLIMIT )
   {
      MinimalPrice=bid+(StpLevel + Spread_)*p;
      if (preco<MinimalPrice)
      {
      if(JournalLogs)Print("13-Adjusting OP_SELLLIMIT EntryPrice to : "+MinimalPrice+" <- Minimal allowed to use with this currency ");
      preco=MinimalPrice;
      }
         auxsl=preco + (StpLevel + Spread_)*p;
         auxTP=preco - (StpLevel + Spread_)*p;
         if (sl<auxsl && sl!=0)
         {
         newSLinPips=((auxsl-preco)/p)*NumDigitosPar;
         msg("14-Adjusting OP_SELLLIMIT SL from sl:"+sl+" to auxsl: "+auxsl+" <- Minimal allowed to use with this currency -bid:"+bid ,AllMessages);
         sl=auxsl;
         }
         if (tp>auxTP && tp!=0)
         {
         msg("15-Adjusting OP_SELLLIMIT TP from tp:"+tp+" to auxTP: "+auxTP+" <- Minimal allowed to use with this currency -bid:"+bid,AllMessages);
         tp=auxTP;
         }
   }
   else if (bs==OP_SELLSTOP )
   {
      MinimalPrice=ask-(StpLevel + Spread_)*p;
      if (preco>MinimalPrice)
      {
      if(JournalLogs)Print("16-Adjusting OP_SELLLIMIT EntryPrice to : "+MinimalPrice+" <- Minimal allowed to use with this currency ");
      preco=MinimalPrice;
      }
         auxsl=preco + (StpLevel + Spread_)*p;
         auxTP=preco - (StpLevel + Spread_)*p;
         if (sl<auxsl && sl!=0)
         {
         newSLinPips=((auxsl-preco)/p)*NumDigitosPar;
         msg("17-Adjusting OP_SELLSTOP SL from sl:"+sl+" to auxsl: "+auxsl+" <- Minimal allowed to use with this currency -bid:"+bid ,AllMessages);
         sl=auxsl;
         }
         if (tp>auxTP && tp!=0)
         {
         msg("18-Adjusting OP_SELLSTOP TP from tp:"+tp+" to auxTP: "+auxTP+" <- Minimal allowed to use with this currency -bid:"+bid,AllMessages);
         tp=auxTP;
         }
   }
return(newSLinPips);
}
void seta(string name,
             int    Window,
             double X0_Time,
             double Y0_Price,
             int    Code,
             int    Color,
             int    Width)
{
  ObjectDelete(name);
  ObjectCreate(name,OBJ_ARROW,Window,X0_Time,Y0_Price);
  ObjectSet(name,OBJPROP_ARROWCODE,Code);
  ObjectSet(name,OBJPROP_COLOR,Color);
  ObjectSet(name,OBJPROP_WIDTH,Width);
}
void _setabuy(string _nomedoea){
Name=StringConcatenate(_nomedoea,numero);
seta(Name,0,TimeCurrent(),Close[0],241,clrAqua,2);
numero++;
Name=StringConcatenate(_nomedoea,"_",numero,"");
}
void _setasell(string _nomedoea){
Name=StringConcatenate(_nomedoea,numero);
seta(Name,0,TimeCurrent(),Bid-(15*Point),242,Red,2);
numero++;
Name=StringConcatenate(_nomedoea,"_",numero,"");
}
void criartext (string nome,string texto, color cor,int tempo,double price,int size){
ObjectDelete(nome);
      ObjectCreate (nome,OBJ_TEXT,0,tempo,price);
      ObjectSetText(nome, texto,size,"Arial",cor);
      ObjectMove   (nome,0,tempo,price);
}
void _setaZERO(string _nomedoea,color cor=White,bool use_MT4_arrows=false){
_nomedoea="seta";
string Name=StringConcatenate(_nomedoea,TimeCurrent());
if (!use_MT4_arrows)int arrow=232; else arrow=1;
seta(Name+Time[0],0,iTime(NULL,0,0),Close[0],117,cor,1);
}
double FixVolume2 ( int bs,double Lots,string SymbolName,bool Log=false, bool AdjustMaxLotMargin=true)
{
  int AccountType;
  if (SymbolName=="") SymbolName = Symbol();
  double StpLot    = MarketInfo(SymbolName,MODE_LOTSTEP);
  double TamLot    = MarketInfo(SymbolName,MODE_LOTSIZE);
  double Total     = AccountFreeMargin() * AccountLeverage();
  double Resultado = 0;
  double MINLOT=MarketInfo(SymbolName,MODE_MINLOT);
  double MAXLOT=MarketInfo(SymbolName,MODE_MAXLOT);
   if (Lots<MINLOT)
   {
      msg(
      StringConcatenate(" Lotsize:",Lots," < MINLOT Allowed  . Lot now = ",MINLOT)
      ,AllMessages,ControleLog);
   return(MINLOT);
   }
   if (Lots>MAXLOT)
   {
      msg(
      StringConcatenate(" Lotsize:",Lots," > MAXLOT Allowed  . Lot now = ",MAXLOT)
      ,AllMessages,ControleLog);
   return(MAXLOT);
   }
    double TamLote = MarketInfo(SymbolName,MODE_LOTSIZE);
       if (TamLote==100000) AccountType=1;
  else if (TamLote==10000)  AccountType=10;
  else if (TamLote==1000)   AccountType=100;
  if (TamLot==0) TamLot = 100000 / AccountType;
  if (StpLot==0) StpLot = 0.1;
  Resultado = MathCeil(Lots / StpLot) * StpLot;
  if ((Resultado*TamLot)>Total)
  {
    Resultado = AccountFreeMargin()/MarketInfo(SymbolName,MODE_LOTSIZE);
    Resultado  = MathCeil(Lots / StpLot) * StpLot;
  }
  if (Lots!=Resultado)
    if (Log)
      msg(
      StringConcatenate(" OldLot:  ",Lots," NewLot:  ",Resultado)
      ,AllMessages,ControleLog);
         if (bs==0 || bs==1)
         {
           AccountFreeMarginCheck(Symbol(), bs, Resultado);
           int err = GetLastError();
            if (err > 0 )
            {
               Alert("Not enough money for new position");
               if (AdjustMaxLotMargin)
               {
               double MaxMarginAllowed=AccountFreeMargin()/MarketInfo(SymbolName,MODE_MARGINREQUIRED);
               msg(
               StringConcatenate("Adjusting LotSize according to the Max Margin Allowed to : ",MaxMarginAllowed)
               ,AllMessages,ControleLog);
               Resultado=MaxMarginAllowed;
               }
            }
        }
  return(Resultado);
}
void UpdatedOE (bool consider_all_orders=false){
AnyOrd=0;
BuyOrd=0;
SellOrd=0;
PendOrd=0;
MarketOrders=0;
Total =    OrdersTotal();
           if (Total!=0)
            for(  int i=Total-1;i>=0;i--)
            {
            OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
               if (OrderMagicNumber()==MagicNumber  ||  consider_all_orders )
               if (OrderSymbol()==Symbol()  )
               {
                AnyOrd++;
                if (OrderType()==OP_BUY){BuyOrd++; MarketOrders++;}
                 else if (OrderType()==OP_SELL){SellOrd++; MarketOrders++;}
                 else if (OrderType()>1 ){PendOrd++;}
                }
            }
}
void msg (string text,bool AllMessagesHere=false)   {
            if (StringLen(text)>0)
            {
               if (AllMessagesHere || LastText != text)
               {
                  LastText = text;
                  Print(text+" LogControl: "+ControleLog+" Broker's time: ",TimeToStr(TimeCurrent(),TIME_DATE|TIME_MINUTES));
                  ControleLog=0;
               }
               else ControleLog++;
            }
         }
bool Log (string FileName, string Text, bool Log=false,bool AddDate=false){
 int error;
bool debugFileOpen=false;
if(debugFileOpen)Print(" FileOPenBug Running log..");
  if (AddDate)Text  = TimeToStr(TimeCurrent(), TIME_DATE) + "/"+   TimeToStr(TimeCurrent(), TIME_MINUTES|TIME_SECONDS) + "/"+Text;
  string Texto="";
  int    Handle3=0;
  bool   Ok = False;
    Handle3 = FileOpen(FileName,FILE_CSV|FILE_WRITE|FILE_READ,'|');
    error = GetLastError();
    if(debugFileOpen)Print(" FileOPenBug OPeninig FileName:",FileName," from LOG GetLastError():",error," ...");
    if(JournalLogs)Print(" Into log function.. writing on FileName:",FileName," Handle3:",Handle3," == Text: ",Text," error:",error);
     if (Handle3>=0)
     {
      if (Log)FileSeek(Handle3,0,SEEK_END);
      FileWrite(Handle3,Text);
      error = GetLastError();
      if(debugFileOpen)Print(" Handle3>=0 - FileOPenBug FileWrite Handle3:",Handle3," from LOG GetLastError():",error," ...Text:",Text);
      FileClose(Handle3);
      if(debugFileOpen)Print(" FileOPenBug FileWrite Handle3:",Handle3," from LOG GetLastError():",GetLastError(),"");
      Ok = True;
        if (error > 0 && error != 4200 )
           if(JournalLogs)Print("3-Log File Error : ", error," FileName:",FileName);
     }
      else
      {
         error = GetLastError();
            if(debugFileOpen)Print(" Handle3<0 - FileOPenBug  Handle3:",Handle3," from LOG GetLastError():",error);
            if (error > 0 && error != 4200 )
            if(JournalLogs)Print("1-Log File Error : ", error," FileName:",FileName);
            FileClose(Handle3);
                  if(debugFileOpen)Print(" Handle3<0 - FileClose FileOPenBug  Handle3:",Handle3," from LOG GetLastError():",GetLastError());
      }
  return(0);
}
string GetPeriodString (int Periodo) {
      string retorno;
      switch (Periodo)
      {
      case PERIOD_M1:
         retorno = "M1";
         break;
      case PERIOD_M5:
         retorno = "M5";
         break;
      case PERIOD_M15:
         retorno = "M15";
         break;
      case PERIOD_M30:
         retorno = "M30";
         break;
      case PERIOD_H1:
         retorno = "H1";
         break;
      case PERIOD_H4:
         retorno = "H4";
         break;
      case PERIOD_D1:
         retorno = "D1";
         break;
      case PERIOD_W1:
         retorno = "W1";
         break;
      case PERIOD_MN1:
         retorno = "MN1";
         break;
      default:
      retorno = "" + DoubleToStr(Periodo,0) + " Min";
      }
      return (retorno);
   }
string ft (int t){
return(TimeToStr(t,TIME_DATE|TIME_MINUTES|TIME_SECONDS));
}
bool CheckAllowedTime (string beg,string end,bool Use_TradeTime_ControlHere,string inirange,bool & ftime,int & numOfBArs){
 if (!Use_TradeTime_ControlHere)return(1);
bool BarrasDiaAnterior=false;
          datetime HIniRange = DgStrTime(inirange);
          datetime HIni = DgStrTime(beg);
          datetime HFim = DgStrTime(end);
          DgGMTTime     = TimeCurrent() - (GMT * DgOneHour);
          HFim = DgAdjustPeriod(HIni,HFim);
          if (HIni>DgGMTTime)
          {
           HIni -= DgOneDay;
           HFim -= DgOneDay;
          }
         int IniBAR=iBarShift(Symbol(),0,HIniRange);
         int FimBAR=iBarShift(Symbol(),0,HIni);
         int Barras = MathAbs(IniBAR-FimBAR);
         if (TimeCurrent()>HIni && TimeCurrent()<HFim )
         {
            if (!ftime)
            {
            numOfBArs=Barras-1;
            }
         return(true);
         }
return(0);
}
datetime DgStrTime (string time){
  time = StringConcatenate(TimeToStr(TimeCurrent(),TIME_DATE)," ",time);
  return(StrToTime(time));
}
datetime DgAdjustPeriod(datetime Begin, datetime End){
  if (Begin>End) End += DgOneDay;
  return(End);
}
void ChangeAllSL_and_TP (){
   Total =    OrdersTotal();
           if (Total!=0)
            for(  int i=Total-1;i>=0;i--)
            {
            OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
               if (OrderSymbol()==Symbol()  )
               {
                AnyOrd++;
                if (OrderType()==OP_BUY)
                {
                  Print(" Changing StopLoss:",StopLoss,"  and TakeProfit:",TakeProfit," of Ticket:",OrderTicket());
                  if(StopLoss==0)double newSL=0; else newSL=Bid-StopLoss*Point;
                  if(TakeProfit==0)double newTP=0; else newTP=Bid+TakeProfit*Point;
                  MudarSL_Price_Ticket(OrderTicket(),newSL,10,true);
                  MudarTPSimple(OrderTicket(),newTP ,10,true);
                }
                else
                {
                  Print(" Changing StopLoss:",StopLoss,"  and TakeProfit:",TakeProfit," of Ticket:",OrderTicket());
                  if(StopLoss==0) newSL=0; else newSL=Bid+StopLoss*Point;
                  if(TakeProfit==0) newTP=0; else newTP=Bid-TakeProfit*Point;
                  MudarSL_Price_Ticket(OrderTicket(),newSL,10,true);
                  MudarTPSimple(OrderTicket(),newTP,10,true);
                }
                }
            }
}
void MudarTPSimple (int t,double valor_price,int attempts,bool debu){
bool errorModify=false;
int countModify=0;
            if(OrderSelect(t,SELECT_BY_TICKET)<=0)return;
                 if (OrderCloseTime()==0 && OrderTakeProfit()!=valor_price)
                 {
                          while (!errorModify  && countModify < attempts)
                          {
                           RefreshRates();
                           errorModify = OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),NormalizeDouble(valor_price,Digitos),0,Green);
                           if (!errorModify)
                           {
                           if (debu)Print(" 1-Error modifying TP BS = ",OrderType(),"Bid = ",Bid," Ask = ",Ask," Price: ",0," Actual TP = ",OrderTakeProfit(),"  Function has tried to change the TP to = ",valor_price," OrderTicket() ",OrderTicket()," errorModify: ",errorModify);
                           Sleep(10000);
                           }
                            else
                            {
                            if (debu)Print(" OK! TP BS  = ",OrderType(),"Bid = ",Bid," Ask = ",Ask," Price: ",0," NEWtP = ",valor_price,"  TP = ",OrderTakeProfit()," OrderTicket() ",OrderTicket());
                            }
                          countModify++;
                          }
                }
}
void MudarSL_Price_Ticket (int t,double valor_price,int attempts,bool debu){
int errorModify=-1;
int countModify=0;
double tpLixo;
double tpLixo2;
            if(OrderSelect(t,SELECT_BY_TICKET))
            {
            if(JournalLogs)Print(" sending valor_price: ",valor_price);
            AdjustSLLevels(Symbol(),OrderType(),valor_price,tpLixo,tpLixo2);
            if(JournalLogs)Print(" Now valor_price: ",valor_price);
                 if (OrderCloseTime()==0 && OrderStopLoss()!=valor_price)
                 {
                          errorModify=-1;
                          countModify=0;
                          while (errorModify==-1  && countModify < attempts)
                          {
                           RefreshRates();
                           errorModify = OrderModify(OrderTicket(),OrderOpenPrice(),NormalizeDouble(valor_price,digit),OrderTakeProfit(),0,Green);
                           if (errorModify<0)
                           {
                           if (debu)
                           msg(
                           StringConcatenate(" MudarSL_Price_Ticket 1-Error modifying SL BS = ",OrderType(),"Bid = ",Bid," Ask = ",Ask," Price: ",0," Actual SL = ",OrderStopLoss(),"  Function has tried to change the SL to = ",valor_price," OrderTicket() ",OrderTicket()," errorModify: ",errorModify)
                           ,AllMessages);
                           Sleep(10000);
                           }
                            else
                            {
                            if (debu)
                           msg(
                           StringConcatenate(" MudarSL_Price_Ticket OK! SL BS  = ",OrderType(),"Bid = ",Bid," Ask = ",Ask," Price: ",0," NEWSL = ",valor_price,"  TP = ",OrderTakeProfit()," OrderTicket() ",OrderTicket())
                           ,AllMessages);
                            }
                          countModify++;
                          }
                }
         }
}
bool isNewBarD1()
{
   static datetime dt3  = 0;
   if (dt3 != iTime(NULL,PERIOD_D1,0))
   {
      dt3 = iTime(NULL,PERIOD_D1,0);
      return(true);
   }
   return(false);
}
double divide (double v1 ,double v2,string calledfrom=""){
if (v2==0)
   if(JournalLogs)Print(" v1:",v1," v2:",v2," calledfrom: ",calledfrom);
return(v1/v2);
}
void CheckButtons (){
bool Changed=false;
   if(ObjectGetInteger(0,buttonID_Close_AnyOpenTrade_At_MACD_ZERO,OBJPROP_STATE))
   {
         bool selected=ObjectGetInteger(0,buttonID_Close_AnyOpenTrade_At_MACD_ZERO,OBJPROP_SELECTED);
         if(Active_Close_AnyOpenTrade_At_MACD_ZERO)
         {
         Active_Close_AnyOpenTrade_At_MACD_ZERO=false;
         ButtonCreate(0,buttonID_Close_AnyOpenTrade_At_MACD_ZERO,0,Button_1_y,Button_1_x,Button_Width,Button_Height,Corner,buttonID_Close_AnyOpenTrade_At_MACD_ZERO,font_here,Button_FontSize,Button_FontColor,Button_OFF_color,clrNONE);
         Print(" Setting Active_Close_AnyOpenTrade_At_MACD_ZERO = FALSE");
         }
         else
         {
         Active_Close_AnyOpenTrade_At_MACD_ZERO=true;
         Print(" Setting Active_Close_AnyOpenTrade_At_MACD_ZERO = TRUE");
         ChangeAllSL_and_TP();
         ButtonCreate(0,buttonID_Close_AnyOpenTrade_At_MACD_ZERO,0,Button_1_y,Button_1_x,Button_Width,Button_Height,Corner,buttonID_Close_AnyOpenTrade_At_MACD_ZERO,font_here,Button_FontSize,Button_FontColor,Button_ON_color,clrNONE);
         }
    }
   if(ObjectGetInteger(0,buttonID_TakeNextHopperTrade,OBJPROP_STATE))
   {
         if(Active_TakeNextHopperTrade)
         {
         Active_TakeNextHopperTrade=0;
         Print("Active_TakeNextHopperTrade=false");
         ButtonCreate(0,buttonID_TakeNextHopperTrade,0,Button_2_y,Button_2_x,Button_Width,Button_Height,Corner,buttonID_TakeNextHopperTrade,font_here,Button_FontSize,Button_FontColor,Button_OFF_color,clrNONE);
         }
         else
         {
         Active_TakeNextHopperTrade=1;
         Print("Active_TakeNextHopperTrade=true");
         ButtonCreate(0,buttonID_TakeNextHopperTrade,0,Button_2_y,Button_2_x,Button_Width,Button_Height,Corner,buttonID_TakeNextHopperTrade,font_here,Button_FontSize,Button_FontColor,Button_ON_color,clrNONE);
         }
    }
   if(ObjectGetInteger(0,buttonID_TakeReverseTriggerFinger,OBJPROP_STATE))
   {
         if(Active_TakeReverseTriggerFinger)
         {
         Active_TakeReverseTriggerFinger=0;
         Print("Active_TakeReverseTriggerFinger=false");
            ButtonCreate(0,buttonID_TakeReverseTriggerFinger,0,Button_3_y,Button_3_x,Button_Width,Button_Height,Corner,buttonID_TakeReverseTriggerFinger,font_here,Button_FontSize,Button_FontColor,Button_OFF_color,clrNONE);
         }
         else
         {
         Active_TakeReverseTriggerFinger=1;
         Print("Active_TakeReverseTriggerFinger=true");
            ButtonCreate(0,buttonID_TakeReverseTriggerFinger,0,Button_3_y,Button_3_x,Button_Width,Button_Height,Corner,buttonID_TakeReverseTriggerFinger,font_here,Button_FontSize,Button_FontColor,Button_ON_color,clrNONE);
         }
    }
   if(ObjectGetInteger(0,buttonID_TakeNextComboHopper,OBJPROP_STATE))
   {
         if(Active_TakeNextComboHopper)
         {
         Active_TakeNextComboHopper=0;
         Print("Active_TakeNextComboHopper=false");
            ButtonCreate(0,buttonID_TakeNextComboHopper,0,Button_4_y,Button_4_x,Button_Width,Button_Height,Corner,buttonID_TakeNextComboHopper,font_here,Button_FontSize,Button_FontColor,Button_OFF_color,clrNONE);
         }
         else
         {
         Active_TakeNextComboHopper=1;
         Print("Active_TakeNextComboHopper=true");
            ButtonCreate(0,buttonID_TakeNextComboHopper,0,Button_4_y,Button_4_x,Button_Width,Button_Height,Corner,buttonID_TakeNextComboHopper,font_here,Button_FontSize,Button_FontColor,Button_ON_color,clrNONE);
         }
    }
   if(ObjectGetInteger(0,buttonID_MondayTrade,OBJPROP_STATE))
   {
         if(Active_TakeNextComboHopper_H4)
         {
         Active_TakeNextComboHopper_H4=0;
         Print("Active_TakeNextComboHopper_H4=false");
            ButtonCreate(0,buttonID_MondayTrade,0,Button_5_y,Button_5_x,Button_Width,Button_Height,Corner,buttonID_MondayTrade,font_here,Button_FontSize,Button_FontColor,Button_OFF_color,clrNONE);
         }
         else
         {
         Active_TakeNextComboHopper_H4=1;
         Print("Active_TakeNextComboHopper_H4=true");
            ButtonCreate(0,buttonID_MondayTrade,0,Button_5_y,Button_5_x,Button_Width,Button_Height,Corner,buttonID_MondayTrade,font_here,Button_FontSize,Button_FontColor,Button_ON_color,clrNONE);
         }
    }
ChartRedraw();
}
 bool ButtonCreate (double           chart_ID=0,
                   string            name="Button",
                   int               sub_window=0,
                   int               x=0,
                   int               y=0,
                   int               width=50,
                   int               height=18,
                   int  corner=1,
                   string            text="Button",
                   string            font="Arial",
                   int               font_size=10,
                   color             clr=clrBlack,
                   color             back_clr=clrGainsboro,
                   color             border_clr=clrNONE,
                   bool              state=false,
                   bool              back=false,
                   bool              selection=false,
                   bool              hidden=true,
                   double              z_order=0)
  {
if(!Show_Buttons_on_chart)return;
     x+=Corner_x_pos_Adjustment;
  if (UseSmallFontSize)font_size=8;
  if (ObjectFind(name)>=0)ObjectDelete(0,name);
   ResetLastError();
   if(!ObjectCreate(chart_ID,name,OBJ_BUTTON,sub_window,0,0))
     {
      Print(__FUNCTION__,
            ": failed to create the button! Error code = ",GetLastError());
      return(false);
     }
     else
     {
     Print("Created  name:",name);
     }
   ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x);
   ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);
   ObjectSetInteger(chart_ID,name,OBJPROP_XSIZE,width);
   ObjectSetInteger(chart_ID,name,OBJPROP_YSIZE,height);
   ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner);
   ObjectSetString(chart_ID,name,OBJPROP_TEXT,text);
   ObjectSetString(chart_ID,name,OBJPROP_FONT,font);
   ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size);
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
   ObjectSetInteger(chart_ID,name,OBJPROP_BGCOLOR,back_clr);
   ObjectSetInteger(chart_ID,name,OBJPROP_BORDER_COLOR,border_clr);
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
   ObjectSetInteger(chart_ID,name,OBJPROP_STATE,state);
ChartRedraw();
   return(true);
}
bool CheckFilters (int bs){
if (MathAbs(ema0-ema1)<=MinDistanceBetween_MA0_MA1*Point)
{
   Print(" Signal cancelled due to (ema0-ema2):",MathAbs(ema0-ema2)," <  MinDistanceBetween_MA0_MA1:",MinDistanceBetween_MA0_MA1);
return(0);
}
   if (  (bs==OP_BUY && ema0>ema1) || (bs==OP_SELL && ema0<ema1) )
   {
      if (MathAbs(ema0-Bid)>Max_X_pips_away_from_MA0*Point && Max_X_pips_away_from_MA0!=0)
      {
         Print(" Signal cancelled due to (ema0-Bid):",MathAbs(ema0-Bid)," >  Max_X_pips_away_from_MA0:",Max_X_pips_away_from_MA0);
      return(0);
      }
      if (MathAbs(ema0-Bid)<Min_X_pips_away_from_MA0*Point && Min_X_pips_away_from_MA0!=0)
      {
         Print(" Signal cancelled due to (ema0-Bid):",MathAbs(ema0-Bid)," <  Min_X_pips_away_from_MA0:",Min_X_pips_away_from_MA0);
      return(0);
      }
   }
   else if (  (bs==OP_BUY && ema0<ema1) || (bs==OP_SELL && ema0>ema1) )
   {
         if (MathAbs(ema1-Bid)>Max_X_pips_away_from_MA1*Point && Max_X_pips_away_from_MA1!=0)
         {
            Print(" Signal cancelled due to (ema1-Bid):",MathAbs(ema1-Bid)," >  Max_X_pips_away_from_MA1:",Max_X_pips_away_from_MA1);
         return(0);
         }
         if (MathAbs(ema1-Bid)<Min_X_pips_away_from_MA1*Point && Min_X_pips_away_from_MA1!=0)
         {
            Print(" Signal cancelled due to (ema1-Bid):",MathAbs(ema1-Bid)," <  Min_X_pips_away_from_MA1:",Min_X_pips_away_from_MA1);
         return(0);
         }
   }
return(1);
}
void comentarios(bool prin=false)   {
return;
string Commemt="";
string a=StringConcatenate(
"IsExpertEnabled():",IsExpertEnabled()," signal:",signal," AllExitEntriesAreCancelled:",AllExitEntriesAreCancelled,
"");
string b=StringConcatenate(
" | LastSignal:",LastSignal," | hopper_macd_line:",hopper_macd_line," | ema0:",ema0," | ema1:",ema1," ema2:",ema2,
" | ema00:",ema00," | ema11:",ema11," ema22:",ema22," Active_TakeNextHopperTrade:",Active_TakeNextHopperTrade,
"\n Active_TakeReverseTriggerFinger:",Active_TakeReverseTriggerFinger,
"\n Active_TakeNextComboHopper:",Active_TakeNextComboHopper,
"");
if (prin) Print("=== New Bar ===","TimeCurrent ",TimeToStr(TimeCurrent(),TIME_DATE|TIME_MINUTES)," LocalTime ",TimeToStr(TimeLocal(),TIME_DATE|TIME_MINUTES)," itime [0] ",
  TimeToStr(iTime(NULL,0,0),TIME_DATE|TIME_MINUTES)," itime [1] ", TimeToStr(iTime(NULL,0,1),TIME_DATE|TIME_MINUTES) ," Bars :",Bars ," barra :",barra) ;
if (prin)Print(a);
if (prin)Print(b);
   Comment ("EA is Working... ",WindowExpertName()," Coded by Marcelo Marques Pereira ->2003-2015 marcelomarkez@gmail.com ","\n",
   " | TimeCurrent ",TimeToStr(TimeCurrent(),TIME_DATE|TIME_MINUTES),
         " ",a,"\n",
         " ",b,"\n",
         "");
}
 void OnTimer(){
CheckButtons();
}
void criarlabelControl (string nome,string textoH, color cor,int x,int y,int size,int corner=1){
   if (nome!="PairLabel")int soma=y+1; else soma=y;
   int window=0;
   ObjectDelete(nome);
   ObjectCreate(nome,OBJ_LABEL,window, 0, 0);
           ObjectSetText(nome,textoH,size, "tahoma", cor);
           ObjectSet(nome, OBJPROP_CORNER, corner);
           ObjectSet(nome, OBJPROP_XDISTANCE, x);
           ObjectSet(nome, OBJPROP_YDISTANCE, soma);
   }
string GetTrueFalseString (int bs){
if (bs==0)return("False");
 else    return("True");
return("");
}
