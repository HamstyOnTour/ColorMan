import 'package:flutter/material.dart';

class Mode {
final String title;
final IconData icon;
final Color color;

Mode(this.title, this.icon, this.color);
}

class ModeCard extends StatelessWidget {
  final Mode mode;
  final VoidCallback onClick;
  const ModeCard({required this.mode, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: onClick,
        borderRadius: BorderRadius.circular(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              mode.icon,
              size: 50.0,
              color: mode.color,
            ),
            SizedBox(height: 10.0),
            Text(
              mode.title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}