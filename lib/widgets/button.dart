import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class FaceTagrButton extends StatelessWidget {
   final String text;
   final Function function;
   const FaceTagrButton({Key? key,required this.text,required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
        child: Text(this.text,style: GoogleFonts.poppins(),),
        onPressed: () {
          this.function();
        },
      ),
    );
  }
}
