import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/apis/api_entities.dart';

class NewRouletteScene extends StatefulWidget {
  @override
  State createState() => _NewRouletteSceneState();
}

class _NewRouletteSceneState extends State<NewRouletteScene> {

  bool _loading;
  List<RouletteStatus> _statuses;

  _NewRouletteSceneState() {
    _loading = false;
    _statuses = [];
  }

  @override
  void initState() {
    super.initState();
    _requestStatuses();
  }

  void _requestStatuses() async {
    final state = ScopedModel.of<AppState>(context);
    setState(() => _loading = true);

    try {
      _statuses = await roomApi().requestRouletteStatuses(memberToken: state.member.token);
    } catch (err) {
      throw err;
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: styles().mainBackground,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: styles().navigationBarBackground,
        previousPageTitle: locales().roulettechat.previous,
        actionsForegroundColor: styles().link,
        middle: Text(locales().roulettechat.title,
          style: TextStyle(
            color: styles().primaryFontColor
          )
        ),
        transitionBetweenRoutes: true
      ),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            ListView(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(locales().roulettechat.description,
                    style: TextStyle(
                      color: styles().primaryFontColor,
                      fontSize: 16
                    )
                  )
                ),
                _buildHeader(title: 'My roulette chats')
              ]
            ),
            Positioned(
              child: _buildProgress(loading: _loading)
            )
          ]
        )
      )
    );
  }
}

Widget _buildProgress({
  @required bool loading
}) =>
  loading == true ? CupertinoActivityIndicator() : Container();

Widget _buildHeader({
  @required String title
}) =>
  Container(
    padding: EdgeInsets.all(7),
    decoration: BoxDecoration(
      color: styles().listRowHeaderBackground
    ),
    child: Text(title,
      style: TextStyle(
        fontSize: 15,
        color: styles().primaryFontColor
      )
    )
  );

Widget _buildStatusesWidget({
  @required bool loading
}) => Container(); // TODO: to be implemented