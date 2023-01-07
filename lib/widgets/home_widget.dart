import 'package:devises/service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeWidget extends StatefulWidget {
  final Currency currency;

  const HomeWidget({super.key, required this.currency});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int coef = 1;

  bool inverse = false;

  double get value =>
      inverse ? 1 / widget.currency.value : widget.currency.value;

  final numberFormat =
      NumberFormat.currency(locale: 'fr', decimalDigits: 0, symbol: '');

  final numberFormatDecimal =
      NumberFormat.currency(locale: 'fr', decimalDigits: 2, symbol: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(inverse
            ? '${widget.currency.code} - EUR'
            : 'EUR - ${widget.currency.code}'),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  inverse = !inverse;
                  coef = 1;
                });
              },
              icon: const Icon(Icons.swap_horiz)),
        ],
      ),
      body: SizedBox.expand(
        child: Column(
          children: Iterable.generate(10)
              .map((i) => Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (coef > 1) {
                                setState(() {
                                  coef = (coef / 10).round();
                                });
                              }
                            },
                            child: Container(
                              color: Colors.yellow.shade300,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    numberFormat.format(((i + 1) * coef)),
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (coef < 1000) {
                                setState(() {
                                  coef *= 10;
                                });
                              }
                            },
                            child: Container(
                              color: Colors.blueGrey.shade200,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    numberFormatDecimal
                                        .format(((i + 1) * coef * value)),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
