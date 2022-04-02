import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:plan_trips/Constants/SizeConfig.dart';

class ErrorText extends StatelessWidget {
  String error;
  ErrorText(this.error);
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: error != "",
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              color: Colors.red,
            ),
            SizedBox(
              width: SizeConfig.widthRatio * 1.5,
            ),
            Text(error,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: SizeConfig.heightRatio * 2.1,
                    color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
