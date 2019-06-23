import 'package:flutter/cupertino.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:meta/meta.dart';
import 'package:chatpot_app/entities/report.dart';
import 'package:chatpot_app/styles.dart';

class ReportRow extends StatelessWidget {

  final ReportStatus report;

  ReportRow({
    @required this.report
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        children: [
          Icon(_buildStatusIcon(report.status),
            color: Styles.secondaryFontColor,
            size: 30
          )
        ]
      )
    );
  }
}

IconData _buildStatusIcon(ReportState state) =>
  state == ReportState.REPORTED ? MdiIcons.account : // TODO: to be changed
  state == ReportState.IN_PROGRESS ? MdiIcons.refresh :
  state == ReportState.DONE ? MdiIcons.check :
  null;