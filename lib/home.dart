import 'dart:convert';

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  static const route = 'home';
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController place = TextEditingController();
  final TextEditingController lat = TextEditingController();
  final TextEditingController lon = TextEditingController();
  bool _isLoading = true;
  bool _hasError = false;
  var _myData;

  @override
  void initState() {
    super.initState();
    _myData = apicall(); //this is a future to fetch data from API
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Api'),
      ),
      body: Center(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: place,
                    selectionWidthStyle: BoxWidthStyle.tight,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.location_city),
                      labelText: 'Enter City Name',
                      hintText: 'Enter a Place to Search',
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: lat,
                    keyboardType: TextInputType.text,
                    selectionWidthStyle: BoxWidthStyle.tight,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.location_on),
                      labelText: 'Enter Latitude',
                      hintText: 'Enter a Place to Search',
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: lon,
                    keyboardType: TextInputType.text,
                    // selectionWidthStyle: BoxWidthStyle.v,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.location_on),
                      labelText: 'Enter Longitude',
                      hintText: 'Enter a Place to Search',
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Flexible(
                  child: Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  child: Text("Search for City"),
                  onPressed: () {
                    setState(() {
                      _isLoading
                          ? const CircularProgressIndicator()
                          : (!_hasError
                              ? Column(
                                  children: [
                                    Text("Temperature: ${_myData.temp}"),
                                    Text("Weather is ${_myData.description}"),
                                    Text("Humidity % = ${_myData.humidity}"),
                                    Text("At Time: ${_myData.time}"),
                                    // Image(image: ),
                                  ],
                                ) //here is the data we want to display.
                              : Text('error here'));
                    });
                  },
                ),
              ))
            ],
          ),
        ]),
      ),
    );
  }

  Future apicall({String place = "", int lat = 0, int lon = 0}) async {
    setState(() {
      _isLoading = true;
    });
    try {
      print("Place" + place);
      print("Lat" + lat.toString());
      print("Lon" + lon.toString());
      // if (lat == "") {
      //   url = Uri.parse("""
      //     https://api.openweathermap.org/data/2.5/
      //     weather?q=Belgaum&appid=dc93eadde9eaf2c221f
      //     0738d939e30f4""");
      // } else {
      //   url = Uri.parse("""
      //     https://api.openweathermap.org/data/2.5/
      //     weather?lat=$lat&lon=$lon&appid=dc93eadde9eaf2c221f
      //     0738d939e30f4""");
      // }
      final queryParameters = {
        'q': 'bangalore',
        'appid': 'dc93eadde9eaf2c221f0738d939e30f4'
      };
      final url = Uri.https(
          'api.openweathermap.org', '/data/2.5/weather', queryParameters);

      final res = await http.get(url);
      final data = jsonDecode(res.body);
      final dataOut = {
        'description': data['weather'][0]['description'],
        'temp': data['main']['temp'],
        'icon': data['weather'][0]['icon'],
        'humidity': data['main']['humidity'],
        "time": data["timezone"]
      };
      setState(() {
        _isLoading = false;
      });
      return dataOut;
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }
}
