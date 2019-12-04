import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bitmec/components/form_components.dart';
import 'package:bitmec/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    return SafeArea(
      child: Scaffold(
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildTitle(context),
        _buildForm(context),
        _buildSubmitButton(context),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Bitmec', style: TextStyle(
          fontSize: 100.0,
          color: Colors.blue,
        )),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          _buildEmailField(context),
          _buildPasswordField(context),
        ],
      ),
    );
  }

  Widget _buildEmailField(BuildContext context) {
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

  Widget _buildPasswordField(BuildContext context) {
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

  Widget _buildSubmitButton(BuildContext context) {
    return MySubmitButton(
      label: 'Ingresar',
      onPressed: () {
        Navigator.of(context).pushNamed(HomeScreen.routeName);
      },
    );
  }
}
