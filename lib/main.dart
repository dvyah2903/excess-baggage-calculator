import 'package:flutter/material.dart';

import 'about_page.dart';

const navyBlue = Color(0xFF163A5F);
const skyBlue = Color(0xFF3478A8);
const softGold = Color(0xFFEFCB70);
const ivory = Color(0xFFF5F6F8);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Excess Baggage Calculator',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: navyBlue,
          secondary: softGold,
          surface: ivory,
        ),
        scaffoldBackgroundColor: ivory,
        appBarTheme: const AppBarTheme(
          backgroundColor: navyBlue,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const BaggageCalculatorPage(),
    );
  }
}

class BaggageCalculatorPage extends StatefulWidget {
  const BaggageCalculatorPage({super.key});

  @override
  State<BaggageCalculatorPage> createState() => _BaggageCalculatorPageState();
}

class _BaggageCalculatorPageState extends State<BaggageCalculatorPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _weightController = TextEditingController();

  final TextEditingController _rateController = TextEditingController();

  String _ticketClass = 'Economy';

  double? _excessWeight;
  double? _excessCharge;
  double? _totalPayable;

  void _calculateFee() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    double baggageWeight = double.parse(_weightController.text);

    double rate = double.parse(_rateController.text);

    double allowance = _ticketClass == 'Economy' ? 20.0 : 40.0;

    double excessWeight = baggageWeight - allowance;

    if (excessWeight < 0) {
      excessWeight = 0;
    }

    double excessCharge = excessWeight * rate;

    double totalPayable = excessCharge + (excessCharge * 0.08);

    setState(() {
      _excessWeight = excessWeight;
      _excessCharge = excessCharge;
      _totalPayable = totalPayable;
    });
  }

  @override
  void dispose() {
    _weightController.dispose();
    _rateController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration({
    required String label,
    String? hint,
    IconData? icon,
    String? suffix,
    String? prefix,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: icon == null ? null : Icon(icon, color: skyBlue),
      prefixText: prefix,
      suffixText: suffix,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE0E4EA)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE0E4EA)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: navyBlue, width: 1.8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // NAVIGATION DRAWER
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: navyBlue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(Icons.luggage, color: softGold, size: 45),
                  SizedBox(height: 12),
                  Text(
                    'Excess Baggage Calculator',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Travel Without Worries!',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: const Icon(Icons.home, color: navyBlue),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.info, color: navyBlue),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutPage()),
                );
              },
            ),
          ],
        ),
      ),

      // APP BAR
      appBar: AppBar(
        title: const Text(
          'Excess Baggage Calculator',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),

      // HOME PAGE
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // INTRODUCTION BANNER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: navyBlue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.luggage, color: softGold, size: 42),
                    SizedBox(height: 14),
                    Text(
                      'Travel Without Worries!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 7),
                    Text(
                      'Calculate your excess baggage fees '
                      'before your flight.',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              const Text(
                'Baggage Information',
                style: TextStyle(
                  color: navyBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              // BAGGAGE WEIGHT
              TextFormField(
                controller: _weightController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: _inputDecoration(
                  label: 'Baggage Weight (kg)',
                  hint: 'Example: 25',
                  icon: Icons.scale,
                  suffix: 'kg',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter baggage weight';
                  }

                  double? weight = double.tryParse(value);

                  if (weight == null || weight < 0) {
                    return 'Enter a valid non-negative weight';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 18),

              // TICKET CLASS
              DropdownButtonFormField<String>(
                initialValue: _ticketClass,
                decoration: _inputDecoration(
                  label: 'Ticket Class',
                  icon: Icons.airplane_ticket,
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Economy',
                    child: Text('Economy (20 kg allowance)'),
                  ),
                  DropdownMenuItem(
                    value: 'Business',
                    child: Text('Business (40 kg allowance)'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _ticketClass = value!;
                    _excessWeight = null;
                    _excessCharge = null;
                    _totalPayable = null;
                  });
                },
              ),

              const SizedBox(height: 18),

              // BAGGAGE RATE
              TextFormField(
                controller: _rateController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: _inputDecoration(
                  label: 'Excess Baggage Rate',
                  hint: 'Example: 15',
                  icon: Icons.payments,
                  prefix: 'RM ',
                  suffix: '/ kg',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter baggage rate';
                  }

                  double? rate = double.tryParse(value);

                  if (rate == null || rate < 0) {
                    return 'Enter a valid non-negative rate';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 28),

              // CALCULATE BUTTON
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: _calculateFee,
                  icon: const Icon(Icons.calculate),
                  label: const Text(
                    'Calculate Baggage Fee',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: softGold,
                    foregroundColor: navyBlue,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // CALCULATION RESULTS
              if (_excessWeight != null) ...[
                const Text(
                  'Calculation Results',
                  style: TextStyle(
                    color: navyBlue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: softGold, width: 1.5),
                  ),
                  child: Column(
                    children: [
                      _resultRow(
                        'Excess Baggage Weight',
                        '${_excessWeight!.toStringAsFixed(2)} kg',
                      ),

                      const Divider(height: 28),

                      _resultRow(
                        'Excess Baggage Charge',
                        'RM ${_excessCharge!.toStringAsFixed(2)}',
                      ),

                      const Divider(height: 28),

                      _resultRow(
                        'Total Amount Payable (8% Tax)',
                        'RM ${_totalPayable!.toStringAsFixed(2)}',
                        isTotal: true,
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 22),

              const Center(
                child: Text(
                  'Service tax: 8%',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // RESULT ROW
  Widget _resultRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 14 : 13,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: navyBlue,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 17 : 15,
            fontWeight: FontWeight.bold,
            color: isTotal ? navyBlue : Colors.black87,
          ),
        ),
      ],
    );
  }
}
