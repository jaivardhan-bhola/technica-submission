import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uniride/frosted_glass.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xffFFE9AD), Color(0xff6fefff)], begin: Alignment.bottomCenter, end: Alignment.topCenter)
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Center(
                child: Text('Welcome', style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 30))
                ),
              ),
            ),
            SizedBox(height: 50),
            FrostedGlassBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Recent Searches', style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 20))),
                  ),
                  // add 7 recent searches with random locations in nagpur randomise the trainsport mode: car pool, bus, metro and add random start and end locations
                  ListTile(
                    leading: Icon(Icons.directions_car),
                    title: Text('Metro'),
                    subtitle: Text('IIIT to Railway Station'),
                  ),
                  ListTile(
                    leading: Icon(Icons.directions_bus),
                    title: Text('Bus'),
                    subtitle: Text('South Airport to Railway Station'),
                  ),
                  ListTile(
                    leading: Icon(Icons.train),
                    title: Text('Metro'),
                    subtitle: Text('Railway Station to South Airport'),
                  ),
                  ListTile(
                    leading: Icon(Icons.directions_car),
                    title: Text('Bus'),
                    subtitle: Text('Rahate Colony to Indora Square'),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}