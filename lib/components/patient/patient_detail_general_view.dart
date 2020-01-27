import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bitmec/components.dart';
import 'package:bitmec/providers.dart';
import 'package:bitmec/models.dart';
import 'package:bitmec/screens.dart';

class PatientDetailGeneralView extends StatefulWidget {
  @override
  _PatientDetailGeneralViewState createState() =>
      _PatientDetailGeneralViewState();
}

class _PatientDetailGeneralViewState extends State<PatientDetailGeneralView> {
  PatientProvider _provider;
  ConsultationProvider _consultationProvider;
  
  final _consultationCtrl = TextEditingController();
  final _consultationNode = FocusNode();

  @override
  void dispose() {
    _consultationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_provider == null) {
      setState(() {
        _provider = PatientProvider.of(context);
      });
    }

    if (_consultationProvider == null) {
      setState(() {
        _consultationProvider = ConsultationProvider.of(context);
      });
    }
    
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildQuickActions(context),
          _buildGeneralInformation(context),
          _ConsultationsSection(provider: _provider),
        ],
      ),
    );
  }
  
  Widget _buildQuickActions(context) {
    return QuickActionsSection(
      children: <QuickActionIcon>[
        QuickActionIcon(
          icon: Icon(Icons.add),
          color: Colors.yellow,
          label: 'Nueva Consulta',
          onTap: () { _createConsultation(context); },
        ),

        // TODO: implements appointments view
        QuickActionIcon(
          icon: Icon(Icons.calendar_today),
          color: Colors.blue,
          label: 'Citas',
          onTap: () { Navigator.pushNamed(
            context,
            AppointmentListByPatientScreen.routeName
          ); },
        ),

        QuickActionIcon(
          icon: Icon(Icons.monetization_on),
          color: Colors.green,
          label: 'Créditos',
        ),
      ],
    );
  }
  
  void _createConsultation(context) {
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
            onPressed: () {
              final consultation = Consultation(
                name: _consultationCtrl.text,
                active: true,
                patient: _provider.object.id,
              );

              _consultationProvider.create(consultation, (c) {
                _consultationCtrl.text = '';
                _provider.addConsultation(c);
                Navigator.pop(context);
              });
            },
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

  Widget _buildGeneralInformation(context) {
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
                      Text(_provider.object.firstName,
                        style: TextStyle(fontSize: 25.0),
                      ),

                      Text(_provider.object.lastName,
                        style: TextStyle(fontSize: 25.0),
                      ),

                      Text('Cui: ${_provider.object.governmentId}'),

                      Text('Edad: ${_provider.object.yearsOld} años'),
                    ],
                  ),

                  Row(
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                      Text(_provider.object.gender ? 'Masculino' : 'Femenino')
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
  final PatientProvider provider;

  _ConsultationsSection({
    Key key,
    this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Consultas', style: TextStyle(
            fontSize: 30.0,
            color: Colors.blue,
          )),
          _buildList(context),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    if (provider.object.consultations.isEmpty) {
      return Text('Aún no hay consultas agregadas');
    }

    return Column(
      children: provider.object.consultations.map((c) =>
        _ConsultationCard(consultation: c)
      ).toList(),
    );
  }
}

class _ConsultationCard extends StatelessWidget {
  final Consultation consultation;

  _ConsultationCard({
    Key key,
    this.consultation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ConsultationDetailScreen.routeName,
          arguments: {'id': consultation.id}
        );
      },

      child: Card(
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 10.0,
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(consultation.name, style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    )),
                  ),

                  Text(consultation.formattedDate()),
                ],
              ),

              Row(
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  Text(consultation.active ? 'Activo' : 'No Activo'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
