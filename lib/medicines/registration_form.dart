import 'package:flutter/material.dart';

class MedicineRegistrationForm extends StatefulWidget {
  const MedicineRegistrationForm({Key? key}) : super(key: key);

  @override
  _MedicineRegistrationFormState createState() =>
      _MedicineRegistrationFormState();
}

class _MedicineRegistrationFormState extends State<MedicineRegistrationForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Register Medicine')),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(children: <Widget>[
              Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Name'),
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'quantity'),
                      ),
                    ],
                  )),
              SizedBox(
                  width: double.infinity,
                  height: 40.0,
                  child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Submit'),
                      style: ElevatedButton.styleFrom(primary: Colors.green)))
            ])));
  }
}
