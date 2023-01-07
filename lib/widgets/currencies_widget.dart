import 'package:devises/service.dart';
import 'package:devises/widgets/home_widget.dart';
import 'package:flutter/material.dart';

class CurrenciesWidget extends StatelessWidget {
  const CurrenciesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sélectionnez votre devise'),
      ),
      body: FutureBuilder(
        future: Service.getCurrencies(),
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (data != null) {
            return Scaffold(
              body: ListView(
                children: data
                    .map((currency) => ListTile(
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                currency.code,
                                style: const TextStyle(
                                  color: Colors.cyan,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          title: Text(
                            currency.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(
                            currency.value.toString().replaceAll('.', ','),
                            style: const TextStyle(color: Colors.brown),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => HomeWidget(
                                  currency: currency,
                                ),
                              ),
                            );
                          },
                        ))
                    .toList(),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
