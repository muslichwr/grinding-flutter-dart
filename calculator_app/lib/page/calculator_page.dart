import 'package:flutter/material.dart';

// Halaman utama aplikasi kalkulator
class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  // Variabel untuk menyimpan input pengguna dan hasil
  String _input = ''; // Input saat ini (misalnya: "123")
  String _result = '0'; // Hasil yang ditampilkan di layar
  double? _firstOperand; // Operand pertama (misalnya: 10)
  double? _secondOperand; // Operand kedua (misalnya: 5)
  String? _operator; // Operator yang dipilih (+, -, ×, ÷)

  // Daftar tombol kalkulator (format: baris x kolom)
  final List<List<String>> _buttons = [
    ['C', '÷', '×', '-'],
    ['7', '8', '9', '+'],
    ['4', '5', '6', '='],
    ['1', '2', '3', '0'],
    ['.', '', '', ''],
  ];

  // Fungsi utama untuk menangani tekanan tombol
  void _onButtonPressed(String value) {
    setState(() {
      // Jika tombol "C" ditekan, reset semua state
      if (value == 'C') {
        _input = '';
        _result = '0';
        _firstOperand = null;
        _secondOperand = null;
        _operator = null;
        return;
      }

      // Jika tombol "=" ditekan, lakukan perhitungan
      if (value == '=') {
        if (_input.isNotEmpty && _operator != null && _firstOperand != null) {
          _secondOperand = double.tryParse(_input);
          double result = 0;

          // Lakukan operasi sesuai operator
          switch (_operator) {
            case '+':
              result = _firstOperand! + _secondOperand!;
              break;
            case '-':
              result = _firstOperand! - _secondOperand!;
              break;
            case '×':
              result = _firstOperand! * _secondOperand!;
              break;
            case '÷':
              if (_secondOperand == 0) {
                _result = 'Error';
                return;
              }
              result = _firstOperand! / _secondOperand!;
              break;
          }

          // Update hasil dan reset operand/operator
          _result = result.toString();
          _input = result.toString();
          _firstOperand = null;
          _secondOperand = null;
          _operator = null;
        }
        return;
      }

      // Jika tombol operator (+, -, ×, ÷) ditekan
      if ('+-×÷'.contains(value)) {
        if (_input.isNotEmpty && _firstOperand == null) {
          // Simpan operand pertama dan operator
          _firstOperand = double.tryParse(_input);
          _operator = value;
          _input = ''; // Reset input untuk operand kedua
        }
        return;
      }

      // Jika tombol angka atau titik desimal ditekan
      _input += value;
      _result = _input;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Bagian layar kalkulator
          _buildDisplay(),

          // Bagian tombol kalkulator
          Expanded(
            child: Container(
              color: Colors.grey[900],
              child: _buildButtonGrid(),
            ),
          ),
        ],
      ),
    );
  }

  // Membuat tampilan layar kalkulator
  Widget _buildDisplay() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      alignment: Alignment.bottomRight,
      child: Text(
        _result,
        style: const TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildButtonGrid() {
    return GridView.count(
      crossAxisCount: 4,
      children:
          _buttons
              .expand(
                (row) => row.map((value) => _buildCalculatorButton(value)),
              )
              .toList(),
    );
  }

  Widget _buildCalculatorButton(String value) {
    if (value.isEmpty) return const SizedBox();

    final bool isOperator = '+-×÷='.contains(value);
    final bool isClear = value == 'C';

    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isClear
                  ? Colors.grey[300]
                  : isOperator
                  ? Colors.orange
                  : Colors.grey[800],
          foregroundColor: isClear ? Colors.black : Colors.white,
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          textStyle: const TextStyle(fontSize: 24),
        ),
        onPressed: () => _onButtonPressed(value),
        child: Text(value),
      ),
    );
  }
}
