import 'package:Food_Order/models/cart.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class FormatMoney {
  final double money;

  FormatMoney(this.money);
  static String format(double money) {
    return FlutterMoneyFormatter(
            settings: MoneyFormatterSettings(
              symbol: 'đ',
              thousandSeparator: '.',
              fractionDigits: 0,
            ),
            amount: money)
        .output
        .symbolOnRight;
  }

  static double amount(List<Cart> list) {
    var _amount = 0.0;
    for (int i = 0; i < list.length; i++) {
      _amount += list[i].total;
    }
    return _amount;
  }
}
