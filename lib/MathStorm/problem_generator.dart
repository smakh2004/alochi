import 'package:alochi_math_app/MathStorm/math_problem.dart';
import 'dart:math';

class ProblemGenerator {
  static final Random _random = Random();

  static MathProblem generate(int score) {
    if (score < 10) return _generateEasy();
    if (score < 20) return _generateMedium();
    if (score < 30) return _generateHard();
    if (score < 40) return _generateSuperHard();
    return _generateExtraHard();
  }

  // Level 1: Easy (Addition / Subtraction)
  static MathProblem _generateEasy() {
    int a = _random.nextInt(10) + 1;
    int b = _random.nextInt(10) + 1;
    bool isAddition = _random.nextBool();
    return isAddition
        ? MathProblem(question: "$a + $b", answer: a + b)
        : MathProblem(question: "$a - $b", answer: a - b);
  }

  // Level 2: Medium (Multiplication / Parentheses)
  static MathProblem _generateMedium() {
    int a = _random.nextInt(10) + 2;
    int b = _random.nextInt(5) + 1;
    int c = _random.nextInt(5) + 1;
    int type = _random.nextInt(3);

    switch (type) {
      case 0:
        return MathProblem(question: "$a × $b", answer: a * b);
      case 1:
        return MathProblem(question: "$a + $b × $c", answer: a + b * c);
      case 2:
        return MathProblem(question: "(${a} + $b) × $c", answer: (a + b) * c);
      default:
        return MathProblem(question: "$a × $b", answer: a * b);
    }
  }

  // Level 3: Hard (Powers / Complex expressions)
  static MathProblem _generateHard() {
    int a = _random.nextInt(5) + 1;
    int b = _random.nextInt(3) + 1;
    int c = _random.nextInt(4) + 2;
    int type = _random.nextInt(4);

    switch (type) {
      case 0:
        int result = pow(a + b, 2).toInt();
        return MathProblem(question: "(${a} + $b)${toSuperscript(2)}", answer: result);
      case 1:
        int result = pow(a, 2).toInt() + b * c;
        return MathProblem(question: "${a}${toSuperscript(2)} + $b × $c", answer: result);
      case 2:
        return MathProblem(question: "(${a} + $b) × (${b} + $c)", answer: (a + b) * (b + c));
      case 3:
        int result = pow(a, 2).toInt() - pow(b, 2).toInt();
        return MathProblem(question: "${a}${toSuperscript(2)} - ${b}${toSuperscript(2)}", answer: result);
      default:
        int result = pow(a + b, 2).toInt();
        return MathProblem(question: "(${a} + $b)${toSuperscript(2)}", answer: result);
    }
  }

  // Level 4: Super Hard (Perfect Roots only)
  static MathProblem _generateSuperHard() {
    int type = _random.nextInt(3);

    switch (type) {
      case 0:
        int a = _random.nextInt(10) + 1;
        return MathProblem(question: "√${a * a}", answer: a);
      case 1:
        int b = _random.nextInt(5) + 1;
        return MathProblem(question: "∛${b * b * b}", answer: b);
      case 2:
        int a = _random.nextInt(10) + 1;
        int sum = a + 2;
        return MathProblem(question: "√($sum × $sum)", answer: sum);
      default:
        int a = _random.nextInt(10) + 1;
        return MathProblem(question: "√${a * a}", answer: a);
    }
  }

  // Level 5: Extra Hard (All integer results only)
  static MathProblem _generateExtraHard() {
    int a = _random.nextInt(5) + 1;
    int b = _random.nextInt(4) + 1;
    int c = (_random.nextInt(4) + 1) * 2; // divisible by 2
    List<int> validDivisors = [1, 2, 3, 4, 5, 6, 8].where((e) => c % e == 0).toList();
    int d = validDivisors[_random.nextInt(validDivisors.length)];
    int type = _random.nextInt(4);

    switch (type) {
      case 0:
        return MathProblem(question: "$a!", answer: _factorial(a));
      case 1:
        return MathProblem(question: "$c ÷ $d", answer: c ~/ d);
      case 2:
        int result = _factorial(a) + pow(b, 2).toInt();
        return MathProblem(question: "$a! + ${b}${toSuperscript(2)}", answer: result);
      case 3:
        int power = pow(a, 2).toInt();
        List<int> divisors = [1, 2, 4, 5].where((x) => power % x == 0).toList();
        int divisor = divisors[_random.nextInt(divisors.length)];
        return MathProblem(question: "${a}${toSuperscript(2)} ÷ $divisor", answer: power ~/ divisor);
      default:
        return MathProblem(question: "$a!", answer: _factorial(a));
    }
  }

  static int _factorial(int n) {
    return n <= 1 ? 1 : n * _factorial(n - 1);
  }

  static String toSuperscript(int number) {
    final Map<String, String> superscriptMap = {
      '0': '⁰', '1': '¹', '2': '²', '3': '³', '4': '⁴',
      '5': '⁵', '6': '⁶', '7': '⁷', '8': '⁸', '9': '⁹'
    };
    return number.toString().split('').map((e) => superscriptMap[e] ?? '').join();
  }
}
