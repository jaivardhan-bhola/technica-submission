import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uniride/pages/about.dart';
import 'package:uniride/pages/onboarding.dart';
import 'package:uniride/pages/bus.dart';
import 'package:uniride/pages/dashboard.dart';
import 'package:uniride/pages/login.dart';
import 'package:uniride/pages/metro.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, Map>? entries = {}; 
  int currentIndex = 0;
  final screens = [
    Dashboard(),
    Bus(),
    Metro(),
  ];
  Box <dynamic> hiveBox = Hive.box('user');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        backgroundColor: Color(0xffFFD565),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  color: Color(0xff48e9ff),
                ),
                Image.asset('assets/drawerBackground.png'),
                Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.purple,
                          radius: 50,
                            child: CircleAvatar(
                              radius: 45,
                              child: Text(hiveBox.get('email')[0].toUpperCase(), style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),),
                            ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(hiveBox.get('email').toString().split('@')[0], style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),),
                  ],
                )
              ],
            ),
            SizedBox(height: 10),
            Card(
              child: ListTile(
                leading: Icon(Icons.help),
                title: Text('How to use'),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Onboarding()));
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.info),
                title: Text('About'),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => About()));
                },
              ),
            ),
            SizedBox(height: 150),
            ElevatedButton(onPressed: (){
              hiveBox.delete('email');
              Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => Login()));}, child: Text('Logout', style: TextStyle(color: Colors.white),), style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              minimumSize: Size(MediaQuery.of(context).size.width*0.5, MediaQuery.of(context).size.height*0.05),
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              )),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff48e9ff),
        title: Text(
          'UniRide',
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(child: Image.asset('assets/Logo.png', height: 20, width: 50), borderRadius: BorderRadius.circular(50)),
        ),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: CircleAvatar(
                          backgroundColor: Colors.purple,
                          radius: 50,
                            child: CircleAvatar(
                              radius: 45,
                              child: Text(hiveBox.get('email')[0].toUpperCase(), style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),),
                            ),
                        )
              );
            },
          ),
        ],
      ),
      body: screens[currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        onTap: (index) => setState(() => currentIndex = index),
        color: Color(0xffFFDB7A),
        backgroundColor: Color(0xffFFE9AD),
        animationDuration: Duration(milliseconds: 150),
        items: [
          Icon(Icons.home),
          Icon(Icons.directions_bus),
          Icon(Icons.subway),
        ],
      ),
    );
  }
}