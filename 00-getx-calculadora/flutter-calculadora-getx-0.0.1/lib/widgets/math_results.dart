import 'package:calculadora/controllers/calculator_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:calculadora/widgets/line_separator.dart';
import 'package:calculadora/widgets/main_result.dart';
import 'package:calculadora/widgets/sub_result.dart';

class MathResults extends StatelessWidget {
  const MathResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Buscar instancia get de CalculatorController
    final calculatorCtrl = Get.find<CalculatorController>();

    debugPrint('Se encontró instancia de CalculatorController');

    return Obx(() => Column(
      children: [
        SubResult( text: '${ calculatorCtrl.firstNumber }' ),
        SubResult( text: '${ calculatorCtrl.operation }' ),
        SubResult( text: '${ calculatorCtrl.secondNumber }' ),
        LineSeparator(),
        MainResultText( text: '${ calculatorCtrl.mathResult }' ),
      ],
    ));
  }
}