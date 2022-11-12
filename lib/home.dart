import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController place = TextEditingController();
  final TextEditingController lat = TextEditingController();
  final TextEditingController lon = TextEditingController();

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
          FutureBuilder(
              future: apicall(place.toString(), lat.toString(), lon.toString()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(snapshot.data),
                    ],
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              })
        ]),
      ),
    );
  }
}

Future apicall(place, lat, lon) async {
  Uri url;
  print("Place" + place);
  print("Lat" + lat);
  print("Lon" + lon);
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
  url = Uri.parse("""
      https://api.openweathermap.org/data/2.5/
      weather?q=Belgaum&appid=dc93eadde9eaf2c221f
      0738d939e30f4""");

  // final url = Uri(
  //     host: 'https://api.openweathermap.org',
  //     path: '/data/2.5/weather',
  //     queryParameters: {
  //       'q': 'bangalore',
  //       'appid': 'dc93eadde9eaf2c221f0738d939e30f4'
  //     });

  final res = await http.get(url);
  // print(res.body);
  final data = jsonDecode(res.body);
  // print(data);
  return data;
}
