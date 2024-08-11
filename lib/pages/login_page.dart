import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:my_chat_app/providers/auth_provider.dart';
import 'package:my_chat_app/services/navigation_service.dart';
import 'package:my_chat_app/services/snackbar_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _deviceHeight;
  var _deviceWidth;

  late String _email;
  late String _password;

  late GlobalKey<FormState> _formKey;

  late AuthProvider _auth;

  _LoginPageState() {
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Align(
        alignment: Alignment.center,
        child: ChangeNotifierProvider<AuthProvider>.value(
            value: AuthProvider.instance, child: _loginPageUi()),
      ),
    );
  }

  Widget _loginPageUi() {
    // print(_email);
    // print(_password);
    return Builder(builder: (BuildContext context) {
      SnackBarService.instance.buildContext = context;
      _auth = Provider.of<AuthProvider>(context);
      return Container(
        height: _deviceHeight * 0.60,
        padding: EdgeInsets.symmetric(horizontal: _deviceHeight * 0.05),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headingWidget(),
            _inputForm(),
            _loginButton(),
            _registerButton(),
          ],
        ),
      );
    });
  }

  Widget _headingWidget() {
    return SizedBox(
      height: _deviceHeight * 0.12,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Wellcome Back',
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
          ),
          Text(
            'Please login your account',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w200),
          )
        ],
      ),
    );
  }

  Widget _inputForm() {
    return SizedBox(
      height: _deviceHeight * 0.16,
      child: Form(
        key: _formKey,
        onChanged: () {
          _formKey.currentState!.save();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _emailTextField(),
            _passwordTextField(),
          ],
        ),
      ),
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      autocorrect: false,
      style: const TextStyle(color: Colors.white),
      validator: (_input) {
        return _input!.length != 0 && _input.contains('@')
            ? null
            : 'please enter valid email address';
      },
      onSaved: (_input) {
        setState(() {
          _email = _input!;
        });
      },
      cursorColor: Colors.white,
      decoration: const InputDecoration(
          hintText: 'Email Address',
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white))),
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      autocorrect: false,
      obscureText: true,
      style: const TextStyle(color: Colors.white),
      validator: (_input) {
        return _input!.length != 0 ? null : 'please enter password';
      },
      onSaved: (_input) {
        setState(() {
          _password = _input!;
        });
      },
      cursorColor: Colors.white,
      decoration: const InputDecoration(
          hintText: 'Password',
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white))),
    );
  }

  Widget _loginButton() {
    return _auth.status == AuthStatus.Authenticating
        ? const Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          )
        : SizedBox(
            height: _deviceHeight * 0.06,
            width: _deviceWidth,
            child: MaterialButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _auth.loginUserWithEmailAndPassword(_email, _password);
                }
              },
              color: Colors.blue,
              child: const Text(
                'LOGIN',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
              ),
            ),
          );
  }

  Widget _registerButton() {
    return GestureDetector(
      onTap: () {
        NavigationService.instance.navigatorTo('register');
      },
      child: SizedBox(
        height: _deviceHeight * 0.06,
        width: _deviceWidth,
        child: const Text(
          'REGISTER',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white60),
        ),
      ),
    );
  }
}
