import 'package:flutter/material.dart';
import 'package:iterasi1/resource/custom_colors.dart';

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
    content: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            errorText: errorText,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: CustomColor.primary , width: 2),
              borderRadius: BorderRadius.circular(20)
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20)
            )
          ),
        ),

        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(top : 18),
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(CustomColor.buttonColor),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ))
                ),
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
          ),
        ),
      ],
    ),
  );
}
