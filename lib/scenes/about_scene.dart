import 'package:chatpot_app/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/components/simple_alert_dialog.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScene extends StatelessWidget {

  void _onBitcoinClicked(BuildContext context) async {
    String bitAddr = '1LNLrgkDPL5KgSxVoW4CLw5ezWWr2aqxAP';
    await Clipboard.setData(ClipboardData(text: bitAddr));

    await showSimpleAlert(context, locales().aboutScene.bitcoinAddrCopyCompleted,
      title: locales().successTitle
    );
  }

  void _onEthereumClicked(BuildContext context) async {
    String etherAddr = '0x58f196b91a77a8db0B30a71Fd7273d1De2DCB627';
    await Clipboard.setData(ClipboardData(text: etherAddr));

    await showSimpleAlert(context, locales().aboutScene.ethereumAddrCopyCompleted,
      title: locales().successTitle
    );
  }

  void _onHomePageClicked(BuildContext context) async {
    await launch('https://chatpot.chat');
  }

  @override 
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: styles().mainBackground,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: styles().navigationBarBackground,
        previousPageTitle: locales().setting.title,
        actionsForegroundColor: styles().link,
        middle: Text(locales().aboutScene.title,
          style: TextStyle(
            color: styles().primaryFontColor
          )
        )
      ),
      child: SafeArea(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(left: 15, top: 30, right: 15),
              child: Image(
                image: styles().logoImageWithTypo
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 30),
              child: Text(locales().aboutScene.greetings1,
                style: TextStyle(
                  fontSize: 16,
                  color: styles().primaryFontColor
                )
              )
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: CupertinoButton(
                child: Text(locales().aboutScene.bitcoinDonateBtnLabel,
                  style: TextStyle(
                    fontSize: 16,
                    color: styles().link
                  )
                ),
                onPressed: () => _onBitcoinClicked(context)
              )
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: CupertinoButton(
                child: Text(locales().aboutScene.ethereumDonateBtnLabel,
                  style: TextStyle(
                    fontSize: 16,
                    color: styles().link
                  )
                ),
                onPressed: () => _onEthereumClicked(context)
              )
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: CupertinoButton(
                child: Text(locales().aboutScene.homePageBtnLabel,
                  style: TextStyle(
                    fontSize: 16,
                    color: styles().link
                  )
                ),
                onPressed: () => _onHomePageClicked(context)
              )
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 15),
              child: Text('''Developed by JayJayDee.
jindongp@gmail.com''',
                style: TextStyle(
                  fontSize: 16,
                  color: styles().primaryFontColor
                )
              )
            )
          ]
        )
      )
    );
  }
}