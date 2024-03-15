import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff48e9ff),
        centerTitle: true,
        title: Text('About Us', style:GoogleFonts.montserrat(
          textStyle: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.w400,
          ),
        ),),
      ),
      body: Card(
        color: Color(0xffFFD565),
        child: ListView(
          children: [
           
              Card(
                color: Color.fromARGB(255, 255, 228, 152),
                child: Column(
                  
                  children: [
                    Text('About UniRide', style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                    ),),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Welcome to UniRide, your ultimate companion for seamless and efficient commuting in the urban jungle! UniRide is not just an app; it\'s your gateway to hassle-free travel by providing real-time information on the nearest metro stations, bus stops, and their schedules.', style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),),
                    ),
                  ],
                ),
              ),
              Card(
                color: Color.fromARGB(255, 255, 228, 152),
                child: Column(
                  children: [
                    Text('Our Mission', style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                    ),),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('At UniRide, we are on a mission to simplify your daily commute. We understand the importance of your time and the need for reliable transportation information. Our goal is to empower you with the knowledge of the nearest public transportation options, ensuring you reach your destination comfortably and on time.', style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),),
                    ),
                  ],
                ),
              ),
              Card(
                color: Color.fromARGB(255, 255, 228, 152),
                child: Column(
                  children: [
                    Text('Key Features', style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                    ),),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('• Nearest Metro Station Locator: UniRide uses advanced location-based technology to identify the closest metro stations around you. No more guessing or wandering aimlessly – UniRide guides you to the nearest metro station with precision.', style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('• Bus Stop Finder: Whether you\'re a regular bus commuter or looking for an alternative mode of transportation, UniRide has got you covered. Discover the closest bus stops and plan your journey efficiently.', style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('• Real-time Schedules: Stay up-to-date with the latest bus and metro schedules in real-time. UniRide provides accurate and timely information, so you can plan your day with confidence.', style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('• User-Friendly Interface: UniRide boasts an intuitive and user-friendly interface designed to make your experience smooth and enjoyable. Navigation is simple, ensuring that even first-time users can quickly access the information they need.', style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),),
                    ),
          ],
        ),
      ),
   ])) );
  }
}