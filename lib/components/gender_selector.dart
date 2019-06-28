import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/factory.dart';

typedef GenderSelectCallback (String gender);
Widget buildGenderSeletor(BuildContext context, {
  @required String gender,
  @required GenderSelectCallback genderSelectCallback
}) =>
  Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Icon(CupertinoIcons.person_solid,
        size: 28.0,
        color: CupertinoColors.lightBackgroundGray
      ),
      CupertinoButton(
        padding: EdgeInsets.only(left: 8, right: 0, top: 0, bottom: 0),
        child: Text(_currentGenderExpr(gender),
          style: TextStyle(
            color: CupertinoColors.lightBackgroundGray,
            fontWeight: FontWeight.w100,
            fontSize: 18
          )
        ),
        onPressed: () => {
          _showGenderPicker(context, 
            callback: genderSelectCallback,
            currentGender: gender
          )
        }
      )
    ]
  );

String _currentGenderExpr(String gender) {
  if (gender == null) return locales().signupScene.genderChooserLabel;
  else if (gender == 'M') return locales().signupScene.genderMale;
  else if (gender == 'F') return locales().signupScene.genderFemale;
  else if (gender == 'NOT_YET') return locales().signupScene.genderNothing;
  return '';
}

Future<String> _showGenderPicker(BuildContext context, {
  @required String currentGender,
  @required GenderSelectCallback callback
}) async {
  List<String> genderLabels = [
    locales().signupScene.genderNothing,
    locales().signupScene.genderFemale,
    locales().signupScene.genderMale
  ];
  List<String> genderValues = ['NOT_YET', 'F', 'M'];

  int currentIdx = genderValues.indexOf(currentGender);
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
          children: List<Widget>.generate(genderLabels.length,
            (int idx) => Center(child: Text(genderLabels[idx]))
          ),
          onSelectedItemChanged: (int idx) {
            callback(genderValues[idx]);
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