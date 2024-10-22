import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:true_gym/bloc/cubit/exersiese_calculator/exersiese_cubit.dart';
import 'package:true_gym/views/widgets/basic_bages_Color.dart';
import 'package:true_gym/views/widgets/input_text.dart';

class ExersiesesCalculator extends StatefulWidget {
  const ExersiesesCalculator({super.key});

  @override
  State<ExersiesesCalculator> createState() => _ExersiesesCalculatorState();
}

class _ExersiesesCalculatorState extends State<ExersiesesCalculator> {
  double weightValue = 40, timeValue = 30;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BasicBagesColor(
        body: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Exersieses Calculator'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              InputTextField(
                hintText: "Exersiese Name",
                controller: controller,
                color: Colors.black,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Weight: ${weightValue.round()}",
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              Slider(
                value: weightValue,
                onChanged: (value) {
                  setState(() {
                    weightValue = value;
                  });
                },
                min: 30,
                max: 150,
                divisions: 150,
                label: weightValue.round().toString(),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "time of exersie: ${timeValue.round()} min",
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              Slider(
                value: timeValue,
                onChanged: (value) {
                  setState(() {
                    timeValue = value;
                  });
                },
                min: 0,
                max: 150,
                divisions: 150,
                label: timeValue.round().toString(),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    fixedSize: WidgetStateProperty.all(const Size(300, 50)),
                    backgroundColor: WidgetStateProperty.all(
                        const Color.fromARGB(255, 65, 0, 0))),
                onPressed: () {
                  BlocProvider.of<ExersieseCalculatorCubit>(context).getExersiesesCalculator(
                      weightValue, controller.text, timeValue.round());
                },
                child: const Text(
                  'Calculate',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              BlocBuilder<ExersieseCalculatorCubit, ExersieseCalculatorState>(
                builder: (context, state) {
                  if (state is ExersieseCalculatorLoaded) {
                    return Column(
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          state.exersieses.name.toString(),
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "spent Time ${state.exersieses.time.toString()} min",
                          style: const TextStyle(
                              fontSize: 20, color: Colors.black),
                        ),
                        const SizedBox(height: 20),
                        Text(
                            "Calories spent ${state.exersieses.calories.toString()} kCal",
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    );
                  } else if (state is ExersieseCalculatorError) {
                    return Column(
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          state.error.toString(),
                          style:
                              const TextStyle(color: Colors.red, fontSize: 20),
                        ),
                      ],
                    );
                  } else if (state is ExersieseCalculatorLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    ));
  }
}
