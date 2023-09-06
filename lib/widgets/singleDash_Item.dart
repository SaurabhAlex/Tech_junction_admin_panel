import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleDashItem extends StatelessWidget {
  final  String title, subtitle;
  final void Function()? onPressed;
  const SingleDashItem({Key? key, required this.title, required this.subtitle, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: Card(
        child: Container(
          width: double.infinity,
          color: Theme.of(context).primaryColor.withOpacity(0.4),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: const TextStyle(fontSize:32, fontWeight: FontWeight.bold),),
              Text(subtitle, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),)
            ],
          ),
        ),
      ),
    );;
  }
}
