package xyl.flutter_java_jiao_hu;

import android.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

public class CUDES {
	private static byte[] iv1 = { (byte) 0x12, (byte) 0x34, (byte) 0x56,
			(byte) 0x78, (byte) 0x90, (byte) 0xAB, (byte) 0xCD, (byte) 0xEF };

	
	private static String key ="AO89c12G";//"RD6fgYd0"; //"AO89c12G";
	
	public static void main(String[] args) {
		String str="9rhRdvUc07zxk3QHEg1I4BoqiF+9CzKdjZcVWcggUWj7/kC4g55+9xVShMC3j7MHpPA/KW5H6qOW5x9RGtdEVYMUa4I8QTsQKX422h8tvkNPllV30NNJqATVkJAwB4RUHdxi8XGfO8SsXuQCNVeDKKg1NDzFfIfg8kuUUpstDjrsPi+lqG8ZQd5Vth04W6I2haBzZ+LczzFlgjsUMh9x6bmzwxJFPuyTcG6gJUtGWQWMEvadvwJKi0sRnIhHgDVCIy062S1grTdT6y27ZvIukUSQ1BiexmPc8rcYcH/rXCnKEE/gycy/y8HSGZEvyWrmDMV0K6aBDYNKc04H+ttYTT3hONXIa+u3pRZXlvQ7o8kbwWGGun/sk1NstCgWNe82caYzobHq9XSb7ts4eCK4WivTeSPbFwH6S3a7cAV0k6poUKEnyK1OksFHPqZc72NT4YRpY3y7DV3111VLNELFZGJCQ+0sXDCU6MI7IN0I3JvVqBLuPP/R20aP2VxCO+wA9N6eUBmCySF/vrtTfTiqBlpOUXIwQisinvVppWBmjdVp0rzRAuSsJIr0a6e0SGDtVk7S1MDgW1lCvPP9vCRimOoyvWxp6kldi4rmALOZJkzmIjgczzJS7qznuFDIehrJZrdCr0V514lbfLUasUBIVNN1z4UzAH6rbpI6ufS6vQrYbF/+cUaePMcWGOKTrG/VxnuuPImtL1T81NfTurUqsYOiUL6XYblhWYZDStxoDWhFrpWsvitWLeSqIdMfPfw6MOgc2cLBvmaQzeWHRTh6DMCCGadSLuA4coPWSNL/tkkyE/ST1yw5+RMEqBYKMXPkon8QqKvcdVz7pSbqP+mdMaNhpDfpnzBD/pXKLVjUU4N1apRjxuyNZwhV927vZIw5m022Ihox8ajpeWfjbDCBbNkxPxOdJrA/OmvZXMER4FY84mo/gZxR2ebLVsfpAOJsaID1j+eQt8sH8rjO9xCW6Q9Ckosbsxoh2zGRbCUSPW9AaWK6IQuUw7f8RYDMSYp";

		System.out.println(CUDES.decrypt(str));
	}

	public static  byte[] desEncrypt(byte[] plainText) throws Exception {
		IvParameterSpec iv = new IvParameterSpec(iv1);

		DESKeySpec dks = new DESKeySpec(key.getBytes());
		SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
		SecretKey key = keyFactory.generateSecret(dks);
		Cipher cipher = Cipher.getInstance("DES/CBC/PKCS5Padding");
		cipher.init(Cipher.ENCRYPT_MODE, key, iv);
		byte data[] = plainText;
		byte encryptedData[] = cipher.doFinal(data);
		return encryptedData;
	}

	
	public static byte[] desDecrypt(byte[] plainText) throws Exception {
		IvParameterSpec iv = new IvParameterSpec(iv1);

		DESKeySpec dks = new DESKeySpec(key.getBytes());
		SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
		SecretKey key = keyFactory.generateSecret(dks);
		Cipher cipher = Cipher.getInstance("DES/CBC/PKCS5Padding");
		cipher.init(Cipher.DECRYPT_MODE,key, iv);
		byte data[] = plainText;
		byte encryptedData[] = cipher.doFinal(data);
		return encryptedData;
//		Cipher cipher = Cipher.getInstance("DES/ECB/PKCS5Padding");
//		cipher.init(Cipher.ENCRYPT_MODE, new SecretKeySpec(key.getBytes("utf-8"), "DES"));
//		byte[] bytes = cipher.doFinal(str.getBytes("utf-8"));
//		return bytes;
	}

	public static String encrypt(String input) {
		String result = "input";
		try {
			result = base64Encode(desEncrypt(input.getBytes()));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		String d = result.substring(result.length() - 1);
		if (d.equals("\n")) {
			result = result.substring(0, result.length() - 1);
		}

		return result;
	}

	

	public static String decrypt(String output) {
		String result = "output";
		try {
			result = new String(desDecrypt(base64Decode(output.getBytes())),"UTF-8");
		} catch (OutOfMemoryError err) {
			err.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	public static String base64Encode(byte[] s) {
		if (s == null)
			return null;
		return Base64.encodeToString(s, Base64.DEFAULT);
	}

	

	public static byte[] base64Decode(byte[] str) {

		if (str == null)
			return null;

		return Base64.decode(str, Base64.DEFAULT);
	}
}
