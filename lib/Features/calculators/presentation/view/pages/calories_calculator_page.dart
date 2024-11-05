import 'package:flutter/material.dart';
import 'package:true_gym/views/widgets/input_text.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Calories Calculator in day ',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 99, 99, 99),
        centerTitle: true,
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
              Row(children: [
                radioButton('Male', Colors.blue, 0),
                const SizedBox(width: 20),
                radioButton('Female', Colors.pink, 1)
              ]),
              const SizedBox(height: 20),
              InputTextField(
                  hintText: "Height in Cm",
                  controller: heightController,
                  isnumber: true,
                  color: Colors.black),
              const SizedBox(height: 20),
              InputTextField(
                  hintText: '   weight in kg',
                  controller: weightController,
                  isnumber: true,
                  color: Colors.black),
              const SizedBox(height: 20),
              InputTextField(
                hintText: "Age",
                controller: ageController,
                isnumber: true,
                color: Colors.black,
              ),
              const SizedBox(height: 30),
              Align(
                  alignment: AlignmentDirectional.center,
                  child: activityStat()),
              const SizedBox(height: 30),
              Align(
                  alignment: AlignmentDirectional.center,
                  child: calculateButton()),
              const SizedBox(height: 30),
              const Align(
                  alignment: AlignmentDirectional.center,
                  child: Text("amount of calories :",
                      style: TextStyle(color: Colors.white, fontSize: 30))),
              const SizedBox(height: 30),
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
              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
    );
  }

  DropdownButton<double> activityStat() {
    return DropdownButton(
      iconEnabledColor: const Color.fromARGB(255, 0, 0, 0),
      value: dropDownValue,
      onChanged: (value) {
        dropDownValue = value as double;
        setState(() {});
      },
      borderRadius: BorderRadius.circular(20),
      dropdownColor: const Color.fromARGB(255, 69, 68, 68),
      isExpanded: true,
      underline: Container(
        height: 2,
        color: const Color.fromARGB(255, 0, 0, 0),
      ),
      iconSize: 30,
      icon: const Icon(Icons.keyboard_arrow_down),
      style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
      alignment: AlignmentDirectional.center,
      items: const [
        DropdownMenuItem(
          value: 1.25,
          child: Text(
            "sedentary",
            style:
                TextStyle(color: Color.fromARGB(255, 77, 255, 0), fontSize: 20),
          ),
        ),
        DropdownMenuItem(
          value: 1.375,
          child: Text(
            "light",
            style: TextStyle(
                color: Color.fromARGB(255, 242, 255, 0), fontSize: 20),
          ),
        ),
        DropdownMenuItem(
          value: 1.550,
          child: Text(
            "medium",
            style: TextStyle(
                color: Color.fromARGB(255, 255, 200, 0), fontSize: 20),
          ),
        ),
        DropdownMenuItem(
          value: 1.725,
          child: Text(
            "heavy",
            style: TextStyle(
                color: Color.fromARGB(255, 255, 149, 0), fontSize: 20),
          ),
        ),
        DropdownMenuItem(
          value: 1.9,
          child: Text(
            "very heavy",
            style:
                TextStyle(color: Color.fromARGB(255, 255, 0, 0), fontSize: 20),
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
        // enabledBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.all(Radius.circular(20)),
        //   borderSide: BorderSide.none,
        // ),
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
            backgroundColor: const Color.fromARGB(180, 237, 237, 237),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(
                    width: 3,
                    color: currentIndex == index
                        ? color
                        : const Color.fromARGB(255, 140, 140, 140))),
          ),
          child: buttonContent(index, value, color),
        ),
      ),
    );
  }

  Column buttonContent(int index, String value, Color color) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 60,
          width: 60,
          child: Image(
              color: currentIndex == index
                  ? color
                  : const Color.fromARGB(255, 255, 255, 255),
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
          style: TextStyle(
              color: currentIndex == index
                  ? color
                  : const Color.fromARGB(255, 255, 255, 255),
              fontSize: 20),
        ),
      ],
    );
  }
}
