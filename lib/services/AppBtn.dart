import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';



class AppBtn extends StatelessWidget {
  final String? title;
  final AnimationController? btnCntrl;
  final Animation? btnAnim;
  final VoidCallback? onBtnSelected;

  const AppBtn(
      {Key? key, this.title, this.btnCntrl, this.btnAnim, this.onBtnSelected})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
      builder: _buildBtnAnimation,
      animation: btnCntrl!,
    );
  }



  Widget _buildBtnAnimation(BuildContext context, Widget? child) {
    return Padding(
      padding: EdgeInsets.only(top: 25),
      child: CupertinoButton(
        child: Container(
          width: 50,
          height: 50,


          alignment: FractionalOffset.center,
          decoration: new BoxDecoration(
            color: colors.primary,

            borderRadius: new BorderRadius.all(const Radius.circular(30.0)),
          ),
          child: Icon(Icons.arrow_forward_ios,color: colors.blackTemp,),
          // child: btnAnim!.value > 75.0
          //     ? Text(title!,
          //     textAlign: TextAlign.center,
          //     style: Theme
          //         .of(context)
          //         .textTheme
          //         .headline6!
          //         .copyWith(color: colors.whiteTemp, fontWeight: FontWeight.normal))
          //     : new CircularProgressIndicator(
          //   valueColor: new AlwaysStoppedAnimation<Color>(colors.whiteTemp),
          // ),
        ),

        onPressed: () {
          onBtnSelected!();
        },
      ),
    );
  }

}
