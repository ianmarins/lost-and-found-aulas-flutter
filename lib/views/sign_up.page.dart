import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found/models/user.dart';
import 'package:lost_and_found/services/auth.dart';
import 'package:lost_and_found/views/sign_in_page.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = '/signup';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = new GlobalKey<FormState>();

  final _nameController = new TextEditingController();
  final _emailController = new TextEditingController();
  final _passwordController = new TextEditingController();
  final _confirmPasswordController = new TextEditingController();

  final _nameFocusNode = new FocusNode();
  final _emailFocusNode = new FocusNode();
  final _passwordFocusNode = new FocusNode();
  final _confirmPasswordFocusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _showNameTextField(),
          _showEmailTextField(),
          _showPasswordTextField(),
          _showConfirmPasswordTextField(),
          _showSignUpButton(),
          _showSignInButton(),
        ],
      ),
    );
  }

  Widget _showNameTextField() {
    return Container(
        height: 60,
        padding: EdgeInsets.only(top: 18.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.zero),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
        child: TextFormField(
          controller: _nameController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Nome',
            prefixIcon: Icon(Icons.person),
          ),
          textInputAction: TextInputAction.next,
          autofocus: true,
          focusNode: _nameFocusNode,
          onEditingComplete: () =>
              FocusScope.of(context).requestFocus(_emailFocusNode),
        ));
  }

  Widget _showEmailTextField() {
    return Container(
        height: 60,
        padding: EdgeInsets.only(top: 18.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.zero),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
        child: TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Email',
            prefixIcon: Icon(Icons.email),
          ),
          textInputAction: TextInputAction.next,
          focusNode: _emailFocusNode,
          onEditingComplete: () =>
              FocusScope.of(context).requestFocus(_passwordFocusNode),
        ));
  }

  Widget _showPasswordTextField() {
    return Container(
        height: 60,
        padding: EdgeInsets.only(top: 18.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.zero),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
        child: TextFormField(
          controller: _passwordController,
          keyboardType: TextInputType.text,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Senha',
            prefixIcon: Icon(Icons.vpn_key),
          ),
          textInputAction: TextInputAction.next,
          focusNode: _passwordFocusNode,
          onEditingComplete: () =>
              FocusScope.of(context).requestFocus(_confirmPasswordFocusNode),
        ));
  }

  Widget _showConfirmPasswordTextField() {
    return Container(
        height: 60,
        padding: EdgeInsets.only(top: 18.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.zero),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
        child: TextFormField(
          controller: _confirmPasswordController,
          keyboardType: TextInputType.text,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Confirmar senha',
            prefixIcon: Icon(Icons.vpn_key),
          ),
          textInputAction: TextInputAction.next,
          focusNode: _confirmPasswordFocusNode,
        ));
  }

  Future _signUp() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    await Auth.signUp(email, password)
        .then(_onResultSignUpSuccess)
        .catchError((error) {
      Flushbar(
        title: 'Erro',
        message: error.toString(),
        duration: Duration(seconds: 3),
      )..show(context);
    });
  }

  void _onResultSignUpSuccess(String userId) {
    final email = _emailController.text;
    final name = _nameController.text;
    final user = User(userId: userId, name: name, email: email);
    Auth.addUser(user).then(_onResultAddUser);
  }

  void _onResultAddUser(result) {
    Flushbar(
      title: 'Novo usuário',
      message: 'Usuário registrado com sucesso!',
      duration: Duration(seconds: 2),
    )..show(context);
  }

  Widget _showSignUpButton() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Center(
          child: SizedBox(
            width: 150.0,
            height: 50.0,
            child: FlatButton(
              child: Text(
                'REGISTRAR',
                style: TextStyle(color: Colors.blue, fontSize: 17.0),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(50.0),
                  side: BorderSide(color: Colors.blue)),
              color: Colors.white,
              onPressed: _signUp,
            ),
          ),
        ));
  }

  void _signIn() {
    Navigator.pushReplacementNamed(context, SignInPage.routeName);
  }

  Widget _showSignInButton() {
    return Column(
      children: <Widget>[
        Center(
          child: Container(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Já Possui Conta ?',
                style: TextStyle(color: Colors.grey),
              )),
        ),
        Container(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Center(
              child: SizedBox(
                width: 150.0,
                height: 50.0,
                child: RaisedButton(
                  child: Text(
                    'ENTRAR',
                    style: TextStyle(color: Colors.white, fontSize: 17.0),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(50.0),
                      side: BorderSide(color: Colors.blue)),
                  color: Colors.blue,
                  onPressed: _signIn,
                ),
              ),
            ))
      ],
    );
  }
}
