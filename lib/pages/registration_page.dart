import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_chat_app/services/media_service.dart';
import 'package:my_chat_app/services/navigation_service.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  var _deviceHeight;
  var _deviceWidth;

  late File? _image;

  late String _name;
  late String _email;
  late String _password;

  late GlobalKey<FormState> _formKey;

  _RegistrationPageState() {
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Container(
          alignment: Alignment.center,
          child: signupPageUI(),
        ));
  }

  Widget signupPageUI() {
    return Container(
      height: _deviceHeight * 0.75,
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _headingWidget(),
          _inputForm(),
          _registerButton(),
          _backButton()
        ],
      ),
    );
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
            'Let`s get start',
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
          ),
          Text(
            'Please Enter your detail',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w200),
          )
        ],
      ),
    );
  }

  Widget _inputForm() {
    return SizedBox(
      height: _deviceHeight * 0.35,
      child: Form(
        key: _formKey,
        onChanged: () {
          _formKey.currentState!.save();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // _imageSelected(),
            _nameTextField(),
            _emailTextField(),
            _passwordTextField(),
          ],
        ),
      ),
    );
  }

  // Widget _imageSelected() {
  //   return Align(
  //     alignment: Alignment.center,
  //     child: GestureDetector(
  //       onTap: () async {
  //         File? _imageFile = (await MediaService.instance.getImageFromLibrary()) as File?;
  //         setState(() {
  //           _image = _imageFile!;
  //         });
  //       },
  //       child: Container(
  //         height: _deviceHeight * 0.10,
  //         width: _deviceWidth * 0.10,
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(5),
  //             image: DecorationImage(
  //                 fit: BoxFit.cover,
  //                 image: _image != null
  //                     ? FileImage(_image!)
  //                     : NetworkImage(
  //                         'https://cdn0.iconfinder.com/data/icons/occupation-002/64/programmer-programming-occupation-avatar-512.png'))),
  //       ),
  //     ),
  //   );
  // }

  Widget _nameTextField() {
    return TextFormField(
      autocorrect: false,
      style: const TextStyle(color: Colors.white),
      validator: (_input) {
        return _input!.length != 0 ? null : 'please Enter your Name';
      },
      onSaved: (_input) {
        setState(() {
          _name = _input!;
        });
      },
      cursorColor: Colors.white,
      decoration: const InputDecoration(
          hintText: 'Name',
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white))),
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      autocorrect: false,
      style: const TextStyle(color: Colors.white),
      validator: (_input) {
        return _input!.length != 0 && _input.contains('@')
            ? null
            : 'please enter valid email';
      },
      onSaved: (_input) {
        setState(() {
          _email = _input!;
        });
      },
      cursorColor: Colors.white,
      decoration: const InputDecoration(
          hintText: 'Email',
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
        return _input!.length != 0 ? null : 'please Enter password';
      },
      onSaved: (_input) {
        setState(() {
          _password = _input!;
        });
      },
      cursorColor: Colors.white,
      decoration: const InputDecoration(
          hintText: 'password',
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white))),
    );
  }

  Widget _registerButton() {
    return SizedBox(
      height: _deviceHeight * 0.06,
      width: _deviceWidth,
      child: MaterialButton(
        onPressed: () {},
        color: Colors.blue,
        child: const Text(
          'Register',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget _backButton() {
    return GestureDetector(
        onTap: () {
          NavigationService.instance.goBack();
        },
        child: SizedBox(
          height: _deviceHeight * 0.06,
          width: _deviceWidth,
          child: const Icon(
            Icons.arrow_back,
            size: 40,
          ),
        ));
  }
}
