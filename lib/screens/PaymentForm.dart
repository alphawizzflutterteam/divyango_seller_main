import 'package:flutter/material.dart';
import '../services/colors.dart';
import 'auth/success.dart';

class PaymentForm extends StatefulWidget {
  const PaymentForm({Key? key}) : super(key: key);

  @override
  State<PaymentForm> createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameOnCardController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.whiteTemp,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: InkWell(
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => SuccussScreen()));
            // if(_formKey.currentState!.validate()){
            //
            // }
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: colors.blackTemp,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Text(
              'PAY Now',
              style: TextStyle(
                  color: colors.whiteTemp1,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            )),
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colors.whiteTemp1,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
        title: Text(
          'Payment form',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          key: _formKey,
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: colors.greyTemp)),
              child: TextFormField(
                controller: nameOnCardController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10),
                    hintText: 'Name on card',
                    border: InputBorder.none),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '   Enter Name';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: colors.greyTemp)),
              child: TextFormField(
                controller: cardNumberController,
                decoration: InputDecoration(
                    prefixIcon: IconButton(
                      icon: Icon(Icons.credit_card_outlined),
                      onPressed: () {},
                    ),
                    contentPadding: EdgeInsets.only(left: 10, top: 10),
                    hintText: 'Card Number',
                    border: InputBorder.none),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '   Enter Card No.';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: colors.greyTemp)),
              child: TextFormField(
                controller: expiryDateController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10),
                    hintText: 'Expiry Date',
                    border: InputBorder.none),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '   Enter Expiry Date';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: colors.greyTemp)),
              child: TextFormField(
                controller: cvvController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10),
                    hintText: 'CVV',
                    border: InputBorder.none),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '   Enter CVV';
                  }
                  return null;
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
