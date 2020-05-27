import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:covid19india/blocs/cloud_bloc.dart';
import 'package:covid19india/repo/common.dart';
import 'package:covid19india/screens/aboutscreen.dart';
import 'package:covid19india/screens/essentials.dart';
import 'package:covid19india/widgets/screen.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'homescreen.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Screen(
      isMenu: true,
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      body: Column(
        children: [
          ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              }),
          Divider(),
          ListTile(
              title: Text('Demographics'),
              trailing: Text('Coming soon',
                  style: Theme.of(context).textTheme.caption),
              onTap: () => BotToast.showText(text: 'Coming soon!')),
          Divider(),
          ListTile(
              title: Text('Deep Dive'),
              trailing: Text('Coming soon',
                  style: Theme.of(context).textTheme.caption),
              onTap: () => BotToast.showText(text: 'Coming soon!')),
          Divider(),
          ListTile(
              title: Text('Essentials'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (ctx) => Essentials()));
              }),
          Divider(),
          ListTile(
              title: Text('About'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => AboutScreen()));
              }),
          Divider(),
          ListTile(
              onTap: () => changeBrightness(context),
              leading: Transform.rotate(
                  angle: 130 * pi / 180, child: Icon(Icons.brightness_2))),
          Divider(),
          SizedBox(height: 24.0),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 16.0),
            child: Text('A crowdsourced initiative',
                style: Theme.of(context).textTheme.caption.copyWith(
                    color: Colors.grey[700], fontWeight: FontWeight.w900)),
          ),
          Spacer(),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('Made with ',
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .apply(color: Colors.grey[800])),
                Icon(Icons.favorite, color: Colors.red, size: 20.0),
                Text(' by ',
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .apply(color: Colors.grey[800])),
                InkWell(
                  onTap: () =>
                      launchURL(url: 'https://www.linkedin.com/in/pharshdev/'),
                  child: Text('HARSH P',
                      style: Theme.of(context).textTheme.caption.apply(
                          color: Colors.blueAccent,
                          decoration: TextDecoration.underline)),
                )
              ]))
        ],
      ),
    );
  }

  changeBrightness(context) {
    bool value = BlocProvider.of<CloudBloc>(context).repo.getNightMode();
    DynamicTheme.of(context)
        .setBrightness(value ? Brightness.dark : Brightness.light);
    BlocProvider.of<CloudBloc>(context).repo.switchNightMode();
  }
}
