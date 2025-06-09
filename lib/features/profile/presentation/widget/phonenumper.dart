import 'package:flutter/material.dart';
import 'package:planitly/features/profile/presentation/widget/edit_phone_numper.dart';


class Phonenumper extends StatefulWidget {
  final TextEditingController phoneController;

  const Phonenumper({super.key, required this.phoneController});

  @override
  State<Phonenumper> createState() => _PhonenumperState();
}

class _PhonenumperState extends State<Phonenumper> {
  // ignore: unused_field
  String _countryCode = '+20';

  @override
  Widget build(BuildContext context) {
    return EditPhoneNumper( labelText: "Phone Number",
      controller: widget.phoneController, 
      onChanged: (countryCode, number) {
        setState(() {
          _countryCode = countryCode;
        });
      },);
  }
}