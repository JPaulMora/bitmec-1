import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:bitmec/components/form/form_components.dart';
import 'package:bitmec/components/quick_actions_components.dart';

import 'package:bitmec/screens/screens.dart';

class PatientDetailGeneralView extends StatefulWidget {
  @override
  _PatientDetailGeneralViewState createState() => _PatientDetailGeneralViewState();
}

class _PatientDetailGeneralViewState extends State<PatientDetailGeneralView> {
  final _consultationCtrl = TextEditingController();
  final _consultationNode = FocusNode();

  @override
  void dispose() {
    _consultationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuickActionsSection(
            children: <QuickActionIcon>[
              QuickActionIcon(
                icon: Icon(Icons.add),
                color: Colors.yellow,
                label: 'Agregar Consulta',
                onTap: () { _createConsultation(context); },
              ),

              QuickActionIcon(
                icon: Icon(Icons.calendar_today),
                color: Colors.blue,
                label: 'Citas',
              ),

              QuickActionIcon(
                icon: Icon(Icons.monetization_on),
                color: Colors.green,
                label: 'Créditos',
              ),
            ],
          ),
          _buildGeneralInformation(context),
          _ConsultationsSection(),
        ],
      ),
    );
  }
  
  void _createConsultation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Agregar Consulta'),
        content: MyTextFormField(
          noPadding: true,
          label: 'Nombre',
          ctrl: _consultationCtrl,
          node: _consultationNode,
          isEnabled: () => true,
          submitted: (_) {},
          validator: (value) => value.trim().isEmpty
              ? 'El valor es requerido' : null,
        ),
        actions: <Widget>[
          FlatButton(
            splashColor: Colors.black12,
            child: Text('Agregar'),
            onPressed: () { Navigator.pop(context); },
          ),
          RaisedButton(
            color: Colors.redAccent,
            child: Text('Cancelar'),
            onPressed: () {
              _consultationCtrl.text = '';
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGeneralInformation(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('General', style: TextStyle(
            fontSize: 30.0,
            color: Colors.blue
          )),
          Card(
            elevation: 3.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 10.0
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Nombres', style: TextStyle(fontSize: 25.0)),
                      Text('Apellidos', style: TextStyle(fontSize: 25.0)),
                      Text('CUI'),
                      Text('Edad'),
                    ],
                  ),
                  Row(
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                      Text('Género')
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ConsultationsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Consultas', style: TextStyle(
              fontSize: 30.0,
              color: Colors.blue
          )),

          Column(
            children: <Widget>[
              _ConsultationCard(),
              _ConsultationCard(),
              _ConsultationCard(),
              _ConsultationCard(),
              _ConsultationCard(),
              _ConsultationCard(),
              _ConsultationCard(),
              _ConsultationCard(),
              _ConsultationCard(),
              _ConsultationCard(),
            ],
          )
        ],
      ),
    );
  }
}

class _ConsultationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppointmentDetailScreen.routeName);
      },
      child: Card(
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 10.0
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Registro', style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
                  Text('Fecha'),
                  Text('Hora'),
                ],
              ),
              Row(
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  Text('Estado', style: TextStyle(
                    color: Colors.blueAccent,
                  ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
