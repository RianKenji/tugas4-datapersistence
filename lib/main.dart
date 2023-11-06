import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import './pizza.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
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

int appCounter = 1;


class _MyHomePageState extends State<MyHomePage> {
  String pizzaString = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shared Preferences')),
      body: Container(
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                    'You have opened the app ' + appCounter.toString() +
                        ' times.'),
                ElevatedButton(
                  onPressed: () {
                    deletePreference();
                  },
                  child: Text('Reset counter'),
                )],)),
      ),

    );}
  @override
  void initState() {
    readJsonFile();
    readAndWritePreference();
    super.initState();
  }


  Future readAndWritePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    appCounter = prefs.getInt('appCounter')!;
    if (appCounter == null) {
      appCounter = 1;
    } else {
      appCounter++;
    }
    await prefs.setInt('appCounter', appCounter);
    setState(() {
      appCounter = appCounter;
    });
  }

  Future deletePreference() async {
    SharedPreferences prefs = await
    SharedPreferences.getInstance();
    await prefs.clear();
    setState(() {
      appCounter = 0;
    });}

  Future<List<Pizza>> readJsonFile() async {
      String myString = await DefaultAssetBundle.of(context)
          .loadString('assets/pizzalist.json');
      List myMap = jsonDecode(myString);

      List<Pizza> myPizzas = [];
      myMap.forEach((dynamic pizza) {
        Pizza myPizza = Pizza.fromJson(pizza);
        myPizzas.add(myPizza);
      });

      /*setState(() {
      pizzaString = myString;
  });*/
      String json = convertToJSON(myPizzas);
      print(json);
      return myPizzas;
  }

  String convertToJSON(List<Pizza> pizzas) {
    String json = '[';
    pizzas.forEach((pizza) {
      json += jsonEncode(pizza);
    });
    json += ']';
    return json;
  }
}

