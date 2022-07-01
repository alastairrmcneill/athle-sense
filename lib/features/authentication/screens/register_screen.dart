import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_wucc/features/authentication/widgets/error_text_widget.dart';
import 'package:reading_wucc/models/models.dart';
import 'package:reading_wucc/services/notifiers.dart';
import 'package:reading_wucc/services/services.dart';
import 'package:reading_wucc/support/wrapper.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _password1 = '';
  String _password2 = '';
  String _errorText = '';
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  Future _register(UserNotifier userNotifier) async {
    // Check passwords match, if not exit
    if (_password1 != _password2) {
      setState(() {
        _errorText = 'Passwords must match';
      });
      return;
    }

    // Create app user and log in firebase
    AppUser newAppUser = AppUser(
      name: _name.trim(),
      email: _email.trim(),
    );
    dynamic result = await AuthService.registerWithEmailAndPassword(
      userNotifier,
      newAppUser,
      _email.trim(),
      _password1.trim(),
    );

    // Check result, if error exit, if good push back to wrapper
    if (result is CustomError) {
      setState(() {
        _errorText = result.message;
      });
      return;
    }
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Wrapper()), (_) => false);
  }

  Widget _buildNameInput() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Name',
        prefixIcon: Icon(Icons.person_outline),
      ),
      maxLines: 1,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Required';
        }
      },
      onSaved: (value) {
        _name = value!;
      },
    );
  }

  Widget _buildEmailInput() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Email',
        prefixIcon: Icon(Icons.email_outlined),
      ),
      maxLines: 1,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Required';
        }
        int atIndex = value.indexOf('@');
        int periodIndex = value.lastIndexOf('.');
        if (!value.contains('@') || atIndex < 1 || periodIndex <= atIndex + 1 || value.length == periodIndex + 1) {
          return 'Not a valid email';
        }
      },
      onSaved: (value) {
        _email = value!;
      },
    );
  }

  Widget _buildPassword1Input() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password',
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _obscureText1 = !_obscureText1;
            });
          },
          icon: _obscureText1 ? const Icon(Icons.visibility_off_rounded) : const Icon(Icons.visibility_rounded),
        ),
      ),
      maxLines: 1,
      keyboardType: TextInputType.visiblePassword,
      obscureText: _obscureText1,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Required';
        }
        if (value.length < 5) {
          return 'Password needs to be greater than 6 characters';
        }
      },
      onSaved: (value) {
        _password1 = value!;
      },
    );
  }

  Widget _buildPassword2Input() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password',
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _obscureText2 = !_obscureText2;
            });
          },
          icon: _obscureText2 ? const Icon(Icons.visibility_off_rounded) : const Icon(Icons.visibility_rounded),
        ),
      ),
      maxLines: 1,
      keyboardType: TextInputType.visiblePassword,
      obscureText: _obscureText2,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Required';
        }
        if (value.length < 5) {
          return 'Password needs to be greater than 6 characters';
        }
      },
      onSaved: (value) {
        _password2 = value!;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Column(children: [
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildNameInput(),
              _buildEmailInput(),
              _buildPassword1Input(),
              _buildPassword2Input(),
            ],
          ),
        ),
        ErrorText(errorText: _errorText),
        ElevatedButton(
            onPressed: () async {
              if (!_formKey.currentState!.validate()) {
                return;
              }
              _formKey.currentState!.save();
              await _register(userNotifier);
            },
            child: Text('Register'))
      ]),
    );
  }
}
