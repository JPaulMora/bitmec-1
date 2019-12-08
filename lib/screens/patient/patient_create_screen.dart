import 'package:flutter/material.dart';

import 'package:bitmec/components/form/form_components.dart';

class PatientCreateScreen extends StatefulWidget {
  static const routeName = '/patient/create';

  @override
  _PatientCreateScreenState createState() => _PatientCreateScreenState();
}

class _PatientCreateScreenState extends State<PatientCreateScreen> {
  final _nameCtrl = TextEditingController();
  final _nameNode = FocusNode();

  final _lastNameCtrl = TextEditingController();
  final _lastNameNode = FocusNode();

  final _bornDateCtrl = TextEditingController();
  final _bornDateNode = FocusNode();

  int _genderValue = -1;

  final _cuiCtrl = TextEditingController();
  final _cuiNode = FocusNode();

  final _phoneCtrl = TextEditingController();
  final _phoneNode = FocusNode();

  final _countryCtrl = TextEditingController();
  final _countryNode = FocusNode();

  int _departmentValue = -1;

  final _cityCtrl = TextEditingController();
  final _cityNode = FocusNode();

  final _addressCtrl = TextEditingController();
  final _addressNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _nameCtrl.text = 'Hello World';
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _lastNameCtrl.dispose();
    _bornDateCtrl.dispose();
    _cuiCtrl.dispose();
    _phoneCtrl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Añadir'),
          centerTitle: true,
        ),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        child: Column(
          children: <Widget>[
            _buildNameInput(context),
            _buildLastNameInput(context),
            _buildBornDateInput(context),
            _buildGenderInput(context),
            _buildCUIInput(context),
            _buildPhoneInput(context),
            _buildCountryInput(context),
            _buildDepartmentInput(context),
            _buildCityInput(context),
            _buildAddressInput(context),
            _buildSubmitButton(context),
            Padding(padding: const EdgeInsets.only(bottom: 15.0))
          ],
        ),
      ),
    );
  }

  Widget _buildNameInput(BuildContext context) {
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

  Widget _buildLastNameInput(BuildContext context) {
    return MyTextFormField(
      label: 'Apellido',
      ctrl: _lastNameCtrl,
      node: _lastNameNode,
      isEnabled: () => true,
      icon: Icon(Icons.person_outline),
      submitted: (value) {
        _lastNameNode.unfocus();
        FocusScope.of(context).requestFocus(_bornDateNode);
      },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'El apellido es requerido';
        }

        return null;
      },
    );
  }

  Widget _buildBornDateInput(BuildContext context) {
    return MyTextFormField(
      label: 'Fecha de Nacimiento',
      ctrl: _bornDateCtrl,
      node: _bornDateNode,
      isEnabled: () => true,
      icon: Icon(Icons.date_range),
      submitted: (value) {
        _bornDateNode.unfocus();
      },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'La fecha de nacimieno es requerida';
        }

        return null;
      },
    );
  }

  Widget _buildGenderInput(BuildContext context) {
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

  Widget _buildCUIInput(BuildContext context) {
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

  Widget _buildPhoneInput(BuildContext context) {
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

  Widget _buildCountryInput(BuildContext context) {
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

  Widget _buildDepartmentInput(BuildContext context) {
    return MyDropdownFormField(
      label: 'Departamento',
      icon: Icon(Icons.business),
      value: _departmentValue,
      items: [
        DropdownMenuItem(
            value: -1,
            child: Text('Selecciona un género', style: TextStyle(
              color: Colors.grey,
            ))
        ),
        DropdownMenuItem(value: 1, child: Text('Alta Verapaz')),
        DropdownMenuItem(value: 2, child: Text('Baja Verapaz')),
        DropdownMenuItem(value: 3, child: Text('Chimaltenango')),
        DropdownMenuItem(value: 4, child: Text('Chiquimula')),
        DropdownMenuItem(value: 5, child: Text('El Progreso')),
        DropdownMenuItem(value: 6, child: Text('El Quiché')),
        DropdownMenuItem(value: 7, child: Text('Escuintla')),
        DropdownMenuItem(value: 8, child: Text('Guatemala')),
        DropdownMenuItem(value: 9, child: Text('Huehuetenango')),
        DropdownMenuItem(value: 10, child: Text('Izabal')),
        DropdownMenuItem(value: 11, child: Text('Jalapa')),
        DropdownMenuItem(value: 12, child: Text('Jutiapa')),
        DropdownMenuItem(value: 13, child: Text('Péten')),
        DropdownMenuItem(value: 14, child: Text('Quetzaltenango')),
        DropdownMenuItem(value: 15, child: Text('Retalhuleu')),
        DropdownMenuItem(value: 16, child: Text('Sacatepequez')),
        DropdownMenuItem(value: 17, child: Text('San Marcos')),
        DropdownMenuItem(value: 18, child: Text('Santa Rosa')),
        DropdownMenuItem(value: 19, child: Text('Sololá')),
        DropdownMenuItem(value: 20, child: Text('Suchitepequez')),
        DropdownMenuItem(value: 21, child: Text('Totonicapán')),
        DropdownMenuItem(value: 22, child: Text('Zacapa')),
      ],

      validator: (value) {
        if (value == -1) {
          return 'El género es requerido';
        }

        return null;
      },

      onChanged: (value) {
        setState(() { _departmentValue = value; });
      },
    );
  }

  Widget _buildCityInput(BuildContext context) {
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

  Widget _buildAddressInput(BuildContext context) {
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

  Widget _buildSubmitButton(BuildContext context) {
    return MySubmitButton(
      label: 'Guardar',
      onPressed: () {},
    );
  }
}
