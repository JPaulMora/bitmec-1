import 'package:flutter/material.dart';

import 'package:bitmec/components.dart';
import 'package:bitmec/providers.dart';
import 'package:bitmec/models.dart';

class VitalSignCreateScreen extends StatefulWidget {
  static const routeName = '/vital_sign/create';

  @override
  _VitalSignCreateScreenState createState() => _VitalSignCreateScreenState();
}

class _VitalSignCreateScreenState extends State<VitalSignCreateScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  VitalSignProvider _provider;
  ConsultationProvider _consultationProvider;
  Map _arguments;

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
    if (_provider == null) {
      setState(() {
        _provider = VitalSignProvider.of(context);
      });
    }

    if (_consultationProvider == null) {
      setState(() {
        _consultationProvider = ConsultationProvider.of(context);
      });
    }

    if (_arguments == null) {
      setState(() {
        _arguments = ModalRoute.of(context).settings.arguments;

        if (_arguments['method'] == 'update') {
          VitalSign vitalSign = _arguments['vitalSign'];
          _weightCtrl.text = vitalSign.weight.toString();
          _heightCtrl.text = vitalSign.height.toString();
          _systolicCtrl.text = vitalSign.systolicPressure.toString();
          _diastolicCtrl.text = vitalSign.diastolicPressure.toString();
          _heartRateCtrl.text = vitalSign.heartRate.toString();
          _temperatureCtrl.text = vitalSign.temperature.toString();
          _glucoseCtrl.text = vitalSign.glucose.toString();
          _oxygenCtrl.text = vitalSign.oxygen.toString();
        }
      });
    }

    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return MyAppBar(
      title: 'Crear',
      scaffoldKey: _scaffoldKey,
      backLeading: true,
      actions: _arguments['method'] != 'update' ? null
        : <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            tooltip: 'Eliminar',
            onPressed: () { _confirmDelete(context); },
          )
        ]
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
              final vitalSign = _arguments['vitalSign'];
              _provider.remove(vitalSign.id, (id) {
                _consultationProvider.removeVitalSign(id);
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
      )
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
              _buildPhysicalMeasuresSection(context),
              _buildCardiovascularMeasuresSection(context),
              _buildTemperatureSection(context),
              _buildGlucoseSection(context),

              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: MySubmitButton(
                  label: 'Guardar',
                  onPressed: () { onCreateVitalSign(context); },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onCreateVitalSign(BuildContext context) {
    if (_formKey.currentState.validate()) {
      final vitalSign = VitalSign(
        weight: double.parse(_weightCtrl.text),
        height: double.parse(_heightCtrl.text),
        systolicPressure: double.parse(_systolicCtrl.text),
        diastolicPressure: double.parse(_diastolicCtrl.text),
        heartRate: double.parse(_heartRateCtrl.text),
        temperature: double.parse(_temperatureCtrl.text),
        glucose: double.parse(_glucoseCtrl.text),
        oxygen: double.parse(_oxygenCtrl.text),
        consultation: _arguments['consultationId'],
      );

      switch (_arguments['method']) {
        case 'create':
          _provider.create(vitalSign, (response) {
            _consultationProvider.addVitalSign(response);
            Navigator.pop(context);
          });
          break;

        case 'update':
          vitalSign.id = (_arguments['vitalSign'] as VitalSign).id;
          _provider.update(vitalSign, (response) {
            _consultationProvider.updateVitalSign(response);
            Navigator.pop(context);
          });
          break;

        default:
          throw 'Not method selected on VitalSignCreateScreen';
      }
    }
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
                FocusScope.of(context).requestFocus(_systolicNode);
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
                FocusScope.of(context).requestFocus(_temperatureNode);
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
                FocusScope.of(context).requestFocus(_glucoseNode);
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
              label: 'Glucosa',
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
