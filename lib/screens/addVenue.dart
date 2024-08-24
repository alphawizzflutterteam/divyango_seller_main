import 'package:divyango_user/screens/venue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../services/btnPage.dart';
import '../services/colors.dart';
import '../widgets/appbar_widget.dart';
import 'PaymentType.dart';

class EditVenueDetail extends StatefulWidget {
  final String appBarTitle;
  const EditVenueDetail({super.key,required this.appBarTitle});

  @override
  State<EditVenueDetail> createState() => _EditVenueDetailState();
}

class _EditVenueDetailState extends State<EditVenueDetail> {
  final _formKey = GlobalKey<FormState>();
  String? selectedAccessibility;
  final List<String> accessibilityOptions = [
    "Wheelchair Accessible",
    "Not Wheelchair Accessible",
  ];

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }
    return null;
  }

  String? validateContactNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a contact number';
    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'Please enter a valid 10-digit contact number';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an address';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // appBar: AppBar(
      //   leading: GestureDetector(
      //     onTap: () {
      //       Navigator.pop(context);
      //     },
      //     child: Icon(
      //       Icons.arrow_back_ios,
      //       color: Colors.white,
      //     ),
      //   ),
      //   backgroundColor: colors.secondary,
      //   title: Text(
      //     "Edit Venue",
      //     style: TextStyle(color: Colors.white),
      //   ),
      // ),
      appBar: appBarWithBackWidget(
          context: context, title:widget.appBarTitle.toString(), color: colors.whiteTemp1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.02),
                Stack(
                  children:[
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Center(
                        child: Image.asset("assets/images/upimage.png",height: screenHeight * 0.10,),
                      ),
                    ),
                    Center(
                      child: Image.asset("assets/images/imageicon.png", height: screenHeight * 0.16)),
                ]),
                SizedBox(height: screenHeight * 0.02),
                Textbattonn(
                  hint: "Venue name",
                  validator: validateName,
                ),
                SizedBox(height: screenHeight * 0.02),
                Textbattonn(
                  keytype: TextInputType.numberWithOptions(),
                  hint: "Contact number",
                  validator: validateContactNumber,
                ),
                SizedBox(height: screenHeight * 0.02),
                Textbattonn(
                  hint: "Email",
                  validator: validateEmail,
                ),
                SizedBox(height: screenHeight * 0.02),
                AccessibilityDropdown(
                  hint: "Accessibility",
                  value: selectedAccessibility,
                  options: accessibilityOptions,
                  onChanged: (newValue) {
                    setState(() {
                      selectedAccessibility = newValue;
                    });
                  },
                ),
                SizedBox(height: screenHeight * 0.02),
                Adressbatton(
                  hint: "Address",
                  validator: validateAddress,
                ),
                SizedBox(height: screenHeight * 0.015),
                Text(
                  "Business hours",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: screenHeight * 0.015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Timebatton(hint: "Start time"),
                    Timebatton(hint: "End time"),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 9.0),
                  child: FilledBtn(
                    width: screenWidth * 0.9,
                    title: "Add Venue",
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(context);
                         Navigator.push(context, MaterialPageRoute(builder: (context) => VenuePage()));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Textbattonn extends StatefulWidget {
  Textbattonn({super.key, required this.hint, this.validator,this.keytype});
  var hint,keytype;
  final FormFieldValidator<String>? validator;

  @override
  State<Textbattonn> createState() => _TextbattonnState();
}

class _TextbattonnState extends State<Textbattonn> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keytype,
      validator: widget.validator,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        border: InputBorder.none,
        fillColor: Colors.grey[200],
        hintText: widget.hint,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class Adressbatton extends StatefulWidget {
  Adressbatton({super.key, required this.hint, this.validator});
  var hint;
  final FormFieldValidator<String>? validator;

  @override
  State<Adressbatton> createState() => _AdressbattonState();
}

class _AdressbattonState extends State<Adressbatton> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 4,
      validator: widget.validator,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        border: InputBorder.none,
        fillColor: Colors.grey[200],
        hintText: widget.hint,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class Timebatton extends StatefulWidget {
  Timebatton({super.key, required this.hint});
  var hint;

  @override
  State<Timebatton> createState() => _TimebattonState();
}

class _TimebattonState extends State<Timebatton> {
  final TextEditingController _controller = TextEditingController();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _controller.text = pickedTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      child: TextFormField(
        controller: _controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          border: InputBorder.none,
          fillColor: Colors.grey[200],
          hintText: widget.hint,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        readOnly: true,
        onTap: () {
          _selectTime(context);
        },
      ),
    );
  }
}

class AccessibilityDropdown extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> options;
  final ValueChanged<String?> onChanged;

  AccessibilityDropdown({
    required this.hint,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        border: InputBorder.none,
        fillColor: Colors.grey[200],
        hintText: hint,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      value: value,
      items: options.map((String option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
