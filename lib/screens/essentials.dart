import 'package:covid19india/widgets/screen.dart';
import 'package:flutter/material.dart';

class Essentials extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Screen(
        onWillPop: () async {
          Navigator.pop(context);
        },
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Expanded(
              child: Container(
                // color: Colors.green,
                child: Image(
                  image: AssetImage('assets/essentials.png'),
                ),
              ),
            ),
            Container(
                color: Colors.orange[50],
                width: 250,
                child: ListTile(
                    onTap: () {},
                    title: Text('View Nearby Essentials',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .apply(color: Colors.orange)),
                    trailing: Icon(Icons.explore, color: Colors.orange))),
            SizedBox(height: 24.0),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                color: Colors.grey[300],
                child: ListTile(
                    title: Text(
                        '''We do not collect any location data; they're all stored inside your browser and are inaccessible to us.''',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .apply(color: Colors.grey[600])),
                    leading: Icon(
                      Icons.error_outline,
                    ))),
            SizedBox(height: 24.0),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                color: Colors.grey[300],
                child: ListTile(
                    title: Text(
                        '''We are a community sourced listing platform and are not associated with any of the organizations listed below. Although we verify all our listings, we request you to follow all the guidelines and take the necessary precautions. We encourage you to report any error or suspicious activity so that we can take immediate action.''',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .apply(color: Colors.grey[600])),
                    leading: Icon(
                      Icons.error_outline,
                    )))
          ]),
        ));
  }
}
