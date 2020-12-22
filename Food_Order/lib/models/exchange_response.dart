class ExchangeResponse {
  int code;
  String message;

  ExchangeResponse({
    this.code,
    this.message,
  });

  factory ExchangeResponse.fromJson(Map<String, dynamic> map) {
    return ExchangeResponse(
      code: map['code'],
      message: map['message'],
    );
  }
}
