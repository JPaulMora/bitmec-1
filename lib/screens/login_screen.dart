import 'package:bitmec/screens.dart';
import 'package:flutter/material.dart';

import 'package:bitmec/components.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  var _nameCtrl = TextEditingController();
  var _nameNode = FocusNode();

  var _passCtrl = TextEditingController();
  var _passNode = FocusNode();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _passCtrl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _buildTitle(context),
            _buildForm(context),
            _buildSubmitButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(context) {
    return Container(
      child: Center(
        child: Text('Bitmec', style: TextStyle(
          fontSize: 100.0,
          color: Colors.blue,
        )),
      ),
    );
  }

  Widget _buildForm(context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _buildEmailField(context),
          _buildPasswordField(context),
        ],
      ),
    );
  }

  Widget _buildEmailField(context) {
    return MyTextFormField(
      label: 'Correo',
      ctrl: _nameCtrl,
      node: _nameNode,
      isEnabled: () => true,
      keyboardType: TextInputType.emailAddress,
      submitted: (value) {
        _nameNode.unfocus();
        FocusScope.of(context).requestFocus(_passNode);
      },
      validator: (value) {
        final pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        final regex = RegExp(pattern);

        if (value.trim().isEmpty) {
          return 'El correo es requerido';
        } else if (!regex.hasMatch(value)){
          return 'Entra un correo valido';
        }

        return null;
      },
    );
  }

  Widget _buildPasswordField(context) {
    return MyTextFormField(
      label: 'Contraseña',
      ctrl: _passCtrl,
      node: _passNode,
      isEnabled: () => true,
      action: TextInputAction.done,
      obscureText: true,
      submitted: (value) {
        _passNode.unfocus();
      },

      validator: (value) {
        if (value.trim().isEmpty) {
          return 'Debes ingresar una contraseña';
        }

        return null;
      },
    );
  }

  Widget _buildSubmitButton(context) {
    return MySubmitButton(
      label: 'Ingresar',
      onPressed: () {
        if (_formKey.currentState.validate()) {
          Navigator.popAndPushNamed(context, HomeScreen.routeName);
        } else {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('¡Todos los campos debe de ser validos!'),
          ));
        }
      },
    );
  }
}
