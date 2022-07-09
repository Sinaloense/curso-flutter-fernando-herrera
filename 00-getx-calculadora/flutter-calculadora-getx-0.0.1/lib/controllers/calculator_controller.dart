import 'package:get/get.dart';

class CalculatorController extends GetxController {
  RxString firstNumber  = '10'.obs;
  RxString secondNumber = '20'.obs;
  RxString mathResult   = '30'.obs;
  RxString operation    = '+'.obs;

  void resetAll() {
    firstNumber.value   = '0';
    secondNumber.value  = '0';
    mathResult.value    = '0';
    operation.value     = '+';
  }

  void changeNegativePositive() {
    if(mathResult.value.startsWith('-')) {
      mathResult.value = mathResult.value.substring(1);
    }
    else {
      mathResult.value = '-' + mathResult.value;
    }
  }

  void addNumber(String number) {
    if(mathResult.value == '0') {
      mathResult.value = number;

      return;
    }

    if(mathResult.value == '-0') {
      mathResult.value = '-' + number;

      return;
    }

    mathResult.value = mathResult.value + number;
  }

  void addDecimalPoint() {
    if(mathResult.value.contains('.')) {
      return;
    }

    mathResult.value = mathResult.value + '.';
  }

  void selectOperation(String newOperation) {
    operation.value   = newOperation;
    firstNumber.value = mathResult.value;
    mathResult.value  = '0';
  }

  void deleteLastEntry() {
    if(mathResult.value.length == 1 ||
      mathResult.value.length == 2 && mathResult.value.startsWith('-')) {
      mathResult.value = '0';

      return;
    }

    mathResult.value = mathResult.value.substring(0, mathResult.value.length - 1);
  }

  void calculateResult() {
    double num1 = double.parse(firstNumber.value);
    double num2 = double.parse(mathResult.value);

    secondNumber.value = mathResult.value;

    switch(operation.value) {
      case '+':
        mathResult.value = '${ num1 + num2 }';
        break;
      case '-':
        mathResult.value = '${ num1 - num2 }';
        break;
      case 'X':
        mathResult.value = '${ num1 * num2 }';
        break;
      case '/':
        mathResult.value = '${ num1 / num2 }';
        break;
      default:
        return;
    }

    if(mathResult.endsWith('.0')) {
      mathResult.value = mathResult.value.substring(0, mathResult.value.length - 2);
    }
  }
}