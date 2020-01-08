import 'package:flutter/material.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:bitmec/components/my_app_bar.dart';
import 'package:bitmec/components/form/form_components.dart';

class SymptomCreateScreen extends StatefulWidget {
  static const routeName = '/symptom/create';

  @override
  _SymptomCreateScreenState createState() => _SymptomCreateScreenState();
}

class _SymptomCreateScreenState extends State<SymptomCreateScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  int _sectionSelected = 0;
  final _sectionsLen = 3;

  int _symptomSelected;
  final _symptoms = <Map<String, dynamic>>[
    {'id': 1, 'name': 'Ardor'},
    {'id': 2, 'name': 'Cansancio'},
    {'id': 3, 'name': 'Dolor'},
    {'id': 4, 'name': 'Hormigueo'},
    {'id': 5, 'name': 'Inflamación'},
    {'id': 6, 'name': 'Nausea'},
    {'id': 7, 'name': 'Palpitaciones'},
  ];

  InAppWebViewController _webViewCtrl;
  int _bodyPartSelected;
  bool _sideSelected = true;

  double _magnitude = 0.0;
  final _dateCtrl = TextEditingController();
  final _dateNode = FocusNode();

  @override
  void dispose() {
    _dateCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(context),
        backgroundColor: Colors.white,
        floatingActionButton: _sectionSelected == _sectionsLen - 1
          ? null : _buildFloatingActionButton(context),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return MyAppBar(
      title: 'Create',
      scaffoldKey: _scaffoldKey,
      backLeading: true,
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.navigate_next),
      backgroundColor: Colors.blue,
      onPressed: () {
        if (_sectionSelected == _sectionsLen - 1) return;

        setState(() {
          _sectionSelected += 1;
        });
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SingleChildScrollView(
        child: Builder(builder: (context) {
          switch (_sectionSelected) {
            case 0: return _buildSymptomSection(context);
            case 1: return _buildSelectBodyPartSection(context);
            case 2: return _buildDetailSection(context);

            default: return Container(
              child: Text('This section not exists'),
            );
          }
        }),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (_sectionSelected == 0) {
      return true;
    } else {
      setState(() {
        _sectionSelected -= 1;
      });

      return false;
    }
  }

  Widget _buildSymptomSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _symptoms.map((symptom) => GestureDetector(
          onTap: () {
            setState(() {
              _symptomSelected = symptom['id'];
            });
          },

          child: Builder(builder: (context) {
            final isCurrentSelected = _symptomSelected == symptom['id'];

            final decoration = BoxDecoration(
              color: isCurrentSelected ? Colors.orange : null,
              border: isCurrentSelected ? null : Border.all(width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(3.0)),
            );

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 6),
              decoration: decoration,
              child: Text(symptom['name'], style: TextStyle(
                fontSize: 16.0,
                color: isCurrentSelected ? Colors.white : null,
              )),
            );
          }),
        )).toList(),
      ),
    );
  }

  Widget _buildSelectBodyPartSection(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: RaisedButton(
            child: Text('Cambiar Lado'),
            color: Colors.blueAccent,
            textColor: Colors.white,
            onPressed: () {
              if (_webViewCtrl == null) return;

              if (_sideSelected) {
                _webViewCtrl.loadFile(
                  assetFilePath: 'assets/back.html',
                );
              } else {
                _webViewCtrl.loadFile(
                  assetFilePath: 'assets/front.html',
                );
              }

              setState(() { _sideSelected = !_sideSelected; });
            },
          ),
        ),

        Container(
          height: MediaQuery.of(context).size.height * 93/100,
          child: InAppWebView(
            initialFile: 'assets/front.html',
            initialHeaders: {},
            initialOptions: InAppWebViewWidgetOptions(
              inAppWebViewOptions: InAppWebViewOptions(
                debuggingEnabled: true,
              )
            ),

            onWebViewCreated: (ctrl) {
              _webViewCtrl = ctrl;
              _webViewCtrl.addJavaScriptHandler(
                handlerName: 'handleBodyPartSelected',
                callback: (args) {
                  setState(() {
                    _bodyPartSelected = args[0];
                  });
                }
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDetailSection(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          _buildMySlider(context),
          _buildDateInput(context),
          _buildSubmitButton(context)
        ],
      ),
    );
  }

  Widget _buildMySlider(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 10.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text('Magnitud', style: TextStyle(
            fontSize: 22.0,
          )),

          Row(
            children: <Widget>[
              Icon(Icons.graphic_eq),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Text('${_magnitude.toInt()}'),
              ),

              Expanded(
                child: Slider(
                  min: 0,
                  max: 10,
                  divisions: 10,
                  value: _magnitude,
                  onChanged: (value) {
                    setState(() {
                      _magnitude = value;
                    });
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildDateInput(BuildContext context) {
    return MyTextFormField(
      icon: Icon(Icons.date_range),
      label: 'Fecha de Inicio',
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

  Widget _buildSubmitButton(BuildContext context) {
    return MySubmitButton(
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
