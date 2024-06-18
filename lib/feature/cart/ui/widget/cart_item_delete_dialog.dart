import 'package:flutter/material.dart';

class CartItemDeleteDialog extends StatelessWidget {
  CartItemDeleteDialog(
      {Key? key, required this.onTrue, required this.isLoading})
      : super(key: key);
  final void Function(bool?)? onTrue;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (_context, setState) {
        return AlertDialog(
          title: Text("Are you sure?"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("No"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onTrue!(true);
              },
              child: Text("Yes"),
            ),
          ],
        );
      },
    );
    ;
  }
}
