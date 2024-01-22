import 'package:flutter/material.dart';

class ToastWidget {
  ToastWidget(this.context);
  BuildContext context;

  OverlayEntry? _entry;
  error({
    String message = 'ไม่สามารถทำรายการได้',
    IconData icon = Icons.error_outline_outlined,
    Duration? duration,
  }) {
    final overlay = Overlay.of(context);
    _entry = OverlayEntry(
      builder: (context) {
        return ToastScreen(
          message: message,
          icon: icon,
        );
      },
    );
    overlay.insert(_entry!);
    Future.delayed(duration ?? const Duration(seconds: 2))
        .then((value) {})
        .then((value) {
      _entry!.remove();
      _entry == null;
    });
  }

  success({
    String message = 'ไม่สามารถทำรายการได้',
    IconData icon = Icons.check_circle_outline,
    Duration? duration,
  }) {
    final overlay = Overlay.of(context);
    _entry = OverlayEntry(
      builder: (context) {
        return ToastScreen(
          message: message,
          icon: icon,
        );
      },
    );
    overlay.insert(_entry!);
    Future.delayed(duration ?? const Duration(seconds: 2))
        .then((value) {})
        .then((value) {
      _entry!.remove();
      _entry == null;
    });
  }
}

class ToastScreen extends StatefulWidget {
  ToastScreen({
    Key? key,
    this.message = 'ไม่สามารถทำรายการได้',
    this.icon = Icons.error_outline_outlined,
  }) : super(key: key);
  String message;
  IconData? icon;
  @override
  State<ToastScreen> createState() => _ToastScreenState();
}

class _ToastScreenState extends State<ToastScreen> {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: true,
      child: Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              // width: 100,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[600],
              ),
              padding: EdgeInsets.only(left: 5, right: 15),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline_outlined,
                    color: Colors.white,
                  ),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 200),
                    child: Text(
                      widget.message,
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
