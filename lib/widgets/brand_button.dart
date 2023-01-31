import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/google_sign_in.dart';
import 'package:provider/provider.dart';



class GoogleButton extends StatelessWidget {
  final String label;
  final double height;
  final Color backgroundColor;
  final Color textColor;
  final Widget brandIcon;

  const GoogleButton({
    required this.brandIcon,
    required this.label,
    this.height = 48,
    this.backgroundColor = Colors.black,
    this.textColor = Colors.white,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: () {
          final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
          provider.googleLogin(context);
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            brandIcon,
            const SizedBox(width: 15),
            Text(
              label,
              style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  height: 1.41),
            )
          ],
        ),
      ),
    );
  }
}


// Aqui se pueden crear mas botones con otras APIS