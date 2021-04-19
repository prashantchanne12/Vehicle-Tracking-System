import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

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

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    databaseReference.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
      setState(() {
        latitude = '${snapshot.value['latitude']}';
        longitude = '${snapshot.value['longitude']}';
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
      body: Container(
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
            SizedBox(height: 10.0),
            RaisedButton(
              child: Text('Get Data'),
              onPressed: () {
                getData();
              },
            )
          ],
        ),
      ),
    );
  }
}
