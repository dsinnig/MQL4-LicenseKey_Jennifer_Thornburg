#property copyright "Copyright 2016, Biiuse"
#property link  "www.biiuse.com"
#property version "1.0"
#property strict

#include "../Include/License.mq4"

input string payPalEmailAddress=""; //PayPal email address
input string license=""; //License key
int productID = 65;

int OnInit()
{
   if (validateProductLicense(payPalEmailAddress, license, productID)) return(INIT_SUCCEEDED);
   else return(10);
   
}

void OnTick()
{
}
