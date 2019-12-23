import 'package:flutter/material.dart';

import 'package:bitmec/components/my_app_bar.dart';
import 'package:bitmec/components/form/form_components.dart';

class PatientDetailMedicineCreateScreen extends StatefulWidget {
  static const routeName = '/patient/detail/medicine/create';

  @override
  _PatientDetailMedicineCreateScreenState createState() =>
      _PatientDetailMedicineCreateScreenState();
}

class _PatientDetailMedicineCreateScreenState
    extends State<PatientDetailMedicineCreateScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _conditionCtrl = TextEditingController();
  final _conditionNode = FocusNode();

  final _dateCtrl = TextEditingController();
  final _dateNode = FocusNode();

  final _endDateCtrl = TextEditingController();
  final _endDateNode = FocusNode();

  final _doseCtrl = TextEditingController();
  final _doseNode = FocusNode();

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
            _buildDoseInput(context),
            _buildByInput(context),
            _buildDateInput(context),
            _buildEndDateInput(context),
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
      label: 'Medicamento',
      ctrl: _conditionCtrl,
      node: _conditionNode,
      isEnabled: () => true,
      submitted: (_) {
        _conditionNode.unfocus();
        FocusScope.of(context).requestFocus(_dateNode);
      },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'El medicamento es requerido';
        }

        return null;
      },
    );
  }

  Widget _buildDateInput(BuildContext context) {
    return MyTextFormField(
      label: 'Fecha Inicio',
      ctrl: _dateCtrl,
      node: _dateNode,
      isEnabled: () => true,
      submitted: (_) {
        _dateNode.unfocus();
        FocusScope.of(context).requestFocus(_byNode);
      },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'La fecha de inicio es requerida';
        }

        return null;
      },
    );
  }

  Widget _buildByInput(BuildContext context) {
    return MyTextFormField(
      label: 'Recetado por',
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

  Widget _buildEndDateInput(BuildContext context) {
    return MyTextFormField(
      label: 'Fecha Fin',
      ctrl: _endDateCtrl,
      node: _endDateNode,
      isEnabled: () => true,
      submitted: (_) {
        _endDateNode.unfocus();
      },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'Este campo es requerido';
        }

        return null;
      },
    );
  }

  Widget _buildDoseInput(BuildContext context) {
    return MyTextAreaFormField(
      label: 'Dosis y frecuencia',
      ctrl: _doseCtrl,
      node: _doseNode,
      isEnabled: () => true,
      submitted: (_) {
        _doseNode.unfocus();
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
