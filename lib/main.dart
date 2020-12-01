import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Map<String, int> _measuresMap = {
    'meters': 0,
    'kilometers': 1,
    'grams': 2,
    'kilograms': 3,
    'feet': 4,
    'miles': 5,
    'pounds': 6,
    'ounces': 7,
  };

  final dynamic _formulas = {
    '0': [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    '1': [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    '2': [0, 0, 1, 0.0001, 0, 0, 0.00220462, 0.035274],
    '3': [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    '4': [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    '5': [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    '6': [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    '7': [0, 0, 28.3495, 0.0283495, 3.28084, 0, 0.0625, 1],
  };

  double _numberFrom;

  final List<String> _measures = [
    'meters',
    'kilometers',
    'grams',
    'kilograms',
    'feet',
    'miles',
    'pounds',
    'ounces',
  ];
  String _startMeasure;
  String _convertedMeasure;
  String _resultMessage;

  void convert(double value, String from, String to) {
    int nFrom = _measuresMap[from];
    int nTo = _measuresMap[to];
    var multiplier = _formulas[nFrom.toString()][nTo];
    var result = value * multiplier;
    if (result == 0) {
      _resultMessage = 'This conversation cannot be performed';
    } else {
      _resultMessage =
          ' ${_numberFrom.toString()} $_startMeasure are ${result.toString()} $_convertedMeasure .';
      //_resultMessage = 'asshole';
    }

    setState(() {
      _resultMessage = _resultMessage;
    });
  }

  @override
  void initState() {
    _numberFrom = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle inputStyle = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
    final TextStyle labelStyle = TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Measures coverter',
      home: Scaffold(
        backgroundColor: Color(0xFF8E44AD),
        // appBar: AppBar(
        //   title: Text('Measures Converter'),
        // ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(90, 10, 20, 0),
                  padding: new EdgeInsets.only(top: 92.0),
                  child: Text(
                    "Measures Converter",
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 28,
                ),
                Container(
                  margin: EdgeInsets.only(),
                  padding: EdgeInsets.all(25),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "value",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (text) {
                      var rv = double.tryParse(text);
                      if (rv != null) {
                        setState(() {
                          _numberFrom = rv;
                        });
                      } else {
                        setState(() {
                          _numberFrom = 0;
                        });
                      }
                    },
                  ),
                ),
                SizedBox(),
                Text(
                  'From',
                  style: labelStyle,
                ),
                SizedBox(),
                Container(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: DropdownButton(
                    value: _startMeasure,
                    style: inputStyle,
                    isExpanded: true,
                    items: _measures.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _startMeasure = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Text(
                  'To',
                  style: labelStyle,
                ),
                SizedBox(),
                Container(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: DropdownButton(
                    isExpanded: true,
                    style: inputStyle,
                    value: _convertedMeasure,
                    items: _measures.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: inputStyle,
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _convertedMeasure = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 28,
                ),
                Container(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: MaterialButton(
                    height: 58,
                    minWidth: 340,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(12)),
                    child: Container(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "CONVERT",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                            ),
                          ),
                          Icon(Icons.compare_arrows),
                        ],
                      ),
                    ),
                    color: Color(0xFFF7CA18),
                    onPressed: () {
                      if ((_numberFrom == 0) ||
                          (_convertedMeasure.isEmpty) ||
                          (_startMeasure.isEmpty)) {
                        setState(() {
                          _resultMessage = 'Check your Input';
                        });
                      } else {
                        convert(_numberFrom, _startMeasure, _convertedMeasure);
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 28,
                ),
                Container(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: Text(
                    (_resultMessage == null) ? '' : _resultMessage.toString(),
                    style: labelStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
