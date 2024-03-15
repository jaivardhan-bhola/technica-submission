import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uniride/pages/login.dart';
import 'package:uniride/pages/register.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff48e9ff),
      body: Align(
        alignment: Alignment.bottomLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/India.png'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'UniRide',
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Plan your next trip',
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context) => Login()),);}, child: Text('Login'), style: ElevatedButton.styleFrom(backgroundColor: Color(0xff1a1528), foregroundColor: Colors.white, minimumSize: Size(MediaQuery.of(context).size.width*0.9, MediaQuery.of(context).size.height*0.05), textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context) => Register()),);}, child: Text('Register'), style: ElevatedButton.styleFrom(backgroundColor: Color(0xff119BFF), foregroundColor: Colors.white, minimumSize: Size(MediaQuery.of(context).size.width*0.9, MediaQuery.of(context).size.height*0.05), textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
            ),        
          ],
        ),
      ) 
      );
  }
}