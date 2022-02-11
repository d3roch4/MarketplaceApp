class Money {
  double value;
  String currency;

  Money({required this.value, required this.currency});
}

class Currencies {
  static const unknown = '';
  static const eth = 'ETH';
  static const ethereum = eth;
  static const brl = 'BRL';
  static const real = brl;
  static const usd = 'USD';
  static const dollar = usd;
  static const xbt = 'XBT';
  static const bitcoin = xbt;
}
