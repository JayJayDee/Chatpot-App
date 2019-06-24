import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/entities/block.dart';

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
  
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = List();

    widgets.addAll(_entries.map((e) =>
      _buildBlockRow(context, entry: e)
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

Widget _buildBlockRow(BuildContext conteext, {
  @required BlockEntry entry
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
                    border: Border.all(color: Styles.primaryFontColor),
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
                    color: Styles.primaryFontColor,
                    fontSize: 16
                  )
                ),
                Text(locales().blockHistoryScene.blockDate(entry.blockDate),
                  style: TextStyle(
                    color: Styles.secondaryFontColor,
                    fontSize: 15
                  )
                ),
              ]
            )
          )
        )
      ]
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
            color: Styles.secondaryFontColor,
            fontSize: 16
          )
        )
      ]
    ),
  );