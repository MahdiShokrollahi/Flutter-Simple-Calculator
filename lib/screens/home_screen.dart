import 'package:calculator_app/constant/constants.dart';
import 'package:calculator_app/main.dart';
import 'package:calculator_app/widgets/memory_list.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculateScreen extends StatefulWidget {
  CalculateScreen(
      {Key? key,
      required this.togglethememodeLight,
      required this.togglethememodeDark})
      : super(key: key);
  final Function() togglethememodeLight;
  final Function() togglethememodeDark;

  @override
  State<CalculateScreen> createState() => _CalculateScreenState();
}

class _CalculateScreenState extends State<CalculateScreen> {
  String inputUser = '';
  String result = '';
  List<String> memory = [];
  bool showMemoryPage = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 30,
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                showMemoryPage = !showMemoryPage;
                              });
                            },
                            child: Icon(
                              showMemoryPage ? Icons.close : Icons.menu,
                              color: themeData.textTheme.bodyText1!.color!,
                              size: 26,
                            )),
                      ),
                      SizedBox(width: 85),
                      Container(
                        width: 100,
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: themeData.colorScheme.surface),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: widget.togglethememodeLight,
                              child: Icon(
                                Icons.light_mode_outlined,
                                color: defaultThemeMode == ThemeMode.dark
                                    ? Colors.grey
                                    : Colors.black,
                                size: 25,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: widget.togglethememodeDark,
                              child: Icon(
                                Icons.dark_mode_outlined,
                                color: defaultThemeMode == ThemeMode.dark
                                    ? Colors.white
                                    : Colors.grey,
                                size: 25,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, top: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(inputUser,
                            textAlign: TextAlign.end,
                            style: themeData.textTheme.bodyText1),
                        SizedBox(height: 10),
                        Text(
                          result,
                          style: themeData.textTheme.headline6,
                          textAlign: TextAlign.end,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 70,
              child: showMemoryPage
                  ? MemoryList(
                      memory: memory,
                      currentExpression: inputUser,
                      callback: memoryCallBack)
                  : keyboardLayout(themeData),
            )
          ],
        ),
      ),
    );
  }

  Widget keyboardLayout(ThemeData themeData) {
    return Container(
      decoration: BoxDecoration(
          color: themeData.colorScheme.surface,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          getRow('ac', 'ce', '%', '/'),
          getRow('7', '8', '9', '*'),
          getRow('4', '5', '6', '-'),
          getRow('1', '2', '3', '+'),
          getRow('00', '0', '.', '='),
        ],
      ),
    );
  }

  void memoryCallBack(String expressions) {
    expressions = inputUser;
  }

  void buttonPressed(String text) {
    setState(() {
      inputUser = inputUser + text;
    });
  }

  bool isOpreator(String text) {
    var list = ['ac', 'ce', '%', '/', '*', '-', '+', '='];
    for (var item in list) {
      if (text == item) {
        return true;
      }
    }
    return false;
  }

  Color getTextColor(String text) {
    var list = ['ac', 'ce', '='];
    for (var item in list) {
      if (isOpreator(text) && text == item) {
        return DarkColors.leftOperatorColor;
      }
    }
    if (isOpreator(text)) {
      return LightColors.operatorColor;
    }
    return Theme.of(context).textTheme.bodyText2!.color!;
  }

  Widget getRow(String text1, String text2, String text3, String text4) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
              style: Theme.of(context).textButtonTheme.style,
              onPressed: () {
                if (text1 == 'ac') {
                  setState(() {
                    inputUser = '';
                    result = '';
                  });
                } else {
                  buttonPressed(text1);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: Text(
                  text1,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .apply(color: getTextColor(text1)),
                ),
              )),
          TextButton(
              style: Theme.of(context).textButtonTheme.style,
              onPressed: () {
                if (text2 == 'ce') {
                  setState(() {
                    if (inputUser.length > 0) {
                      inputUser = inputUser.substring(0, inputUser.length - 1);
                    }
                  });
                } else {
                  buttonPressed(text2);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: Text(
                  text2,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .apply(color: getTextColor(text2)),
                ),
              )),
          TextButton(
              style: Theme.of(context).textButtonTheme.style,
              onPressed: () {
                buttonPressed(text3);
              },
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: Text(
                  text3,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .apply(color: getTextColor(text3)),
                ),
              )),
          TextButton(
              style: Theme.of(context).textButtonTheme.style,
              onPressed: () {
                if (text4 == '=') {
                  Parser parser = Parser();
                  Expression expression = parser.parse(inputUser);
                  ContextModel contextModel = ContextModel();
                  double eval =
                      expression.evaluate(EvaluationType.REAL, contextModel);
                  memory.add(inputUser);
                  setState(() {
                    result = eval.toString();
                  });
                } else {
                  buttonPressed(text4);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: Text(
                  text4,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .apply(color: getTextColor(text4)),
                ),
              )),
        ],
      );
}
