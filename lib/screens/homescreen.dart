import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:covid19india/blocs/cloud_bloc.dart';
import 'package:covid19india/models/national_data.dart';
import 'package:covid19india/widgets/screen.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  Timer _dataFetchTimer;
  NationalData _nationalData;
  final formatter = NumberFormat("#,##,###");

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CloudBloc>(context).add(FetchNationalData());
    // Auto update every 10 sec
    _dataFetchTimer = Timer.periodic(Duration(seconds: 10),
        (_) => BlocProvider.of<CloudBloc>(context).add(FetchNationalData()));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.inactive)
      _dataFetchTimer?.cancel();
    else if (state == AppLifecycleState.resumed) {
      _dataFetchTimer?.cancel();
      _dataFetchTimer = Timer.periodic(Duration(seconds: 10),
          (_) => BlocProvider.of<CloudBloc>(context).add(FetchNationalData()));
    }
  }

  @override
  void dispose() {
    _dataFetchTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CloudBloc, CloudState>(
      listener: (context, state) {
        if (state is NationalDataFetched) {
          setState(() {
            _nationalData = state.nationalData;
          });
        }
      },
      child: Screen(
          body: _nationalData == null
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(child: Text('Search your city, resources, etc')),
                      SizedBox(height: 16.0),
                      Container(
                          height: 70.0,
                          child: FloatingSearchBar(
                            onTap: () =>
                                BotToast.showText(text: 'Coming soon!'),
                            leading: Icon(Icons.search),
                            children: [],
                            title: Text(''),
                            pinned: true,
                            body: Container(),
                            trailing: IconButton(
                                icon: Icon(Icons.favorite_border,
                                    color: Colors.red, size: 20.0),
                                onPressed: () =>
                                    BotToast.showText(text: 'Coming soon!')),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(_nationalData.statewise.first.lastupdatedtime,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(fontWeight: FontWeight.bold)),
                          IconButton(
                              icon: Icon(Icons.notifications_none, size: 15.0),
                              onPressed: () =>
                                  BotToast.showText(text: 'Coming soon!'))
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Confirmed',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 16.0),
                                Text(
                                    '[+${formatter.format(int.parse(_nationalData.statewise.first.deltaconfirmed))}]',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(
                                            color: Colors.red[300],
                                            fontWeight: FontWeight.bold)),
                                SizedBox(height: 8.0),
                                Text(
                                    formatter.format(int.parse(_nationalData
                                        .statewise.first.confirmed)),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .copyWith(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Column(
                              children: [
                                Text('Active',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.bold)),
                                SizedBox(height: 16.0),
                                Text(''),
                                SizedBox(height: 8.0),
                                Text(
                                    formatter.format(int.parse(
                                        _nationalData.statewise.first.active)),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .copyWith(
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Column(
                              children: [
                                Text('Recovered',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold)),
                                SizedBox(height: 16.0),
                                Text(
                                    '[+${formatter.format(int.parse(_nationalData.statewise.first.deltarecovered))}]',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(
                                            color: Colors.green[300],
                                            fontWeight: FontWeight.bold)),
                                SizedBox(height: 8.0),
                                Text(
                                    formatter.format(int.parse(_nationalData
                                        .statewise.first.recovered)),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .copyWith(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Column(
                              children: [
                                Text('Deceased',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(
                                            color: Colors.grey[700],
                                            fontWeight: FontWeight.bold)),
                                SizedBox(height: 16.0),
                                Text(
                                    '[+${formatter.format(int.parse(_nationalData.statewise.first.deltadeaths))}]',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(
                                            color: Colors.grey[500],
                                            fontWeight: FontWeight.bold)),
                                SizedBox(height: 8.0),
                                Text(
                                    formatter.format(int.parse(
                                        _nationalData.statewise.first.deaths)),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .copyWith(
                                            color: Colors.grey[700],
                                            fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ]),
                      SizedBox(height: 36.0),
                      Container(
                          padding: const EdgeInsets.only(right: 8.0),
                          alignment: Alignment.centerRight,
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: 'Compiled from State Govt. numbers, ',
                                style: Theme.of(context).textTheme.caption),
                            TextSpan(
                                text: 'know more!',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        decorationStyle:
                                            TextDecorationStyle.dashed)),
                          ]))),
                      SizedBox(height: 8.0),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3.0),
                        child: Row(children: [
                          _tableCell(
                              flex: 2,
                              index: 2,
                              text: 'State/UT',
                              textColor: Colors.grey[700],
                              textAlign: TextAlign.start,
                              fontWeight: FontWeight.bold),
                          SizedBox(width: 3.0),
                          _tableCell(
                              flex: 1,
                              index: 2,
                              text: 'Cnfrmd',
                              textAlign: TextAlign.start,
                              fontWeight: FontWeight.bold,
                              textColor: Colors.red),
                          SizedBox(width: 3.0),
                          _tableCell(
                              flex: 1,
                              index: 2,
                              text: 'Actv',
                              textAlign: TextAlign.start,
                              fontWeight: FontWeight.bold,
                              textColor: Colors.blueAccent),
                          SizedBox(width: 3.0),
                          _tableCell(
                              flex: 1,
                              index: 2,
                              text: 'Recvrd',
                              textAlign: TextAlign.start,
                              fontWeight: FontWeight.bold,
                              textColor: Colors.green),
                          SizedBox(width: 3.0),
                          _tableCell(
                              flex: 1,
                              index: 2,
                              text: 'Dcsd',
                              textAlign: TextAlign.start,
                              fontWeight: FontWeight.bold,
                              textColor: Colors.grey[700]),
                        ]),
                      ),
                      Expanded(
                        child: Scrollbar(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: _nationalData.statewise.length,
                              itemBuilder: (ctx, index) => index == 0
                                  ? Container()
                                  : _tableRow(
                                      _nationalData.statewise[index], index)),
                        ),
                      ),
                    ],
                  ),
                )),
    );
  }

  Widget _tableRow(Statewise statewise, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3.0),
      child: Row(
        children: [
          _tableCell(
              flex: 2,
              index: index,
              textColor: Colors.grey[700],
              text: statewise.state,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.bold),
          SizedBox(width: 3.0),
          _tableCell(flex: 1, index: index, text: statewise.confirmed),
          SizedBox(width: 3.0),
          _tableCell(flex: 1, index: index, text: statewise.active),
          SizedBox(width: 3.0),
          _tableCell(flex: 1, index: index, text: statewise.recovered),
          SizedBox(width: 3.0),
          _tableCell(flex: 1, index: index, text: statewise.deaths),
        ],
      ),
    );
  }

  Widget _tableCell(
      {int flex,
      String text,
      int index,
      TextAlign textAlign,
      Color textColor,
      FontWeight fontWeight}) {
    return Expanded(
        flex: flex,
        child: Container(
          padding: const EdgeInsets.all(6.0),
          color: index.isOdd ? Colors.grey[100] : Colors.grey[200],
          child: Text(
            text,
            textAlign: textAlign ?? TextAlign.end,
            style: TextStyle(
                color: textColor ?? Colors.grey[800],
                fontWeight: fontWeight ?? FontWeight.normal),
          ),
        ));
  }

  Future<List<String>> search(String search) async {
    await Future.delayed(Duration(seconds: 2));
    return List.generate(search.length, (int index) {
      return 'Random result $index';
    });
  }
}
