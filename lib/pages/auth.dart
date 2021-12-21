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

  void submitAction(){
    if (_formKey.currentState!.validate()) {
          ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
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
          InputField('Device Name','Enter Device Name'),
          InputField('OTP','Enter your OTP'),
        ],
      ),
    );
  }

  Widget InputField(String hintText,String labelText){
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
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
