import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class AlarmItem extends StatelessWidget {
  Duration time;
  String name;
  bool isActive;

  final Color activeTextColor = Colors.white;
  final Color inactiveTextColor = Colors.grey;

  Function(bool)? switchPressed;
  Function(BuildContext? buildContext)? onDelete;

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitHours = twoDigits(duration.inHours);
    return "$twoDigitHours:$twoDigitMinutes";
  }

  AlarmItem(
      {super.key,
      required this.time,
      required this.name,
      required this.isActive,
      required this.switchPressed,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 10,
        top: 0,
      ),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: onDelete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(12),
              label: "Удалить",
            )
          ],
        ),
        child: Container(
          padding: EdgeInsets.zero,
          decoration: const BoxDecoration(
              border: Border(
                  top: BorderSide(color: Colors.grey, width: 0.3),
                  bottom: BorderSide(color: Colors.grey, width: 0.3))),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formatDuration(time),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: isActive ? activeTextColor : inactiveTextColor,
                        fontSize: 42,
                        fontWeight: FontWeight.w300),
                  ),
                  Padding(
                    padding: EdgeInsets.zero,
                    child: Text(name,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: isActive ? activeTextColor : inactiveTextColor,
                          fontSize: 12,
                        )),
                  )
                ],
              ),
              const Spacer(),
              Transform.scale(
                  scale: 0.8,
                  child: CupertinoSwitch(
                      value: isActive, onChanged: switchPressed))
            ],
          ),
        ),
      ),
    );
  }
}
