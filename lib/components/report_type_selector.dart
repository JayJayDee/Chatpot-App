import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:chatpot_app/entities/report.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/styles.dart';

typedef ReportTypeSelectCallback (ReportType type);
Widget builReportTypeSeletor(BuildContext context, {
  @required ReportType reportType,
  @required ReportTypeSelectCallback reportSelectCallback
}) =>
  Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Icon(MdiIcons.gavel,
        size: 28.0,
        color: styles().secondaryFontColor
      ),
      CupertinoButton(
        padding: EdgeInsets.only(left: 8, right: 0, top: 0, bottom: 0),
        child: Text(_currentReportTypeExpr(reportType),
          style: TextStyle(
            color: styles().secondaryFontColor,
            fontWeight: FontWeight.w100,
            fontSize: 18
          )
        ),
        onPressed: () => {
          _showReportTypePicker(context, 
            callback: reportSelectCallback,
            currentType: reportType
          )
        }
      )
    ]
  );

String _currentReportTypeExpr(ReportType type) {
  if (type == null) return locales().reportScene.chooseReportType;
  else if (type == ReportType.HATE) return locales().reportScene.hateLabel;
  else if (type == ReportType.SEXUAL) return locales().reportScene.sexualLabel;
  else if (type == ReportType.ETC) return locales().reportScene.etcLabel;
  return null;
}

Future<String> _showReportTypePicker(BuildContext context, {
  @required ReportType currentType,
  @required ReportTypeSelectCallback callback
}) async {
  List<String> typeLabels = [
    locales().reportScene.hateLabel,
    locales().reportScene.sexualLabel,
    locales().reportScene.etcLabel
  ];
  List<ReportType> typeValues = [
    ReportType.HATE,
    ReportType.SEXUAL,
    ReportType.ETC
  ];

  int currentIdx = typeValues.indexOf(currentType);
  if (currentIdx == -1) currentIdx = 0;

  final FixedExtentScrollController pickerScrollCtrl =
    FixedExtentScrollController(initialItem: currentIdx);

  return await showCupertinoModalPopup<String>(
    context: context,
    builder: (BuildContext context) =>
      _buildBottomPicker(
        CupertinoPicker(
          scrollController: pickerScrollCtrl,
          itemExtent: 32.0,
          diameterRatio: 32.0,
          backgroundColor: CupertinoColors.white,
          children: List<Widget>.generate(typeLabels.length,
            (int idx) => Center(child: Text(typeLabels[idx]))
          ),
          onSelectedItemChanged: (int idx) {
            callback(typeValues[idx]);
          }
        )
      )
  );
}

Widget _buildBottomPicker(Widget picker) {
  return Container(
    height: 180.0,
    padding: const EdgeInsets.only(top: 6.0),
    color: CupertinoColors.white,
    child: DefaultTextStyle(
      style: const TextStyle(
        color: CupertinoColors.black,
        fontSize: 22.0,
      ),
      child: GestureDetector(
        onTap: () { },
        child: SafeArea(
          top: false,
          child: picker,
        ),
      ),
    ),
  );
}