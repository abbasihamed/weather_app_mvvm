import 'package:flutter/material.dart';

class AppError extends StatelessWidget {
  final String? errorText;

  const AppError({Key? key, this.errorText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Visibility(
        visible: errorText != null && errorText!.isNotEmpty,
        child:
            Text(errorText ?? '', style: Theme.of(context).textTheme.headline1),
      ),
    );
  }
}
