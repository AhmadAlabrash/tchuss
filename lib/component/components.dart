import 'package:flutter/material.dart';

Widget defulttextform({
  @required preficon,
  @required label,
  @required control,
  invisible = false,
  suficon,
}) =>
    TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        prefixIcon: preficon,
        suffixIcon: suficon,
        labelText: label,
      ),
      obscureText: invisible,
      controller: control,
      validator: (value) {
        if (value!.isEmpty) {
          return 'you not insert your data';
        }
      },
    );
