import 'package:flutter/material.dart';
import 'package:pantallas/corazones.dart';
import 'package:toast/toast.dart';

void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: TextInputValue(),
  ));
}

class TextInputValue extends StatefulWidget {
  _TextInputValueState createState() => _TextInputValueState();
}

class _TextInputValueState extends State<TextInputValue> {
  TextEditingController _textInputController = TextEditingController();
  int numero=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Number favorites Value'),
        ),
        body: Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 200,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)),
                    child: Text("Choose my favorites"),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder:
                              (context)=> RandomWords()));}),
              ),
              // the arguments in the onGenerateRoute function and pass them
              // to the screen.
              Container(
                width: 200,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)),
                    child: Text("Choose my best favorites"),
                    onPressed: () {_parseNumber();}
                ),
              ),
              Container(
                width: 300,
                margin: const EdgeInsets.only(top: 40.0),
                child: TextFormField(
                  controller: _textInputController,
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(labelText: "Enter your number"),

                ),
              ),
             ],
        )));
  }

  _parseNumber() {
    setState(() {
      numero = int.tryParse(_textInputController.text);
    });
    if (numero == null) {
      Toast.show("Introduce a number up to 99", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    } else {
      if (numero > 99) {
        Toast.show("Only numbers up to 99", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RandomWords(numero: numero,)),
        );
      }
    }
  }

}