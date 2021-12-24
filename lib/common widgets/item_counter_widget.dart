import 'package:flutter/material.dart';
import 'package:products/styles/colors.dart';

class ItemCounterWidget extends StatefulWidget {
  final Function onAmountChanged;

  const ItemCounterWidget({Key? key, required this.onAmountChanged}) : super(key: key);

  @override
  _ItemCounterWidgetState createState() => _ItemCounterWidgetState();
}

class _ItemCounterWidgetState extends State<ItemCounterWidget> {
  int amount = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        iconWidget(Icons.remove,
            iconColor: AppColors.darkGrey, onPressed: decrementAmount),
        const SizedBox(width: 18),
        SizedBox(
            width: 30,
            child: Center(
                child: getText(
                    text: amount.toString(), fontSize: 18, isBold: true))),
        const SizedBox(width: 18),
        iconWidget(Icons.add,
            iconColor: Colors.blueGrey, onPressed: incrementAmount)
      ],
    );
  }

  void incrementAmount() {
    setState(() {
      amount = amount + 1;
      updateParent();
    });
  }

  void decrementAmount() {
    if (amount <= 0) return;
    setState(() {
      amount = amount - 1;
      updateParent();
    });
  }

  void updateParent() {
    widget.onAmountChanged(amount);
  }
  void setAmount(int amount) {
    this.amount = amount;
  }


  Widget iconWidget(IconData iconData, {required Color iconColor, onPressed}) {
    return GestureDetector(
      onTap: () {
        if (onPressed != null) {
          onPressed();
        }
      },
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Center(
          child: Icon(
            iconData,
            color: iconColor ?? Colors.black,
            size: 25,
          ),
        ),
      ),
    );
  }

  Widget getText(
      {required String text,
        required double fontSize,
        bool isBold = false,
        color = Colors.black}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: color,
      ),
    );
  }
}

