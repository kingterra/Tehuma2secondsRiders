import 'package:flutter/material.dart';
import 'package:foodpanda_riders_app/widgets/progress_bar.dart';

class LoadingDialog extends StatelessWidget {
  final String? message;

  LoadingDialog({this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          circularProgress(backgroundColor: Colors.blue, progressColor: Colors.red) ,
          const SizedBox(height: 16),
          Text(
            message! + ", Por favor espera...",
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
