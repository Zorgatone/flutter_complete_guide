import 'package:flutter/material.dart';

typedef _VoidFunction = void Function();

class Answer extends StatelessWidget {
  final _VoidFunction _onPressed;
  final String _answerText;

  Answer(this._answerText, {_VoidFunction onPressed}) : _onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        child: Text(_answerText),
        onPressed: _onPressed,
      ),
    );
  }
}
