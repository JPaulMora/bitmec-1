import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

import 'package:bitmec/my_theme.dart';
import 'package:bitmec/components.dart';
import 'package:bitmec/providers.dart';
import 'package:bitmec/models.dart';

class MedicalPrescriptionCreateUpdateScreen extends StatefulWidget {
  static const routeName = '/medical_history/medical_prescription/create_update';

  @override
  _MedicalPrescriptionCreateUpdateScreenState createState() =>
      _MedicalPrescriptionCreateUpdateScreenState();
}

class _MedicalPrescriptionCreateUpdateScreenState
    extends State<MedicalPrescriptionCreateUpdateScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();

  Map _arguments;
  MedicalPrescriptionProvider _provider;
  PatientProvider _patientProvider;
  ImageDBProvider _imageDBProvider;

  final _medicineCtrl = TextEditingController();
  final _medicineNode = FocusNode();

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  final _doseCtrl = TextEditingController();
  final _doseNode = FocusNode();

  final _frequencyCtrl = TextEditingController();
  final _frequencyNode = FocusNode();

  final _byCtrl = TextEditingController();
  final _byNode = FocusNode();

  int _conditionValue = -1;
  int _surgeryValue = -1;

  @override
  Widget build(BuildContext context) {
    if (_arguments == null) {
      setState(() {
        _arguments = ModalRoute.of(context).settings.arguments;

        if (_arguments['method'] == 'update') {
          Prescription prescription = _arguments['prescription'];
          _medicineCtrl.text = prescription.drug;
          _startDate = DateTime.parse(prescription.prescriptionStartDate);
          _endDate = DateTime.parse(prescription.prescriptionEndDate);
          _byCtrl.text = prescription.prescribingDoctor;
          _conditionValue = prescription.historicalCondition ?? -1;
          _surgeryValue = prescription.historicalOperation ?? -1;
        }
      });
    }

    if (_provider == null) {
      setState(() {
        _provider = MedicalPrescriptionProvider.of(context);
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
      title: _arguments['method'] != 'update' ? 'Crear Medicamento' : 'Actualizar Medicamento',
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
              _medicineInput(context),
              _startDateInput(context),
              _endDateInput(context),
              _doseInput(context),
              _frequencyInput(context),
              _byInput(context),
              _medicalConditionInput(context),
              _medicalOperationInput(context),

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
      final prescription = Prescription(
        drug: _medicineCtrl.text,
        prescriptionStartDate: DateFormat('yyyy-MM-dd').format(_startDate),
        prescriptionEndDate: DateFormat('yyyy-MM-dd').format(_endDate),
        dose: _doseCtrl.text,
        frequency: _frequencyCtrl.text,
        prescribingDoctor: _byCtrl.text,
        patient: _patientProvider.object.id,
        historicalCondition: _conditionValue,
        historicalOperation: _surgeryValue,
      );

      switch (_arguments['method']) {
        case 'create':
          _provider.create(prescription, (response) {
            _patientProvider.addMedicalPrescription(response);
            Navigator.pop(context);
          });
          break;

        case 'update':
          prescription.id = (_arguments['prescription'] as Prescription).id;
          _provider.update(prescription, (response) {
            _patientProvider.updateMedicalPrescription(response);
            Navigator.pop(context);
          });
          break;

        default:
          throw 'Not method selected on MedicalPrescriptionCreateUpdateScreen';
      }
    }
  }

  Widget _medicineInput(context) {
    return MyTextFormField(
      label: 'Medicamento',
      ctrl: _medicineCtrl,
      node: _medicineNode,
      isEnabled: () => true,
      icon: Icon(Icons.mode_edit),
      submitted: (_) { _medicineNode.unfocus(); },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'Este campo es requerido';
        }

        return null;
      },
    );
  }

  Widget _startDateInput(context) {
    return MyDateTimePicker(
      dateTime: _startDate,
      label: 'Fecha de Inicio',
      onChange: (date) {
        setState(() {
          _startDate = date;
        });
      },
    );
  }

  Widget _endDateInput(context) {
    return MyDateTimePicker(
      dateTime: _endDate,
      label: 'Fecha de Fin',
      onChange: (date) {
        setState(() {
          _endDate = date;
        });
      },
    );
  }

  Widget _doseInput(context) {
    return MyTextFormField(
      label: 'Dosis',
      ctrl: _doseCtrl,
      node: _doseNode,
      icon: Icon(Icons.view_stream),
      isEnabled: () => true,
      submitted: (_) {
        _doseNode.unfocus();
        FocusScope.of(context).requestFocus(_frequencyNode);
      },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'Este campo es requerido';
        }

        return null;
      },
    );
  }

  Widget _frequencyInput(context) {
    return MyTextFormField(
      label: 'Realizada por',
      ctrl: _frequencyCtrl,
      node: _frequencyNode,
      icon: Icon(Icons.list),
      isEnabled: () => true,
      submitted: (_) {
        _frequencyNode.unfocus();
        FocusScope.of(context).requestFocus(_byNode);
      },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'Este campo es requerido';
        }

        return null;
      },
    );
  }

  Widget _byInput(context) {
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

  Widget _medicalConditionInput(context) {
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
          'Selecciona un género',
          style: TextStyle(color: MyTheme.grey),
        )
      )]..addAll(items),

      validator: (value) {
        if (value == -1)
          return 'Este valor es requerido';

        return null;
      },
    );
  }

  Widget _medicalOperationInput(context) {
    final items = _patientProvider.object.historicalOperations.map(
      (surgery) => DropdownMenuItem(
        value: surgery.id,
        child: Text(surgery.operation),
      ),
    ).toList();

    return MyDropdownFormField(
      label: 'Cirugias',
      icon: Icon(Icons.security),
      value: _surgeryValue,
      onChanged: (value) {
        setState(() {
          _surgeryValue = value;
        });
      },

      items: [DropdownMenuItem(
        value: -1,
        child: Text(
          'Selecciona un género',
          style: TextStyle(color: MyTheme.grey),
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
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
      Prescription prescription = _arguments['prescription'];
      _imageDBProvider.create(2, image, prescription.id, (response) {
        _patientProvider.addMedicalPrescriptionImage(prescription.id, response);
      });
    }
  }

  Widget _buildImages(context) {
    Prescription prescription = _arguments['prescription'];

    if (prescription.images.isEmpty) {
      return Center(
        child: Text('No se han seleccionado imagenes'),
      );
    }

    return GridView.count(
      shrinkWrap: true,
      mainAxisSpacing: 5,
      crossAxisSpacing: 5,
      crossAxisCount: 3,
      children: prescription.images.map(
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
