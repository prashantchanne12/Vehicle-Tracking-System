import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geocoder/geocoder.dart';
import 'package:maps_launcher/maps_launcher.dart';

final databaseReference = FirebaseDatabase.instance.reference();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vehicle Tracking System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'poppins',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var latitude = '';
  var longitude = '';
  var location = '';

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    databaseReference.once().then((DataSnapshot snapshot) async {
      var lat = '${snapshot.value['latitude']}';
      var long = '${snapshot.value['longitude']}';
      final coordinates =
          new Coordinates(double.parse(lat), double.parse(long));
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      var loc = '${first.locality}, ${first.subLocality}';

      setState(() {
        latitude = lat;
        longitude = long;
        location = loc;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Vehicle Tracking System'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 25.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                        child: Container(
                          width: (MediaQuery.of(context).size.width - 50) / 2,
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Latitude',
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 15.0),
                              Text(
                                latitude,
                                style: TextStyle(
                                  fontSize: 26.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          width: (MediaQuery.of(context).size.width - 50) / 2,
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Longitude',
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 15.0),
                              Text(
                                longitude,
                                style: TextStyle(
                                  fontSize: 26.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Card(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width - 30,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                'Location',
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(height: 6.0),
                            Container(
                              child: Text(
                                location,
                                style: TextStyle(
                                  fontSize: 26.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Card(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width - 30,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                'Past Locations',
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(height: 6.0),
                            ListTile(
                              title: Text('Mumbai, Sion'),
                              leading: Icon(Icons.location_on),
                            ),
                            ListTile(
                              title: Text('New Mumbai, Vashi'),
                              leading: Icon(Icons.location_on),
                            ),
                            Container(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                'show more',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Card(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width - 30,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FlatButton(
                              onPressed: () => {
                                MapsLauncher.launchCoordinates(
                                    double.parse(latitude),
                                    double.parse(longitude))
                              },
                              child: Container(
                                child: Text(
                                  'Open Google Map',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
