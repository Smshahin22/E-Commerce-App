import 'package:e_commerce/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ProductStepper extends StatefulWidget {
  final Function(int currentValue) onDecrement, onIncrement;
  const ProductStepper({Key? key, required this.onDecrement, required this.onIncrement}) : super(key: key);

  @override
  State<ProductStepper> createState() => _ProductStepperState();
}

class _ProductStepperState extends State<ProductStepper> {
  int _currentValue = 1;
  final TextEditingController _stepperTeController =
      TextEditingController(text: '1');
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        stepperButton(onTap: () {
          if (_currentValue > 1) {
            _currentValue--;
            _stepperTeController.text = _currentValue.toString();
            widget.onDecrement(_currentValue);
          }
        }, iconData: Icons.remove),

        SizedBox(
          width: 50,
          height: 30,
          child: TextField(
            controller: _stepperTeController,
            enabled: false,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500
            ),
            decoration: const InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none)),
          ),
        ),
        stepperButton(onTap: () {
          if (_currentValue < 20) {
            _currentValue++;
            widget.onIncrement(_currentValue);
            _stepperTeController.text = _currentValue.toString();

          }
        },
            iconData: Icons.add),
      ],
    );
  }

  Widget stepperButton({required VoidCallback onTap, required IconData iconData}) {
    return SizedBox(
      width: 30,
      height: 30,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              color: primaryColor, borderRadius: BorderRadius.circular(8)),
          child: Icon(
            iconData,
            size: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
