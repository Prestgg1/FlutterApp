import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int trimLines;

  const ExpandableText({super.key, required this.text, this.trimLines = 2});

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool expanded = false;
  bool overflows = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final span = TextSpan(
          text: widget.text,
          style: const TextStyle(fontSize: 15),
        );
        final tp = TextPainter(
          maxLines: widget.trimLines,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr,
          text: span,
        );
        tp.layout(maxWidth: constraints.maxWidth);
        overflows = tp.didExceedMaxLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.text,
              maxLines: expanded ? null : widget.trimLines,
              overflow: expanded ? TextOverflow.visible : TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 15),
            ),
            if (overflows)
              TextButton(
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                onPressed: () {
                  setState(() => expanded = !expanded);
                },
                child: Text(
                  expanded ? 'Gizlət' : 'Davamını oxu',
                  style: const TextStyle(color: Colors.blue),
                ),
              ),
          ],
        );
      },
    );
  }
}


/* ❯ 
java -jar openapi-generator-cli.jar generate \
      -i https://bimonet.com/openapi.json \
      -g dart-dio \
      -o flutter_api_client

dart run build_runner build --delete-conflicting-outputs


 */