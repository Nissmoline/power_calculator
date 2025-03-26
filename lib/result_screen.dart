import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final double powerConsumption;

  const ResultScreen({super.key, required this.powerConsumption});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Результат')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Потребляемая мощность:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              '${powerConsumption.toStringAsFixed(2)} Ват',
              style: const TextStyle(
                fontSize: 36,
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Назад к главному меню'),
            ),
          ],
        ),
      ),
    );
  }
}
