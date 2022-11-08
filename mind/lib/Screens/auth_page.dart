import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Providers/auth_provider.dart';
import '../Models/http_exception.dart';
import '../Screens/home_page.dart';
import '../Widgets/image_selection.dart';
import '../Widgets/image_selection.dart';
import '../Models/user_model.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                  Color.fromARGB(255, 255, 255, 255).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          Container(
            height: deviceSize.height,
            width: deviceSize.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Image.asset('lib/Assets/Mind Logo.png'),
                ),
                Flexible(
                  flex: 2,
                  //flex: deviceSize.width > 600 ? 2 : 1,
                  child: AuthCard(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
    'username': '',
  };
  User newUser =
      User(username: '', email: '', password: '', UID: '', profilePic: null);

  var _isLoading = false;
  bool _signedIn = false;

  final _passwordController = TextEditingController();

  void _pickedImage(File image) {
    newUser.profilePic = image;
  }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              title: Text(
                "An error occured",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              content: Text(
                message,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Ok",
                      style: Theme.of(context).textTheme.labelSmall,
                    ))
              ],
            )));
  }

  Future<void> _submit() async {
//client side validate

    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    if (newUser.profilePic == null && _authMode == AuthMode.Signup) {
      _showErrorDialog('Please provide a profile picture');
      return;
    }
    //save inputs
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
//attempt to sign in/up, success = go to home page
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await Provider.of<AuthProvider>(context, listen: false).signIn(
            //_authData['email'], _authData['password']
            newUser);
      } else {
        // Sign user up
        await Provider.of<AuthProvider>(context, listen: false).signup(
            //_authData['email'], _authData['username'], _authData['password']
            newUser);
      }
      setState(() {
        _isLoading = false;
        Navigator.of(context).pushReplacementNamed(HomePage.routeName);
      });
//if error show message based on known errors, else show error occurred
    } on HttpException catch (error) {
      var errorMessage = "An error Occured";

      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = "This email account is already taken";
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = "The provided email is not valid";
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = "This password is too weak";
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = "Invalid Password";
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = "Email Not Found";
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      var errorMessage = "Could not authenticate. Please try again later.";
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: _authMode == AuthMode.Signup
            ? deviceSize.height * .85
            : deviceSize.height * .45,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _authMode == AuthMode.Login
                    ? Container()
                    : ImageSelection(_pickedImage),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    //increase validation not fully accurate
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    //_authData['email'] = value!;
                    newUser.email = value!;
                  },
                ),
                _authMode == AuthMode.Login
                    ? Container()
                    : TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Username'),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          //increase validation not fully accurate
                          if (value!.isEmpty || value.length <= 5) {
                            return 'Username Invalid!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          //_authData['username'] = value!;
                          newUser.username = value!;
                        },
                      ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                  },
                  onSaved: (value) {
                    //_authData['password'] = value!;
                    newUser.password = value!;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: _submit,
                    child: Text(
                      _authMode == AuthMode.Login ? 'Login' : 'Sign Up',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: GoogleFonts.yesevaOne().fontFamily),
                    ),
                  ),
                Divider(),
                TextButton(
                  onPressed: _switchAuthMode,
                  child: Text(
                    '${_authMode == AuthMode.Login ? 'Sign Up' : 'Login'}',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: GoogleFonts.yesevaOne().fontFamily,
                      color: Colors.white,
                    ),
                  ),
                ),
                //may add in other sign in options below, ie google, facebook
              ],
            ),
          ),
        ),
      ),
    );
  }
}
