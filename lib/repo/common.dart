import 'package:bot_toast/bot_toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:meta/meta.dart';

launchURL({@required String url}) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    BotToast.showText(text: 'Could not launch $url!');
  }
}
