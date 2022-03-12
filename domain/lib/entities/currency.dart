class Currency {
  final String code;
  final String name;
  final String symbol;

  const Currency({required this.code, required this.name, required this.symbol});

  static const unknown = Currency(code: '', name: '', symbol: '');
  static const ethereum = Currency(code: 'ETH', name: 'Ethereum', symbol: '	Ξ');
  static const real = Currency(code: 'BRL', name: 'Real', symbol: 'R\$');
  static const dollar = Currency(code: 'USD', name: 'Dollar', symbol: '\$');
  static const bitcoin = Currency(code: 'BTC', name: 'Bitcoin', symbol: '₿');

  static var values = <Currency>[unknown, ethereum, real, dollar, bitcoin];
}
