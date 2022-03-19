class Currency {
  final String code;
  final String name;
  final String symbol;
  final int decimalDigits;

  const Currency({required this.code, required this.name, required this.symbol, this.decimalDigits = 2});

  static const unknown = Currency(code: '', name: '', symbol: '');
  static const ethereum = Currency(code: 'ETH', name: 'Ethereum', symbol: 'Ξ', decimalDigits: 18);
  static const real = Currency(code: 'BRL', name: 'Real', symbol: 'R\$');
  static const dollar = Currency(code: 'USD', name: 'Dollar', symbol: '\$');
  static const bitcoin = Currency(code: 'BTC', name: 'Bitcoin', symbol: '₿', decimalDigits: 18);

  static var values = <Currency>[unknown, ethereum, real, dollar, bitcoin];
}
