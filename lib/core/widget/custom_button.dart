import 'package:flutter/material.dart';

import '../color/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key,
  required this.title,this.onPressed,this.isLoading=false,
  });
final String title;
final VoidCallback? onPressed;
final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: isLoading? null
            :onPressed ,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 48),
          backgroundColor: AppColor.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: isLoading ?
    SizedBox(height: 15,width: 15,child: CircularProgressIndicator(strokeWidth: 2,color: AppColor.white,),)
    :Text(title,style: TextStyle(color: AppColor.white,fontSize: 20),
        )
    );
  }
}
