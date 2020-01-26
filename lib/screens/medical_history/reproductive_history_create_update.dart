import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:bitmec/components.dart';
import 'package:bitmec/providers.dart';
import 'package:bitmec/models.dart';

class ReproductiveHistoryCreateUpdateScreen extends StatefulWidget {
  static const routeName = '/medical_history/reproductive_history/create_update';

  @override
  _ReproductiveHistoryCreateUpdateScreenState createState() =>
      _ReproductiveHistoryCreateUpdateScreenState();
}

class _ReproductiveHistoryCreateUpdateScreenState
    extends State<ReproductiveHistoryCreateUpdateScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();

  Map _arguments;
  ReproductiveHistoryProvider _provider;
  PatientProvider _patientProvider;

  var _menstrualPeriod = false;
  var _firstMenstruationDate = DateTime.now();
  var _lastMenstruationDate = DateTime.now();

  var _pregnant = false;
  final _pregnanciesCtrl = TextEditingController();
  final _pregnanciesNode = FocusNode();
  final _liveBirthsCtrl = TextEditingController();
  final _liveBirthsNode = FocusNode();

  var _unborn = false;
  final _abortionsCtrl = TextEditingController();
  final _abortionsNode = FocusNode();
  final _stillbornsCtrl = TextEditingController();
  final _stillbornsNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    if (_arguments == null) {
      setState(() {
        _arguments = ModalRoute.of(context).settings.arguments;

        if (_arguments['reproductiveHealth'] != null) {
          ReproductiveHistory reproductiveHistory = _arguments['reproductiveHealth'];

          if (reproductiveHistory.firstMenstruationDate != null) {
            _menstrualPeriod = true;
            _firstMenstruationDate = DateTime.parse(reproductiveHistory.firstMenstruationDate);

            if (reproductiveHistory.lastMenstruationDate != null) {
              _lastMenstruationDate = DateTime.parse(reproductiveHistory.lastMenstruationDate);
            }
          }

          if (reproductiveHistory.pregnancies > 0) {
            _pregnant = true;
            _pregnanciesCtrl.text = reproductiveHistory.pregnancies.toString();
            _liveBirthsCtrl.text = reproductiveHistory.liveBirths.toString();
          }

          if (reproductiveHistory.abortions > 0) {
            _unborn = true;
            _abortionsCtrl.text = reproductiveHistory.abortions.toString();
            _stillbornsCtrl.text = reproductiveHistory.stillborns.toString();
          }
        }
      });
    }

    if (_provider == null) {
      setState(() {
        _provider = ReproductiveHistoryProvider.of(context);
      });
    }

    if (_patientProvider == null) {
      setState(() {
        _patientProvider = PatientProvider.of(context);
      });
    }

    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return MyAppBar(
      title: 'Actualizar',
      scaffoldKey: _scaffoldKey,
      backLeading: true,
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildMenstrualPeriodSection(context),
              _buildPregnantSection(context),
              _buildUnbornSection(context),

              MySubmitButton(onPressed: () { _onCreate(context); }),
            ],
          ),
        ),
      ),
    );
  }

  void _onCreate(context) {
    if (_formKey.currentState.validate()) {
      final formatter = DateFormat('yyyy-MM-dd');

      final reproductiveHealth = ReproductiveHistory(
        firstMenstruationDate: _menstrualPeriod
            ? formatter.format(_firstMenstruationDate) : null,
        lastMenstruationDate: _menstrualPeriod
            ? formatter.format(_lastMenstruationDate) : null,

        pregnancies: _pregnant ? int.parse(_pregnanciesCtrl.text) : 0,
        liveBirths: _pregnant ? int.parse(_liveBirthsCtrl.text) : 0,

        abortions: _unborn ? int.parse(_abortionsCtrl.text) : 0,
        stillborns: _unborn ? int.parse(_stillbornsCtrl.text) : 0,

        patient: _patientProvider.object.id,
      );

      ReproductiveHistory reproductiveHistory = _arguments['reproductiveHealth'];
      if (reproductiveHistory != null) {
        reproductiveHealth.id = reproductiveHistory.id;
        _provider.update(reproductiveHealth, (response) {
          _patientProvider.reproductiveHistory = response;
          Navigator.pop(context);
        });
      } else {
        _provider.create(reproductiveHealth, (response) {
          _patientProvider.reproductiveHistory = response;
          Navigator.pop(context);
        });
      }
    }
  }

  Widget _buildMenstrualPeriodSection(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('¿Has tenido uno o más ciclos mestruales?'),
              RaisedButton(
                child: Text(_menstrualPeriod ? 'Si' : 'No'),
                onPressed: () {
                  setState(() {
                    _menstrualPeriod = !_menstrualPeriod;
                  });
                },
              ),
            ],
          ),

          _menstrualPeriod == false ? Container() : Column(
            children: <Widget>[
              _firstMenstruationDateInput(context),
              _lastMenstruationDateInput(context),
            ],
          )
        ],
      ),
    );
  }

  Widget _firstMenstruationDateInput(context) {
    return MyDateTimePicker(
      label: 'Primera Mestruación',
      dateTime: _firstMenstruationDate,
      onChange: (date) {
        setState(() {
          _firstMenstruationDate = date;
        });
      },
    );
  }

  Widget _lastMenstruationDateInput(context) {
    return MyDateTimePicker(
      label: 'Última Mestruación',
      dateTime: _lastMenstruationDate,
      onChange: (date) {
        setState(() {
          _lastMenstruationDate = date;
        });
      },
    );
  }

  Widget _buildPregnantSection(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('¿Has estado embarazada?'),
              RaisedButton(
                child: Text(_pregnant ? 'Si' : 'No'),
                onPressed: () {
                  setState(() {
                    _pregnant = !_pregnant;
                  });
                },
              ),
            ],
          ),

          _pregnant == false ? Container() : Column(
            children: <Widget>[
              _pregnanciesInput(context),
              _liveBirthsInput(context),
            ],
          )
        ],
      ),
    );
  }

  Widget _pregnanciesInput(context) {
    return MyTextFormField(
      label: 'Embarazos',
      ctrl: _pregnanciesCtrl,
      node: _pregnanciesNode,
      isEnabled: () => true,
      icon: Icon(Icons.pan_tool),
      keyboardType: TextInputType.number,
      submitted: (_) { _pregnanciesNode.unfocus(); },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'Este campo es requerido';
        }

        return null;
      },
    );
  }

  Widget _liveBirthsInput(context) {
    return MyTextFormField(
      label: 'Hijos Vivos',
      ctrl: _liveBirthsCtrl,
      node: _liveBirthsNode,
      isEnabled: () => true,
      icon: Icon(Icons.pan_tool),
      keyboardType: TextInputType.number,
      submitted: (_) { _liveBirthsNode.unfocus(); },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'Este campo es requerido';
        }

        return null;
      },
    );
  }

  Widget _buildUnbornSection(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('¿Ha perdido algún bebe no nacido?'),
              RaisedButton(
                child: Text(_unborn ? 'Si' : 'No'),
                onPressed: () {
                  setState(() {
                    _unborn = !_unborn;
                  });
                },
              ),
            ],
          ),

          _unborn == false ? Container() : Column(
            children: <Widget>[
              _abortionsInput(context),
              _stillbornsInput(context),
            ],
          )
        ],
      ),
    );
  }

  Widget _abortionsInput(context) {
    return MyTextFormField(
      label: 'Cantidad de Abortos',
      ctrl: _abortionsCtrl,
      node: _abortionsNode,
      isEnabled: () => true,
      icon: Icon(Icons.pan_tool),
      keyboardType: TextInputType.number,
      submitted: (_) { _abortionsNode.unfocus(); },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'Este campo es requerido';
        }

        return null;
      },
    );
  }

  Widget _stillbornsInput(context) {
    return MyTextFormField(
      label: 'Perdidas Naturales',
      ctrl: _stillbornsCtrl,
      node: _stillbornsNode,
      isEnabled: () => true,
      icon: Icon(Icons.pan_tool),
      keyboardType: TextInputType.number,
      submitted: (_) { _stillbornsNode.unfocus(); },
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'Este campo es requerido';
        }

        return null;
      },
    );
  }
}
