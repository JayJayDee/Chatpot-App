import 'dart:async';
import 'package:chatpot_app/components/simple_alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/entities/block.dart';
import 'package:chatpot_app/scenes/report_scene.dart';

class BlockHistoryScene extends StatefulWidget {

  @override
  State createState() => _BlockHistorySceneState();
}

class _BlockHistorySceneState extends State<BlockHistoryScene> {

  bool _loading;
  List<BlockEntry> _entries;

  _BlockHistorySceneState() {
    _loading = false;
    _entries = List();
  }

  @override
  void initState() {
    super.initState();
    this._loadBlockHistories();
  }

  void _loadBlockHistories() async {
    setState(() => _loading = true);
    List<BlockEntry> entries = await blockAccessor().fetchAllBlockEntries();

    setState(() {
      _loading = false;
      _entries = entries;
    });
  }

  void _onClickBlockEntryRow(BuildContext context, BlockEntry entry) =>
    _showMenuSheet(context,
      entry: entry,
      unblockCallback: (BlockEntry entry) => _onClickUnblockMenu(context, entry),
      reportCallback: (BlockEntry entry) => _onClickReportMenu(context, entry)
    );

  void _onClickReportMenu(BuildContext context, BlockEntry entry) async {
    await Navigator.of(context).push(CupertinoPageRoute<bool>(
      builder: (BuildContext context) => ReportScene(
        roomToken: entry.roomToken,
        targetToken: entry.memberToken,
      )
    ));
  }

  void _onClickUnblockMenu(BuildContext context, BlockEntry entry) async {
    bool unblock = await showCupertinoDialog<bool>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(locales().blockHistoryScene.unblockDialogTitle),
        content: Text(locales().blockHistoryScene.unblockDialogContent),
        actions: [
          CupertinoDialogAction(
            child: Text(locales().blockHistoryScene.unblockDialogYes),
            onPressed: () => Navigator.pop(context, true),
          ),
          CupertinoDialogAction(
            child: Text(locales().blockHistoryScene.unblockDialogCancel),
            onPressed: () => Navigator.pop(context, false),
            isDestructiveAction: true,
          )
        ]
      )
    );

    if (unblock == true) {
      setState(() => _loading = true);
      try {
        await blockAccessor().unblock(entry.memberToken);
        await showSimpleAlert(context, locales().blockHistoryScene.unblockCompleted,
          title: locales().successTitle
        );
        this._loadBlockHistories();
      } catch (err) {
        setState(() => _loading = false);
        throw err;
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = List();

    widgets.addAll(_entries.map((e) =>
      _buildBlockRow(context,
        entry: e,
        callback: (BlockEntry entry) => _onClickBlockEntryRow(context, entry)
      )
    ).toList());

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: locales().setting.title,
        middle: Text(locales().blockHistoryScene.title),
      ),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            _loading == false && _entries.length == 0 ?
              _buildEmptyIndicator() : ListView(children: widgets),
            Positioned(
              child: _buildProgress(context, loading: _loading)
            )
          ]
        )
      )
    );
  }
}

Widget _buildProgress(BuildContext context, {
  @required bool loading
}) =>
  loading == true ? CupertinoActivityIndicator() :
  Container();


typedef BlockEntryCallback (BlockEntry entry);

Future<void> _showMenuSheet(BuildContext context, {
  @required BlockEntry entry,
  @required BlockEntryCallback reportCallback,
  @required BlockEntryCallback unblockCallback
}) async =>
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) =>
      CupertinoActionSheet(
        message: Text(locales().blockHistoryScene.menuText(entry),
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
          )
        ),
        actions: [
          CupertinoActionSheetAction(
            child: Text(locales().blockHistoryScene.reportButtonLabel,
              style: TextStyle(
                fontSize: 16.0
              )
            ),
            onPressed: () {
              Navigator.of(context).pop();
              reportCallback(entry);
            }
          ),
          CupertinoActionSheetAction(
            child: Text(locales().blockHistoryScene.unblockButtonLabel,
              style: TextStyle(
                fontSize: 16.0
              )
            ),
            onPressed: () {
              Navigator.of(context).pop();
              unblockCallback(entry);
            }
          )
        ]
      )
  );

Widget _buildBlockRow(BuildContext conteext, {
  @required BlockEntry entry,
  @required BlockEntryCallback callback
}) =>
  Container(
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: CupertinoColors.inactiveGray,
          width: 0.3
        )
      )
    ),
    padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
    child: CupertinoButton(
      padding: EdgeInsets.all(0),
      onPressed: () => callback(entry),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: CachedNetworkImage(
                    imageUrl: entry.avatar.thumb,
                    placeholder: (context, url) => CupertinoActivityIndicator(),
                    width: 60,
                    height: 60,
                  )
                ),
                Positioned(
                  child: Container(
                    width: 30,
                    height: 15,
                    decoration: BoxDecoration(
                      border: Border.all(color: styles().primaryFontColor),
                      image: DecorationImage(
                        image: locales().getFlagImage(entry.region),
                        fit: BoxFit.cover
                      )
                    ),
                  )
                )
              ]
            )
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(locales().getNick(entry.nick),
                    style: TextStyle(
                      color: styles().primaryFontColor,
                      fontSize: 16
                    )
                  ),
                  Text(locales().blockHistoryScene.blockDate(entry.blockDate),
                    style: TextStyle(
                      color: styles().secondaryFontColor,
                      fontSize: 15
                    )
                  ),
                ]
              )
            )
          )
        ]
      )
    )
  );

Widget _buildEmptyIndicator() =>
  Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 90,
          child: Image(
            image: AssetImage('assets/chatpot-logo-only-800-grayscale.png')
          )
        ),
        Text(locales().blockHistoryScene.emptyBlocks,
          style: TextStyle(
            color: styles().secondaryFontColor,
            fontSize: 16
          )
        )
      ]
    ),
  );