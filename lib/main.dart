import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format-json-cors&key=015f9fd";

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(hintColor: Colors.amber, primaryColor: Colors.white),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final bitcoinController = TextEditingController();
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();
  final libraController = TextEditingController();
  final dolarcadController = TextEditingController();
  final dolaraudController = TextEditingController();

  double dolaraud;
  double dolarcad;
  double bitcoin;
  double libra;
  double euro;
  double dolar;

  void _clearAll(){
    realController.text = "";
    dolarController.text = "";
    euroController.text = "";
    libraController.text = "";
    bitcoinController.text = "";
    dolarcadController.text = "";
    dolaraudController.text = "";
  }

  void _realChanged(String text){
    if(text.isEmpty){
      _clearAll();
      return;
    }
    double real = double.parse(text);
    dolarController.text = (real/dolar).toStringAsFixed(2);
    euroController.text = (real/euro).toStringAsFixed(2);
    libraController.text = (real/libra).toStringAsFixed(2);
    bitcoinController.text = (real/bitcoin).toStringAsFixed(2);
    dolarcadController.text = (real/dolarcad).toStringAsFixed(2);
    dolaraudController.text = (real/dolaraud).toStringAsFixed(2);
  }

  void _dolarChanged(String text){
    if(text.isEmpty){
      _clearAll();
      return;
    }
    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
    libraController.text = (dolar * this.dolar / libra).toStringAsFixed(2);
    bitcoinController.text = (dolar * this.dolar / bitcoin).toStringAsFixed(2);
    dolaraudController.text = (dolar * this.dolar / dolaraud).toStringAsFixed(2);
    dolarcadController.text = (dolar * this.dolar / dolarcad).toStringAsFixed(2);
  }

  void _euroChanged(String text){
    if(text.isEmpty){
      _clearAll();
      return;
    }
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
    libraController.text = (euro * this.euro / libra).toStringAsFixed(2);
    bitcoinController.text = (euro * this.euro / bitcoin).toStringAsFixed(2);
    dolaraudController.text = (euro * this.euro / dolaraud).toStringAsFixed(2);
    dolarcadController.text = (euro * this.euro / dolarcad).toStringAsFixed(2);
  }

  void _libraChanged(String text){
    if(text.isEmpty){
      _clearAll();
      return;
    }
    double libra = double.parse(text);
    realController.text = (libra * this.libra).toStringAsFixed(2);
    dolarController.text = (libra * this.libra / dolar).toStringAsFixed(2);
    euroController.text = (libra * this.libra / euro).toStringAsFixed(2);
    bitcoinController.text = (libra * this.libra / bitcoin).toStringAsFixed(2);
    dolarcadController.text = (libra * this.libra / dolarcad).toStringAsFixed(2);
    dolaraudController.text = (libra * this.libra / dolaraud).toStringAsFixed(2);
  }

  void _bitcoinChanged(String text){
    if(text.isEmpty){
      _clearAll();
      return;
    }
    double bitcoin = double.parse(text);
    realController.text = (bitcoin * this.bitcoin).toStringAsFixed(2);
    dolarController.text = (bitcoin * this.bitcoin / dolar).toStringAsFixed(2);
    euroController.text = (bitcoin * this.bitcoin / euro).toStringAsFixed(2);
    libraController.text = (bitcoin * this.bitcoin/ libra).toStringAsFixed(2);
    dolaraudController.text = (bitcoin * this.bitcoin / dolaraud).toStringAsFixed(2);
    dolarcadController.text = (bitcoin * this.bitcoin / dolarcad).toStringAsFixed(2);

  }

  void _dolarcadChanged(String text){
    if(text.isEmpty){
      _clearAll();
      return;
    }
    double dolarcad = double.parse(text);
    realController.text = (dolarcad * this.dolarcad).toStringAsFixed(2);
    euroController.text = (dolarcad * this.dolarcad / euro).toStringAsFixed(2);
    libraController.text = (dolarcad * this.dolarcad / libra).toStringAsFixed(2);
    bitcoinController.text = (dolarcad * this.dolarcad / bitcoin).toStringAsFixed(2);
    dolarController.text = (dolarcad * this.dolarcad / dolar).toStringAsFixed(2);
    dolaraudController.text = (dolarcad * this.dolarcad / dolaraud).toStringAsFixed(2);
  }

  void _dolaraudChanged(String text){
    if(text.isEmpty){
      _clearAll();
      return;
    }
    double dolaraud = double.parse(text);
    realController.text = (dolaraud * this.dolaraud).toStringAsFixed(2);
    dolarController.text = (dolaraud * this.dolaraud / dolar).toStringAsFixed(2);
    euroController.text = (dolaraud * this.dolaraud / euro).toStringAsFixed(2);
    libraController.text = (dolaraud * this.dolaraud/ libra).toStringAsFixed(2);
    dolaraudController.text = (dolaraud * this.dolaraud / dolaraud).toStringAsFixed(2);
    dolarcadController.text = (dolaraud * this.dolaraud / dolarcad).toStringAsFixed(2);
    bitcoinController.text = (dolaraud * this.dolaraud / bitcoin).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("Global Coin"),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),
        body: FutureBuilder<Map>(
            future: getData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                      child: Text(
                    "Carregando Dados...",
                    style: TextStyle(color: Colors.amber, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ));
                default:
                  if (snapshot.hasError) {
                    return Center(
                        child: Text(
                      "Erro ao carregar dados",
                      style: TextStyle(color: Colors.amber, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ));
                  } else {
                    dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                    euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                    libra = snapshot.data["results"]["currencies"]["GBP"]["buy"];
                    bitcoin = snapshot.data["results"]["currencies"]["BTC"]["buy"];
                    dolarcad = snapshot.data["results"]["currencies"]["CAD"]["buy"];
                    dolaraud = snapshot.data["results"]["currencies"]["AUD"]["buy"];

                    return SingleChildScrollView(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Icon(Icons.monetization_on,
                              size: 150.0, color: Colors.amber),
                          buildTextFormField("Bitcoin", "฿", bitcoinController, _bitcoinChanged),
                          Divider(),
                          buildTextFormField("Libra", "£", libraController, _libraChanged),
                          Divider(),
                          buildTextFormField("Euro", "€", euroController, _euroChanged),
                          Divider(),
                          buildTextFormField("Dólar", "US\$", dolarController, _dolarChanged),
                          Divider(),
                          buildTextFormField("Dólar Canadense", "C\$", dolarcadController, _dolarcadChanged),
                          Divider(),
                          buildTextFormField("Dólar Australiano", "A\$", dolaraudController, _dolaraudChanged),
                          Divider(),
                          buildTextFormField("Reais", "R\$", realController, _realChanged),
                          Divider(),
                        ],
                      ),
                    );
                  }
              }
            })
    );
  }
}

Widget buildTextFormField(String label, String prefix, TextEditingController c, Function f){
  var _controller = TextEditingController();
  return TextFormField(
    controller: c,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.amber),
        border: OutlineInputBorder(),
        prefixText: prefix

    ),
    style: TextStyle(
      color: Colors.amber, fontSize: 25.0
    ),
    onChanged: f,
    keyboardType: TextInputType.number,
  );
}