
// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;


class Metro extends StatefulWidget {
  const Metro({super.key});

  @override
  _MetroState createState() => _MetroState();
}

class _MetroState extends State<Metro> {
  TextEditingController source = TextEditingController();
  TextEditingController destination = TextEditingController();
  var uuid = Uuid();
  String _sessionToken = '12345';
  final _apiKey = dotenv.env['API_KEY'];
  List <dynamic> _suggestions = [];
  Map <dynamic, dynamic> _directions = {};
  var isSourceVisible = true;
  var isDestinationVisible = false;
  var isSearchVisible = false;
  Map<double, double> sourceCoordinates={};
  Map<double, double> destinationCoordinates ={};
  @override
  void initState() {
    super.initState();
    source.addListener(() {
      onChange(source.text);
    });
    destination.addListener(() {
      onChange(destination.text);
    });
  }
  void onChange(String input) {
      if (_sessionToken == null) {
        setState(() {
          _sessionToken = uuid.v4();
        });
      }
      getSuggestions(input);
    }

void getSuggestions(String input) async {
  String baseURL ='https://maps.googleapis.com/maps/api/place/autocomplete/json';
  String request = '$baseURL?input=$input&key=$_apiKey&sessiontoken=$_sessionToken'; 
  var response = await http.get(Uri.parse(request));
  if (response.statusCode == 200) {
    setState(() {
      _suggestions = json.decode(response.body.toString())['predictions'];
    });
  } else {
    throw Exception('Failed to load predictions');
  }
}

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
                child: Text('Metro', style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 30))
                ),
              ),
            ),
            SizedBox(height: 50),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xff1A1528),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Search for Metro Routes', style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 20, color: Colors.white))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onTap: () {
                        setState(() {
                          isSourceVisible = true;
                          isDestinationVisible = false;
                          isSearchVisible = false;
                        });
                      },
                      controller: source,
                      style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white)),
                      decoration: InputDecoration(
                        hintText: 'Enter Source',
                        hintStyle: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2
                          )
                        )
                      ),
                    ),
                  ),
                  if (isSourceVisible)
                  Expanded(child: ListView.builder(
                    itemCount: _suggestions.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_suggestions[index]['description'], style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white))),
                        onTap: () async {
                          List<Location> locations = await locationFromAddress(_suggestions[index]['description']);
                          sourceCoordinates[locations.last.latitude.toDouble()] = locations.last.longitude.toDouble();
                          setState(() {
                            source.text = _suggestions[index]['description'];
                            _suggestions = [];
                            isDestinationVisible = true;
                            isSourceVisible = false;
                          });

                        },
                      );
                    },
                  )),
                  if (isDestinationVisible)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onTap: () {setState(() => isSearchVisible = false); setState(() { isSourceVisible = false; 
                        });},
                        controller: destination,
                        style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white)),
                        decoration: InputDecoration(
                          hintText: 'Enter Destination',
                          hintStyle: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2
                            )
                          )
                        ),
                      ),
                    ),
                    if (isDestinationVisible)
                    Expanded(child: ListView.builder(
                    itemCount: _suggestions.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_suggestions[index]['description'], style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white))),
                        onTap: () async {
                          List<Location> locations = await locationFromAddress(_suggestions[index]['description']);
                          destinationCoordinates[locations.last.latitude.toDouble()] = locations.last.longitude.toDouble();
                          setState(() {
                            destination.text = _suggestions[index]['description'];
                            _suggestions = [];
                            isSearchVisible = true;
                          });
                        },

                      );
                    },
                    )),
                  if (isSearchVisible)
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          var responseDirection = await http.get(Uri.parse('https://maps.googleapis.com/maps/api/directions/json?origin=${sourceCoordinates.keys.first},${sourceCoordinates.values.first}&destination=${destinationCoordinates.keys.first},${destinationCoordinates.values.first}&mode=transit&key=$_apiKey'));
                          if (responseDirection.statusCode == 200) {
                            setState(() {
                              _directions['duration'] = json.decode(responseDirection.body.toString())['routes'][0]['legs'][0]['duration']['text'];
                              _directions['distance'] = json.decode(responseDirection.body.toString())['routes'][0]['legs'][0]['distance']['text'];
                              if (responseDirection.statusCode == 200) {
                                setState(() {
                                  _directions['duration'] = json.decode(responseDirection.body.toString())['routes'][0]['legs'][0]['duration']['text'];
                                  _directions['distance'] = json.decode(responseDirection.body.toString())['routes'][0]['legs'][0]['distance']['text'];
                                  _directions['steps'] = json.decode(responseDirection.body.toString())['routes'][0]['legs'][0]['steps'];
                                });
                              } else {
                                throw Exception('Failed to load directions');
                              }

                              showModalBottomSheet(
                                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.4),
                                backgroundColor: Color(0xff1A1528),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                                ),

                                context: context, builder: (context){
                                  return ListView.builder(
                                    itemCount: _directions['steps'].length+1,
                                    itemBuilder: (context, index) {
                                      if (index == 0) {
                                        return ListTile(
                                          
                                          title:Card(
                                            color: Color(0xffFFD565),
                                            child: ListTile(
                                              title: Text('Total Distance: ${_directions['distance']}', style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black))),
                                              subtitle: Text('Total Time: ${_directions['duration']}', style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black))),
                                            ),
                                          )
                                        );
                                      } else {
                                        if (_directions['steps'][index-1]['travel_mode'] == 'WALKING') {
                                          return Card(
                                            color: Color(0xff48e9ff),
                                            child: ListTile(
                                              leading: Icon(Icons.directions_walk, color: Colors.black),
                                              title: Text(_directions['steps'][index-1]['html_instructions'], style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black))),
                                            ),
                                          );
                                        } else {
                                          if (_directions['steps'][index-1]['html_instructions'].contains('Bus') ||
                                              _directions['steps'][index-1]['html_instructions'].contains('bus')) {
                                            return Card(
                                              color: Color(0xff48e9ff),
                                              child: ListTile(
                                                leading: Icon(Icons.directions_bus, color: Colors.black),
                                                title: Text(_directions['steps'][index-1]['html_instructions'], style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black))),
                                              ),
                                            );
                                          } else {
                                            return Card(
                                              color: Color(0xff48e9ff),
                                              child: ListTile(
                                                leading: Icon(Icons.directions_subway, color: Colors.black),
                                                title: Text(_directions['steps'][index-1]['html_instructions'], style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black))),
                                              ),
                                            );
                                          } 
                                        }
                                    }
                                });
                              });
                            });
                          } else {
                            throw Exception('Failed to load directions');
                          }
                        },
                        child: Text('Search', style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 20))),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xffFFD565),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          )
                        ),
                      ),
                    )
                ],
              ),
            ),
            Image.asset('assets/Metro.png', height: MediaQuery.of(context).size.height * 0.3),
            SizedBox(height: 20),
          ],
        ),
      ),
      );

  }
}