import 'package:college_match/core/values/firebase_constants.dart';
import 'package:college_match/data/services/auth_service.dart';
import 'package:college_match/data/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SignUpSteps { first, second, otp }

class SignUpController extends GetxController {
  final Rx<SignUpSteps> _currentStep = SignUpSteps.first.obs;
  final _authService = Get.find<AuthService>();
  final _formKeyFirst = GlobalKey<FormState>();
  final _formKeySecond = GlobalKey<FormState>();
  final _userService = UserService();

  String _username = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  String _phoneNumber = '';
  String _verificationId = '';
  final _hidePassword = true.obs;
  final _hideConfirmPassword = true.obs;
  final _isLoading = false.obs;
  final Rx<String> _usernameErrorMsg = ''.obs;
  final Rx<String> _emailErrorMsg = ''.obs;
  final Rx<String> _passwordErrorMsg = ''.obs;
  final Rx<String> _phoneNumberErrorMsg = ''.obs;

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
  get emailErrorMsg => _emailErrorMsg.value;
  get passwordErrorMsg => _passwordErrorMsg.value;
  get phoneNumberErrorMsg => _phoneNumberErrorMsg.value;
  get usernameErrorMsg => _usernameErrorMsg.value;

  void setConfirmPassword(String value) => _confirmPassword = value;

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

  void onChangePhoneNumber(String value) {
    if (_phoneNumberErrorMsg.value != '') {
      _phoneNumberErrorMsg.value = '';
    }
    _phoneNumber = value;
  }

  void onChangeUsername(String value) {
    if (_usernameErrorMsg.value != '') {
      _usernameErrorMsg.value = '';
    }
    _username = value;
  }

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

  void tryContinue() async {
    final isValid = _formKeyFirst.currentState!.validate();
    Get.focusScope!.unfocus();

    if (isValid) {
      _formKeyFirst.currentState!.save();

      _isLoading.value = true;

      try {
        await _authService
            .registerWithEmailAndPassword(_email, _password)
            .then((_) {
          _isLoading.value = false;
          _currentStep.value = SignUpSteps.second;
        });
      } on FirebaseAuthException catch (e) {
        _isLoading.value = false;

        switch (e.code) {
          case 'email-already-in-use':
            _emailErrorMsg.value = 'Email already in use';
            break;
          case 'weak-password':
            _passwordErrorMsg.value = 'Password is too weak';
            break;
          default:
        }
      }
    }
  }

  void trySignUp() {
    final isValid = _formKeySecond.currentState!.validate();
    Get.focusScope!.unfocus();

    if (isValid) {
      _formKeySecond.currentState!.save();

      _isLoading.value = true;

      try {
        _userService.checkUsernameAvailability(_username).then((value) {
          if (value) {
            _userService.registerSecondStep(
              uid: auth.currentUser!.uid,
              username: _username,
              phone: _phoneNumber,
            );

            // authController.setInitialScreen(authController.firebaseUser.value);
            // _authService.verifyPhoneNumber(
            //     phoneNumber: _phoneNumber,
            //     verificationCompleted: (credential) {},
            //     verificationFailed: (e) {
            //       _isLoading.value = false;
            //       _phoneNumberErrorMsg.value = e.message!;
            //     },
            //     codeSent: (verId, i) {
            //       _isLoading.value = false;
            //       _verificationId = verId;
            //       _currentStep.value = SignUpSteps.otp;
            //     },
            //     codeAutoRetrievalTimeout: (e) {});
          } else {
            print('here');
            _usernameErrorMsg.value = 'Username already taken';
          }
        });
      } catch (e) {
        print(e);
      }
    }
    _isLoading.value = false;
  }

  // String? verifyOTP(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'OTP is required';
  //   }

  //   try {
  //     PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //         verificationId: _verificationId, smsCode: value);

  //     auth.currentUser!.linkWithCredential(credential);
  //   } catch (e) {
  //     print(e);
  //     return 'Invalid OTP';
  //   }

  //   return null;
  // }
}
