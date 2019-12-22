import 'package:flutter/material.dart';

import 'package:bitmec/components/my_app_bar.dart';
import 'package:bitmec/components/form/form_components.dart';

class PatientDetailHabitCreateScreen extends StatefulWidget {
  static const routeName = '/patient/detail/habit/create';

  @override
  _PatientDetailHabitCreateScreenState createState() =>
      _PatientDetailHabitCreateScreenState();
}

class _PatientDetailHabitCreateScreenState
    extends State<PatientDetailHabitCreateScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _habitCtrl = TextEditingController();
  final _habitNode = FocusNode();

  final _dateStartCtrl = TextEditingController();
  final _dateStartNode = FocusNode();

  final _dateEndCtrl = TextEditingController();
  final _dateEndNode = FocusNode();

  final _quantityCtrl = TextEditingController();
  final _quantityNode = FocusNode();

  final _frequencyCtrl = TextEditingController();
  final _frequencyNode = FocusNode();

  final _methodCtrl = TextEditingController();
  final _methodNode = FocusNode();

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
            _buildHabitInput(context),
            _buildDateStartInput(context),
            _buildDateEndInput(context),
            _buildQuantityInput(context),
            _buildFrequencyInput(context),
            _buildMethodInput(context),

            MySubmitButton(label: 'Guardar', onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildHabitInput(BuildContext context) {
    return MyTextFormField(
      label: 'Hábito',
      ctrl: _habitCtrl,
      node: _habitNode,
      isEnabled: () => true,
      submitted: (_) {
        _habitNode.unfocus();
        FocusScope.of(context).requestFocus(_dateStartNode);
      },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'Ek hábito es requerido';
        }

        return null;
      },
    );
  }

  Widget _buildDateStartInput(BuildContext context) {
    return MyTextFormField(
      label: 'Fecha de Inicio',
      ctrl: _dateStartCtrl,
      node: _dateStartNode,
      isEnabled: () => true,
      submitted: (_) {
        _dateStartNode.unfocus();
        FocusScope.of(context).requestFocus(_dateEndNode);
      },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'La fecha de inicio es requerida';
        }

        return null;
      },
    );
  }

  Widget _buildDateEndInput(BuildContext context) {
    return MyTextFormField(
      label: 'Fecha de Fin',
      ctrl: _dateEndCtrl,
      node: _dateEndNode,
      isEnabled: () => true,
      submitted: (_) {
        _dateEndNode.unfocus();
        FocusScope.of(context).requestFocus(_quantityNode);
      },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'La fecha es requerida';
        }

        return null;
      },
    );
  }

  Widget _buildQuantityInput(BuildContext context) {
    return MyTextFormField(
      label: 'Cantidad',
      ctrl: _quantityCtrl,
      node: _quantityNode,
      isEnabled: () => true,
      submitted: (_) {
        _quantityNode.unfocus();
        FocusScope.of(context).requestFocus(_frequencyNode);
      },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'La cantidad es requerida';
        }

        return null;
      },
    );
  }

  Widget _buildFrequencyInput(BuildContext context) {
    return MyTextFormField(
      label: 'Frecuencia',
      ctrl: _frequencyCtrl,
      node: _frequencyNode,
      isEnabled: () => true,
      submitted: (_) {
        _frequencyNode.unfocus();
        FocusScope.of(context).requestFocus(_methodNode);
      },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'La fecha es requerida';
        }

        return null;
      },
    );
  }

  Widget _buildMethodInput(BuildContext context) {
    return MyTextFormField(
      label: 'Método',
      ctrl: _methodCtrl,
      node: _methodNode,
      isEnabled: () => true,
      submitted: (_) {
        _methodNode.unfocus();
      },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'El método es requerido';
        }

        return null;
      },
    );
  }
}
