import 'package:facetagr/pages/auth.dart';
import 'package:facetagr/utliz/data_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';
class WebViewOpener extends StatefulWidget {
  final String url;
  const WebViewOpener({Key? key,required this.url}) : super(key: key);

  @override
  _WebViewOpenerState createState() => _WebViewOpenerState();
}

class _WebViewOpenerState extends State<WebViewOpener> {
  bool isLoading=true;
  final _key = UniqueKey();

  void _logoutHandler(){
    removeWebsiteUrl();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => AuthScreen()),
            (Route<dynamic> route) => false
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FaceTagr Alerts',style: GoogleFonts.poppins(
        ),),
        actions: [IconButton(onPressed: _logoutHandler, icon: const Icon(Icons.logout))],
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            key: _key,
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (finish) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading ? Center( child: CircularProgressIndicator(),)
              : Stack(),
        ],
      ),
    );
  }
}
