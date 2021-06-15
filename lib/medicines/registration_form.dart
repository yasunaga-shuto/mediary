import 'package:flutter/material.dart';

class MedicineRegistrationForm extends StatefulWidget {
  const MedicineRegistrationForm({Key? key}) : super(key: key);

  @override
  _MedicineRegistrationFormState createState() =>
      _MedicineRegistrationFormState();
}

class _MedicineRegistrationFormState extends State<MedicineRegistrationForm> {
  final FocusNode _quantityFocusNode = FocusNode();
  final TextEditingController _quantityTextFieldController =
      TextEditingController();

  @override
  void initState() {
    _quantityFocusNode.addListener(() {
      if (_quantityFocusNode.hasFocus) {
        FocusScope.of(context).requestFocus(FocusNode());
        _selectTime();
      }
    });
    super.initState();
  }

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
                        decoration: const InputDecoration(
                            labelText: '薬の名前', icon: Icon(Icons.healing)),
                      ),
                      Row(
                        children: const [
                          Flexible(
                              child: TextField(
                            decoration: InputDecoration(
                                labelText: '服用量',
                                icon: Icon(Icons.takeout_dining)),
                          )),
                          Text('錠')
                        ],
                      ),
                      TextFormField(
                        focusNode: _quantityFocusNode,
                        controller: _quantityTextFieldController,
                        decoration: const InputDecoration(
                            labelText: '服用時刻を入力', icon: Icon(Icons.schedule)),
                      ),
                    ],
                  )),
              SizedBox(
                  width: double.infinity,
                  height: 40.0,
                  child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('登録'),
                      style: ElevatedButton.styleFrom(primary: Colors.green)))
            ])));
  }

  void _selectTime() async {
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 8, minute: 0),
    );
    if (newTime != null) {
      setState(() {
        _quantityTextFieldController.text = newTime.format(context).toString();
      });
    }
  }
}
