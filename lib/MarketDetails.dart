class MarketDetails {
  String _coindcxName;
  String _baseCurrencyShortName;
  String _targetCurrencyShortName;
  String _targetCurrencyName;
  String _baseCurrencyName;
  double _minQuantity;
  double _maxQuantity;
  double _minPrice;
  double _maxPrice;
  double _minNotional;
  int _baseCurrencyPrecision;
  var _targetCurrencyPrecision;
  double _step;
  String _symbol;
  String _ecode;
  double _maxLeverage;
  double _maxLeverageShort;
  String _pair;
  String _status;

  MarketDetails(
      {String coindcxName,
      String baseCurrencyShortName,
      String targetCurrencyShortName,
      String targetCurrencyName,
      String baseCurrencyName,
      double minQuantity,
      double maxQuantity,
      double minPrice,
      double maxPrice,
      double minNotional,
      int baseCurrencyPrecision,
      var targetCurrencyPrecision,
      double step,
      String symbol,
      String ecode,
      double maxLeverage,
      double maxLeverageShort,
      String pair,
      String status}) {
    this._coindcxName = coindcxName;
    this._baseCurrencyShortName = baseCurrencyShortName;
    this._targetCurrencyShortName = targetCurrencyShortName;
    this._targetCurrencyName = targetCurrencyName;
    this._baseCurrencyName = baseCurrencyName;
    this._minQuantity = minQuantity;
    this._maxQuantity = maxQuantity;
    this._minPrice = minPrice;
    this._maxPrice = maxPrice;
    this._minNotional = minNotional;
    this._baseCurrencyPrecision = baseCurrencyPrecision;
    this._targetCurrencyPrecision = targetCurrencyPrecision;
    this._step = step;
    this._symbol = symbol;
    this._ecode = ecode;
    this._maxLeverage = maxLeverage;
    this._maxLeverageShort = maxLeverageShort;
    this._pair = pair;
    this._status = status;
  }

  String get coindcxName => _coindcxName;

  set coindcxName(String coindcxName) => _coindcxName = coindcxName;

  String get baseCurrencyShortName => _baseCurrencyShortName;

  set baseCurrencyShortName(String baseCurrencyShortName) =>
      _baseCurrencyShortName = baseCurrencyShortName;

  String get targetCurrencyShortName => _targetCurrencyShortName;

  set targetCurrencyShortName(String targetCurrencyShortName) =>
      _targetCurrencyShortName = targetCurrencyShortName;

  String get targetCurrencyName => _targetCurrencyName;

  set targetCurrencyName(String targetCurrencyName) =>
      _targetCurrencyName = targetCurrencyName;

  String get baseCurrencyName => _baseCurrencyName;

  set baseCurrencyName(String baseCurrencyName) =>
      _baseCurrencyName = baseCurrencyName;

  double get minQuantity => _minQuantity;

  set minQuantity(double minQuantity) => _minQuantity = minQuantity;

  double get maxQuantity => _maxQuantity;

  set maxQuantity(double maxQuantity) => _maxQuantity = maxQuantity;

  double get minPrice => _minPrice;

  set minPrice(double minPrice) => _minPrice = minPrice;

  double get maxPrice => _maxPrice;

  set maxPrice(double maxPrice) => _maxPrice = maxPrice;

  double get minNotional => _minNotional;

  set minNotional(double minNotional) => _minNotional = minNotional;

  //int get baseCurrencyPrecision => int.parse(_baseCurrencyPrecision);
  //set baseCurrencyPrecision(int baseCurrencyPrecision) =>
  //  _baseCurrencyPrecision = baseCurrencyPrecision;
  int get baseCurrencyPrecision => _baseCurrencyPrecision;

  set baseCurrencyPrecision(int baseCurrencyPrecision) =>
      _baseCurrencyPrecision = baseCurrencyPrecision;

  int get targetCurrencyPrecision => int.parse(_targetCurrencyPrecision);

  set targetCurrencyPrecision(var targetCurrencyPrecision) =>
      _targetCurrencyPrecision = targetCurrencyPrecision;

  double get step => _step;

  set step(double step) => _step = step;

  String get symbol => _symbol;

  set symbol(String symbol) => _symbol = symbol;

  String get ecode => _ecode;

  set ecode(String ecode) => _ecode = ecode;

  double get maxLeverage => _maxLeverage;

  set maxLeverage(double maxLeverage) => _maxLeverage = maxLeverage;

  double get maxLeverageShort => _maxLeverageShort;

  set maxLeverageShort(double maxLeverageShort) =>
      _maxLeverageShort = maxLeverageShort;

  String get pair => _pair;

  set pair(String pair) => _pair = pair;

  String get status => _status;

  set status(String status) => _status = status;

  MarketDetails.fromJson(Map<String, dynamic> json) {
    _coindcxName = json['coindcx_name'];
    _baseCurrencyShortName = json['base_currency_short_name'];
    _targetCurrencyShortName = json['target_currency_short_name'];
    _targetCurrencyName = json['target_currency_name'];
    _baseCurrencyName = json['base_currency_name'];
    _minQuantity = json['min_quantity'];
    _maxQuantity = json['max_quantity'];
    _minPrice = json['min_price'];
    _maxPrice = json['max_price'];
    _minNotional = json['min_notional'];
    _baseCurrencyPrecision = json['base_currency_precision'];
    _targetCurrencyPrecision = json['target_currency_precision'];
    _step = json['step'];
    _symbol = json['symbol'];
    _ecode = json['ecode'];
    _maxLeverage = json['max_leverage'];
    _maxLeverageShort = json['max_leverage_short'];
    _pair = json['pair'];
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coindcx_name'] = this._coindcxName;
    data['base_currency_short_name'] = this._baseCurrencyShortName;
    data['target_currency_short_name'] = this._targetCurrencyShortName;
    data['target_currency_name'] = this._targetCurrencyName;
    data['base_currency_name'] = this._baseCurrencyName;
    data['min_quantity'] = this._minQuantity;
    data['max_quantity'] = this._maxQuantity;
    data['min_price'] = this._minPrice;
    data['max_price'] = this._maxPrice;
    data['min_notional'] = this._minNotional;
    data['base_currency_precision'] = this._baseCurrencyPrecision;
    data['target_currency_precision'] = this._targetCurrencyPrecision;
    data['step'] = this._step;
    data['symbol'] = this._symbol;
    data['ecode'] = this._ecode;
    data['max_leverage'] = this._maxLeverage;
    data['max_leverage_short'] = this._maxLeverageShort;
    data['pair'] = this._pair;
    data['status'] = this._status;
    return data;
  }
}
