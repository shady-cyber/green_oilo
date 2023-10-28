import 'dart:developer';

mixin ValidationMixin<StatelessWidget> {

  bool isFieldEmpty(String fieldValue) => fieldValue.isEmpty;

  bool validateName(String name) {
    return !RegExp("[a-zA-Z]").hasMatch(name);
  }

  bool validateEmailAddress(String email) {
    return !RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  bool validatePassword(String password) {
    ///* use this if u wan to validate a strong password
    return !RegExp(
        // "^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{6,}$
        // r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{6,}$'
        r'^(?=.*)(?=.*?[a-z])(?=.*?[0-9])(?=.).{8,}$').hasMatch(password);
  }

  bool validateConfirmPassword(confirmPassword, password) {
    log('this is the confirm passwor d $confirmPassword and this is the password  $password');
    if (confirmPassword == null) {
      return false;
    } else if (confirmPassword == password) {
      return false;
    } else {
      return true;
    }
  }

  String? validateBirthday(String? value) {
    if (value!.isEmpty || value.length < 2) {
      return 'Enter valid date';
    }
    return null;
  }

  String? validCardExpiredDate(String? value) {
    if (value!.isEmpty) {
      return 'Enter valid Date';
    }
    var now = DateTime.now();
    var date = value.split(RegExp(r'/'));
    var month = int.parse(date.first);
    var year = int.parse('20${date.last}');
    var cardDate = DateTime(year, month);

    if (cardDate.isBefore(now) || month > 12 || month == 0) {
      return 'Enter valid Date';
    }
    return null;
  }

  String? validateCvv(String? value) {
    if (value!.isEmpty || value.length < 3) {
      return 'Enter valid CVV';
    }
    return null;
  }

//   String? validateCardNumber(String? value) =>
//       CreditCardValidator().validateCCNum(value!).isValid
//           ? null
//           : 'Please add valid card number';

//   String? validateEmptyField(String? value) =>
//       value == null || value.isEmpty ? 'This field required' : null;
}
