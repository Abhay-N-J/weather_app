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
  // final TextEditingController place = TextEditingController();
  // final TextEditingController lat = TextEditingController();
  // final TextEditingController lon = TextEditingController();
  // bool _isLoading = true;
  // bool _hasError = false;
  // var _myData;

  double temp = 30;
  String weather = "Clear";
  int humidity = 10;
  int pressure = 1010;
  double wind_speed = 5;
  String city = "Sample City";
  String app_id = 'dc93eadde9eaf2c221f0738d939e30f4';
  String app_id_2 = 'c6313da7ea37ec2eed66b4aca7360d98';
  String icon_url = "http://openweathermap.org/img/w/03n.png";
  String city_api_url = 'https://api.openweathermap.org/data/2.5/weather?q=';
  String lat_api_url = 'https://api.openweathermap.org/data/2.5/weather?';
  String lat = "10";
  String lon = "10";

  void lat_lon_weather() async {
    var location_result = await http
        .get(Uri.parse('$lat_api_url${"lat=$lat&lon=$lon"}&appid=$app_id_2'));
    var result = json.decode(location_result.body);
    print('$city_api_url${"lat=$lat&lon=$lon"}&appid=$app_id_2');

    setState(() {
      city = result["name"];
      weather = result["weather"][0]["main"];
      temp = (result["main"]["temp"] - 273.15);
      temp = num.parse(temp.toStringAsFixed(1)) as double;
      pressure = result["main"]["pressure"].round();
      humidity = result["main"]["humidity"].round();
      wind_speed = ((result["wind"]["speed"]) * (18 / 5));
      wind_speed = num.parse(temp.toStringAsFixed(1)) as double;
      icon_url =
          "${"http://openweathermap.org/img/w/" + result["weather"][0]["icon"]}.png";
    });
  }

  void city_weather({String input = ""}) async {
    var location_result =
        await http.get(Uri.parse('$city_api_url$city&appid=$app_id_2'));
    var result = json.decode(location_result.body);

    setState(() {
      weather = result["weather"][0]["main"];
      temp = (result["main"]["temp"] - 273.15);
      temp = num.parse(temp.toStringAsFixed(1)) as double;
      pressure = result["main"]["pressure"].round();
      humidity = result["main"]["humidity"].round();
      wind_speed = ((result["wind"]["speed"]) * (18 / 5));
      wind_speed = num.parse(temp.toStringAsFixed(1)) as double;
      icon_url =
          "${"http://openweathermap.org/img/w/" + result["weather"][0]["icon"]}.png";
    });
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
                    // controller: place,
                    onSubmitted: (String place) {
                      city = place;
                      city_weather();
                    },
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
                    onSubmitted: (String input) {
                      // lat_lon_weather();
                      lat = input;
                    },
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
                    onSubmitted: (String input) {
                      lon = input;
                      lat_lon_weather();
                    },
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
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue[900],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Icon(_icons[index],size: 100, color: Colors.yellow,),
                ImageIcon(
                  NetworkImage(icon_url),
                  color: Colors.yellow,
                  size: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    style: const TextStyle(
                      fontSize: 65,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    city.toUpperCase(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    "$temp" "°C",
                    style: const TextStyle(
                      fontSize: 45,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                const SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: Icon(
                    Icons.thermostat_sharp,
                    size: 40,
                    color: Colors.orange[900],
                  ),
                  title: const Text(
                    "Temperature",
                    style: TextStyle(
                      color: Colors.cyanAccent,
                      fontSize: 20,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    "$temp" " °C",
                    style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 20,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: Icon(
                    Icons.speed_sharp,
                    size: 40,
                    color: Colors.yellow[700],
                  ),
                  title: const Text(
                    "Wind Speed",
                    style: TextStyle(
                      color: Colors.cyanAccent,
                      fontSize: 20,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    "$wind_speed km/h",
                    style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 20,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: Icon(
                    Icons.cloud,
                    size: 40,
                    color: Colors.blue[100],
                  ),
                  title: const Text(
                    "Weather",
                    style: TextStyle(
                      color: Colors.cyanAccent,
                      fontSize: 20,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    weather,
                    style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 20,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.water_drop_outlined,
                    size: 40,
                    color: Colors.blue,
                  ),
                  title: const Text(
                    "Humidity",
                    style: TextStyle(
                      color: Colors.cyanAccent,
                      fontSize: 20,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    "$humidity %",
                    style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 20,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: Icon(
                    Icons.air_rounded,
                    size: 40,
                    color: Colors.blue[100],
                  ),
                  title: const Text(
                    "Pressure",
                    style: TextStyle(
                      color: Colors.cyanAccent,
                      fontSize: 20,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    "$pressure mbar",
                    style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 20,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          )
          // Row(
          //   children: [
          //     Flexible(
          //         child: Padding(
          //       padding: EdgeInsets.all(10),
          //       child: ElevatedButton(
          //           child: Text("Search for City"),
          //           onPressed: () {
          //             setState(() {
          //               _isLoading = false;
          //             });
          //           }),
          //     ))
          //   ],
          // ),
        ]),
      ),
    );
  }
}

//   Future apicall({String place = "belgaum", int lat = 0, int lon = 0}) async {
//     setState(() {
//       _isLoading = true;
//     });
//     try {
//       print("Place" + place);
//       print("Lat" + lat.toString());
//       print("Lon" + lon.toString());

//       final url = Uri.parse(
//           "https://api.openweathermap.org/data/2.5/weather?q=$place&appid=dc93eadde9eaf2c221f0738d939e30f4");
//       print(url);

//       final res = await http.get(url);
//       final data = jsonDecode(res.body);
//       final dataOut = {
//         'description': data['weather'][0]['description'],
//         'temp': data['main']['temp'],
//         'icon': data['weather'][0]['icon'],
//         'humidity': data['main']['humidity'],
//         "time": data["timezone"]
//       };
//       setState(() {
//         _isLoading = false;
//       });
//       return dataOut;
//     } catch (e) {
//       print(e.toString());
//       setState(() {
//         _isLoading = true;
//         _hasError = true;
//       });
//     }
//   }
// }
