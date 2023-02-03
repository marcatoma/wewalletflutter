import 'package:flutter/material.dart';

class FormTransactionModel extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey();
  String concepto = '';
  double cantidad = 0.0;
  String tipoTransaccion = '';
  bool _isLoading = false;
  bool _disposed = false;

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
