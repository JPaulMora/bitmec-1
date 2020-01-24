import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:bitmec/components.dart';
import 'package:bitmec/providers.dart';
import 'package:bitmec/models.dart';

class MedicalConditionCreateUpdateScreen extends StatefulWidget {
  static const routeName = '/patient/detail/medical_condition/create';

  @override
  _MedicalConditionCreateUpdateScreenState createState() =>
      _MedicalConditionCreateUpdateScreenState();
}

class _MedicalConditionCreateUpdateScreenState
    extends State<MedicalConditionCreateUpdateScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();

  Map _arguments;
  MedicalConditionProvider _provider;
  PatientProvider _patientProvider;

  final _conditionCtrl = TextEditingController();
  final _conditionNode = FocusNode();

  DateTime _date = DateTime.now();

  final _byCtrl = TextEditingController();
  final _byNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    if (_arguments == null) {
      setState(() {
        _arguments = ModalRoute.of(context).settings.arguments;

        if (_arguments['method'] == 'update') {
          MedicalCondition medicalCondition = _arguments['medicalCondition'];
          _conditionCtrl.text = medicalCondition.condition;
          _date = DateTime.parse(medicalCondition.diagnosisDate);
          _byCtrl.text = medicalCondition.diagnosingDoctor;
        }
      });
    }

    if (_provider == null) {
      setState(() {
        _provider = MedicalConditionProvider.of(context);
      });
    }

    if (_patientProvider == null) {
      setState(() {
        _patientProvider = PatientProvider.of(context);
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
//      actions: _arguments['method'] != 'update' ? null
//        : <Widget>[
//          IconButton(
//            icon: Icon(Icons.delete),
//            tooltip: 'Eliminar',
//            onPressed: () { _confirmDelete(context); },
//          )
//      ],
    );
  }

  // TODO: implement delete condition and document attached
  void _confirmDelete(context) async {
    bool response = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Confirmar'),
          content: Text('¿Estas seguro de querer eliminar este dato?'),
          actions: <Widget>[
            FlatButton(
              splashColor: Colors.black12,
              child: Text('Aceptar'),
              onPressed: () {
                MedicalCondition medicalCondition = _arguments['medicalCondition'];
                _provider.remove(medicalCondition.id, (id) {
                  _patientProvider.removeMedicalCondition(id);
                  Navigator.pop(context, true);
                });
              },
            ),

            RaisedButton(
              color: Colors.redAccent,
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            )
          ],
        )
    );

    if (response == true) {
      Navigator.pop(context);
    }
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildConditionInput(context),
              _buildDateInput(context),
              _buildByInput(context),

              MySubmitButton(onPressed: () { _onCreate(context); }),
            ],
          ),
        ),
      ),
    );
  }

  void _onCreate(context) {
    if (_formKey.currentState.validate()) {
      final condition = MedicalCondition(
        condition: _conditionCtrl.text,
        diagnosingDoctor: _byCtrl.text,
        diagnosisDate: DateFormat('yyyy-MM-dd').format(_date),
        patient: _patientProvider.object.id,
      );

      switch (_arguments['method']) {
        case 'create':
          _provider.create(condition, (response) {
            _patientProvider.addMedicalCondition(response);
            Navigator.pop(context);
          });
          break;

        case 'update':
          condition.id = (_arguments['medicalCondition'] as MedicalCondition).id;
          _provider.update(condition, (response) {
            _patientProvider.updateMedicalCondition(response);
            Navigator.pop(context);
          });
          break;

        default:
          throw 'Not method selected on MedicalConditionCreateUpdateScreen';
      }
    }
  }

  Widget _buildConditionInput(BuildContext context) {
    return MyTextFormField(
      label: 'Padecimiento',
      ctrl: _conditionCtrl,
      node: _conditionNode,
      isEnabled: () => true,
      icon: Icon(Icons.short_text),
      submitted: (_) { _conditionNode.unfocus(); },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'El padecimiento es requerido';
        }

        return null;
      },
    );
  }

  Widget _buildDateInput(BuildContext context) {
    return MyDateTimePicker(
      dateTime: _date,
      onChange: (date) {
        setState(() {
          _date = date;
        });
      },
    );
  }

  Widget _buildByInput(BuildContext context) {
    return MyTextFormField(
      label: 'Diagnosticado por',
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
}
