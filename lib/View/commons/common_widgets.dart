import 'package:flutter/material.dart';
import 'package:portfolio_lms/Utilities/Constants.dart';

class CustomAppbar extends StatelessWidget {
  final String titleText;
  const CustomAppbar({super.key, required this.titleText});

  @override
  Widget build(BuildContext context) {
    return Container(height: 60,
      color: Colors.white,
      child: Row(
        children: [IconButton(
            onPressed: () {
              return Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new),),
          
          AppSpacing.smallWidth,
          Text(titleText,style: AppTextStyles.subHeading,),
        ],
      ),
    );
  }
}
