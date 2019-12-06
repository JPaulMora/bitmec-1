import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PatientDetailGeneralView extends StatefulWidget {
  @override
  _PatientDetailGeneralViewState createState() => _PatientDetailGeneralViewState();
}

class _PatientDetailGeneralViewState extends State<PatientDetailGeneralView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _QuickActionsSection(),
          _buildGeneralInformation(context),
          _ConsultationsSection(),
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

class _QuickActionsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Card(
        margin: EdgeInsets.all(0.0),
        elevation: 5.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _QuickActionIcon(
              icon: Icon(Icons.add),
              color: Colors.yellow,
              tooltip: 'Agregar Cita',
            ),

            _QuickActionIcon(
              icon: Icon(Icons.calendar_today),
              color: Colors.blue,
              tooltip: 'Citas',
            ),

            _QuickActionIcon(
              icon: Icon(Icons.monetization_on),
              color: Colors.green,
              tooltip: 'Créditos',
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionIcon extends StatelessWidget {
  final Icon icon;
  final Color color;
  final Color textColor;
  final String tooltip;

  _QuickActionIcon({
    @required this.icon,
    this.color,
    this.textColor = Colors.white,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        color: this.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: IconButton(
            tooltip: this.tooltip,
            icon: this.icon,
            color: this.textColor,
            iconSize: 50.0,
            onPressed: () {},
          ),
        ),
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
    return Card(
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
    );
  }
}
