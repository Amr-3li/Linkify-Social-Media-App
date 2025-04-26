import 'package:flutter/material.dart';
import 'package:linkify/Features/add_friend/presentation/view/widgets/my_request_item.dart';

class MyRequestsList extends StatelessWidget {
  const MyRequestsList({
    super.key,
  });
  Future<void> _onRefresh() async {
    // هنا تحط لوجيك الريفرش اللي انت عايزه
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 20,
      color: Colors.green,
      backgroundColor: Colors.white,
      strokeWidth: 2,
      onRefresh: _onRefresh,
      child: ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index) => const MyRequestItem(),
      ),
    );
  }
}
