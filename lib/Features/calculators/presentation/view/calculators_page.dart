import 'package:flutter/material.dart';
import 'package:true_gym/Features/calculators/presentation/view/widgets/calculator_page_body.dart';
import 'package:true_gym/consts.dart';

class CalculatorsPage extends StatelessWidget {
  const CalculatorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
              const SliverAppBar(
                centerTitle: true,
                backgroundColor: MyColors.appBarColor,
                title: Text("Calculators"),
                elevation: 2,
                floating: true,
                snap: true,
                shadowColor: MyColors.shadowColor,
              )
            ],
        body: const CalculatorsPageBody());
  }
}
