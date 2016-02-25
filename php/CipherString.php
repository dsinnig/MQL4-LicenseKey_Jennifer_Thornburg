<?php
class CipherString {

	private static $charArray = array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z");
	private static $secretFactor1 = 211;
	private static $secretFactor2 = 177;
	
	private static function findKey($char) {
		//global $charArray;
		$index = -1;
		foreach (CipherString::$charArray as $key => $val) {
			if ($val == $char) {
				$index = $key;
				break;
			}
		}
		return $index;
	}

	public static function getAlphabetSize() {
		return sizeof(CipherString::$charArray);
	}
	
	public static function getAlphabet() {
		return CipherString::$charArray;
	}
	
	private static function encryptKey($key, $offset) {
		//global $charArray;
		$mod = sizeof(CipherString::$charArray);
		$encryptedKey = ($key + (int) $offset) % $mod;
		return $encryptedKey;
	}

	private static function decryptKey($cipher, $offset) {
		//global $charArray;
		$mod = sizeof(CipherString::$charArray);
		$prekey = $cipher - (int) $offset;
		while ($prekey < 0) $prekey += $mod;
		$key = $prekey % $mod;
		return $key;
	}

	public static function encryptString($rawStr)
		{
			//global $charArray;
			$decryptedStr = "";
			for ($i = 0; $i < strlen($rawStr); $i++)
			{
				$key = CipherString::findKey(substr($rawStr, $i, 1));
				$cipherKey = CipherString::encryptKey($key, 80 + $i);
				//$cipherKey = encryptKey($key, 1);
				$decryptedStr = $decryptedStr . CipherString::$charArray[$cipherKey];
			}

			return $decryptedStr;
		}
		
	public static function decryptString($cipherString) {
		//global $charArray;
		$rawStr = "";
		for ($i = 0; $i < strlen($cipherString); $i++)
			{
				$cipherKey = CipherString::findKey(substr($cipherString, $i, 1));
				$key = CipherString::decryptKey($cipherKey, 80 + $i);
				//$key = decryptKey($cipherKey, 1);
				$rawStr = $rawStr . CipherString::$charArray[$key];
			}
		return $rawStr;
	}
	
	public static function sanityTest() {
		for ($i = 0; $i< 1000; $i++) {
			$strlen = rand(1, 100);
			$str = "";
			for ($j = 0; $j < $strlen; $j++) {
				$str = $str . CipherString::getAlphabet()[rand(0,CipherString::getAlphabetSize()-1)];
			}
			assert($str == CipherString::decryptString(CipherString::encryptString($str)));
		}
	}
	
	private static function isInAlphabet($char) {
		$result = false;
		foreach (CipherString::$charArray as $val) {
			if ($val == $char) {
				$result = true;
				break;
			}
		}
		return $result;
	}
	
	public static function normalizeEmail($email, $length) {
		$result = "";
		$email = strtoupper($email);
		for ($i=0; $i < strlen($email); $i++) {
			if (CipherString::isInAlphabet($email[$i])) $result = $result . $email[$i];
		}
		//pad if necessary
		if (strlen($result) < $length) {
			$result = str_pad($result, $length, "AZ");
		}
		//use only 15 first characters
		return substr($result,0,$length);
	}
	
	public static function normalizeDate($year, $month, $day) {
		return $year . str_pad($month, 2, "0", STR_PAD_LEFT) . str_pad($day, 2, "0", STR_PAD_LEFT);
	}
	
	public static function normalizeProductID($id) {
		return str_pad($id, 3, "0", STR_PAD_LEFT);
	}
	
	public static function generateClearTxtEncryptionString($email, $productID, $expirationYear, $expirationMonth, $expirationDay) {
		/*Secrete criteria1 (10) (Random number that is dividable by $secretFactor1) (index 0-9)
		  PaypalEmail (20) index 10 - 29)
          ProductID (3) (index 30 - 32) 
          Expiration date (Y3M1Y1D2M2Y4Y1D1) (8) (index 33 - 40)
          Secrete criteria2 (10) (Random number that is dividable by $secretFactor2) (index 41-50) 
		*/
		
		$secret1 = ($expirationYear % 1000) * $expirationMonth * $expirationDay * $productID * CipherString::$secretFactor1;
		$secret1Str = str_pad($secret1, 10, "0", STR_PAD_LEFT);
		$secret2 = ($expirationYear % 1000) * $expirationMonth * $expirationDay * $productID * CipherString::$secretFactor2;
		$secret2Str = str_pad($secret2, 10, "0", STR_PAD_LEFT);
		
		$productStr = CipherString::normalizeProductID($productID);
		$dateStr = CipherString::normalizeDate($expirationYear, $expirationMonth, $expirationDay);
		$emailStr = CipherString::normalizeEmail($email, 20);
		
		$clearTxtLicense = $secret1Str . $emailStr . $productStr . $dateStr . $secret2Str;
		return $clearTxtLicense;
	}
	
	public static function generateLicenseKey($email, $productID, $expirationYear, $expirationMonth, $expirationDay) {
		//checks: 
		//ProdID <= 999
		//Date is valid and in the future
		
		
		return CipherString::encryptString(CipherString::generateClearTxtEncryptionString($email, $productID, $expirationYear, $expirationMonth, $expirationDay));
	}
	
	
	
	public static function validateClearTxtEncryptionString($clearTxtLicenseKey, $email, $productID, $expirationYear, $expirationMonth, $expirationDay) {
		//check that first 10 digits are divisible by secretFactor1
		$secret1 = intval(substr($clearTxtLicenseKey, 0, 10));
		if (($secret1 % CipherString::$secretFactor1) != 0) return false;
		//check that last 10 digits are divisible by secretFactor2
		$secret2 = intval(substr($clearTxtLicenseKey, 41, 10));
		if (($secret2 % CipherString::$secretFactor2) != 0) return false;
		//check that date matches
		$year = intval(substr($clearTxtLicenseKey, 33, 4));
		$month = intval(substr($clearTxtLicenseKey, 37, 2));
		$day = intval(substr($clearTxtLicenseKey, 39, 2));
		if (($year != $expirationYear) || ($month != $expirationMonth) || ($day != $expirationDay)) return false;
		//check that email matches
		$normalizedEmail = CipherString::normalizeEmail($email, 20);
		$emailStrFromLicense = substr($clearTxtLicenseKey, 10, 20);
		if (strcmp($normalizedEmail, $emailStrFromLicense) != 0) return false;
		//check if productID matches
		$productIdFromLicense = intval(substr($clearTxtLicenseKey, 30, 3));
		if ($productIdFromLicense <> $productID) return false;
		return true;
	}
	
	public static function validateLicenseKey($licenseKey, $email, $productID, $expirationYear, $expirationMonth, $expirationDay) {
		return CipherString::validateClearTxtEncryptionString(CipherString::decryptString($licenseKey), $email, $productID, $expirationYear, $expirationMonth, $expirationDay);
	}
}
?>


