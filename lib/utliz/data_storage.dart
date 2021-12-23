
import 'package:facetagr/net/services.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';

void StoreDeviceRegisration(String clientId,String secretKey,String deviceId ){
  var clientData = Hive.box('clientData');
  clientData.put('id', clientId);
  clientData.put('secret', secretKey);
  clientData.put('deviceId', deviceId);
  print('!!!!!!!!!-- Data Stored in Local Storage  --!!!!!!!!!');
  print('Client ID --- > ' + clientId);
  print('Client Secret --- > ' + secretKey);
  print('Device ID--- > '+   deviceId);
}

dynamic GetDeviceRegistraion() async {
  var clientData =await  Hive.openBox('clientData');
  return {
    'id' : clientData.get('id')??'',
    'secret': clientData.get('secret')??'',
    'deviceId' : clientData.get('deviceId')??''
  };
}

Future<void> registrationCheck() async {
  var data=await GetDeviceRegistraion();
  if(data['id']=='' || data['secret']==''){
    DeviceRegistrationAPI();
  }else{
    print("Device Already Registered with --> " );
    print("Client ID --- > " + data['id']);
    print("Client Secret --- > " + data['secret']);
    print("Device ID --- > " + data['deviceId']);

  }
}

void StoreURLToken(String url){
 try{
   var websiteData = Hive.box('clientData');
   websiteData.put('url', url);
   print('!!!!!!!!!-- Data Stored in Local Storage  --!!!!!!!!!');
   print('WebSite URL --- > ' + url);
 }
 catch(e){
   print(e);
 }
}

Future<String> getWebsiteStatus() async{
  var clientData =await  Hive.openBox('clientData');
  return clientData.get('url')??'';
}

void removeWebsiteUrl() async{
  var clientData =await  Hive.openBox('clientData');
  clientData.delete('url');
}