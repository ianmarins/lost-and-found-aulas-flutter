import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found/services/auth.dart';
import 'package:lost_and_found/views/home_page.dart';
import 'package:lost_and_found/views/sign_up.page.dart';
import 'package:splashscreen/splashscreen.dart';

class SignInPage extends StatefulWidget {
  static const String routeName = '/signin';

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = new TextEditingController();
  final _passwordController = new TextEditingController();
  bool _obscurePassword = true;

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 50.0),
            child: Text(
              'Lost_And _Found',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 40.0,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        _showEmailTextField(),
        _showPasswordTextField(),
        _showSignInButton(),
        Center(
          child: Container(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Náo Possui Conta ?',
                style: TextStyle(color: Colors.grey),
              )),
        ),
        _showSignUpButton(),
      ],
    );
  }

  Widget _showEmailTextField() {
    return Container(
      height: 60,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.zero),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        controller: _emailController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 10.0),
          border: InputBorder.none,
          hintText: 'Email',
        ),
      ),
    );
  }

  void _toggleObscurePassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  Widget _showPasswordTextField() {
    return Container(
      height: 60,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.zero),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
      child: TextFormField(
        textInputAction: TextInputAction.done,
        controller: _passwordController,
        obscureText: _obscurePassword,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 10.0),
          border: InputBorder.none,
          hintText: 'Senha',
          suffixIcon: IconButton(
            icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility),
            onPressed: _toggleObscurePassword,
          ),
        ),
      ),
    );
  }

  Future<void> _signIn() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    await Auth.signIn(email, password)
        .then(_onSignInSuccess)
        .catchError((error) {
      print('Caught error: $error');
      Flushbar(
        title: 'Erro',
        message: error.toString(),
        duration: Duration(seconds: 3),
      )..show(context);
    });
  }

  Future _onSignInSuccess(String userId) async {
    final user = await Auth.getUser(userId);
    await Auth.storeUserLocal(user);
    Navigator.pushReplacementNamed(context, HomePage.routeName);
  }

  Widget _showSignInButton() {
    if ((_passwordController.text == '') || (_emailController.text == '')) {
      return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Center(
            child: SizedBox(
              width: 150.0,
              height: 50.0,
              child: FlatButton(
                child: Text(
                  'ENTRAR',
                  style: TextStyle(color: Colors.grey, fontSize: 17.0),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(50.0),
                    side: BorderSide(color: Colors.grey)),
                color: Colors.white,
                onPressed: _signIn,
              ),
            ),
          ));
    } else if ((_passwordController.text != '') &&
        (_emailController.text != '')) {
      return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Center(
            child: SizedBox(
              width: 150.0,
              height: 50.0,
              child: RaisedButton(
                child: Text(
                  'ENTRAR',
                  style: TextStyle(color: Colors.blue, fontSize: 17.0),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(50.0),
                    side: BorderSide(color: Colors.blue)),
                color: Colors.white,
                onPressed: _signIn,
              ),
            ),
          ));
    }
  }

  void _signUp() {
    Navigator.pushReplacementNamed(context, SignUpPage.routeName);
  }

  Widget _showSignUpButton() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Center(
          child: SizedBox(
            width: 250.0,
            height: 50.0,
            child: FlatButton(
              child: Text(
                'CADASTRAR AGORA',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold),
              ),
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(50.0),
                  side: BorderSide(color: Colors.blue)),
              onPressed: _signUp,
            ),
          ),
        ));
  }

}
