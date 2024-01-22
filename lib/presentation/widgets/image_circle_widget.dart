import 'package:flutter/material.dart';
import 'package:todo_app_2/core/constants/theme.dart';

class ImageCircleWidget extends StatelessWidget {
  ImageCircleWidget(
      {super.key,
      required this.imagePath,
      this.height = 50,
      this.width = 50,
      this.isBoxBorder = false});
  String imagePath;
  double height;
  double width;
  bool isBoxBorder;
  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(
      color: primaryColor,
      shape: BoxShape.circle,
    );
    if (isBoxBorder) {
      boxDecoration = BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: primaryColor, width: 1.0));
    }

    return Container(
      height: height,
      width: width,
      decoration: boxDecoration,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child: Image.network(
          imagePath,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: backgroundColor,
              child: const Icon(
                Icons.account_circle,
              ),
            );
          },
        ),
      ),
    );
  }
}
