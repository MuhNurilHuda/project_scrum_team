import 'package:flutter/material.dart';

class SearchField extends StatefulWidget{
  final String initialText;
  final Function(String) onSubmit;
  final Function(String) onValueChange;

  SearchField({
    required this.initialText ,
    required this.onSubmit,
    required this.onValueChange,
    Key? key
  }) : super(key: key);

  @override
  State createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField>{
  late TextEditingController controller;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text : widget.initialText);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.done,
      controller: controller,
      onChanged: widget.onValueChange,
      onSubmitted: widget.onSubmit,
      style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white
      ),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        suffixIcon : IconButton(
            onPressed: (){
              widget.onSubmit(controller.text);
            },
            icon: Icon(
                Icons.close,
              color: Colors.white
            )
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white)
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white)
        ),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white)
        ),
      ),
    );
  }
}