import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../services/colors.dart';
import '../widgets/appbar_widget.dart';
import 'PaymentForm.dart';


class PaymentSelectionWidget extends StatefulWidget {
  const PaymentSelectionWidget({Key,key});

  @override
  State<PaymentSelectionWidget> createState() => _PaymentSelectionWidgetState();
}

class _PaymentSelectionWidgetState extends State<PaymentSelectionWidget> {
  int selectedIndex = 0;
  List<String> list = [
    'Visa',
    'Phone Pay',
    'UPI Payment',
    'Google Pay',
    'Cash On Delivery'
  ];
  List<String> imageLink = [
    'assets/images/visa.png',
    'assets/images/phonepay.png',
    'assets/images/upi.png',
    'assets/images/google.png',
    'assets/images/cashondelivery.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.whiteTemp,
      appBar: appBarWithBackWidget(context: context, title: 'Payment Type', color: colors.whiteTemp1),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: selectedIndex == index
                              ? Colors.black
                              : Colors.transparent)),
                  child: ListTile(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    title: Row(
                      children: [
                        Image(image: AssetImage(imageLink[index])),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          list[index],
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                    trailing: Icon(
                      selectedIndex == index
                          ? Icons.radio_button_checked_sharp
                          : Icons.radio_button_off_sharp,
                      color:
                      selectedIndex == index ? colors.primary: Colors.black,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 8,
                );
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16,right: 16,bottom: 50),
        child: InkWell(
          onTap: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PaymentForm()));
            // if(_formKey.currentState!.validate()){
            //
            // }
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: colors.blackTemp,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Center(child: Text('CONTINUE',style: TextStyle(color: colors.whiteTemp1,fontWeight: FontWeight.bold,fontSize: 16),)),
          ),
        ),
      ),
      // bottomSheet: Container(
      //   padding: EdgeInsets.only(bottom: 30),
      //   margin: EdgeInsets.symmetric(horizontal: 20),
      //   child: FilledBtn(
      //     width: MediaQuery.of(context).size.width,
      //     title: "CONTINUE",
      //     onPress: () {},
      //   ),
      // ),
    );
  }
}
