import 'package:flutter/material.dart';

import 'package:bitmec/components/my_app_bar.dart';
import 'package:bitmec/components/form/form_components.dart';

class PatientDetailMedicalAlergiesCreateScreen extends StatefulWidget {
  static const routeName = '/patient/detail/alergies_condition/create';

  @override
  _PatientDetailMedicalAlergiesCreateScreenState createState() =>
      _PatientDetailMedicalAlergiesCreateScreenState();
}

class _PatientDetailMedicalAlergiesCreateScreenState
    extends State<PatientDetailMedicalAlergiesCreateScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _conditionCtrl = TextEditingController();
  final _conditionNode = FocusNode();

  final _dateCtrl = TextEditingController();
  final _dateNode = FocusNode();

  final _byCtrl = TextEditingController();
  final _byNode = FocusNode();

  final _MedicationCtrl = TextEditingController();
  final _MedicationNode = FocusNode();

  final _foodCtrl = TextEditingController();
  final _foodNode = FocusNode();

  final _reactionCtrl = TextEditingController();
  final _reactionNode = FocusNode();

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
            _buildMedicationInput(context),
            _buildFoodInput(context),
            _buildReactionInput(context),
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
      label: 'Alergia',
      ctrl: _conditionCtrl,
      node: _conditionNode,
      isEnabled: () => true,
      submitted: (_) {
        _conditionNode.unfocus();
        FocusScope.of(context).requestFocus(_dateNode);
      },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'El tipo de alergia es requerida';
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

  Widget _buildMedicationInput(BuildContext context) {
    return MyTextAreaFormField(
      label: 'Medicamentos',
      ctrl: _MedicationCtrl,
      node: _MedicationNode,
      isEnabled: () => true,
      submitted: (_) {
        _MedicationNode.unfocus();
      },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'Este campo es requerido';
        }

        return null;
      },
    );
  }

  Widget _buildFoodInput(BuildContext context) {
    return MyTextAreaFormField(
      label: 'Alimentos',
      ctrl: _foodCtrl,
      node: _foodNode,
      isEnabled: () => true,
      submitted: (_) {
        _foodNode.unfocus();
      },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'Este campo es requerido';
        }

        return null;
      },
    );
  }

  Widget _buildReactionInput(BuildContext context) {
    return MyTextFormField(
      label: 'Reacción',
      ctrl: _reactionCtrl,
      node: _reactionNode,
      isEnabled: () => true,
      submitted: (_) {
        _reactionNode.unfocus();
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
