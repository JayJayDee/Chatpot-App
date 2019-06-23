import 'package:flutter/cupertino.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:meta/meta.dart';
import 'package:chatpot_app/entities/report.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/factory.dart';

class ReportRow extends StatelessWidget {

  final ReportStatus report;

  ReportRow({
    @required this.report
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(locales().reportHistoryScene.reportTitle(report),
                    style: TextStyle(
                      fontSize: 17,
                      color: Styles.primaryFontColor
                    )
                  ),
                  Padding(padding: EdgeInsets.only(top: 7)),
                  Text(locales().reportHistoryScene.reportDescription(report.status),
                    style: TextStyle(
                      fontSize: 15,
                      color: Styles.secondaryFontColor
                    )
                  ),
                  Padding(padding: EdgeInsets.only(top: 7)),
                  Text(locales().reportHistoryScene.reportTimeUtc(report.regDate),
                    style: TextStyle(
                      fontSize: 15,
                      color: Styles.secondaryFontColor
                    )
                  )
                ]
              )
            )
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(_buildStatusIcon(report.status),
                color: Styles.secondaryFontColor,
                size: 24
              ),
              Padding(padding: EdgeInsets.only(left: 5)),
              Text(locales().reportHistoryScene.reportExpr(report.status),
                style: TextStyle(
                  color: Styles.secondaryFontColor,
                  fontSize: 16
                ),
              )
            ]
          )
        ]
      )
    );
  }
}

IconData _buildStatusIcon(ReportState state) =>
  state == ReportState.REPORTED ? MdiIcons.alert :
  state == ReportState.IN_PROGRESS ? MdiIcons.refresh :
  state == ReportState.DONE ? MdiIcons.check :
  null;