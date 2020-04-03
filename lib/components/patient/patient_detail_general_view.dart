import 'package:flutter/material.dart';

import 'package:bitmec/my_theme.dart';
import 'package:bitmec/components.dart';
import 'package:bitmec/providers.dart';
import 'package:bitmec/models.dart';
import 'package:bitmec/screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
          color: MyTheme.orange,
          label: 'Nueva Consulta',
          onTap: () { _createConsultation(context); },
        ),

        QuickActionIcon(
          icon: Icon(Icons.calendar_today),
          color: Colors.blueAccent,
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
            color: MyTheme.red,
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
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: MyTheme.tenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('General'.toUpperCase(), style: textTheme.subtitle),
          Card(
            child: Padding(
              padding: MyTheme.tenPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(_provider.object.fullName,
                      style: MyTheme.cardHeaderTextStyle),

                  RowWithIcon(
                    icon: FontAwesomeIcons.idCard,
                    text: _provider.object.governmentId.toString(),
                  ),

                  RowWithIcon(
                    icon: FontAwesomeIcons.birthdayCake,
                    text: '${_provider.object.yearsOld} años',
                  ),

                  RowWithIcon(
                    icon: FontAwesomeIcons.transgender,
                    text: _provider.object.gender ? 'Hombre' : 'Mujer',
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

  _ConsultationsSection({ this.provider });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: MyTheme.tenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Consultas'.toUpperCase(), style: textTheme.subtitle),
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

  _ConsultationCard({ this.consultation });

  @override
  Widget build(BuildContext context) {
    return GeneralCard(
      onTap: () {
        Navigator.pushNamed(
          context,
          ConsultationDetailScreen.routeName,
          arguments: {'id': consultation.id}
        );
      },

      header: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(consultation.name, style: TextStyle(fontSize: 20.0)),
      ),
      children: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RowWithIcon(
            icon: FontAwesomeIcons.calendar,
            text: FormattedDate(consultation.timestamp).formatted,
          ),

          Text(
            consultation.active ? 'Activo' : 'No Activo',
            textDirection: TextDirection.rtl,
            style: TextStyle(
              color: consultation.active ? Colors.green : MyTheme.grey,
            ),
          ),
        ],
      ),
    );
  }
}
