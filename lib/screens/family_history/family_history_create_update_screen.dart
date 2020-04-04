import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:bitmec/components.dart';
import 'package:bitmec/models.dart';
import 'package:bitmec/providers.dart';

class FamilyHistoryCreateUpdateScreen extends StatefulWidget {
  static const routeName = '/patient/detail/family_history/create_update';

  @override
  _FamilyHistoryCreateUpdateScreenState createState() =>
      _FamilyHistoryCreateUpdateScreenState();
}

class _FamilyHistoryCreateUpdateScreenState
    extends State<FamilyHistoryCreateUpdateScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();

  Map _arguments;
  FamilyHistoryProvider _provider;
  PatientProvider _patientProvider;

  final _relationshipCtrl = TextEditingController();
  final _relationshipNode = FocusNode();

  final _conditionCtrl = TextEditingController();
  final _conditionNode = FocusNode();

  var _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    if (_arguments == null) {
      setState(() {
        _arguments = ModalRoute.of(context).settings.arguments;

        if (_arguments['method'] == 'update') {
          FamilyMemberCondition member = _arguments['member'];
          _relationshipCtrl.text = member.relative;
          _conditionCtrl.text = member.condition;
          _date = member.dateDiagnosed == null ? _date
              : DateTime.parse(member.dateDiagnosed);
        }
      });
    }

    if (_provider == null) {
      setState(() {
        _provider = FamilyHistoryProvider.of(context);
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
      title: notUpdating ? 'Crear Historial Familiar' : 'Actualizar Historial Familiar',
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
              FamilyMemberCondition member = _arguments['member'];
              _provider.remove(member.id, (id) {
                _patientProvider.removeFamilyMember(id);
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
      ),
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
              _relationshipInput(context),
              _conditionInput(context),
              _dateInput(context),

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

      final member = FamilyMemberCondition(
        relative: _relationshipCtrl.text,
        condition: _conditionCtrl.text,
        dateDiagnosed: formatter.format(_date),
        patient: _patientProvider.object.id,
      );

      switch (_arguments['method']) {
        case 'create':
          _provider.create(member, (response) {
            _patientProvider.addFamilyMember(response);
            Navigator.pop(context);
          });
          break;

        case 'update':
          member.id = (_arguments['member'] as FamilyMemberCondition).id;
          _provider.update(member, (response) {
            _patientProvider.updateFamilyMember(response);
            Navigator.pop(context);
          });
          break;

        default:
          throw 'Not method selected on MedicalConditionCreateUpdateScreen';
      }
    }
  }

  Widget _relationshipInput(BuildContext context) {
    return MyTextFormField(
      label: 'Relación',
      icon: Icon(Icons.face),
      ctrl: _relationshipCtrl,
      node: _relationshipNode,
      isEnabled: () => true,
      submitted: (_) {
        _relationshipNode.unfocus();
        FocusScope.of(context).requestFocus(_conditionNode);
      },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'La relación es requerida';
        }

        return null;
      },
    );
  }

  Widget _conditionInput(BuildContext context) {
    return MyTextFormField(
      label: 'Condición',
      icon: Icon(Icons.bug_report),
      ctrl: _conditionCtrl,
      node: _conditionNode,
      isEnabled: () => true,
      submitted: (_) { _conditionNode.unfocus(); },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'Este campo es requerido';
        }

        return null;
      },
    );
  }

  Widget _dateInput(BuildContext context) {
    return MyDateTimePicker(
      dateTime: _date,
      onChange: (date) {
        setState(() {
          _date = date;
        });
      },
    );
  }
}
