import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:bitmec/components.dart';
import 'package:bitmec/models.dart';
import 'package:bitmec/providers.dart';

class HabitCreateUpdateScreen extends StatefulWidget {
  static const routeName = '/medical_history/habit/create_update';

  @override
  _HabitCreateUpdateScreenState createState() =>
      _HabitCreateUpdateScreenState();
}

class _HabitCreateUpdateScreenState extends State<HabitCreateUpdateScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();

  Map _arguments;
  HabitProvider _provider;
  PatientProvider _patientProvider;

  final _habitCtrl = TextEditingController();
  final _habitNode = FocusNode();

  var _startDate = DateTime.now();
  var _endDate = DateTime.now();

  final _quantityCtrl = TextEditingController();
  final _quantityNode = FocusNode();

  final _frequencyCtrl = TextEditingController();
  final _frequencyNode = FocusNode();

  final _methodCtrl = TextEditingController();
  final _methodNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    if (_arguments == null) {
      setState(() {
        _arguments = ModalRoute.of(context).settings.arguments;

        if (_arguments['method'] == 'update') {
          Habit habit = _arguments['data'];
          _habitCtrl.text = habit.habit;
          _startDate = habit.habitStartDate != null
              ? DateTime.parse(habit.habitStartDate)
              : _startDate;
          _endDate = habit.habitEndDate != null
              ? DateTime.parse(habit.habitEndDate)
              : _endDate;
          _quantityCtrl.text = habit.quantity;
          _frequencyCtrl.text = habit.frequency;
          _methodCtrl.text = habit.intakeMethods;
        }
      });
    }

    if (_provider == null) {
      setState(() {
        _provider = HabitProvider.of(context);
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
      title: notUpdating ? 'Crear Hábito' : 'Actualizar Hábito',
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
              Habit habit = _arguments['data'];
              _provider.remove(habit.id, (id) {
                _patientProvider.removeHabit(id);
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
              _habitInput(context),
              _startDateInput(context),
              _endDateInput(context),
              _quantityInput(context),
              _frequencyInput(context),
              _methodInput(context),

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

      final habit = Habit(
        habit: _habitCtrl.text,
        habitStartDate: formatter.format(_startDate),
        habitEndDate: formatter.format(_endDate),
        quantity: _quantityCtrl.text,
        frequency: _frequencyCtrl.text,
        intakeMethods: _methodCtrl.text,
        patient: _patientProvider.object.id,
      );

      switch (_arguments['method']) {
        case 'create':
          _provider.create(habit, (response) {
            _patientProvider.addHabit(response);
            Navigator.pop(context);
          });
          break;

        case 'update':
          habit.id = (_arguments['data'] as Habit).id;
          _provider.update(habit, (response) {
            _patientProvider.updateHabit(response);
            Navigator.pop(context);
          });
          break;

        default:
          throw 'Not method selected on MedicalConditionCreateUpdateScreen';
      }
    }
  }

  Widget _habitInput(BuildContext context) {
    return MyTextFormField(
      label: 'Hábito',
      icon: Icon(Icons.web_asset),
      ctrl: _habitCtrl,
      node: _habitNode,
      isEnabled: () => true,
      submitted: (_) { _habitNode.unfocus(); },
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

  Widget _quantityInput(context) {
    return MyTextFormField(
      label: 'Cantidad',
      icon: Icon(Icons.web_asset),
      ctrl: _quantityCtrl,
      node: _quantityNode,
      isEnabled: () => true,
      submitted: (_) {
        _quantityNode.unfocus();
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
      label: 'Frecuencia',
      icon: Icon(Icons.web_asset),
      ctrl: _frequencyCtrl,
      node: _frequencyNode,
      isEnabled: () => true,
      submitted: (_) {
        _frequencyNode.unfocus();
        FocusScope.of(context).requestFocus(_methodNode);
      },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'Este campo es requerido';
        }

        return null;
      },
    );
  }

  Widget _methodInput(context) {
    return MyTextFormField(
      label: 'Método',
      icon: Icon(Icons.web_asset),
      ctrl: _methodCtrl,
      node: _methodNode,
      isEnabled: () => true,
      submitted: (_) { _methodNode.unfocus(); },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'Este campo es requerido';
        }

        return null;
      },
    );
  }
}
