import 'package:flutter/material.dart';

Future<T?> showTextDialog<T> (
  BuildContext context, {
    required String title,
    required String value,
}) =>
    showDialog<T>(
      context: context,
      builder: (context) => TextDialogWidget(
        title: title,
        value: value,
      ),
    );

class TextDialogWidget extends StatefulWidget {
  final String title;
  final String value;
  const TextDialogWidget({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  State<TextDialogWidget> createState() => _TextDialogWidgetState();
}

class _TextDialogWidgetState extends State<TextDialogWidget> {
  late TextEditingController controller;
  String? errorText;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.value);
  }

  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.title),
    content: TextField(
      controller: controller,
      decoration: InputDecoration(
        errorText: errorText,
        border: OutlineInputBorder()
      ),
    ),
    actions: [
      ElevatedButton(
        child: Text('Done'),
        onPressed: (){
          if (controller.text.isNotEmpty)
            Navigator.of(context).pop(controller.text);
          else
            setState(() {
              errorText = "Judul tidak boleh kosong!";
            });
        }
      ),
    ],
  );
}
