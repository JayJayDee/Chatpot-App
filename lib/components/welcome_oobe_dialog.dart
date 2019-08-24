import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/models/app_state.dart';

void showWelcomeOobeDialog(BuildContext context) async {
  await showCupertinoDialog<void>(
    context: context,
    builder: (BuildContext context) => _buildDialog(context)
  );
}

Widget _buildDialog(BuildContext context) {
  List<Widget> pages = [
    _buildPage1(context),
    _buildPage2(context),
    _buildPage3(context,
      exitCallback: () {
        Navigator.of(context).pop();
      }
    )
  ];
  SwiperControl control = SwiperControl();
  SwiperPagination pagination = SwiperPagination(
    builder: DotSwiperPaginationBuilder(
      color: styles().secondaryFontColor,
      activeColor: styles().primaryFontColor
    )
  );

  return Container(
    alignment: Alignment.center,
    margin: EdgeInsets.only(left: 40, right: 40, top: 100, bottom: 100),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: styles().mainBackground
    ),
    child: Swiper(
      itemCount: pages.length,
      itemBuilder: (BuildContext context, int idx) => pages[idx],
      control: control,
      pagination: pagination,
      loop: false
    )
  );
}

Widget _buildPage1(BuildContext context) {
  final state = ScopedModel.of<AppState>(context);

  return ListView(
    children: [
      Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 5),
        child: Text(locales().welcomeOobeDialog.page1Title,
          style: TextStyle(
            fontSize: 19,
            color: styles().primaryFontColor
          )
        )
      ),
      Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Text(locales().welcomeOobeDialog.page1ItsYou,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: styles().primaryFontColor,
            fontSize: 17
          )
        )
      ),
      Container(
        width: 140,
        height: 140,
        margin: EdgeInsets.only(top: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(70),
          child: CachedNetworkImage(
            imageUrl: state.member.avatar.thumb,
            placeholder: (context, url) => CupertinoActivityIndicator(),
            width: 140,
            height: 140,
          ),
        )
      ),
      Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 20),
        child: Text(locales().welcomeOobeDialog.page1ItsYouPrefix,
          style: TextStyle(
            color: styles().primaryFontColor,
            fontSize: 17
          )
        )
      ),
      Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 5),
        child: Text(locales().getNick(state.member.nick),
          style: TextStyle(
            color: styles().primaryFontColor,
            fontSize: 17,
            fontWeight: FontWeight.bold
          )
        )
      ),
      locales().welcomeOobeDialog.page1ItsYouPostfix == '' ?
        Container() :
        Container(
          alignment: Alignment.center,
          child: Text(locales().welcomeOobeDialog.page1ItsYouPostfix,
            style: TextStyle(
              color: styles().primaryFontColor,
              fontSize: 17
            )
          ) 
        )
    ]
  );
}

Widget _buildPage2(BuildContext context) {
  return ListView(
    children: [
      Container(
        padding: EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
        alignment: Alignment.center,
        child: Text(locales().welcomeOobeDialog.page2Desc1,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: styles().primaryFontColor,
            fontSize: 17
          )
        )
      ),
      Container(
        padding: EdgeInsets.all(20),
        child: Image(
          image: AssetImage('assets/oobe_hint_01.png')
        )
      )
    ]
  );
}

Widget _buildPage3(BuildContext context, {
  @required VoidCallback exitCallback
}) {
  return ListView(
    children: [
      Container(
        padding: EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 5),
        alignment: Alignment.center,
        child: Text(locales().welcomeOobeDialog.page3Desc1,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: styles().primaryFontColor,
            fontSize: 17
          )
        )
      ),
      Container(
        padding: EdgeInsets.all(20),
        child: Image(
          image: AssetImage('assets/oobe_dark_mode_hint.png')
        )
      ),
      Container(
        margin: EdgeInsets.only(bottom: 50),
        padding: EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
        alignment: Alignment.center,
        child: CupertinoButton(
          color: CupertinoColors.activeBlue,
          child: Text(locales().welcomeOobeDialog.nextButton),
          onPressed: exitCallback
        )
      )
    ]
  );
}