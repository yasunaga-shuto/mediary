import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:mediary/models/medicine_model.dart";

class MedicineForm extends StatefulWidget {
  const MedicineForm({
    Key? key,
    required this.type,
    this.id,
    this.name,
    this.quantity,
    this.takenAt,
  }) : super(key: key);

  final String type;
  final int? id;
  final String? name;
  final int? quantity;
  final TimeOfDay? takenAt;

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
    Future.delayed(Duration.zero, () {
      _setDefaultText();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: _getFormTitle()),
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
                        labelText: "薬の名前 *",
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
                              labelText: "服用量",
                              icon: Icon(Icons.takeout_dining),
                            ),
                          ),
                        ),
                        const Text("錠"),
                      ],
                    ),
                    TextFormField(
                      focusNode: _takenAtFocusNode,
                      controller: _takenAtController,
                      decoration: const InputDecoration(
                        labelText: "服用時刻を入力 *",
                        icon: Icon(Icons.schedule),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              width: double.infinity,
              height: 40.0,
              child: ElevatedButton(
                onPressed: () {
                  switch (widget.type) {
                    case "registration":
                      _registerMedicine();
                      break;
                    case "edit":
                      _updateMedicine();
                      break;
                  }
                },
                child: _getFormAction(),
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
      initialTime: const TimeOfDay(hour: 0, minute: 0),
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
    MedicineModel().createMedicine(
      _nameController.text,
      int.parse(_quantityController.text),
      _takenAtController.text,
    );
    Navigator.pop(context, "お薬が登録されました");
  }

  void _updateMedicine() async {
    var isUpdated = await MedicineModel().updateMedicine(
      widget.id,
      _nameController.text,
      int.parse(_quantityController.text),
      _takenAtController.text,
    );
    if (isUpdated) {
      Navigator.pop(context, "お薬が更新されました");
    }
  }

  // TODO: I18n化
  Widget _getFormTitle() {
    switch (widget.type) {
      case "registration":
        return const Text("お薬の登録");
      case "edit":
        return const Text("お薬の編集");
      default:
        return const Text("");
    }
  }

  Widget _getFormAction() {
    switch (widget.type) {
      case "registration":
        return const Text("登録");
      case "edit":
        return const Text("更新");
      default:
        return const Text("");
    }
  }

  void _setDefaultText() {
    _nameController.text = widget.name ?? "";
    _quantityController.text =
        widget.quantity == null ? "" : widget.quantity!.toString();
    _takenAtController.text = widget.takenAt!.format(context);
  }
}

class ScreenArguments {
  ScreenArguments(
    this.id,
    this.name,
    this.quantity,
    this.takenAt,
  );

  final int? id;
  final String? name;
  final int? quantity;
  final TimeOfDay? takenAt;
}
