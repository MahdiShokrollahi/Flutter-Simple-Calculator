import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class MemoryList extends StatelessWidget {
  const MemoryList(
      {Key? key,
      required this.memory,
      required this.currentExpression,
      required this.callback})
      : super(key: key);
  final List<String> memory;
  final String currentExpression;
  final Function(String) callback;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: themeData.colorScheme.surface,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Padding(
        padding: EdgeInsets.all(20),
        child:
            memory.length > 0 ? getList(themeData) : getEmptyMessage(themeData),
      ),
    );
  }

  Widget getList(ThemeData themeData) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (String experssion in memory) getListItem(experssion, themeData)
        ],
      ),
    );
  }

  Widget getListItem(String experssion, ThemeData themeData) {
    Parser parser = Parser();
    Expression expression = parser.parse(experssion);
    ContextModel contextModel = ContextModel();
    double eval = expression.evaluate(EvaluationType.REAL, contextModel);
    return GestureDetector(
        onTap: callback(experssion),
        child: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: currentExpression == experssion
                  ? Colors.blueAccent.withOpacity(0.2)
                  : themeData.colorScheme.onSurface.withOpacity(0.02),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
              ),
              Text(
                experssion,
                style: TextStyle(
                  color: themeData.colorScheme.onSurface.withOpacity(0.8),
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                ),
              ),
              Divider(
                color: themeData.colorScheme.onSurface.withOpacity(0.1),
                height: 20,
              ),
              Text(
                eval.toString(),
                style: TextStyle(
                  color: themeData.colorScheme.onSurface.withOpacity(0.8),
                  fontWeight: FontWeight.w300,
                  fontSize: 46,
                ),
              )
            ],
          ),
        ));
  }

  Widget getEmptyMessage(ThemeData themeData) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.hourglass_disabled_rounded,
          color: themeData.colorScheme.onSurface.withOpacity(0.8),
          size: 46,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'There are no mathematical expressions',
          style: TextStyle(
            color: themeData.colorScheme.onSurface.withOpacity(0.8),
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        )
      ],
    );
  }
}
