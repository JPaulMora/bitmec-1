import 'package:flutter/material.dart';

import 'package:bitmec/components/my_app_bar.dart';
import 'package:bitmec/components/form/form_components.dart';

class PatientDetailDependentCreateScreen extends StatefulWidget {
  static const routeName = '/patient/detail/dependent/create';

  @override
  _PatientDetailDependentCreateScreenState createState() =>
      _PatientDetailDependentCreateScreenState();
}

class _PatientDetailDependentCreateScreenState
    extends State<PatientDetailDependentCreateScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _relationshipCtrl = TextEditingController();
  final _relationshipNode = FocusNode();

  int _dependentValue = -1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return MyAppBar(
      title: 'Crear',
      scaffoldKey: _scaffoldKey,
      backLeading: true,
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        child: Column(
          children: <Widget>[
            _buildRelationshipInput(context),
            _buildDependentInput(context),

            MySubmitButton(label: 'Guardar', onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildRelationshipInput(BuildContext context) {
    return MyTextFormField(
      label: 'Hábito',
      ctrl: _relationshipCtrl,
      node: _relationshipNode,
      isEnabled: () => true,
      submitted: (_) {
        _relationshipNode.unfocus();
      },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'La relación es requerida';
        }

        return null;
      },
    );
  }

  Widget _buildDependentInput(BuildContext context) {
    return MyDropdownFormField(
      label: 'Dependent',
      icon: Icon(Icons.person),
      value: _dependentValue,

      validator: (value) {
        if (value == -1) {
          return 'Este campo es requerido';
        }

        return null;
      },

      onChanged: (value) {
        setState(() {
          _dependentValue = value;
        });
      },

      items: [
        DropdownMenuItem(
          value: -1,
          child: Text(
            'Selecciona un género',
            style: TextStyle(color: Colors.grey),
          )
        ),

        DropdownMenuItem(
          value: 1,
          child: Text('Random Person Name'),
        ),
      ],
    );
  }
}
