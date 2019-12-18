import 'package:flutter/material.dart';

import 'package:bitmec/components/my_app_bar.dart';
import 'package:bitmec/components/form/form_components.dart';

class PatientDetailMedicalTraumaCreateScreen extends StatefulWidget {
  static const routeName = '/patient/detail/trauma_condition/create';

  @override
  _PatientDetailMedicalTraumaCreateScreenState createState() =>
      _PatientDetailMedicalTraumaCreateScreenState();
}

class _PatientDetailMedicalTraumaCreateScreenState
    extends State<PatientDetailMedicalTraumaCreateScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _conditionCtrl = TextEditingController();
  final _conditionNode = FocusNode();

  final _dateCtrl = TextEditingController();
  final _dateNode = FocusNode();

  final _byCtrl = TextEditingController();
  final _byNode = FocusNode();

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
            _buildConditionInput(context),
            _buildLocationInput(context),
            _buildTreatmentInput(context),
            _buildByInput(context),
            _buildDateInput(context),
            MySubmitButton(
              label: 'Guardar',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConditionInput(BuildContext context) {
    return MyTextFormField(
      label: 'Trauma',
      ctrl: _conditionCtrl,
      node: _conditionNode,
      isEnabled: () => true,
      submitted: (_) {
        _conditionNode.unfocus();
        FocusScope.of(context).requestFocus(_dateNode);
      },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'El trauma es requerido';
        }

        return null;
      },
    );
  }

  Widget _buildDateInput(BuildContext context) {
    return MyTextFormField(
      label: 'Fecha de Diagnostico',
      ctrl: _dateCtrl,
      node: _dateNode,
      isEnabled: () => true,
      submitted: (_) {
        _dateNode.unfocus();
        FocusScope.of(context).requestFocus(_byNode);
      },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'La fecha es requerida';
        }

        return null;
      },
    );
  }

  Widget _buildByInput(BuildContext context) {
    return MyTextFormField(
      label: 'Diagnosticado por',
      ctrl: _byCtrl,
      node: _byNode,
      isEnabled: () => true,
      submitted: (_) {
        _byNode.unfocus();
      },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'Este campo es requerido';
        }

        return null;
      },
    );
  }

  Widget _buildLocationInput(BuildContext context) {
    return MyTextFormField(
      label: 'Localización',
      ctrl: _byCtrl,
      node: _byNode,
      isEnabled: () => true,
      submitted: (_) {
        _byNode.unfocus();
      },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'Este campo es requerido';
        }

        return null;
      },
    );
  }

  Widget _buildTreatmentInput(BuildContext context) {
    return MyTextFormField(
      label: 'Tratamiento',
      ctrl: _byCtrl,
      node: _byNode,
      isEnabled: () => true,
      submitted: (_) {
        _byNode.unfocus();
      },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'Este campo es requerido';
        }

        return null;
      },
    );
  }
}
