import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:cdcxtask/MarketDetails.dart';
import 'package:cdcxtask/TickerDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Params
  Future<List<MarketDetails>> marketDetailsList;
  bool _isLoading = false;

  bool _sortCoinNameAsc = true;
  bool _sortAsc = true;
  int _sortColumnIndex;
  var _currentCtx = null;

  var img_base_url = "https://coindcx.com/assets/coins/";

  List<MarketDetails> _marketDetails = [];
  List<TickerDetails> _tickerDetails = [];

  @override
  initState() {
    super.initState();
    _isLoading = true;
    fetchMarketData();
  }

  @override
  Widget build(BuildContext context) {
    _currentCtx = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('Market Details'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _showData(),
    );
  }

  Widget _showData() {
    return new Scaffold(
      body: new SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: new Container(
              alignment: Alignment.center,
              child: new DataTable(
                columns: [
                  new DataColumn(
                    label: new Text('Coin Name',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    onSort: (columnIndex, sortAscending) {
                      setState(() {
                        if (columnIndex == _sortColumnIndex) {
                          _sortAsc = _sortCoinNameAsc = sortAscending;
                        } else {
                          _sortColumnIndex = columnIndex;
                          _sortAsc = _sortCoinNameAsc;
                        }
                        _marketDetails.sort((a, b) => a.targetCurrencyName
                            .compareTo(b.targetCurrencyName));
                        if (!sortAscending) {
                          _marketDetails = _marketDetails.reversed.toList();
                        }
                      });
                    },
                  ),
                  new DataColumn(
                      label: new Text('Last Price',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14))),
                  new DataColumn(
                      label: new Text('24H Change',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14))),
                ],
                horizontalMargin: 4,
                rows:
                    _marketDetails // Loops through dataColumnText, each iteration assigning the value to element
                        .map(((marketElement) => DataRow(cells: <DataCell>[
                              new DataCell(
                                Container(
                                    child: new Row(
                                  children: <Widget>[
                                    new Container(
                                      padding: EdgeInsets.all(2.0),
                                      height: 40,
                                      width: 40,
                                      child: SvgPicture.network(img_base_url +
                                          marketElement
                                              .targetCurrencyShortName +
                                          ".svg"),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(marketElement.targetCurrencyName,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13))
                                  ],
                                )),
                                onTap: () {
                                  _getMoreDetails(marketElement);
                                },
                              ),
                              new DataCell(
                                new Text(
                                  getDataforLastPrice(marketElement),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                onTap: () {
                                  _getMoreDetails(marketElement);
                                },
                              ),
                              new DataCell(RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2)),
                                child: Text(
                                  getDatafor24HChange(marketElement) + " %",
                                  style: TextStyle(fontSize: 13),
                                ),
                                onPressed: () {
                                  _getMoreDetails(marketElement);
                                },
                                color: double.parse(getDatafor24HChange(
                                            marketElement)) >
                                        0
                                    ? Colors.green
                                    : Colors.red,
                                textColor: Colors.white,
                              )),
                            ])))
                        .toList(),
              ))),
    );
  }

  String getDataforLastPrice(MarketDetails currentObj) {
    var tickdata = null;
    TickerDetails finalData = null;
    tickdata = _tickerDetails
        .where((elements) => elements.market == currentObj.coindcxName);
    if (tickdata != null) {
      for (TickerDetails obj in tickdata) {
        finalData = obj;
      }
    }
    return finalData?.lastPrice + " " + currentObj.baseCurrencyShortName ??
        "--" + " " + currentObj.baseCurrencyShortName;
  }

  String getDatafor24HChange(MarketDetails currentObj) {
    var tickdata = null;
    TickerDetails finalData = null;
    tickdata = _tickerDetails
        .where((elements) => elements.market == currentObj.coindcxName);
    if (tickdata != null) {
      for (TickerDetails obj in tickdata) {
        finalData = obj;
      }
    }
    return (finalData?.change24Hour ?? "0.0");
  }

  void _showCoinBottomSheet(
      BuildContext ctx, MarketDetails _selmarketObj, TickerDetails _tickerObj) {
    showModalBottomSheet(
        context: ctx,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Container(
                      padding: EdgeInsets.all(2.0),
                      height: 40,
                      width: 40,
                      child: SvgPicture.network(img_base_url +
                          _selmarketObj.targetCurrencyShortName +
                          ".svg"),
                    ),
                    title: new Text(_selmarketObj.targetCurrencyName,
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    onTap: () => {}),
                Divider(
                  height: 1.0,
                  color: Colors.red,
                ),
                new Container(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Last Traded Price",
                                  textAlign: TextAlign.left,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12)),
                              Text(
                                  _tickerObj.lastPrice +
                                      " " +
                                      _selmarketObj.baseCurrencyShortName,
                                  textAlign: TextAlign.left,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20))
                            ]),
                        Flexible(fit: FlexFit.tight, child: SizedBox()),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2)),
                          child: Text(_tickerObj.change24Hour + " %"),
                          onPressed: () {},
                          color: double.parse(_tickerObj.change24Hour) > 0
                              ? Colors.green
                              : Colors.red,
                          textColor: Colors.white,
                        )
                      ]),
                ),
                Divider(
                  height: 1.0,
                  color: Colors.red,
                ),
                new Container(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("24H High",
                                  textAlign: TextAlign.left,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12)),
                              Text(
                                  _tickerObj.high +
                                      " " +
                                      _selmarketObj.baseCurrencyShortName,
                                  textAlign: TextAlign.left,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20))
                            ]),
                        Flexible(fit: FlexFit.tight, child: SizedBox()),
                        new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("24h Low",
                                  textAlign: TextAlign.left,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12)),
                              Text(
                                  _tickerObj.low +
                                      " " +
                                      _selmarketObj.baseCurrencyShortName,
                                  textAlign: TextAlign.left,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20))
                            ]),
                      ]),
                )
              ],
            ),
          );
        });
  }

  void _getMoreDetails(MarketDetails _currentMarketObj) {
    fetchTickerData(_currentMarketObj);
  }

  //Fetch Market Details API
  void fetchMarketData() async {
    var _url = "https://api.coindcx.com/exchange/v1/markets_details";
    final response = await http.get(_url);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      var tempListObj = List<MarketDetails>();
      var marketDetailsList = jsonDecode(response.body);
      print(marketDetailsList.toString());
      for (var currentObj in marketDetailsList) {
        var marketDetails = new MarketDetails.fromJson(currentObj);
        if (marketDetails.status.toLowerCase().compareTo("active") == 0) {
          tempListObj.add(marketDetails);
        }
      }
      //TickerData
      var _url = "https://api.coindcx.com/exchange/ticker";
      final response1 = await http.get(_url);

      if (response1.statusCode == 200) {
        // If the server did return a 200 OK response,
        var tempListObj = TickerDetails();
        var tickerList = jsonDecode(response1.body);
        print(tickerList.toString());
        for (var currentObj in tickerList) {
          var currentTicker = new TickerDetails.fromJson(currentObj);
          _tickerDetails.add(currentTicker);
        }
      }

      setState(() {
        _marketDetails = tempListObj;
        _isLoading = false;
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Market Data!!');
    }
  }

  //Fetch Ticker Details API
  void fetchTickerData(MarketDetails _coinObj) async {
    var _url = "https://api.coindcx.com/exchange/ticker";
    final response = await http.get(_url);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      var tempListObj = TickerDetails();
      var tickerList = jsonDecode(response.body);
      print(tickerList.toString());
      for (var currentObj in tickerList) {
        var currentTicker = new TickerDetails.fromJson(currentObj);
        if (_coinObj.coindcxName
                .toLowerCase()
                .compareTo(currentTicker.market.toLowerCase()) ==
            0) {
          tempListObj = currentTicker;
          print(tempListObj.toString());
          break;
        }
      }
      _showCoinBottomSheet(_currentCtx, _coinObj, tempListObj);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Market Data!!');
    }
  }
}
