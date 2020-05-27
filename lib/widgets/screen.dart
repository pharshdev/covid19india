import 'package:covid19india/screens/homescreen.dart';
import 'package:flutter/material.dart';

class Screen extends StatelessWidget {
  final Widget body;
  final Function onWillPop;

  Screen({this.body, this.onWillPop});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: this.onWillPop ??
            () async {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
              return false;
            },
        child: SafeArea(
          child: Scaffold(
              body: Column(children: [
            Row(children: [
              FlatButton(
                onPressed: () {},
                child: Text('English',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(fontSize: 12.0)),
              ),
              Spacer(),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: 'COVID19',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(fontWeight: FontWeight.w900, fontSize: 16)),
                TextSpan(
                    text: 'INDIA',
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                        fontWeight: FontWeight.w900, color: Colors.indigo)),
              ])),
              Spacer(),
              FlatButton(
                onPressed: () {},
                child: Text('Menu',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(fontSize: 12.0)),
              ),
            ]),
            Expanded(child: this.body)
          ])),
        ));
  }
}
