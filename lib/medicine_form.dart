import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mediary/models/medicine_repository.dart';

class MedicineForm extends StatefulWidget {
  const MedicineForm({Key? key}) : super(key: key);

  @override
  _MedicineFormState createState() => _MedicineFormState();
}

class _MedicineFormState extends State<MedicineForm> {
  final FocusNode _takenAtFocusNode = FocusNode();
  final TextEditingController _takenAtController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  @override
  void initState() {
    _takenAtFocusNode.addListener(() {
      if (_takenAtFocusNode.hasFocus) {
        FocusScope.of(context).requestFocus(FocusNode());
        _selectTime();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('お薬の登録')),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: <Widget>[
            Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: '薬の名前 *',
                        icon: Icon(Icons.healing),
                      ),
                      controller: _nameController,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: TextField(
                            controller: _quantityController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: const InputDecoration(
                              labelText: '服用量',
                              icon: Icon(Icons.takeout_dining),
                            ),
                          ),
                        ),
                        const Text('錠'),
                      ],
                    ),
                    TextFormField(
                      focusNode: _takenAtFocusNode,
                      controller: _takenAtController,
                      decoration: const InputDecoration(
                        labelText: '服用時刻を入力 *',
                        icon: Icon(Icons.schedule),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              width: double.infinity,
              height: 40.0,
              child: ElevatedButton(
                onPressed: _registerMedicine,
                child: const Text('登録'),
                style: ElevatedButton.styleFrom(primary: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectTime() async {
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 8, minute: 0),
    );
    if (newTime != null) {
      setState(() {
        _takenAtController.text = newTime.format(context).toString();
      });
    }
  }

  void _registerMedicine() {
    // TODO: バリデーション
    // TODO: unitを変えられるようにする
    // TODO: 再描画
    MedicineRepository.create(
      _nameController.text,
      int.parse(_quantityController.text),
      '錠',
      _takenAtController.text,
    );
    Navigator.of(context).pop();
  }
}
