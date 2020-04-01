import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppLogoLogin extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 150,
        width: 150,
        child: Center(child: SvgPicture.asset("assets/image/ehi_logo_login.svg",color: Colors.white,))
    );
  }
}

class AppLogo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 45,
        width: 45,
        child: Center(child: SvgPicture.asset("assets/image/ehi_logo.svg",color: Colors.white,))
    );
  }
}