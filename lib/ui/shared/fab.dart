import 'package:flutter/material.dart';
import 'package:my_app/LangUtils.dart';

class FancyFab extends StatefulWidget {
  final Function() onPressed;
  final String tooltip;
  final IconData icon;
  final Function() notifyParent;

  FancyFab({this.onPressed, this.tooltip, this.icon, this.notifyParent});

  @override
  _FancyFabState createState() => _FancyFabState();
}

class _FancyFabState extends State<FancyFab>
    with SingleTickerProviderStateMixin {
  // bool isOpened = false;
  // AnimationController _animationController;
  // AnimationController _animationController2;

  // Animation<Color> _buttonColor;
  // Animation<double> _animateIcon;
  // Animation<double> _translateButton;
  // Curve _curve = Curves.easeOut;
  // double _fabHeight = 56.0;

  @override
  initState() {
    // _animationController =
    //     AnimationController(vsync: this, duration: Duration(milliseconds: 500))
    //       ..addListener(() {
    //         setState(() {});
    //       });
    // _animateIcon =
    //     Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    // _buttonColor = ColorTween(
    //   begin: Colors.indigo,
    //   end: Colors.grey,
    // ).animate(CurvedAnimation(
    //   parent: _animationController,
    //   curve: Interval(
    //     0.00,
    //     1.00,
    //     curve: Curves.linear,
    //   ),
    // ));
    // _translateButton = Tween<double>(
    //   begin: _fabHeight,
    //   end: -14.0,
    // ).animate(CurvedAnimation(
    //   parent: _animationController,
    //   curve: Interval(
    //     0.0,
    //     0.75,
    //     curve: _curve,
    //   ),
    // ));
    // super.initState();
  }

  @override
  dispose() {
    // _animationController.dispose();
    super.dispose();
  }

//   animate() {
//     if (!isOpened) {
//       _animationController.forward();
//     } else {
//       _animationController.reverse();
//     }
//     isOpened = !isOpened;
//   }

//   Widget flagTr() {    
//     return Container(
//       child: FloatingActionButton(
//         backgroundColor: Colors.transparent,
//         heroTag: 2,
//         onPressed: () async { 
//            await LangUtils.saveLanguage(Locale("tr"));
//            widget.notifyParent();
//        },
//         tooltip: 'Türkçe',
//         child: new Image(
//                image: new AssetImage("assets/images/flagTr.png"),
//                width: 30,
//                height: 30,
//            )   ,
//       ),
//     );
//   }
// Locale locale = new Locale("tr");

//   Widget flagEng() {
//     return Container(
//       child: FloatingActionButton(
//         backgroundColor: Colors.transparent,
//         heroTag: 1,
//         onPressed: () async { 
//           await LangUtils.saveLanguage(Locale("en"));
//           widget.notifyParent();
//         },
//         tooltip: 'English',
//         child: new Image(
//                image: new AssetImage("assets/images/flagEng.png"),
//                width: 30,
//                height: 30,
//            ),
//       ),
//     );
//   }

//   Widget toggle() {
//     return Container(
//       child: FloatingActionButton(
//         heroTag: 0,
//         backgroundColor: _buttonColor.value,
//         onPressed: animate,
//         tooltip: 'Toggle',
//         child: AnimatedIcon(
//           icon: AnimatedIcons.menu_close,
//           progress: _animateIcon,
//         ),
//       ),
//     );
//   }


//     Widget multiLanguage() {
//     return  Column(children: <Widget>[        Transform(
//           transform: Matrix4.translationValues(
//             -_translateButton.value * 2.0,
//             0.0,
//             0.0,
//           ),
//           child: flagTr(),
//         ),
//         Transform(
//           transform: Matrix4.translationValues(
//            -_translateButton.value,
//             0.0,
//             0.0,
//           ),
//           child: flagEng(),
//         ),    Container(
//       child: FloatingActionButton(
//         backgroundColor: Colors.transparent,
//         heroTag: 1,
//         onPressed: () { 
//           animate();
//         },
//         tooltip: 'English',
//         child: new Image(
//                image:  new AssetImage("assets/images/multiLanguage.png"),
//                width: 30,
//                height: 30,
//            ),
//       ),
//     )]);
//   }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        // Transform(
        //   transform: Matrix4.translationValues(
        //     0.0,
        //     _translateButton.value,
        //     0.0,
        //   ),
        //   child: multiLanguage(),
        // ),
        // toggle(),
      ],
    );
  }
}