import 'dart:io';

import 'package:facetagr/pages/auth.dart';
import 'package:facetagr/pages/webview.dart';
import 'package:facetagr/utliz/data_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'net/services.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  registrationCheck();
  String websiteStatus=await getWebsiteStatus();
  runApp(FaceTagrAlertsMain(status: websiteStatus,));
}

class FaceTagrAlertsMain extends StatelessWidget {
  final String status;
  const FaceTagrAlertsMain({Key? key,required this.status}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FaceTagr Alerts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: EasyLoading.init(),
      home: status!=''  ? WebViewOpener(url: status,) : AuthScreen(),
    );
  }
}

