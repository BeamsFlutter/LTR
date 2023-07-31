import 'package:flutter/material.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:ltr/views/components/enum.dart';


class CustomTextField extends StatefulWidget {
  const CustomTextField({Key? key,required this.controller,this.textFormFieldType,required this.hintText,
    this.keybordType, this.editable, this.maxCount,  this.fnOnChange, this.focusNode
  }) : super(key: key);

  final TextEditingController controller;
  final TextFormFieldType? textFormFieldType;
  final String? hintText;
  final int? maxCount;
  final bool? editable;
  final TextInputType ? keybordType;
  final Function? fnOnChange;
  final FocusNode? focusNode;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  bool _isObsecure = true;
  obSecureBtnTapped(){
    setState(() {
      _isObsecure = !_isObsecure;
    });


  }

  getSuffixIcon(textFormFieldType) {
    if (widget.textFormFieldType == TextFormFieldType.passwrd ) {
      return GestureDetector(
          onTap: () {
           obSecureBtnTapped();
          },
          child: _isObsecure
              ?  const Icon(
            Icons.visibility_off,
            color: Colors.black54,
            size: 23,
          )
              : const Icon(
            Icons.visibility,
            color: Colors.black54,
            size: 23,
          ));
    }
    else     if (widget.textFormFieldType == TextFormFieldType.confirmPasswrd ) {
      return GestureDetector(
          onTap: () {
            obSecureBtnTapped();
          },
          child: _isObsecure
              ?  const Icon(
            Icons.visibility_off,
            color: Colors.black54,
            size: 23,
          )
              : const Icon(
            Icons.visibility,
            color: Colors.black54,
            size: 23,
          ));
    }
    else     if (widget.textFormFieldType == TextFormFieldType.weeklyCreditLimit ) {
      return   const Padding(
        padding: EdgeInsets.only(top: 10,left: 18),
        child: Text(
          '\u{20B9}',
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
            fontWeight: FontWeight.w400
          ),

        ),
      );
    }
    else     if (widget.textFormFieldType == TextFormFieldType.dailyCreditLimit ) {
      return   const Padding(
        padding: EdgeInsets.only(top: 10,left: 18),
        child: Text(
          '\u{20B9}',
          style: TextStyle(
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.w400
          ),

        ),
      );
    }

    else const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.maxCount == 0?1000:widget.maxCount,
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText:
      widget.textFormFieldType == TextFormFieldType.passwrd ||  widget.textFormFieldType == TextFormFieldType.confirmPasswrd
          ? _isObsecure
          : false,keyboardType: widget.keybordType,
      enabled: widget.editable??true,
      onChanged: (value){
        try{
          widget.fnOnChange!(value);
        }catch(e){
          dprint(e);
        }
      },
      decoration:  InputDecoration(
          counterText: "",
          border: const OutlineInputBorder(),
          suffixIcon: getSuffixIcon(widget.textFormFieldType),
          labelText: widget.hintText,
          labelStyle: const TextStyle(
            color: Color(0xff546f9a)
          ),
          focusedBorder:  const OutlineInputBorder(

            borderSide: BorderSide(color:Color(0xff546f9a)),
          ),
      ),
    );
  }
}
