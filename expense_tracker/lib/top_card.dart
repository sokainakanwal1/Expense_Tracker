import 'package:flutter/material.dart';

class TopNewCard extends StatelessWidget {
  final String balance;
  final String income;
  final String expense;

  const TopNewCard(
      {super.key,
      required this.balance,
      required this.income,
      required this.expense});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        // color: Colors.grey[200],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'B A L A N C E',
                style: TextStyle(color: Colors.grey[500], fontSize: 16),
              ),
              Text(
                balance,
                style: TextStyle(color: Colors.grey[800], fontSize: 26),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.arrow_upward,
                            color: Colors.green,
                          )),
                      Column(
                        children: [
                          Text('income'),
                          Text(income),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.arrow_downward,
                            color: Colors.red,
                          )),
                      Column(
                        children: [
                          Text('Expense'),
                          Text(expense),
                        ],
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey[300],
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade500,
                offset: Offset(4.0, 4.0),
                blurRadius: 15.0,
                spreadRadius: 1.0,
              ),
              BoxShadow(
                color: Colors.white,
                offset: Offset(-4.0, -4.0),
                blurRadius: 15.0,
                spreadRadius: 1.0,
              ),
            ]),
      ),
    );
  }
}
