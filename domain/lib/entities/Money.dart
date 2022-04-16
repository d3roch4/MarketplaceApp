import 'package:domain/entities/currency.dart';

export 'currency.dart';

class Money {
  int _value;
  double get value => _value / 100.0;
  set value(double v) => _value = (v * 100.0).toInt();

  Currency currency;

  Money({required double value, required this.currency})
      : _value = (value * 100).toInt();

  bool operator <(Money other) {
    if (this.currency.code != other.currency.code)
      throw ArgumentError('Currency not is egual');
    return this._value < other._value;
  }

  bool operator >(Money other) {
    if (this.currency.code != other.currency.code)
      throw ArgumentError('Currency not is egual');
    return this._value > other._value;
  }

  String toString() => "${currency.code} $value";
}
