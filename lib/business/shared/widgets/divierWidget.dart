import 'package:flutter/material.dart';

import '../../../config/screen_size/media_query_values.dart';
import '../../../config/styles/colors/app_colors.dart';

Widget myDivder(double width) => Container(
      width: getProportionateScreenWidth(width),
      height: 1.0,
      color: AppColors.grayColor,
    );
