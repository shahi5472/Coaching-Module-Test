import 'package:coaching_module_test/utils/constansts/dimentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class NotesBottomSheet extends StatelessWidget {
  const NotesBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: defaultPadding),
      child: Column(
        mainAxisSize: .min,
        children: [
          SizedBox(height: 20),
          HtmlWidget("""
        <div>
<h2>What is Lorem Ipsum?</h2>
<p><strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>
</div>
        """),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
