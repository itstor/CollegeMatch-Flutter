import 'package:college_match/core/values/colors.dart';
import 'package:college_match/core/values/firebase_constants.dart';
import 'package:college_match/data/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final RegExp _emailRegex = RegExp(
      r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$",
      caseSensitive: false);
  final _authService = Get.find<AuthService>();

  String _email = '';
  String _password = '';
  final _isLoading = false.obs;
  final _hidePassword = true.obs;
  final _emailErrorMsg = ''.obs;
  final _passwordErrorMsg = ''.obs;

  get isLoading => _isLoading.value;
  get hidePassword => _hidePassword.value;
  get email => _email;
  get password => _password;
  get emailErrorMsg => _emailErrorMsg.value;
  get passwordErrorMsg => _passwordErrorMsg.value;

  void setEmail(String value) => _email = value;

  void setPassword(String value) => _password = value;

  void togglePassword() => _hidePassword.value = !_hidePassword.value;

  void onChangeEmail(String value) {
    if (_emailErrorMsg.value != '') {
      _emailErrorMsg.value = '';
    }
    _email = value;
  }

  void onChangePassword(String value) {
    if (_passwordErrorMsg.value != '') {
      _passwordErrorMsg.value = '';
    }
    _password = value;
  }

  String? emailValidator(String value) {
    if (value.isEmpty) {
      return 'Please input email address';
    } else if (!_emailRegex.hasMatch(value)) {
      return 'Please input valid email address';
    } else {
      return null;
    }
  }

  String? passwordValidator(String value) {
    if (value.isEmpty) {
      return 'Please input password';
    }
    return null;
  }

  void trySubmit() async {
    final isValid = formKey.currentState!.validate();
    Get.focusScope!.unfocus();

    if (isValid) {
      formKey.currentState!.save();

      _isLoading.value = true;

      try {
        await _authService
            .signInWithEmailAndPassword(_email, _password)
            .then((value) {
          _isLoading.value = false;
          Fluttertoast.showToast(
            msg: 'Login Success',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color(0xFFA989FF),
            textColor: Colors.white,
            fontSize: 16.0,
          );
        });
      } on FirebaseAuthException catch (e) {
        _isLoading.value = false;
        switch (e.code) {
          case 'user-not-found':
            _emailErrorMsg.value = 'User not registered';
            break;
          case 'wrong-password':
            _passwordErrorMsg.value = 'Wrong password';
            break;
          default:
        }
      }
    }
  }
}
