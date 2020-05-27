import 'dart:math';

import 'package:covid19india/widgets/screen.dart';
import 'package:flutter/material.dart';

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
                Navigator.pop(context);
              }),
          Divider(),
          ListTile(title: Text('Demographics'), onTap: () {}),
          Divider(),
          ListTile(title: Text('Deep Dive'), onTap: () {}),
          Divider(),
          ListTile(title: Text('Essentials'), onTap: () {}),
          Divider(),
          ListTile(title: Text('About'), onTap: () {}),
          Divider(),
          Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                  icon: Transform.rotate(
                      angle: 130 * pi / 180, child: Icon(Icons.brightness_2)),
                  onPressed: null)),
          Divider(),
          SizedBox(height: 24.0),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 16.0),
            child: Text('A crowdsourced initiative',
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .apply(color: Colors.grey[800])),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Made with ',
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .apply(color: Colors.grey[800])),
                Icon(Icons.favorite, color: Colors.red, size: 20.0),
                Text(' by HARSH',
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .apply(color: Colors.grey[800]))
              ],
            ),
          )
        ],
      ),
    );
  }
}
