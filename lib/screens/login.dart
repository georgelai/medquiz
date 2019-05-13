import 'package:flutter/material.dart';
import 'home.dart';

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
          Padding(
            padding: const EdgeInsets.only(left: 32.0, right: 32.0),
            child: TextFormField(
              // USERNAME
              decoration: InputDecoration(
                labelText: 'E-mail',
                prefixIcon: Icon(Icons.email),
              ),
              controller: _emailController,
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              validator: (value) =>
              value.isEmpty ? 'Please enter a username' : null,
              onSaved: (value) => _email = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32.0, right: 32.0),
            child: TextFormField(
              controller: _passwordController,
              obscureText: true,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock_outline),
              ),
              validator: (value) =>
              value.isEmpty ? 'Please enter a password' : null,
              onSaved: (value) => _password = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32.0, right: 32.0, bottom: 16.0),
            child: _formMode == FormMode.SIGNUP
                ? TextFormField(
              obscureText: true,
              maxLines: 1,
              decoration: InputDecoration(
                // PASSWORD VERIFICATION
                labelText: 'Verify Password',
                prefixIcon: Icon(Icons.lock_outline),
              ),
              validator: (value) => value != _passwordController.text
                  ? 'Passwords do not match.'
                  : null,
              onSaved: (value) => _password = value,
            )
                : null,
          ),
          _showErrorMessage(),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                      fontFamily: 'NunitoSansRegular',
                      color: Theme.of(context).primaryColor,
                      fontSize: 13.0,
                    ),
                  ),
                  onPressed: (){}
//                => Navigator.push(context,
//                    MaterialPageRoute(builder: (context) => ForgotPassword(auth: widget.auth,))),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 32.0, right: 32.0),
            child: RaisedButton(
              // BUTTON
              color: Theme.of(context).primaryColor,
              child: _formMode == FormMode.LOGIN
                  ? Text(
                'LOGIN',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'NunitoSansBold'
                ),
              )
                  : Text(
                'SIGN UP',
                style: TextStyle(
                  color: Colors.white,
                    fontFamily: 'NunitoSansBold',
                ),
              ),
              onPressed: () async {
              if (_formKey.currentState.validate()) {
                // this is where the API call will go to sign in

//                _formMode == FormMode.LOGIN
//                    ? _signInWithEmailAndPassword()
//                    : _register();

                  _formMode == FormMode.LOGIN
                      ? Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyHomePage()))
                      : null;
              }
              },
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 0.0),
            child: Text(
              _success == null
                  ? ''
                  : (_success
                  ? 'Successfully signed in ' + _email
                  : 'Sign in failed'),
              style: TextStyle(color: Colors.red),
            ),
          ),


          Container(
            margin: EdgeInsets.only(top: 0.0),
            padding: EdgeInsets.only(top: 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _formMode == FormMode.LOGIN
                        ? Text(
                      'Don\'t  have an account?',
                      style: TextStyle(
                        fontSize: 13.0,
                      ),
                    )
                        : Text(
                      'Have an account?',
                      style: TextStyle(
                        fontSize: 10.0,
                      ),
                    ),
                    FlatButton(
                      child: _formMode == FormMode.LOGIN
                          ? Text(
                        'Sign Up here',
                        style: TextStyle(
                          fontSize: 13.0,
                          fontFamily: 'NunitoSansRegular',
                          color: Theme.of(context).primaryColor,
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
