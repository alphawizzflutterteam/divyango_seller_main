import 'package:divyango_user/services/btnPage.dart';
import 'package:divyango_user/services/colors.dart';
import 'package:divyango_user/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithBackWidget(context: context, title: "Change Password", color: colors.primary),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Old Password Field
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: _obscureText,
              decoration: InputDecoration(
                filled: true,
                isDense: true,
                fillColor: colors.txtField,
                hintText: 'Old Password',
                hintStyle: TextStyle(color: colors.fieldTxt),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
              style: TextStyle(
                color: colors.darkgrey,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a password';
                }
                else if (value!.length < 8) {
                  return 'Password is too short';
                }
                return null;
              },
            ),

            const SizedBox(height: 20),
            // New Password Field
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: _obscureText,
              decoration: InputDecoration(
                filled: true,
                isDense: true,
                fillColor: colors.txtField,
                hintText: 'New Password',
                hintStyle: TextStyle(color: colors.fieldTxt),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
              style: TextStyle(
                color: colors.darkgrey,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a password';
                }
                else if (value!.length < 8) {
                  return 'Password is too short';
                }
                return null;
              },
            ),

            const SizedBox(height: 20),
            // Confirm Password Field
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: _obscureText,
              decoration: InputDecoration(
                filled: true,
                isDense: true,
                fillColor: colors.txtField,
                hintText: 'Confirm Password',
                hintStyle: TextStyle(color: colors.fieldTxt),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
              style: TextStyle(
                color: colors.darkgrey,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a password';
                }
                else if (value!.length < 8) {
                  return 'Password is too short';
                }
                return null;
              },
            ),

          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FilledBtn(
          title: 'Change Password',
          onPress: () => Navigator.pop(context),
        ),
      )
    );
  }
}
