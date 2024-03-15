import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uniride/pages/register.dart';
import 'package:uniride/pages/welcome.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var userBox = Hive.box('user');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 75),
              ClipRRect(child: Image.asset('assets/Logo.png', height: 100, width: 100,), borderRadius: BorderRadius.circular(10)),
              SizedBox(height: 10),
              Text('Welcome back', style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),),
              SizedBox(height: 5),
              Text('Login to your account', style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),),
              SizedBox(height: 75),
              Align(
                alignment: Alignment.topLeft,
                child: Text('Email', style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email, color: Colors.grey[600],),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.transparent)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.transparent)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.transparent)),

                  
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: Text('Password', style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),),
              ),
              SizedBox(height: 10),
                            TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password, color: Colors.grey[600],),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.transparent)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.transparent)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.transparent))),
                  obscureText: true,
              ),
              SizedBox(height: 50),
              ElevatedButton(onPressed: _login, child: Text('Login'), style: ElevatedButton.styleFrom(backgroundColor: Color(0xff1a1528), foregroundColor: Colors.white, minimumSize: Size(MediaQuery.of(context).size.width*0.9, MediaQuery.of(context).size.height*0.05), textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account? ', style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Register()));
                    },
                    child: Text('Register', style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      );
  }

  void _login() async {
    var email = _emailController.text;
    var password = _passwordController.text;
    var user = userBox.get(email);
    if (user != null) {
      if (user['password'] == password) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Welcome()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Incorrect password')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User not found')));
  }
}
}