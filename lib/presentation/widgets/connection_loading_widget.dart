import 'package:flutter/material.dart';
import 'package:todo_app_2/core/constants/theme.dart';
import 'package:todo_app_2/presentation/widgets/sizer.dart';

class ConnectionLoadingWidget extends StatelessWidget {
  const ConnectionLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizer(context).w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: Sizer(context).h * 0.3),
          CircularProgressIndicator(
            color: primaryColor,
          ),
          SizedBox(height: 10),
          Text(
            "Loading",
            style: TextStyle(
              color: appTextPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
