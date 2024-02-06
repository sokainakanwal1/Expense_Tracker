import 'dart:async';

import 'package:expense_tracker/google_sheets_api.dart';
import 'package:expense_tracker/top_card.dart';
import 'package:expense_tracker/transaction.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool timerHasStarted = false;
  void startLoading() {
    timerHasStarted = true;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (GoogleSheetsApi.loading == false) {
        setState(() {});
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //start loading until the data arrives
    if (GoogleSheetsApi.loading == true && timerHasStarted == false) {
      startLoading();
    }
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          TopNewCard(
            balance: '\$ 20,000',
            income: '\$200',
            expense: '\$100',
          ),
          Expanded(
              child: Container(
            color: Colors.blue[300],
            child: Center(
                child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: GoogleSheetsApi.currentTransactions.length,
                      itemBuilder: (context, index) {
                        return MyTransaction(
                          money: GoogleSheetsApi.currentTransactions[index][0],
                          transactionName:
                              GoogleSheetsApi.currentTransactions[index][1],
                          expenseOrIncome:
                              GoogleSheetsApi.currentTransactions[index][2],
                        );
                      }),
                )
              ],
            )),
          )),
          Container(
            height: 75,
            width: 75,
            decoration:
                BoxDecoration(color: Colors.grey[500], shape: BoxShape.circle),
            child: Center(
              child: Text(
                '+',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          )
        ],
      ),
    );
  }
}
