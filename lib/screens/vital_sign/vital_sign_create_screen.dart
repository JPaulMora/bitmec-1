import 'package:flutter/material.dart';

import 'package:bitmec/components.dart';

class VitalSignCreateScreen extends StatefulWidget {
  static const routeName = '/vital_sign/create';

  @override
  _VitalSignCreateScreenState createState() => _VitalSignCreateScreenState();
}

class _VitalSignCreateScreenState extends State<VitalSignCreateScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _weightCtrl = TextEditingController();
  final _weightNode = FocusNode();
  final _heightCtrl = TextEditingController();
  final _heightNode = FocusNode();

  final _systolicCtrl = TextEditingController();
  final _systolicNode = FocusNode();
  final _diastolicCtrl = TextEditingController();
  final _diastolicNode = FocusNode();
  final _heartRateCtrl = TextEditingController();
  final _heartRateNode = FocusNode();
  final _oxygenCtrl = TextEditingController();
  final _oxygenNode = FocusNode();

  final _temperatureCtrl = TextEditingController();
  final _temperatureNode = FocusNode();

  final _glucoseCtrl = TextEditingController();
  final _glucoseNode = FocusNode();

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
            _buildPhysicalMeasuresSection(context),
            _buildCardiovascularMeasuresSection(context),
            _buildTemperatureSection(context),
            _buildGlucoseSection(context),

            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: MySubmitButton(
                label: 'Guardar',
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhysicalMeasuresSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 20.0, 0, 10.0),
              child: Text('Medidas Físicas'),
            ),
            MyTextFormField(
              label: 'Peso',
              ctrl: _weightCtrl,
              node: _weightNode,
              icon: Icon(Icons.web),
              isEnabled: () => true,
              keyboardType: TextInputType.number,
              submitted: (value) {
                _weightNode.unfocus();
                FocusScope.of(context).requestFocus(_heightNode);
              },
              validator: (value) {
                if (value.trim().isEmpty) {
                  return 'El peso es requerido';
                }

                return null;
              },
            ),
            MyTextFormField(
              label: 'Altura',
              ctrl: _heightCtrl,
              node: _heightNode,
              icon: Icon(Icons.person),
              isEnabled: () => true,
              keyboardType: TextInputType.number,
              submitted: (value) {
                _heightNode.unfocus();
              },
              validator: (value) {
                if (value.trim().isEmpty) {
                  return 'La altura es requerido';
                }

                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardiovascularMeasuresSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 20.0, 0, 10.0),
              child: Text('Medidas Cardiovasculares'),
            ),
            MyTextFormField(
              label: 'Sistólica',
              ctrl: _systolicCtrl,
              node: _systolicNode,
              isEnabled: () => true,
              keyboardType: TextInputType.number,
              icon: Icon(Icons.web),
              submitted: (value) {
                _systolicNode.unfocus();
                FocusScope.of(context).requestFocus(_diastolicNode);
              },
              validator: (value) {
                if (value.trim().isEmpty) {
                  return 'La sistólica es requerida';
                }

                return null;
              },
            ),
            MyTextFormField(
              label: 'Diastólica',
              ctrl: _diastolicCtrl,
              node: _diastolicNode,
              icon: Icon(Icons.person),
              isEnabled: () => true,
              keyboardType: TextInputType.number,
              submitted: (value) {
                _diastolicNode.unfocus();
                FocusScope.of(context).requestFocus(_heartRateNode);
              },
              validator: (value) {
                if (value.trim().isEmpty) {
                  return 'La diastólica es requerida';
                }

                return null;
              },
            ),
            MyTextFormField(
              label: 'Frecuencia Cardiaca',
              ctrl: _heartRateCtrl,
              node: _heartRateNode,
              icon: Icon(Icons.person),
              isEnabled: () => true,
              keyboardType: TextInputType.number,
              submitted: (value) {
                _heartRateNode.unfocus();
                FocusScope.of(context).requestFocus(_oxygenNode);
              },
              validator: (value) {
                if (value.trim().isEmpty) {
                  return 'La frecuencia cardiaca es requerida';
                }

                return null;
              },
            ),
            MyTextFormField(
              label: 'Oxigeno',
              ctrl: _oxygenCtrl,
              node: _oxygenNode,
              icon: Icon(Icons.person),
              isEnabled: () => true,
              keyboardType: TextInputType.number,
              submitted: (value) {
                _oxygenNode.unfocus();
              },
              validator: (value) {
                if (value.trim().isEmpty) {
                  return 'El oxigeno es requerido';
                }

                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTemperatureSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 20.0, 0, 10.0),
              child: Text('Temperatura'),
            ),
            MyTextFormField(
              label: 'Temperatura',
              ctrl: _temperatureCtrl,
              node: _temperatureNode,
              icon: Icon(Icons.web),
              isEnabled: () => true,
              keyboardType: TextInputType.number,
              submitted: (value) {
                _temperatureNode.unfocus();
              },
              validator: (value) {
                if (value.trim().isEmpty) {
                  return 'La temperatura es requerida';
                }

                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlucoseSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 20.0, 0, 10.0),
              child: Text('Glucosa'),
            ),
            MyTextFormField(
              label: 'Temperatura',
              ctrl: _glucoseCtrl,
              node: _glucoseNode,
              icon: Icon(Icons.web),
              isEnabled: () => true,
              keyboardType: TextInputType.number,
              submitted: (value) {
                _glucoseNode.unfocus();
              },
              validator: (value) {
                if (value.trim().isEmpty) {
                  return 'La glucosa es requerida';
                }

                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
