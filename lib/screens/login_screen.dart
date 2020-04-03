import 'package:flutter/material.dart';

import 'package:bitmec/my_theme.dart';
import 'package:bitmec/screens.dart';
import 'package:bitmec/components.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  var _emailCtrl = TextEditingController();
  var _emailNode = FocusNode();

  var _passCtrl = TextEditingController();
  var _passNode = FocusNode();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: MyTheme.white,
            image: DecorationImage(
              fit: BoxFit.cover,
              alignment: Alignment.bottomLeft,
              image: AssetImage('assets/images/login-balloon-alt.jpg'),
            )
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildTitle(context),
              _buildForm(context),
              _buildSubmitButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Container(
        width: 250.0,
        height: 75.0,
        child: Center(),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            alignment: Alignment.center,
            image: AssetImage('assets/images/logo.png'),
          ),
        ),
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
      ctrl: _emailCtrl,
      node: _emailNode,
      isEnabled: () => true,
      keyboardType: TextInputType.emailAddress,
      fillColor: MyTheme.white,
      submitted: (value) {
        _emailNode.unfocus();
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
      fillColor: MyTheme.white,
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
