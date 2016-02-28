//+------------------------------------------------------------------+
//|                                                      License.mq4 |
//|                                       Copyright 2016, Biiuse.com |
//|                                                                  |
//|                                                                  |
//|                                    Version 1.0 by Daniel Sinnig  |
//|                                                                  |
//|                                                                  |
//+------------------------------------------------------------------+

#property library
#property copyright "Daniel Sinnig"
#property link "https://www.biiuse.com"
//#property strict

class License {
private: 
   static const int charArraySize;
   static string charArray[36];
   static int secretFactor1;
   static int secretFactor2;
   
   
   
   static int findKey(string alphabetChar) {
      int index = -1;
      for (int i = 0; i < ArraySize(License::charArray); ++i) {
         if (alphabetChar == charArray[i]) {
            index = i;
            break;
         }
      }
      return index;
   }
   
   static int decryptKey(int cipher, int offset) {
      int mod = ArraySize(License::charArray);
		int prekey = cipher - offset;
		while (prekey < 0) prekey += mod;
		int key = prekey % mod;
		return key;
   }
   
   static bool isInAlphabet(string s) {
      bool result = false;
		for (int i = 0; i < ArraySize(License::charArray); ++i) {
			if (charArray[i] == s) {
				result = true;
				break;
			}
		}
		return result;
   }
   
   
   static datetime convertYYMMDDToDatetime(string timeString) {
      string yearString = StringSubstr(timeString, 0, 4);
      int year = StrToInteger(yearString);
      string monthString = StringSubstr(timeString, 4, 2);
      int month = StrToInteger(monthString);
      string dayString = StringSubstr(timeString, 6, 2);
      int day = StrToInteger(dayString);
      MqlDateTime mql4Date;
      mql4Date.year = year;
      mql4Date.mon = month;
      mql4Date.day = day;
      mql4Date.hour=23;
      mql4Date.min=59;
      mql4Date.sec=59;
      return StructToTime(mql4Date);
   }
   
   
public:
   static string decryptString(string cipherString) {
      string rawStr = "";
      cipherString = StringTrimLeft(StringTrimRight(cipherString));
      for (int i = 0; i < StringLen(cipherString); i++)
			{
				int cipherKey = License::findKey(StringSubstr(cipherString, i, 1));
            int key = License::decryptKey(cipherKey, 80 + i);
				if ((key < 0) || (key > ArraySize(License::charArray))) return "";
            rawStr = StringConcatenate(rawStr, License::charArray[key]);
			}

			return rawStr;
   }
   
   static string normalizeEmail(string email, int length) {
		string result = "";
		StringToUpper(email);
		for (int i=0; i < StringLen(email); i++) {
			if (License::isInAlphabet(StringSubstr(email, i, 1))) result = StringConcatenate(result, StringSubstr(email, i, 1));
		}
		//pad if necessary
		if (StringLen(result) < length) {
			result = StringConcatenate(result, "AZAZAZAZAZAZAZAZAZAZAZAZAZAZAZAZAZAZAZAZAZ");
		}
		return StringSubstr(result,0,length);
	}
   
   static datetime getExpirationDate(string cipherString) {
      string rawLicense = decryptString(cipherString);
      string dateString = StringSubstr(rawLicense, 33,8);
      return convertYYMMDDToDatetime(dateString) + 60*60*24; //add one extra day to expiration date
   }
   
   static int getRemainingDays(string cipherString, datetime refTime) {
      string rawLicense = decryptString(cipherString);
      string dateString = StringSubstr(rawLicense, 33,8);
      datetime expirationDate = convertYYMMDDToDatetime(dateString);
      if ((long) expirationDate < (long) refTime) return 0;
      long remainingSeconds = (long) expirationDate - (long) refTime;
      int remainingDays = (int) remainingSeconds / (60 * 60 * 24);
      return remainingDays + 1; //add one extra day
   }
   
   static bool hasExpired(string cipherString, datetime refTime) {
      return (long) License::getExpirationDate(cipherString) < (long) refTime;
   }
   
   static bool validateLicense(string cipherString, string email, int productID, datetime refTime) {
      if (License::hasExpired(cipherString, refTime)) return false;
      string rawLicense = decryptString(cipherString);
      //check that first 10 digits are divisible by secretFactor1
      int secret1 = StrToInteger(StringSubstr(rawLicense, 0, 10));
      if ((secret1 % License::secretFactor1) != 0) return false;
      //check that last 10 digits are divisible by secretFactor2
      int secret2 = StrToInteger(StringSubstr(rawLicense, 41, 10));
      if ((secret2 % License::secretFactor2) != 0) return false;
      //check that email matches
		string normalizedEmail = License::normalizeEmail(email, 20);
		string emailStrFromLicense = StringSubstr(rawLicense, 10, 20);
		if (normalizedEmail != emailStrFromLicense) return false;
      //check if productID matches
		int productIdFromLicense = StrToInteger(StringSubstr(rawLicense, 30, 3));
		if (productIdFromLicense != productID) return false;
		return true;
   }
   
   static bool isValidDoNotCheckExpirationDate(string cipherString, string email, int productID) {
      string rawLicense = decryptString(cipherString);
      //check that first 10 digits are divisible by secretFactor1
      int secret1 = StrToInteger(StringSubstr(rawLicense, 0, 10));
      if ((secret1 % License::secretFactor1) != 0) return false;
      //check that last 10 digits are divisible by secretFactor2
      int secret2 = StrToInteger(StringSubstr(rawLicense, 41, 10));
      if ((secret2 % License::secretFactor2) != 0) return false;
      //check that email matches
		string normalizedEmail = License::normalizeEmail(email, 20);
		string emailStrFromLicense = StringSubstr(rawLicense, 10, 20);
		if (normalizedEmail != emailStrFromLicense) return false;
      //check if productID matches
		int productIdFromLicense = StrToInteger(StringSubstr(rawLicense, 30, 3));
		if (productIdFromLicense != productID) return false;
		return true;
   }
};

const int License::charArraySize = 36;
string License::charArray[36] = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};
int License::secretFactor1 = 211;
int License::secretFactor2 = 177;

bool validateProductLicense(string payPalEmailAddress, string license, int productID) {
   
   if (IsTesting()) {
      Print ("Back testing mode - no license required");
      return true;
   }
   
   if (!IsConnected()) {
      Print ("Please connect to your trading account to use this EA / Indicator");
      return false;
   }
   
   /*
   MqlDateTime sampleDate;
   sampleDate.year = 2015;
   sampleDate.mon = 02;
   sampleDate.day = 25;
   sampleDate.hour=23;
   sampleDate.min=59;
   sampleDate.sec=59;
   */
   
   if (license == "") {
      Print("Please enter a license key in the Inputs section.");
      MessageBox("Please enter a license key in the Inputs section.", "License key", MB_OK);
      return false;
   }
   if (payPalEmailAddress == "") {
      Print("Please enter your PayPal email address in the Inputs section.");
      MessageBox("Please enter your PayPal email address in the Inputs section.", "Email address", MB_OK);
      return false;
   }
   
   if (License::validateLicense(license, payPalEmailAddress, productID, TimeCurrent())) {
      Print("License successfully validated");
      //int remainingDays = License::getRemainingDays("89CBGDLOIHVBXD4AB763GF4U6W8YA0299768E9DEDDEGNIJSOPM", TimeCurrent());
      datetime expDate = License::getExpirationDate(license);
      int remainingDays = License::getRemainingDays(license, TimeCurrent());
      Print("Expiration date: ", TimeYear(expDate), "/", TimeMonth(expDate), "/", TimeDay(expDate), " ", TimeHour(expDate), ":", TimeMinute(expDate), ":", TimeSeconds(expDate), " (", remainingDays, " days remaining)");
      return true;
   } else {
      if ((License::isValidDoNotCheckExpirationDate(license, payPalEmailAddress, productID)) && (!License::hasExpired("license", TimeCurrent()))) {
         expDate = License::getExpirationDate(license);
         Print("License expired on: ", TimeYear(expDate), "/", TimeMonth(expDate), "/", TimeDay(expDate), " ", TimeHour(expDate), ":", TimeMinute(expDate), ":", TimeSeconds(expDate), ": Download your new license from www.simplycombo.com");
         
         MessageBox("License expired on: " + TimeYear(expDate) + "/" + TimeMonth(expDate) + "/" + TimeDay(expDate) + " " + TimeHour(expDate) + ":" + TimeMinute(expDate) + ":" + TimeSeconds(expDate) + ": Download your new license from www.simplycombo.com", "License expired", MB_OK);
         return false;
      }
      Print("License key is invalid. Download a valid license key for this product from www.simplycombo.com");
      MessageBox("License key is invalid. Download a valid license key for this product from www.simplycombo.com", "License invalid", MB_OK);
      
      return false;
   }
   return true;
}


