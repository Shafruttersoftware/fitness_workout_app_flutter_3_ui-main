import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class SecureStorage {
  static const FlutterSecureStorage storage = FlutterSecureStorage();

  //here all can pass the keyvalue
  static const _keyValue = "token";
  static const _keyValue1 = "EMAIL";
  static const _keyValue2 = "token2";

  static Future setString(String str,) async {
    await storage.write(key: _keyValue, value: str);
    // await storage.write(key: _keyValue1, value: str1);
    // await storage.write(key: _keyValue2, value: str2);
  }
  static Future setString1(String str1,) async {
    // await storage.write(key: _keyValue, value: str);
    await storage.write(key: _keyValue1, value: str1);
    // await storage.write(key: _keyValue2, value: str2);
  }
  static Future setString2( String str2) async {
    // await storage.write(key: _keyValue, value: str);
    // await storage.write(key: _keyValue1, value: str1);
    await storage.write(key: _keyValue2, value: str2);
  }

  static Future getString() async{
    var res = await storage.read(key: _keyValue);
    var res1 = await storage.read(key: _keyValue1);
    var res2 = await storage.read(key: _keyValue2);
    return res;
    return res1;
    return res2;

  }
  static Future getString1() async{
    // var res = await storage.read(key: _keyValue);
    var res1 = await storage.read(key: _keyValue1);
    // var res2 = await storage.read(key: _keyValue2);
    // return res;
    return res1;
    // return res2;

  }
  static Future getString2() async{
    // var res = await storage.read(key: _keyValue);
    // var res1 = await storage.read(key: _keyValue1);
    var res2 = await storage.read(key: _keyValue2);
    // return res;
    // return res1;
    return res2;

  }


}