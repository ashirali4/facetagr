import 'package:facetagr/net/services.dart';
import 'package:facetagr/pages/webview.dart';
import 'package:facetagr/utliz/toast.dart';
import 'package:facetagr/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController username=TextEditingController();
  TextEditingController password=TextEditingController();


  Future<void> submitAction() async {
    if (_formKey.currentState!.validate()) {
      var a =await AccessTokenAPI(username.text,password.text);
      if(!a['error']){
        showToast('Logged In Successfully');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => WebViewOpener(url: a['content'])),
                (Route<dynamic> route) => false
        );
      }else{
        showToast('Something Went Wrong. Please Try Again');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FaceTagr Alerts',style: GoogleFonts.poppins(
        ),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              LogoImage(),
              InputForm(),
              FaceTagrButton(
                text: 'Sign In', function: submitAction,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget InputForm(){
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InputField('Username','Enter your username',username),
          InputField('Password','Enter your password',password),
        ],
      ),
    );
  }

  Widget InputField(String hintText,String labelText,TextEditingController controller){
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter '+hintText;
            }
            return null;
          },
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.blueAccent,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.blueAccent,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.blueAccent,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.blueAccent,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            labelText: labelText,
            hintText: hintText,
          )),
    );
  }

  Widget LogoImage(){
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      height: 150,
      child: Image.asset(
        "assets/logo.png"
      ),
    );
  }
}
