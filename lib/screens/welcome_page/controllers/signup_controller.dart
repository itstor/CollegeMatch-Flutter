import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SignUpSteps { first, second, otp }

class SignUpController extends GetxController {
  final Rx<SignUpSteps> _currentStep = SignUpSteps.first.obs;
  final _formKeyFirst = GlobalKey<FormState>();
  final _formKeySecond = GlobalKey<FormState>();

  String _username = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  String _phoneNumber = '';
  final _hidePassword = true.obs;
  final _hideConfirmPassword = true.obs;
  final _isLoading = false.obs;

  final RegExp _emailRegex = RegExp(
      r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$",
      caseSensitive: false);

  get username => _username;
  get email => _email;
  get password => _password;
  get confirmPassword => _confirmPassword;
  get phoneNumber => _phoneNumber;
  get hidePassword => _hidePassword.value;
  get hideConfirmPassword => _hideConfirmPassword.value;
  get isLoading => _isLoading.value;
  SignUpSteps get currentStep => _currentStep.value;
  get formKeyFirst => _formKeyFirst;
  get formKeySecond => _formKeySecond;

  void setUsername(String value) => _username = value;
  void setEmail(String value) => _email = value;
  void setPassword(String value) => _password = value;
  void setConfirmPassword(String value) => _confirmPassword = value;
  void setPhoneNumber(String value) => _phoneNumber = value;

  void togglePassword() => _hidePassword.value = !_hidePassword.value;
  void toggleConfirmPassword() =>
      _hideConfirmPassword.value = !_hideConfirmPassword.value;

  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    } else if (value.length < 3) {
      return 'Username must be at least 3 characters';
    } else if (value.length > 20) {
      return 'Username must be less than 20 characters';
    }
    //TODO add regex alphanumeric
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!_emailRegex.hasMatch(value)) {
      return 'Email is invalid';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  void tryContinue() {
    final isValid = _formKeyFirst.currentState!.validate();
    Get.focusScope!.unfocus();

    if (isValid) {
      _formKeyFirst.currentState!.save();

      _isLoading.value = true;

      //API call here
      Future.delayed(Duration(seconds: 2), () {
        _isLoading.value = false;
        _currentStep.value = SignUpSteps.second;
      });
    }
  }

  void trySignUp() {
    final isValid = _formKeySecond.currentState!.validate();
    Get.focusScope!.unfocus();

    if (isValid) {
      _formKeySecond.currentState!.save();

      _isLoading.value = true;

      //API call here
      Future.delayed(Duration(seconds: 2), () {
        _isLoading.value = false;
        _currentStep.value = SignUpSteps.otp;
      });
    }
  }
}
