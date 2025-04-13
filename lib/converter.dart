import 'package:flutter/material.dart';

class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  TextEditingController textController = TextEditingController();
  double result = 0;
  String? errorText;
  final double conversionRate = 0.0026;

  void showMessage(String message, {bool isError = false}) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: isError ? const Color.fromARGB(255, 174, 31, 222) : const Color.fromARGB(255, 86, 23, 153),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void convert() {
    final input = textController.text.trim();

    if (input.isEmpty) {
      setState(() {
        errorText = "You must have to give INPUT";
        result = 0;
      });
      showMessage("Please enter the value", isError: true);
      return;
    }

    try {
      final usd = double.parse(input);
      setState(() {
        result = usd * conversionRate;
        errorText = null;
      });
      showMessage("Conversion successful!");
    } catch (e) {
      setState(() {
        errorText = "Invalid number";
        result = 0;
      });
      showMessage("Enter a valid number", isError: true);
    }
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 224, 26, 161), Color.fromARGB(255, 180, 36, 191)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    "USD To BDT Convert",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(20),
                    
                    child: Column(
                      children: [
                        const Text(
                          "USD ",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(179, 221, 214, 221),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          controller: textController,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          style: const TextStyle(color: Color.fromARGB(255, 143, 55, 131)),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.2),
                            labelText: "Enter USD",
                            labelStyle: const TextStyle(color: Colors.white70),
                            
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            errorText: errorText,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: convert,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 253, 253, 253),
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 40,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 8,
                          ),
                          child: const Text(
                            "Convert",
                            style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 11, 11, 11)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    child: Column(
                      children: [
                        const Text(
                          "BDT",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "৳ ${result.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 252, 255, 254),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
