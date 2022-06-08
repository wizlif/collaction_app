import 'package:collaction_app/presentation/shared_widgets/pin_input/pin_input.dart';
import 'package:collaction_app/presentation/shared_widgets/pin_input/pin_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      'should autofill '
      'when autocomplete is called', (tester) async {
    const smsCode = '389010';
    final _pinKey = await tester.pumpPinVerify(submit: (value) {});

    _pinKey.currentState?.autoComplete(smsCode);

    await tester.pumpAndSettle();

    final _pinFields =
        tester.widgetList<PinTextField>(find.byType(PinTextField)).toList();
    expect(_pinFields.length, smsCode.length);

    for (int i = 0; i < _pinFields.length; i++) {
      final PinTextField field = _pinFields[i];
      expect(field.controller.text, smsCode[i]);
    }
  });
}

extension WidgetTesterX on WidgetTester {
  Future<GlobalKey<PinInputState>> pumpPinVerify({
    int pinLength = 6,
    required Function(String) submit,
  }) async {
    final _key = GlobalKey<PinInputState>();
    await pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PinInput(
            key: _key,
            pinLength: pinLength,
            submit: submit,
          ),
        ),
      ),
    );

    return _key;
  }
}
