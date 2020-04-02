import 'package:bitmec/models.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:bitmec/components.dart';
import 'package:bitmec/providers.dart';

class PatientEditScreen extends StatefulWidget {
  static const routeName = '/patient/edit';

  @override
  _PatientEditScreenState createState() => _PatientEditScreenState();
}

class _PatientEditScreenState extends State<PatientEditScreen> {
  final _formKey = GlobalKey<FormState>();

  PatientProvider _provider;

  final _nameCtrl = TextEditingController();
  final _nameNode = FocusNode();

  final _lastNameCtrl = TextEditingController();
  final _lastNameNode = FocusNode();

  var _bornDate = DateTime.now();

  var _genderValue = -1;

  final _cuiCtrl = TextEditingController();
  final _cuiNode = FocusNode();

  final _phoneCtrl = TextEditingController();
  final _phoneNode = FocusNode();

  final _countryCtrl = TextEditingController();
  final _countryNode = FocusNode();

  var _departmentValue = 'Selecciona un género';

  final _cityCtrl = TextEditingController();
  final _cityNode = FocusNode();

  final _addressCtrl = TextEditingController();
  final _addressNode = FocusNode();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _lastNameCtrl.dispose();
    _cuiCtrl.dispose();
    _phoneCtrl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_provider == null) {
      setState(() {
        _provider = PatientProvider.of(context);

        _nameCtrl.text = _provider.object.firstName;
        _lastNameCtrl.text = _provider.object.lastName;
        _bornDate = DateTime.parse(_provider.object.birthDate);
        _genderValue = _provider.object.gender ? 0 : 1;
        _cuiCtrl.text = _provider.object.governmentId;
        _phoneCtrl.text = _provider.object.phoneNumber;
        _countryCtrl.text = _provider.object.country;
        _departmentValue = _provider.object.state;
        _cityCtrl.text = _provider.object.city;
        _addressCtrl.text = _provider.object.city;
      });
    }

    return Scaffold(
      appBar: AppBar(title: Text('Editar'), centerTitle: true),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _nameInput(context),
              _lastNameInput(context),
              _bornDateInput(context),
              _genderInput(context),
              _cuiInput(context),
              _phoneInput(context),
              _countryInput(context),
              _departmentInput(context),
              _cityInput(context),
              _addressInput(context),
              MySubmitButton(onPressed: () { _onCreate(context); })
            ],
          ),
        ),
      ),
    );
  }

  void _onCreate(context) {
    if (_formKey.currentState.validate()) {
      final formatter = DateFormat('yyyy-MM-dd');

      final patient = Patient(
        id: _provider.object.id,
        firstName: _nameCtrl.text,
        lastName: _lastNameCtrl.text,
        birthDate: formatter.format(_bornDate),
        gender: _genderValue == 1 ? true : false,
        governmentId: _cuiCtrl.text,
        phoneNumber: _phoneCtrl.text,
        country: _countryCtrl.text,
        state: _departmentValue,
        city: _cityCtrl.text,
        address: _addressCtrl.text,
        alive: _provider.object.alive,
        active: _provider.object.active,
        birthControls: _provider.object.birthControls,
        consultations: _provider.object.consultations,
        familyMembers: _provider.object.familyMembers,
        habits: _provider.object.habits,
        historicalConditions: _provider.object.historicalConditions,
        historicalOperations: _provider.object.historicalOperations,
        historicalPrescriptions: _provider.object.historicalPrescriptions,
        reproductiveHistory: _provider.object.reproductiveHistory,
        profilePicture: _provider.object.profilePicture,
      );

      // TODO: fix update method
    }
  }

  Widget _nameInput(context) {
    return MyTextFormField(
      label: 'Nombre',
      ctrl: _nameCtrl,
      node: _nameNode,
      isEnabled: () => true,
      icon: Icon(Icons.person_outline),
      submitted: (value) {
        _nameNode.unfocus();
        FocusScope.of(context).requestFocus(_lastNameNode);
      },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'El nombre es requerido';
        }

        return null;
      },
    );
  }

  Widget _lastNameInput(context) {
    return MyTextFormField(
      label: 'Apellido',
      ctrl: _lastNameCtrl,
      node: _lastNameNode,
      isEnabled: () => true,
      icon: Icon(Icons.person_outline),
      submitted: (value) { _lastNameNode.unfocus(); },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'El apellido es requerido';
        }

        return null;
      },
    );
  }

  Widget _bornDateInput(context) {
    return MyDateTimePicker(
      dateTime: _bornDate,
      onChange: (date) {
        setState(() {
          _bornDate = date;
        });
      },
    );
  }

  Widget _genderInput(context) {
    return MyDropdownFormField(
      label: 'Genero',
      icon: Icon(Icons.child_care),
      value: _genderValue,
      items: [
        DropdownMenuItem(
          value: -1,
          child: Text('Selecciona un género', style: TextStyle(
            color: Colors.grey,
          ))
        ),
        DropdownMenuItem(value: 0, child: Text('Masculino')),
        DropdownMenuItem(value: 1, child: Text('Femenino')),
      ],

      validator: (value) {
        if (value == -1) {
          return 'El género es requerido';
        }

        return null;
      },

      onChanged: (value) {
        setState(() { _genderValue = value; });
      },
    );
  }

  Widget _cuiInput(context) {
    return MyTextFormField(
      label: 'CUI',
      ctrl: _cuiCtrl,
      node: _cuiNode,
      isEnabled: () => true,
      icon: Icon(Icons.perm_identity),
      keyboardType: TextInputType.number,
      submitted: (value) {
        _cuiNode.unfocus();
        FocusScope.of(context).requestFocus(_phoneNode);
      },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'El nombre CUI es requerido';
        }

        return null;
      },
    );
  }

  Widget _phoneInput(context) {
    return MyTextFormField(
      label: 'Teléfono',
      ctrl: _phoneCtrl,
      node: _phoneNode,
      isEnabled: () => true,
      icon: Icon(Icons.phone),
      keyboardType: TextInputType.number,
      submitted: (value) {
        _phoneNode.unfocus();
      },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'El nombre teléfono es requerido';
        }

        return null;
      },
    );
  }

  Widget _countryInput(context) {
    return MyTextFormField(
      label: 'País',
      ctrl: _countryCtrl,
      node: _countryNode,
      isEnabled: () => true,
      icon: Icon(Icons.filter_b_and_w),
      submitted: (value) {
        _countryNode.unfocus();
      },

      validator: (value) {
        if (value.trim().isEmpty) {
          return 'El país es requerido';
        }

        return null;
      },
    );
  }

  Widget _departmentInput(context) {
    return MyDropdownFormField(
      label: 'Departamento',
      icon: Icon(Icons.business),
      value: _departmentValue,
      items: [
        'Selecciona un género',
        'Alta Verapaz',
        'Baja Verapaz',
        'Chimaltenango',
        'Chiquimula',
        'El Progreso',
        'El Quiché',
        'Escuintla',
        'Guatemala',
        'Huehuetenango',
        'Izabal',
        'Jalapa',
        'Jutiapa',
        'Péten',
        'Quetzaltenango',
        'Retalhuleu',
        'Sacatepequez',
        'San Marcos',
        'Santa Rosa',
        'Sololá',
        'Suchitepequez',
        'Totonicapán',
        'Zacapa',
      ].map((t) => DropdownMenuItem(
        value: t,
        child: Text(t),
      )).toList(),

      validator: (value) {
        if (value == -1) {
          return 'El departamento es requerido';
        }

        return null;
      },

      onChanged: (value) {
        setState(() { _departmentValue = value; });
      },
    );
  }

  Widget _cityInput(context) {
    return MyTextFormField(
      label: 'Ciudad',
      ctrl: _cityCtrl,
      node: _cityNode,
      isEnabled: () => true,
      icon: Icon(Icons.location_city),
      submitted: (value) {
        _cityNode.unfocus();
        FocusScope.of(context).requestFocus(_addressNode);
      },

      validator: (value) {
        if (value.trim().isEmpty) {
          return 'El ciudad es requerida';
        }

        return null;
      },
    );
  }

  Widget _addressInput(context) {
    return MyTextFormField(
      label: 'Dirección',
      ctrl: _addressCtrl,
      node: _addressNode,
      isEnabled: () => true,
      icon: Icon(Icons.location_city),
      submitted: (value) {
        _addressNode.unfocus();
      },

      validator: (value) {
        if (value.trim().isEmpty) {
          return 'La dirección es requerida';
        }

        return null;
      },
    );
  }
}
