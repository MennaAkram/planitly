
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planitly/design_system/theme.dart';


class SettingButtom extends StatelessWidget {
  final String text;
  final String address;
  final String iconPath;
  final VoidCallback? onTap;

  const SettingButtom({
    super.key,
    required this.text,
    required this.iconPath,
    this.onTap,
     required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
     
      margin: EdgeInsets.symmetric(vertical: 12),
      height: 64,
      width: double.infinity,
      child: MaterialButton(
          onPressed: onTap,
        
          child: Container(
             margin: EdgeInsets.symmetric(vertical: 12),
            width: double.infinity,
            child: Stack(
              children: [  SvgPicture.asset(iconPath),
               
              Container(margin: EdgeInsets.symmetric(horizontal: 48),
                child: Column(children: [
                    Container(alignment: Alignment.centerLeft,
                    width: double.maxFinite,
                      child: Text(text,style:Theme.of(context).appTexts.bodySmall.copyWith(
                              color: Theme.of(context).appColors.black87,
                            ) ,)
                            ),
                            SizedBox(
                              width: double.maxFinite,
                              child: Text(address,
                            style: Theme.of(context).appTexts.bodySmall.copyWith(
                              color: Theme.of(context).appColors.black60,
                            )
                            ),)
                  
              ],))

                
              ],
            ),
          )),
    );
  }
}
