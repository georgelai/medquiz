import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum FormMode { LOGIN, SIGNUP }

class LoginScreen extends StatefulWidget {



  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordVerificationController =
  TextEditingController();

  String _email = '';
  String _password;
  String _errorMessage = '';

  FormMode _formMode = FormMode.LOGIN;

  bool _success;


  Widget _appTitleLogo(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Med",
          style: TextStyle(
            color: Color.fromARGB(255, 13, 13, 13),
            fontSize: 42,
            letterSpacing: 0.49,
            fontFamily: "NunitoSans",
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          "Quiz",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 42,
            letterSpacing: 0.49,
            fontFamily: "NunitoSans",
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget SignInForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            // USERNAME
            controller: _emailController,
            decoration: InputDecoration(
              hintText: 'E-mail address',
              fillColor: Colors.grey[200],
              filled: true,
              border: OutlineInputBorder(),
            ),
            maxLines: 1,
            keyboardType: TextInputType.emailAddress,
            validator: (value) =>
            value.isEmpty ? 'Please enter a username' : null,
            onSaved: (value) => _email = value,
          ),
          SizedBox(
            height: 16.0,
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            maxLines: 1,
            decoration: InputDecoration(
              // PASSWORD
              hintText: 'Password',
              fillColor: Colors.grey[200],
              filled: true,
              border: OutlineInputBorder(),
            ),
            validator: (value) =>
            value.isEmpty ? 'Please enter a password' : null,
            onSaved: (value) => _password = value,
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: _formMode == FormMode.SIGNUP
                ? TextFormField(
              obscureText: true,
              maxLines: 1,
              decoration: InputDecoration(
                // PASSWORD VERIFICATION
                hintText: 'Verify Password',
                fillColor: Colors.grey[200],
                filled: true,
                border: OutlineInputBorder(),
              ),
              validator: (value) => value != _passwordController.text
                  ? 'Passwords do not match.'
                  : null,
              onSaved: (value) => _password = value,
            )
                : null,
          ),
          _showErrorMessage(),
          SizedBox(
            height: 16.0,
          ),
          RaisedButton(
            // BUTTON
            color: Colors.blue,
            child: _formMode == FormMode.LOGIN
                ? Text(
              'Log In',
              style: TextStyle(
                color: Colors.white,
              ),
            )
                : Text(
              'Sign Up',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () async {
//              if (_formKey.currentState.validate()) {
//                _formMode == FormMode.LOGIN
//                    ? _signInWithEmailAndPassword()
//                    : _register();
//              }
            },
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              _success == null
                  ? ''
                  : (_success
                  ? 'Successfully signed in ' + _email
                  : 'Sign in failed'),
              style: TextStyle(color: Colors.red),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Forgot your login details?',
                style: TextStyle(
                  fontSize: 11.0,
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              FlatButton(
                child: Text(
                  'Get help signing in.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.0,
                  ),
                ),
                onPressed: (){}
//                => Navigator.push(context,
//                    MaterialPageRoute(builder: (context) => ForgotPassword(auth: widget.auth,))),
              ),
            ],
          ),










          Container(
            padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Divider(
                  color: Colors.grey[700],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        bottom: 8.0,
                      ),
                      child: _formMode == FormMode.LOGIN
                          ? Text(
                        'Don\'t  have an account?',
                        style: TextStyle(
                          fontSize: 10.0,
                        ),
                      )
                          : Text(
                        'Have an account?',
                        style: TextStyle(
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                    FlatButton(
                      child: _formMode == FormMode.LOGIN
                          ? Text(
                        'Sign Up',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10.0,
                        ),
                      )
                          : Text(
                        'Sign In',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10.0,
                        ),
                      ),
                      onPressed: _formMode == FormMode.LOGIN
                          ? _changeFormToSignUp
                          : _changeFormToLogin,
                    ),
                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // build method
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: 100.0,
              ),
              _appTitleLogo(context),
              SignInForm(),
            ],
          ),
        ],
      ),
    );
  }


  void _changeFormToSignUp() {
    _formKey.currentState.reset();
    _errorMessage = '';
    setState(() {
      _formMode = FormMode.SIGNUP;
    });
  }

  void _changeFormToLogin() {
    _formKey.currentState.reset();
    _errorMessage = '';
    setState(() {
      _formMode = FormMode.LOGIN;
    });
  }

  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordVerificationController.dispose();
    super.dispose();
  }



  Widget _showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }
}
