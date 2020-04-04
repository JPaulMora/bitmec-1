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
          _ConsultationsSection(provider: _provider),
        ],
      ),
    );
  }

  void createConsultation(context) {
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
}

class _ConsultationsSection extends StatefulWidget {
  final PatientProvider provider;

  _ConsultationsSection({ this.provider });

  @override
  __ConsultationsSectionState createState() => __ConsultationsSectionState();
}

class __ConsultationsSectionState extends State<_ConsultationsSection> {
  ConsultationProvider _consultationProvider;

  final _consultationCtrl = TextEditingController();

  final _consultationNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    if (_consultationProvider == null) {
      setState(() {
        _consultationProvider = ConsultationProvider.of(context);
      });
    }

    return ListOfSection(
      title: 'Consultas',
      onPressedAdd: () => _createConsultation(context),
      children: _buildList(context),
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
          RaisedButton(
            child: Text('Agregar', style: TextStyle(color: MyTheme.white)),
            onPressed: () {
              final consultation = Consultation(
                name: _consultationCtrl.text,
                active: true,
                patient: widget.provider.object.id,
              );

              _consultationProvider.create(consultation, (c) {
                _consultationCtrl.text = '';
                widget.provider.addConsultation(c);
                Navigator.pop(context);
              });
            },
          ),

          FlatButton(
            child: Text('Cancelar'),
            onPressed: () {
              _consultationCtrl.text = '';
              Navigator.pop(context);
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0),
                side: BorderSide(color: Colors.white)
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildList(BuildContext context) {
    if (widget.provider.object.consultations.isEmpty) {
      return [Text('Aún no hay consultas agregadas')];
    }

    return widget.provider.object.consultations.map((c) =>
        _ConsultationCard(consultation: c)
    ).toList();
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
        child: Text(consultation.name, style: Theme.of(context).textTheme.subtitle),
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
