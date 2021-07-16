import 'package:flutter/material.dart';

class PriceAndCountInput extends StatelessWidget {
  const PriceAndCountInput({
    Key? key,
    required TextEditingController priceController,
    required TextEditingController countController,
  })   : _priceController = priceController,
        _countController = countController,
        super(key: key);

  final TextEditingController _priceController;
  final TextEditingController _countController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: TextField(
                textAlign: TextAlign.end,
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.monetization_on_outlined),
                    labelText: '단가',
                    suffixText: '원'),
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: TextField(
                  textAlign: TextAlign.end,
                  controller: _countController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.toll_outlined),
                      labelText: '수량',
                      suffixText: '개')),
            ),
          ],
        ));
  }
}
