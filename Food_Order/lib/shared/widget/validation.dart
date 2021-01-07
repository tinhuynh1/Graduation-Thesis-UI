class Validation {
  static isPhoneValid(String phone) {
    final regexPhone = RegExp(r'^(?:[+0]9)?[0-9]{10}$');
    return regexPhone.hasMatch(phone);
  }
}
