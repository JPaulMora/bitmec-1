import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:bitmec/components.dart';
import 'package:bitmec/providers.dart';
import 'package:bitmec/models.dart';

class BirthControlCreateUpdateScreen extends StatefulWidget {
  static const routeName = '/medical_history/contraceptive/create_update';

  @override
  _BirthControlCreateUpdateScreenState createState() =>
      _BirthControlCreateUpdateScreenState();
}

class _BirthControlCreateUpdateScreenState
    extends State<BirthControlCreateUpdateScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();

  Map _arguments;
  BirthControlProvider _provider;
  PatientProvider _patientProvider;

  final _methodCtrl = TextEditingController();
  final _methodNode = FocusNode();

  var _startDate = DateTime.now();
  var _endDate = DateTime.now();

  final _byCtrl = TextEditingController();
  final _byNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    if (_arguments == null) {
      setState(() {
        _arguments = ModalRoute.of(context).settings.arguments;

        if (_arguments['method'] == 'update') {
          BirthControl contraceptive = _arguments['contraceptive'];
          _methodCtrl.text = contraceptive.method;
          _startDate = DateTime.parse(contraceptive.methodStartDate);
          _endDate = DateTime.parse(contraceptive.methodEndDate);
          _byCtrl.text = contraceptive.prescribingDoctor;
        }
      });
    }

    if (_provider == null) {
      setState(() {
        _provider = BirthControlProvider.of(context);
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
    final notUpdating = _arguments['method'] != 'update';

    return MyAppBar(
      title: notUpdating ? 'Crear Anticonceptivo' : 'Actualizar Anticonceptivo',
      scaffoldKey: _scaffoldKey,
      backLeading: true,
      actions: notUpdating ? null : [
        IconButton(
          icon: Icon(Icons.delete),
          tooltip: 'Eliminar',
          onPressed: () { _confirmDelete(context); },
        ),
      ],
    );
  }

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
              BirthControl contraceptive = _arguments['contraceptive'];
              _provider.remove(contraceptive.id, (id) {
                _patientProvider.removeBirthControl(id);
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
              _methodInput(context),
              _startDateInput(context),
              _endDateInput(context),
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
      final formatter = DateFormat('yyyy-MM-dd');

      final contraceptive = BirthControl(
        method: _methodCtrl.text,
        methodStartDate: formatter.format(_startDate),
        methodEndDate: formatter.format(_endDate),
        prescribingDoctor: _byCtrl.text,
        patient: _patientProvider.object.id,
      );

      switch (_arguments['method']) {
        case 'create':
          _provider.create(contraceptive, (response) {
            _patientProvider.addBirthControl(response);
            Navigator.pop(context);
          });
          break;

        case 'update':
          contraceptive.id = (_arguments['contraceptive'] as BirthControl).id;
          _provider.update(contraceptive, (response) {
            _patientProvider.updateBirthControl(response);
            Navigator.pop(context);
          });
          break;

        default:
          throw 'Not method selected on MedicalConditionCreateUpdateScreen';
      }
    }
  }

  Widget _methodInput(context) {
    return MyTextFormField(
      label: 'Anticonceptivo',
      ctrl: _methodCtrl,
      node: _methodNode,
      isEnabled: () => true,
      icon: Icon(Icons.short_text),
      submitted: (_) { _methodNode.unfocus(); },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'Este campo es requerido';
        }

        return null;
      },
    );
  }

  Widget _startDateInput(BuildContext context) {
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
