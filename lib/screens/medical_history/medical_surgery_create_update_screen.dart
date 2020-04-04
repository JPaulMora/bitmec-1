import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

import 'package:bitmec/my_theme.dart';
import 'package:bitmec/components.dart';
import 'package:bitmec/providers.dart';
import 'package:bitmec/models.dart';

class MedicalSurgeryCreateUpdateScreen extends StatefulWidget {
  static const routeName = '/medical_history/medical_surgery/create_update';

  @override
  _MedicalSurgeryCreateUpdateScreenState createState() =>
      _MedicalSurgeryCreateUpdateScreenState();
}

class _MedicalSurgeryCreateUpdateScreenState
    extends State<MedicalSurgeryCreateUpdateScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();

  Map _arguments;
  MedicalSurgeryProvider _provider;
  PatientProvider _patientProvider;
  ImageDBProvider _imageDBProvider;

  final _surgeryCtrl = TextEditingController();
  final _surgeryNode = FocusNode();

  DateTime _date = DateTime.now();

  final _byCtrl = TextEditingController();
  final _byNode = FocusNode();

  int _conditionValue = -1;

  @override
  Widget build(BuildContext context) {
    if (_arguments == null) {
      setState(() {
        _arguments = ModalRoute.of(context).settings.arguments;

        if (_arguments['method'] == 'update') {
          Surgery surgery = _arguments['surgery'];
          _surgeryCtrl.text = surgery.operation;
          _date = DateTime.parse(surgery.operationDate);
          _byCtrl.text = surgery.operatingDoctor;
          _conditionValue = surgery.historicalCondition ?? -1;
        }
      });
    }

    if (_provider == null) {
      setState(() {
        _provider = MedicalSurgeryProvider.of(context);
      });
    }

    if (_patientProvider == null) {
      setState(() {
        _patientProvider = PatientProvider.of(context);
      });
    }

    if (_imageDBProvider == null) {
      setState(() {
        _imageDBProvider = ImageDBProvider.of(context);
      });
    }

    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return MyAppBar(
      title: _arguments['method'] != 'update' ? 'Crear' : 'Actualizar',
      scaffoldKey: _scaffoldKey,
      backLeading: true,
    );
  }

  /// TODO: implement delete condition and document attached
//  void _confirmDelete(context) async {
//    bool response = await showDialog(
//        context: context,
//        builder: (context) => AlertDialog(
//          title: Text('Confirmar'),
//          content: Text('¿Estas seguro de querer eliminar este dato?'),
//          actions: <Widget>[
//            FlatButton(
//              splashColor: Colors.black12,
//              child: Text('Aceptar'),
//              onPressed: () {
//                MedicalCondition medicalCondition = _arguments['medicalCondition'];
//                _provider.remove(medicalCondition.id, (id) {
//                  _patientProvider.removeMedicalCondition(id);
//                  Navigator.pop(context, true);
//                });
//              },
//            ),
//
//            RaisedButton(
//              color: Colors.redAccent,
//              child: Text('Cancelar'),
//              onPressed: () {
//                Navigator.pop(context, false);
//              },
//            )
//          ],
//        )
//    );
//
//    if (response == true) {
//      Navigator.pop(context);
//    }
//  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildSurgeryInput(context),
              _buildDateInput(context),
              _buildByInput(context),
              _buildMedicalConditionInput(context),

              MySubmitButton(onPressed: () { _onCreate(context); }),

              _arguments['method'] != 'update' ? Container()
                  : _buildSelectImage(context),
            ],
          ),
        ),
      ),
    );
  }

  void _onCreate(context) {
    if (_formKey.currentState.validate()) {
      final surgery = Surgery(
        operation: _surgeryCtrl.text,
        operatingDoctor: _byCtrl.text,
        operationDate: DateFormat('yyyy-MM-dd').format(_date),
        patient: _patientProvider.object.id,
        historicalCondition: _conditionValue,
      );

      switch (_arguments['method']) {
        case 'create':
          _provider.create(surgery, (response) {
            _patientProvider.addMedicalSurgery(response);
            Navigator.pop(context);
          });
          break;

        case 'update':
          surgery.id = (_arguments['surgery'] as Surgery).id;
          _provider.update(surgery, (response) {
            _patientProvider.updateMedicalSurgery(response);
            Navigator.pop(context);
          });
          break;

        default:
          throw 'Not method selected on MedicalConditionCreateUpdateScreen';
      }
    }
  }

  Widget _buildSurgeryInput(context) {
    return MyTextFormField(
      label: 'Cirugía',
      ctrl: _surgeryCtrl,
      node: _surgeryNode,
      isEnabled: () => true,
      icon: Icon(Icons.pan_tool),
      submitted: (_) { _surgeryNode.unfocus(); },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'Este campo es requerido';
        }

        return null;
      },
    );
  }

  Widget _buildDateInput(context) {
    return MyDateTimePicker(
      dateTime: _date,
      onChange: (date) {
        setState(() {
          _date = date;
        });
      },
    );
  }

  Widget _buildByInput(context) {
    return MyTextFormField(
      label: 'Realizada por',
      ctrl: _byCtrl,
      node: _byNode,
      icon: Icon(Icons.person),
      isEnabled: () => true,
      submitted: (_) { _byNode.unfocus(); },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'Este campo es requerido';
        }

        return null;
      },
    );
  }

  Widget _buildMedicalConditionInput(context) {
    final items = _patientProvider.object.historicalConditions.map(
      (condition) => DropdownMenuItem(
        value: condition.id,
        child: Text(condition.condition),
      ),
    ).toList();

    return MyDropdownFormField(
      label: 'Padecimiento',
      icon: Icon(Icons.bug_report),
      value: _conditionValue,
      onChanged: (value) {
        setState(() { _conditionValue = value; });
      },

      items: [DropdownMenuItem(
        value: -1,
        child: Text(
          'Selecciona un padecimiento',
          style: TextStyle(color: Colors.grey),
        )
      )]..addAll(items),

      validator: (value) {
        if (value == -1)
          return 'Este valor es requerido';

        return null;
      },
    );
  }

  Widget _buildSelectImage(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),

      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Imagenes:', style: TextStyle(
                fontSize: 25.0,
                color: MyTheme.primary,
              )),

              DropdownButton<int>(
                icon: Icon(Icons.camera),
                iconSize: 25.0,
                underline: Container(),
                onChanged: _addImage,
                items: <DropdownMenuItem<int>>[
                  DropdownMenuItem(
                    value: 1,
                    child: Text('Camára'),
                  ),
                  DropdownMenuItem(
                    value: 2,
                    child: Text('Galería'),
                  ),
                ],
              ),
            ],
          ),
          _buildImages(BuildContext),
        ],
      ),
    );
  }

  void _addImage(value) async {
    ImageSource source;

    switch (value) {
      case 1:
        source = ImageSource.camera;
        break;

      case 2:
        source = ImageSource.gallery;
        break;
    }

    final image = await ImagePicker.pickImage(source: source);

    if (image != null) {
      Surgery surgery = _arguments['surgery'];
      _imageDBProvider.create(1, image, surgery.id, (response) {
        _patientProvider.addMedicalSurgeryImage(surgery.id, response);
      });
    }
  }

  Widget _buildImages(context) {
    Surgery surgery = _arguments['surgery'];

    if (surgery.images.isEmpty) {
      return Center(
        child: Text('No se han seleccionado imagenes'),
      );
    }

    return GridView.count(
      shrinkWrap: true,
      mainAxisSpacing: 5,
      crossAxisSpacing: 5,
      crossAxisCount: 3,
      children: surgery.images.map(
        (imageDB) => Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imageDB.file),
            ),
          ),
        ),
      ).toList(),
    );
  }
}
