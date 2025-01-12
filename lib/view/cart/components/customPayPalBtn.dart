import 'package:alpha_bookstore/constants/links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';

class Custompaypalbtn extends StatelessWidget {
  final double total;
  final Function method;
  const Custompaypalbtn({super.key, required this.total, required this.method});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xffEF5A5A),
            borderRadius: BorderRadius.circular(20)),
        child: TextButton(
            onPressed: () => {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => UsePaypal(
                          sandboxMode: true,
                          clientId: clientID,
                          secretKey: secretKey,
                          returnURL: "https://samplesite.com/return",
                          cancelURL: "https://samplesite.com/cancel",
                          transactions: [
                            {
                              "amount": {
                                "total": total,
                                "currency": "USD",
                                "details": {
                                  "subtotal": total,
                                  "shipping": '0',
                                  "shipping_discount": 0
                                }
                              },
                              "description":
                                  "The payment transaction description.",
                              // "payment_options": {
                              //   "allowed_payment_method":
                              //       "INSTANT_FUNDING_SOURCE"
                              // },
                              "item_list": {
                                "items": [
                                  {
                                    "name": "A demo product",
                                    "quantity": 1,
                                    "price": total,
                                    "currency": "USD"
                                  }
                                ],

                                // shipping address is not required though
                                "shipping_address": {
                                  "recipient_name": "Jane Foster",
                                  "line1": "Travis County",
                                  "line2": "",
                                  "city": "Austin",
                                  "country_code": "US",
                                  "postal_code": "73301",
                                  "phone": "+00000000",
                                  "state": "Texas"
                                },
                              }
                            }
                          ],
                          note: "Contact us for any questions on your order.",
                          onSuccess: (Map params) async {
                            print("onSuccess: $params");
                            method();
                          },
                          onError: (error) {
                            print("onError: $error");
                          },
                          onCancel: (params) {
                            print('cancelled: $params');
                          }),
                    ),
                  )
                },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Complete Payment with ",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(
                    width: 30,
                    height: 30,
                    child: Image.asset('./images/pngegg.png'))
              ],
            )),
      ),
    );
  }
}
