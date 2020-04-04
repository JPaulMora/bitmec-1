import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:bitmec/components.dart';
import 'package:bitmec/models.dart';
import 'package:bitmec/providers.dart';

class AppointmentCreateUpdateScreen extends StatefulWidget {
  static const routeName = '/appointment/create_update';

  @override
  _AppointmentCreateUpdateScreenState createState() =>
      _AppointmentCreateUpdateScreenState();
}

class _AppointmentCreateUpdateScreenState extends State<AppointmentCreateUpdateScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();

  Map _arguments;
  AppointmentProvider _provider;
  PatientProvider _patientProvider;

  var _date = DateTime.now();

  int _consultationValue = -1;
  String _typeValue = 'PC';

  @override
  Widget build(BuildContext context) {
    if (_arguments == null) {
      setState(() {
        _arguments = ModalRoute.of(context).settings.arguments;

        if (_arguments['method'] == 'update') {
          Appointment appointment = _arguments['data'];
          _date = appointment.scheduled == null ? _date
              : DateTime.parse(appointment.scheduled);
          _consultationValue = appointment.consultation.id;
          _typeValue = appointment.appointmentType;
        }
      });
    }

    if (_provider == null) {
      setState(() {
        _provider = AppointmentProvider.of(context);
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
      title: notUpdating ? 'Crear Consulta' : 'Actualizar Consulta',
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
              Appointment appointment = _arguments['data'];
              _provider.remove(appointment.id, (id) {
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
              _dateInput(context),
              _consultationInput(context),
              _typeInput(context),

              MySubmitButton(onPressed: () { _onCreate(context); }),
            ],
          ),
        ),
      ),
    );
  }

  void _onCreate(context) {
    if (_formKey.currentState.validate()) {
      final formatter = DateFormat('yyyy-MM-dd hh:mm');

      final appointment = Appointment(
        scheduled: formatter.format(_date),
        appointmentType: _typeValue,
        consultation: _patientProvider.object.consultations.firstWhere((e) => _consultationValue == e.id),
        patient: _patientProvider.object,
      );

      switch (_arguments['method']) {
        case 'create':
          _provider.create(appointment, (response) {
            Navigator.pop(context);
          });
          break;

        case 'update':
          appointment.id = (_arguments['data'] as Appointment).id;
          _provider.update(appointment, (response) {
            Navigator.pop(context);
          });
          break;

        default:
          throw 'Not method selected on MedicalConditionCreateUpdateScreen';
      }
    }
  }

  Widget _dateInput(context) {
    return MyDateTimePicker(
      dateTime: _date,
      label: 'Fecha y Hora',
      timePicker: true,
      onChange: (date) {
        setState(() {
          _date = date;
        });
      },
    );
  }

  Widget _consultationInput(context) {
    final items = _patientProvider.object.consultations.map(
      (c) => DropdownMenuItem(
        value: c.id,
        child: Text(c.name),
      ),
    ).toList();

    return MyDropdownFormField(
      label: 'Consulta',
      icon: Icon(Icons.insert_drive_file),
      value: _consultationValue,
      onChanged: (value) {
        setState(() {
          _consultationValue = value;
        });
      },

      items: [DropdownMenuItem(
        value: -1,
        child: Text('Selecciona una consulta', style: TextStyle(color: Colors.grey)),
      )]..addAll(items),

      validator: (value) {
        if (value == -1) {
          return 'Este campo es requerido';
        }

        return null;
      },
    );
  }

  Widget _typeInput(context) {
    return MyDropdownFormField(
      label: 'Tipo',
      icon: Icon(Icons.merge_type),
      value: _typeValue,
      onChanged: (value) {
        setState(() {
          _typeValue = value;
        });
      },

      items: [
        DropdownMenuItem(value: 'PC', child: Text('Primer Consulta')),
        DropdownMenuItem(value: 'S', child: Text('Seguimiento')),
        DropdownMenuItem(value: 'E', child: Text('Emergencia')),
      ],

      validator: (_) => null,
    );
  }
}
