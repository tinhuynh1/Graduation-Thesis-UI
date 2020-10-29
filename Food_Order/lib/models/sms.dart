class Sms {
  String smsNonce;
  String otp;
  Sms({this.smsNonce, this.otp});
  factory Sms.fromJson(Map<String, dynamic> map) {
    return Sms(
      smsNonce: map["smsNonce"],
      otp: map["otp"],
    );
  }
}
