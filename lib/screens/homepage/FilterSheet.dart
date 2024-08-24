import 'package:flutter/material.dart';

import '../../services/colors.dart';

class Myseet extends StatefulWidget {
  const Myseet({Key? key}) : super(key: key);

  @override
  State<Myseet> createState() => _MyseetState();
}

class _MyseetState extends State<Myseet> {
  bool isSelected = false; bool isSelected2 = false;
  bool isSelected1 = false; bool isSelected3 = false;
  bool isSelected4 = false; bool isSelected5 = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 600, // Increased height to avoid overflow
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Review",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Clear All",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(height: 10), // Adjust the space between "Review" and the ListView
              Container(
                height: 60,
                child: ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0), // Space between items
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              ["Cafes", "Restaurants", "Parlours", "Entertainment venues", "Public facilities"][index],
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Container(
                    height: 140,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: colors.secondary,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite, color: colors.secondary ),
                        SizedBox(height: 10),
                        Text("Accessible", style: TextStyle(color: isSelected ? colors.secondary : Colors.grey)),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 140,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: colors.primary,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite, color: colors.primary),
                        SizedBox(height: 10),
                        Text("Accessible", style: TextStyle(color: colors.primary)),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 140,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.red,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite, color: Colors.red),
                        SizedBox(height: 10),
                        Text("Accessible", style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSelected = !isSelected;
                        });
                      },
                      child: Container(
                        height: 30,
                        width: 160,
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.yellow : Colors.transparent,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                        child: Center(child: Text("Accessible From Home",style: TextStyle(color: isSelected ? Colors.white : Colors.black,),)),
                      ),
                    ),
                    SizedBox(width: 15),

                    Container(
                      height: 30,
                      width: 150,
                      decoration: BoxDecoration(
                        color: isSelected1 ? Colors.yellow : Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      child: Center(child: Text("Accessible Parking")),

                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Container(
                    height: 30,
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Center(child: Text("Accessible Washroom")),
                  ),
                  SizedBox(width: 15),
                  Container(
                    height: 30,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Center(child: Text("Accessible Entrance")),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Container(
                    height: 30,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Center(child: Text("Braille")),
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 30,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Center(child: Text("Bright Lighting")),
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 30,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Center(child: Text("Bright Lighting")),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Container(
                    height: 30,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Center(child: Text("Digital Menu")),
                  ),
                  SizedBox(width: 15),
                  Container(
                    height: 30,
                    width: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Center(child: Text("Gender Neutral Washroom")),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Container(
                    height: 30,
                    width: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Center(child: Text("Elevator")),
                  ),
                  SizedBox(width: 15),
                  Container(
                    height: 30,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Center(child: Text("Handrails")),
                  ),
                ],
              ),SizedBox(height: 20,),
              Center(
                child: TextButton(onPressed: (){}, child: Container(
                  height: 40,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Center(child: Text("Apply",style: TextStyle(color: Colors.white),)),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
