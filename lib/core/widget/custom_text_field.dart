import 'package:flutter/material.dart';
import 'package:untitled7/core/color/app_colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({super.key,
  required this.controller,
    required this.label,
    this.obscure=false,
    this.keyboardType = TextInputType.text,
    this.validator,
     required this.prefixIcon});
  final TextEditingController controller;
  final String label;
  final bool obscure;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final IconData prefixIcon;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureState = false;
  @override
  void initState() {
    obscureState = widget.obscure;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.obscure,
      keyboardType: widget.keyboardType,
      decoration:InputDecoration(
        labelText: widget.label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
        contentPadding: EdgeInsets.symmetric(horizontal: 12,vertical: 14),
       suffixIcon:widget.obscure?
       IconButton(
         icon: Icon(obscureState?Icons.visibility_off:Icons.visibility,color: AppColor.black,),
           onPressed: (){
           setState(() {
             obscureState =!obscureState;
           });
           },
           ):null,
      )

    );
  }
}
