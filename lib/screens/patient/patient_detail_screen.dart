import 'package:flutter/material.dart';

import 'package:bitmec/my_theme.dart';
import 'package:bitmec/components.dart';
import 'package:bitmec/screens.dart';
import 'package:bitmec/providers.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:bitmec/models.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PatientDetailScreen extends StatefulWidget {
  static const routeName = '/patient/detail';

  @override
  _PatientDetailScreenState createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  PatientProvider _provider;
  ConsultationProvider _consultationProvider;

  final _consultationCtrl = TextEditingController();
  final _consultationNode = FocusNode();

  @override
  void dispose() {
    _provider.removeObject();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_provider == null) {
      Map args = ModalRoute.of(context).settings.arguments;

      setState(() {
        _provider = PatientProvider.of(context);
        _provider.fetchById(args['id']);
      });
    }

    if (_consultationProvider == null) {
      setState(() {
        _consultationProvider = ConsultationProvider.of(context);
      });
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      floatingActionButton: _buildSpeedDial(context),
    );
  }

  Widget _buildSpeedDial(context) {
    return SpeedDial(
      elevation: 0,
      backgroundColor: MyTheme.secondary,
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(color: Colors.white),
      overlayOpacity: 0.0,
      children: [
        SpeedDialChild(
          child: Icon(Icons.add, color: MyTheme.white),
          backgroundColor: Colors.lightBlue,
          onTap: () => _createConsultation(context),
        ),

        SpeedDialChild(
          child: Icon(Icons.calendar_today, color: MyTheme.white),
          backgroundColor: MyTheme.primary,
          onTap: () {
            Navigator.pushNamed(
              context,
              AppointmentListByPatientScreen.routeName
            );
          },
        ),

        SpeedDialChild(
          child: Icon(Icons.attach_money, color: MyTheme.white),
          backgroundColor: Colors.green,
          onTap: () => {},
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
          RaisedButton(
            child: Text('Agregar', style: TextStyle(color: MyTheme.white)),
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

  Widget _buildAppBar(BuildContext context) {
    return MyAppBar(
      title: 'Detalle',
      scaffoldKey: _scaffoldKey,
      backLeading: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            Navigator.pushNamed(context, PatientEditScreen.routeName);
          },
        )
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Builder(builder: (context) {
        if (_provider.objectLoaded == false) {
          return Center(child: CircularProgressIndicator());
        }

        return DefaultTabController(
          length: 4,
          child: Column(
            children: <Widget>[
              _buildTopHeader(context),
              _buildTabBar(context),
              _buildContent(context),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTopHeader(BuildContext context) {
    Widget _thumbnail() => Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      alignment: FractionalOffset.center,
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
          border: Border.all(color: MyTheme.secondary, width: 2.5),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              _provider.object.profilePicture
                  ?? 'https://maxcdn.icons8.com/Share/icon/Users//user_male_circle_filled1600.png'
            ),
          )
        ),
      ),
    );

    Widget _headerContent() => Container(
      margin: const EdgeInsets.only(top: 45.0),
      constraints: new BoxConstraints.expand(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(_provider.object.firstName, style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          )),

          Text(_provider.object.lastName, style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          )),

          Container(height: 10.0),
          Text(_provider.object.address, style: TextStyle(
            color: Colors.black,
            fontSize: 12.0,
          )),
          Container(height: 10.0),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RowWithIcon(
                icon: FontAwesomeIcons.birthdayCake,
                text: '${_provider.object.yearsOld} años',
              ),

              Container(width: 25.0),
              RowWithIcon(
                icon: FontAwesomeIcons.transgender,
                text: _provider.object.gender ? 'Hombre' : 'Mujer',
              ),

              Container(width: 25.0),
              RowWithIcon(
                icon: FontAwesomeIcons.idCard,
                text: _provider.object.governmentId,
              )
            ],
          ),
        ],
      ),
    );

    Widget _topCard() => Container(
      child: _headerContent(),
      height: 160.0,
      margin: const EdgeInsets.only(top: 70.0),
      decoration: new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
    );

    return Container(
      margin: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 20.0),
      child: new Stack(
        children: <Widget>[
          _topCard(),
          _thumbnail(),
        ],
      ),
    );
  }

  Widget _buildTabBar(context) {
    return Material(
      color: MyTheme.primary,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TabBar(
              isScrollable: true,
              labelColor: Colors.white,
              indicatorColor: MyTheme.secondary,
              indicatorWeight: 5.0,

              tabs: <Widget>[
                Tab(child: Text('General')),
                Tab(child: Text('Historial Médico')),
                Tab(child: Text('Historial Familiar')),
                Tab(child: Text('Hábitos')),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildContent(context) {
    return Expanded(
      child: TabBarView(
        children: <Widget>[
          PatientDetailGeneralView(),
          MedicalHistoryView(),
          PatientDetailFamilyHistoryView(),
          PatientDetailHabitsView(),
          // TODO: implement dependent
        ],
      ),
    );
  }
}
