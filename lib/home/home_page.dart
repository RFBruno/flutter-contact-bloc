import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('home'),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          children: [
            _cardButton(context, 'Example', '/bloc/example'),
            _cardButton(context, 'Example Freezed', '/bloc/example'),
            _cardButton(context, 'Contact', '/bloc/example'),
            _cardButton(context, 'Contact Cubit', '/bloc/example'),
          ],
        ),
      ),
    );
  }

  InkWell _cardButton(BuildContext context, label, route) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        Navigator.of(context).pushNamed(route);
      },
      child: Card(
        color: Colors.indigo.shade100,
        elevation: 5,
        child: Center(
          child: Text(label),
        ),
      ),
    );
  }
}
