import 'package:flutter/material.dart';

import 'package:bitmec/components.dart';

class PatientDetailFamilyHistoryCreateScreen extends StatefulWidget {
  static const routeName = '/patient/detail/family_history/create';

  @override
  _PatientDetailFamilyHistoryCreateScreenState createState() =>
      _PatientDetailFamilyHistoryCreateScreenState();
}

class _PatientDetailFamilyHistoryCreateScreenState
    extends State<PatientDetailFamilyHistoryCreateScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _relationshipCtrl = TextEditingController();
  final _relationshipNode = FocusNode();

  final _conditionCtrl = TextEditingController();
  final _conditionNode = FocusNode();

  final _dateCtrl = TextEditingController();
  final _dateNode = FocusNode();

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
            _buildConditionInput(context),
            _buildDateInput(context),

            MySubmitButton(label: 'Guardar', onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildRelationshipInput(BuildContext context) {
    return MyTextFormField(
      label: 'Relación',
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

  Widget _buildConditionInput(BuildContext context) {
    return MyTextFormField(
      label: 'Padecimiento',
      ctrl: _conditionCtrl,
      node: _conditionNode,
      isEnabled: () => true,
      submitted: (_) {
        _conditionNode.unfocus();
        FocusScope.of(context).requestFocus(_dateNode);
      },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'El padecimiento es requerido';
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
      },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'La fecha es requerida';
        }

        return null;
      },
    );
  }
}
