import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _isDarkMode = prefs.getBool('ff_isDarkMode') ?? _isDarkMode;
    });
    _safeInit(() {
      _sumExpenses = prefs.getDouble('ff_sumExpenses') ?? _sumExpenses;
    });
    _safeInit(() {
      _sumIncomes = prefs.getDouble('ff_sumIncomes') ?? _sumIncomes;
    });
    _safeInit(() {
      _save = prefs.getDouble('ff_save') ?? _save;
    });
    _safeInit(() {
      _isNotificationRequested = prefs.getBool('ff_isNotificationRequested') ??
          _isNotificationRequested;
    });
    _safeInit(() {
      _isBiometricEnabled =
          prefs.getBool('ff_isBiometricEnabled') ?? _isBiometricEnabled;
    });
    _safeInit(() {
      _isCalendarSet = prefs.getBool('ff_isCalendarSet') ?? _isCalendarSet;
    });
    _safeInit(() {
      _isBillListSet = prefs.getBool('ff_isBillListSet') ?? _isBillListSet;
    });
    _safeInit(() {
      _seeAmounts = prefs.getBool('ff_seeAmounts') ?? _seeAmounts;
    });
    _safeInit(() {
      _isSaveSelect = prefs.getBool('ff_isSaveSelect') ?? _isSaveSelect;
    });
    _safeInit(() {
      _isChekSelect = prefs.getBool('ff_isChekSelect') ?? _isChekSelect;
    });
    _safeInit(() {
      _isCreditSelect = prefs.getBool('ff_isCreditSelect') ?? _isCreditSelect;
    });
    _safeInit(() {
      _selectedDate = prefs.containsKey('ff_selectedDate')
          ? DateTime.fromMillisecondsSinceEpoch(
              prefs.getInt('ff_selectedDate')!)
          : _selectedDate;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  bool _isDarkMode = true;
  bool get isDarkMode => _isDarkMode;
  set isDarkMode(bool value) {
    _isDarkMode = value;
    prefs.setBool('ff_isDarkMode', value);
  }

  double _sumExpenses = 0.0;
  double get sumExpenses => _sumExpenses;
  set sumExpenses(double value) {
    _sumExpenses = value;
    prefs.setDouble('ff_sumExpenses', value);
  }

  double _sumIncomes = 0.0;
  double get sumIncomes => _sumIncomes;
  set sumIncomes(double value) {
    _sumIncomes = value;
    prefs.setDouble('ff_sumIncomes', value);
  }

  double _save = 0.0;
  double get save => _save;
  set save(double value) {
    _save = value;
    prefs.setDouble('ff_save', value);
  }

  double _anualIncome = 0.0;
  double get anualIncome => _anualIncome;
  set anualIncome(double value) {
    _anualIncome = value;
  }

  double _anualExpenses = 0.0;
  double get anualExpenses => _anualExpenses;
  set anualExpenses(double value) {
    _anualExpenses = value;
  }

  double _anualCashFlow = 0.0;
  double get anualCashFlow => _anualCashFlow;
  set anualCashFlow(double value) {
    _anualCashFlow = value;
  }

  double _mensualCashFlow = 0.0;
  double get mensualCashFlow => _mensualCashFlow;
  set mensualCashFlow(double value) {
    _mensualCashFlow = value;
  }

  bool _isNotificationRequested = false;
  bool get isNotificationRequested => _isNotificationRequested;
  set isNotificationRequested(bool value) {
    _isNotificationRequested = value;
    prefs.setBool('ff_isNotificationRequested', value);
  }

  double _anualSaves = 0.0;
  double get anualSaves => _anualSaves;
  set anualSaves(double value) {
    _anualSaves = value;
  }

  bool _isBiometricEnabled = false;
  bool get isBiometricEnabled => _isBiometricEnabled;
  set isBiometricEnabled(bool value) {
    _isBiometricEnabled = value;
    prefs.setBool('ff_isBiometricEnabled', value);
  }

  bool _isCalendarSet = true;
  bool get isCalendarSet => _isCalendarSet;
  set isCalendarSet(bool value) {
    _isCalendarSet = value;
    prefs.setBool('ff_isCalendarSet', value);
  }

  bool _isBillListSet = false;
  bool get isBillListSet => _isBillListSet;
  set isBillListSet(bool value) {
    _isBillListSet = value;
    prefs.setBool('ff_isBillListSet', value);
  }

  bool _isBlokedHome = false;
  bool get isBlokedHome => _isBlokedHome;
  set isBlokedHome(bool value) {
    _isBlokedHome = value;
  }

  bool _seeAmounts = false;
  bool get seeAmounts => _seeAmounts;
  set seeAmounts(bool value) {
    _seeAmounts = value;
    prefs.setBool('ff_seeAmounts', value);
  }

  bool _isSaveSelect = false;
  bool get isSaveSelect => _isSaveSelect;
  set isSaveSelect(bool value) {
    _isSaveSelect = value;
    prefs.setBool('ff_isSaveSelect', value);
  }

  bool _isChekSelect = false;
  bool get isChekSelect => _isChekSelect;
  set isChekSelect(bool value) {
    _isChekSelect = value;
    prefs.setBool('ff_isChekSelect', value);
  }

  bool _isCreditSelect = false;
  bool get isCreditSelect => _isCreditSelect;
  set isCreditSelect(bool value) {
    _isCreditSelect = value;
    prefs.setBool('ff_isCreditSelect', value);
  }

  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;
  set selectedDate(DateTime? value) {
    _selectedDate = value;
    value != null
        ? prefs.setInt('ff_selectedDate', value.millisecondsSinceEpoch)
        : prefs.remove('ff_selectedDate');
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
