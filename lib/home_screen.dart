import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'result_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _currentController = TextEditingController();
  final TextEditingController _voltageController = TextEditingController();
  final TextEditingController _powerFactorController = TextEditingController();

  bool _dataProcessingConsent = false;
  bool _showConsentError = false;

  void _clearFields() {
    _currentController.clear();
    _voltageController.clear();
    _powerFactorController.clear();
    setState(() {
      _dataProcessingConsent = false;
      _showConsentError = false;
    });
  }

  void _calculatePower() {
    setState(() {
      _showConsentError = !_dataProcessingConsent;
    });

    if (_formKey.currentState!.validate() && _dataProcessingConsent) {
      double current = double.parse(_currentController.text);
      double voltage = double.parse(_voltageController.text);
      double powerFactor = double.parse(_powerFactorController.text);

      double power = current * voltage * powerFactor;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(powerConsumption: power),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Калькулятор энергопотребления')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _currentController,
                decoration: const InputDecoration(
                  labelText: 'Ток (Амперы)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите Амперы';
                  }
                  final current = double.tryParse(value);
                  if (current == null || current < 0) {
                    return 'Пожалуйста, введите действительные Амперы';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _voltageController,
                decoration: const InputDecoration(
                  labelText: 'Напряжение (Вольты)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите напряжение';
                  }
                  final voltage = double.tryParse(value);
                  if (voltage == null || voltage < 0) {
                    return 'Пожалуйста, введите действующее напряжение';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _powerFactorController,
                decoration: const InputDecoration(
                  labelText: 'Коэффициент мощности (0-1)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите коэффициент мощности';
                  }
                  final powerFactor = double.tryParse(value);
                  if (powerFactor == null ||
                      powerFactor < 0 ||
                      powerFactor > 1) {
                    return 'Коэффициент мощности должен быть в пределах от 0 до 1';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _dataProcessingConsent,
                    onChanged: (bool? value) {
                      setState(() {
                        _dataProcessingConsent = value ?? false;
                        _showConsentError = false;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text('Я даю согласие на обработку данных'),
                  ),
                ],
              ),
              if (_showConsentError)
                Padding(
                  padding: const EdgeInsets.only(left: 48.0),
                  child: Text(
                    'Пожалуйста, согласитесь на обработку данных, чтобы программа могла произвести расчёты',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _clearFields,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    child: const Text('Очистить'),
                  ),
                  ElevatedButton(
                    onPressed: _calculatePower,
                    child: const Text('Рассчитать'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _currentController.dispose();
    _voltageController.dispose();
    _powerFactorController.dispose();
    super.dispose();
  }
}
