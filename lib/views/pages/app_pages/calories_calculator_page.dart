import 'package:flutter/material.dart';

class CaloriesCalculatorPage extends StatefulWidget {
  const CaloriesCalculatorPage({super.key});

  @override
  State<CaloriesCalculatorPage> createState() => _CaloriesCalculatorPageState();
}

class _CaloriesCalculatorPageState extends State<CaloriesCalculatorPage> {
  int currentIndex = 0;
  var heightController = TextEditingController();
  var weightController = TextEditingController();
  var ageController = TextEditingController();
  var dropDownValue = 1.25;

  String resultText = "";

  double? tryParseDouble(String value) {
    try {
      return double.parse(value);
    } catch (e) {
      return null;
    }
  }

  void calculateCalories() {
    var height = tryParseDouble(heightController.text);
    var weight = tryParseDouble(weightController.text);
    var age = tryParseDouble(ageController.text);

    if (height == null || weight == null || age == null) {
      setState(() {
        resultText = "Please enter valid numbers";
      });
      return;
    }

    var result = 0.0;
    if (currentIndex == 0) {
      result = (10 * weight) + (6.25 * height) - (5 * age) + 5;
    } else {
      result = (10 * weight) + (6.25 * height) - (5 * age) - 161;
    }
    setState(() {
      resultText = (result * dropDownValue).toStringAsFixed(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 30, 30, 30),
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Calories Calculator in day ',
          style: TextStyle(color: Colors.white),
        )),
        backgroundColor: const Color.fromARGB(255, 99, 99, 99),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  radioButton('Male', Colors.blue, 0),
                  const SizedBox(
                    width: 20,
                  ),
                  radioButton('Female', Colors.pink, 1),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                '   Height in Cm',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(
                height: 5,
              ),
              inputText(
                controler: heightController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                '   weight in kg',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(
                height: 5,
              ),
              inputText(
                controler: weightController,
                keyboardType: TextInputType.number,
              ),
              
              const SizedBox(
                height: 20,
              ),
              const Text(
                '   Age',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(
                height: 5,
              ),
              inputText(
                controler: ageController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: AlignmentDirectional.center,
                child: activityStat(),
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: AlignmentDirectional.center,
                child: calculateButton(),
              ),
              const SizedBox(
                height: 30,
              ),
              const Align(
                alignment: AlignmentDirectional.center,
                child: Text(
                  "amount of calories :",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: AlignmentDirectional.center,
                child: Text(
                  resultText,
                  style: const TextStyle(
                      color: Colors.green,
                      fontSize: 40,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 70,
              ),
            ],
          ),
        ),
      ),
    );
  }

  DropdownButton<double> activityStat() {
    return DropdownButton(
      iconEnabledColor: Colors.white,
      value: dropDownValue,
      onChanged: (value) {
        dropDownValue = value as double;
        setState(() {});
      },
      borderRadius: BorderRadius.circular(20),
      dropdownColor: const Color.fromARGB(255, 69, 68, 68),
      isExpanded: true,
      underline: const SizedBox(),
      iconSize: 30,
      icon: const Icon(Icons.keyboard_arrow_down),
      style: const TextStyle(color: Colors.white),
      items: const [
        DropdownMenuItem(
          value: 1.25,
          child: Text(
            "sedentary",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        DropdownMenuItem(
          value: 1.375,
          child: Text(
            "light",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        DropdownMenuItem(
          value: 1.550,
          child: Text(
            "medium",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        DropdownMenuItem(
          value: 1.725,
          child: Text(
            "heavy",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        DropdownMenuItem(
          value: 1.9,
          child: Text(
            "very heavy",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    );
  }

  ElevatedButton calculateButton() {
    return ElevatedButton(
      onPressed: () {
        calculateCalories();
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          const Color.fromARGB(255, 14, 1, 56),
        ),
        fixedSize: WidgetStateProperty.all(
          const Size(300, 60),
        ),
      ),
      child: const Text(
        'Calculate',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  TextField inputText({
    required TextEditingController controler,
    required TextInputType keyboardType,
  }) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      keyboardType: keyboardType,
      controller: controler,
      decoration: const InputDecoration(
        filled: true,
        fillColor: Color.fromARGB(255, 0, 0, 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  chagngeIndex(int index) {
    currentIndex = index;
    setState(() {});
  }

  Widget radioButton(String value, Color color, int index) {
    return Expanded(
      child: SizedBox(
        height: 150,
        child: ElevatedButton(
          onPressed: () {
            chagngeIndex(index);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                currentIndex == index ? color : Color.fromARGB(255, 0, 0, 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          child: buttonContent(index, value),
        ),
      ),
    );
  }

  Column buttonContent(int index, String value) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 60,
          width: 60,
          child: Image(
              color: Colors.white,
              image: index == 0
                  ? const AssetImage("assets/icons/male.png")
                  : const AssetImage("assets/icons/female.png"),
              fit: BoxFit.fill),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          value,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ],
    );
  }
}
