import 'package:auto_route/auto_route.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../shared_widgets/custom_app_bars/clean_app_bar.dart';
import '../shared_widgets/phone_input.dart';
import '../shared_widgets/rectangle_button.dart';
import '../themes/constants.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // All Pages
  final _pageController = PageController();
  double _currentPage = 0.0;

  // Page One
  var _isPhoneValid = false;
  late PhoneInput _phoneInput;
  late TextEditingController _phoneInputController;

  // Page Two
  late FocusNode focusNode0,
      focusNode1,
      focusNode2,
      focusNode3,
      focusNode4,
      focusNode5;
  late TextEditingController digit0, digit1, digit2, digit3, digit4, digit5;

  @override
  void initState() {
    super.initState();
    // All pages
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });

    // Page One
    _phoneInputController = TextEditingController();
    _phoneInput = PhoneInput(
      _phoneInputController,
      isValid: (valid) => setState(() => _isPhoneValid = valid),
    );

    // Page Two
    focusNode0 = FocusNode();
    focusNode1 = FocusNode();
    focusNode2 = FocusNode();
    focusNode3 = FocusNode();
    focusNode4 = FocusNode();
    focusNode5 = FocusNode();
    digit0 = TextEditingController();
    digit1 = TextEditingController();
    digit2 = TextEditingController();
    digit3 = TextEditingController();
    digit4 = TextEditingController();
    digit5 = TextEditingController();
  }

  @override
  void dispose() {
    // Page Two
    focusNode0.dispose();
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    focusNode4.dispose();
    focusNode5.dispose();
    digit0.dispose();
    digit1.dispose();
    digit2.dispose();
    digit3.dispose();
    digit4.dispose();
    digit5.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: _currentPage == 0
          ? CleanAppBar(
              actions: [
                ElevatedButton(
                  onPressed: () => context.router.pop(),
                  child: Image.asset('assets/images/icons/close_icon.png'),
                )
              ],
            ) // TODO: add action
          : AppBar(backgroundColor: Colors.transparent, elevation: 0.0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23.0),
            child: Column(
              children: [
                SizedBox(
                  height: 470.0,
                  child: PageView.builder(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Expanded(
                                  child: Text(
                                    'Verify your\r\nphone number',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 32.0),
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 35.0),
                            _phoneInput,
                            const SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: RectangleButton(
                                    text: 'Next',
                                    enabled: _isValidToContinue(),
                                    onTap: () {
                                      if (_isValidToContinue()) {
                                        _pageController.nextPage(
                                            duration: const Duration(
                                                milliseconds: 400),
                                            curve: Curves.easeIn);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      } else if (index == 1) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: const [
                                Expanded(
                                  child: Text(
                                    'Enter your \r\nverification code',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 32.0),
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              children: const [
                                Expanded(
                                  child: Text(
                                    'We just sent you a text message with a 4-digit code to verify your account',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: kInactiveColor),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 45.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _digitField(
                                    digit0,
                                    focusNode0,
                                    (value) =>
                                        _changeFocus(value, focusNode1, null)),
                                _digitField(
                                    digit1,
                                    focusNode1,
                                    (value) => _changeFocus(
                                        value, focusNode2, focusNode0)),
                                _digitField(
                                    digit2,
                                    focusNode2,
                                    (value) => _changeFocus(
                                        value, focusNode3, focusNode1)),
                                _digitField(
                                    digit3,
                                    focusNode3,
                                    (value) => _changeFocus(
                                        value, focusNode4, focusNode2)),
                                _digitField(
                                    digit4,
                                    focusNode4,
                                    (value) => _changeFocus(
                                        value, focusNode5, focusNode3)),
                                _digitField(
                                    digit5,
                                    focusNode5,
                                    (value) =>
                                        _changeFocus(value, null, focusNode4)),
                              ],
                            ),
                            const SizedBox(height: 15.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed: () => _reset(),
                                    child: const Text(
                                        'No code? Click here and we will send a new one',
                                        style: TextStyle(
                                            color: kAccentColor,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14.0)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      } else if (index == 2) {
                        return const Text("Picture");
                      } else {
                        return const Text("Hello");
                      }
                    },
                  ),
                ),
                DotsIndicator(
                  position: _currentPage,
                  dotsCount: 3,
                  decorator: const DotsDecorator(
                    activeColor: kAccentColor,
                    color: Color(0xFFCCCCCC),
                    size: Size(12.0, 12.0),
                    activeSize: Size(12.0, 12.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Page One
  bool _isValidToContinue() {
    return _isPhoneValid;
  }

  // Page Two
  Padding _digitField(TextEditingController controller, FocusNode focus,
      ValueChanged<String> onChanged) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.0125),
      child: SizedBox(
        height: MediaQuery.of(context).size.width * 0.12,
        width: MediaQuery.of(context).size.width * 0.12,
        child: TextFormField(
          controller: controller,
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.center,
          showCursor: false,
          keyboardType: TextInputType.number,
          style: const TextStyle(fontSize: 28),
          maxLength: 1,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
            counterText: "",
          ),
          focusNode: focus,
          onChanged: onChanged,
        ),
      ),
    );
  }

  void _changeFocus(String value, FocusNode? next, FocusNode? previous) {
    if (value.isNotEmpty && next != null) {
      next.requestFocus();
      return;
    }

    if (value.isEmpty && previous != null) {
      previous.requestFocus();
      return;
    }

    if (value.isNotEmpty && next == null) {
      // TODO: Call validation method/BLOC
      return;
    }
  }

  void _reset() {
    _pageController.animateTo(0.0,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
    _phoneInputController.text = '';
    _isPhoneValid = false;
  }
}
