#property copyright "Copyright © 2019, TEST"

#property indicator_chart_window
#property indicator_buffers 4
#property indicator_width1 1
#property indicator_style1 0
#property indicator_color1 Magenta
#property indicator_width2 1
#property indicator_style2 0
#property indicator_color2 White
#property indicator_width3 1
#property indicator_style3 0
#property indicator_color3 Aqua
#property indicator_width4 1
#property indicator_style4 0
#property indicator_color4 White

input int number=1000;

double dBuffer_0[];
double dBuffer_1[];
double dBuffer_2[];
double dBuffer_3[];

#define INDIVAL_CNT 2
// リソース指定
#resource "\\Indicators\\CapChannel (1).ex4"


int init(){
   IndicatorBuffers(4);
   IndicatorDigits(Digits);
   SetIndexStyle(0,DRAW_HISTOGRAM);
   SetIndexShift(0,0);
   SetIndexBuffer(0,dBuffer_0);
   SetIndexStyle(1,DRAW_LINE);
   SetIndexShift(1,0);
   SetIndexBuffer(1,dBuffer_1);
   SetIndexStyle(2,DRAW_HISTOGRAM);
   SetIndexShift(2,0);
   SetIndexBuffer(2,dBuffer_2);
   SetIndexStyle(3,DRAW_LINE);
   SetIndexShift(3,0);
   SetIndexBuffer(3,dBuffer_3);
   return(0);
}

int start(){
   
   int limit;
   int pos;
   int ExtCountedBars;
   double dIndiVal[INDIVAL_CNT];

   SetIndexDrawBegin(0,Bars-number-1);
   SetIndexDrawBegin(1,Bars-number-1);
   SetIndexDrawBegin(2,Bars-number-1);
   SetIndexDrawBegin(3,Bars-number-1);

   double dPoint = Point;
   if( Digits==3 || Digits==5 ) dPoint = Point * 10;

   ExtCountedBars = IndicatorCounted();
   if( ExtCountedBars < 0 ) return(-1);
   if( ExtCountedBars > 0 ) ExtCountedBars--;
   limit = Bars-ExtCountedBars-1;
   for( pos=limit; pos>=0; pos-- ){
      dBuffer_0[pos] = EMPTY_VALUE;
      dBuffer_1[pos] = EMPTY_VALUE;
      dBuffer_2[pos] = EMPTY_VALUE;
      dBuffer_3[pos] = EMPTY_VALUE;

      dIndiVal[0] = iMA(NULL,0,25,0,0,0,pos);
      dIndiVal[1] = iCustom(NULL,0,"::Indicators\\CapChannel (1).ex4","",3,15,false,false,-1,-1,"","",1,false,false,false,false,"","",0,pos);

      if( dIndiVal[0] > dIndiVal[1] ){
         dBuffer_0[pos] = dIndiVal[0];
      }
      if( dIndiVal[1] > dIndiVal[0] ){
         dBuffer_2[pos] = dIndiVal[1];
      }
         dBuffer_1[pos] = dIndiVal[1];
         dBuffer_3[pos] = dIndiVal[0];
   }

   return(0);
}

int deinit(){
   return(0);
}

