import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

List<CalendarDayStruct> getCalendarForMonth(
  DateTime inputDate,
  List<String>? docDates,
  List<bool>? docIsIncome,
  List<bool>? docIsEvent,
  List<bool>? docIsSave,
  List<bool>? docIsExpense,
  List<bool>? docIsInternalTransfer,
) {
  final DateTime baseDate = DateTime(
    inputDate.year,
    inputDate.month,
    inputDate.day,
  );

  final List<String> dates = docDates ?? <String>[];
  final List<bool?> incomes = docIsIncome ?? <bool?>[];
  final List<bool?> events = docIsEvent ?? <bool?>[];
  final List<bool?> saves = docIsSave ?? <bool?>[];
  final List<bool?> expenses = docIsExpense ?? <bool?>[];
  final List<bool?> internalTransfers = docIsInternalTransfer ?? <bool?>[];

  String dayKey(DateTime d) {
    return '${d.year.toString().padLeft(4, '0')}-'
        '${d.month.toString().padLeft(2, '0')}-'
        '${d.day.toString().padLeft(2, '0')}';
  }

  int n = dates.length;
  if (incomes.length < n) n = incomes.length;
  if (events.length < n) n = events.length;
  if (saves.length < n) n = saves.length;
  if (expenses.length < n) n = expenses.length;
  if (internalTransfers.length < n) n = internalTransfers.length;

  final Set<String> incomeDays = <String>{};
  final Set<String> expenseDays = <String>{};
  final Set<String> eventDays = <String>{};
  final Set<String> saveDays = <String>{};
  final Set<String> internalTransferDays = <String>{};

  for (int i = 0; i < n; i++) {
    final String key = dates[i];

    if (incomes[i] == true) incomeDays.add(key);
    if (expenses[i] == true) expenseDays.add(key);
    if (events[i] == true) eventDays.add(key);
    if (saves[i] == true) saveDays.add(key);
    if (internalTransfers[i] == true) internalTransferDays.add(key);
  }

  final DateTime firstOfMonth = DateTime(baseDate.year, baseDate.month, 1);
  final DateTime lastOfMonth = DateTime(baseDate.year, baseDate.month + 1, 0);

  final DateTime startCalendar =
      firstOfMonth.subtract(Duration(days: firstOfMonth.weekday - 1));

  final DateTime endCalendar = (lastOfMonth.weekday == 7)
      ? lastOfMonth
      : lastOfMonth.add(Duration(days: 7 - lastOfMonth.weekday));

  final List<CalendarDayStruct> calendar = <CalendarDayStruct>[];

  for (DateTime d = startCalendar;
      !d.isAfter(endCalendar);
      d = d.add(const Duration(days: 1))) {
    final String key = dayKey(d);

    calendar.add(
      CalendarDayStruct(
        calendarDate: DateTime(d.year, d.month, d.day),
        isPreviousMonth: d.isBefore(firstOfMonth),
        isNextMonth: d.isAfter(lastOfMonth),
        hasIncome: incomeDays.contains(key),
        hasExpense: expenseDays.contains(key),
        hasEvent: eventDays.contains(key),
        hasSave: saveDays.contains(key),
        hasInternalTransfer: internalTransferDays.contains(key),
      ),
    );
  }

  return calendar;
}

DateTime getNextMonthDateTime(DateTime inputDate) {
  int year = inputDate.year;
  int month = inputDate.month;

  if (month == 12) {
    year++;
    month = 1;
  } else {
    month++;
  }
  return DateTime(year, month);
}

DateTime getLastMonthDateTime(DateTime inputDate) {
  int year = inputDate.year;
  int month = inputDate.month;

  if (month == 1) {
    year--;
    month = 12;
  } else {
    month--;
  }
  return DateTime(year, month);
}

double sumincomes(List<double> docs) {
  double total = 0.0;

  for (final v in docs) {
    total += v;
  }

  return total;
}

double sumexpenses(List<double> docs) {
  double total = 0.0;

  for (final v in docs) {
    total += v;
  }

  return total;
}

String normalizeToCalendarDatedateTime(DateTime dateTime) {
  final year = dateTime.year.toString().padLeft(4, '0');
  final month = dateTime.month.toString().padLeft(2, '0');
  final day = dateTime.day.toString().padLeft(2, '0');

  return '$year-$month-$day';
}

int dateToOccurrenceKey(String date) {
  // "YYYY-MM-DD" → "YYYYMMDD" → int
  return int.parse(date.replaceAll('-', ''));
}

List<String> generateRecurrenceDatesByCode(
  String startDate,
  int frequencyCode,
  bool includeStart,
) {
  final parts = startDate.split('-');

  if (parts.length != 3) {
    return <String>[];
  }

  final int year = int.parse(parts[0]);
  final int month = int.parse(parts[1]);
  final int day = int.parse(parts[2]);

  final DateTime parsedStart = DateTime(year, month, day, 0, 0, 0);

  int lastDayOfMonth(int y, int m) => DateTime(y, m + 1, 0).day;

  DateTime normalizeToMidnight(DateTime d) =>
      DateTime(d.year, d.month, d.day, 0, 0, 0);

  DateTime makeMonthlyDateAtMidnight(int y, int m, int targetDay) {
    final int safeDay = math.min(targetDay, lastDayOfMonth(y, m));
    return DateTime(y, m, safeDay, 0, 0, 0);
  }

  String toDateString(DateTime d) {
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final dd = d.day.toString().padLeft(2, '0');

    return '$y-$m-$dd';
  }

  final DateTime start = normalizeToMidnight(parsedStart);
  final DateTime limitDate = DateTime(start.year, 12, 31, 23, 59, 59);

  final List<String> out = <String>[];

  int stepDays = 0;
  int stepMonths = 0;

  if (frequencyCode < 1000) {
    stepDays = frequencyCode;
    if (stepDays <= 0) return <String>[];
  } else {
    stepMonths = frequencyCode - 1000;
    if (stepMonths <= 0) return <String>[];
  }

  DateTime current = start;

  if (includeStart) {
    out.add(toDateString(current));
  }

  final int targetDay = start.day;

  while (true) {
    if (stepDays > 0) {
      current = normalizeToMidnight(current.add(Duration(days: stepDays)));
    } else {
      final int totalMonths =
          (current.year * 12 + (current.month - 1)) + stepMonths;

      final int ny = totalMonths ~/ 12;
      final int nm = (totalMonths % 12) + 1;

      current = makeMonthlyDateAtMidnight(ny, nm, targetDay);
    }

    if (current.isAfter(limitDate)) break;

    out.add(toDateString(current));
  }

  return out;
}

List<int> monthBoundaries(DateTime inputDate) {
  final int year = inputDate.year;
  final int month = inputDate.month;

// inicio del mes → YYYYMM01
  final int startKey = year * 10000 + month * 100 + 1;

// último día del mes
  final int lastDay = DateTime(year, month + 1, 0).day;

// fin del mes → YYYYMMDD
  final int endKey = year * 10000 + month * 100 + lastDay;

  return [startKey, endKey];
}

double? calcNetCashflow(
  double? incomes,
  double? expenses,
  double? savings,
) {
  double i = incomes ?? 0;
  double e = expenses ?? 0;

  double s = savings ?? 0;

  return i - (e + s);
}

double sumAmountsInYear(
  List<double>? amounts,
  List<int>? occurrenceKey,
  DateTime referenceDate,
) {
  final safeAmounts = amounts ?? <double>[];
  final safeKeys = occurrenceKey ?? <int>[];

  final int year = referenceDate.year;
  final int startKey = year * 10000 + 101; // YYYY0101
  final int endKey = (year + 1) * 10000 + 101; // próximo año

  double total = 0.0;

  final len = math.min(safeAmounts.length, safeKeys.length);

  for (int i = 0; i < len; i++) {
    final k = safeKeys[i];

    if (k >= startKey && k < endKey) {
      total += safeAmounts[i];
    }
  }

  return total;
}

Color cashFlowColor(double cashFlowValue) {
  if (cashFlowValue > 0) {
    return Colors.green;
  } else if (cashFlowValue < 0) {
    return Colors.red;
  } else {
    return Colors.grey;
  }
}

double uncategorizedCash(
  double? cashFlow,
  double? totalSavings,
) {
  final cf = cashFlow ?? 0.0;
  final savings = totalSavings ?? 0.0;

  return cf - savings;
}

dynamic calculateGoalInstallmentsFn(
  String startDate,
  String endDate,
  double totalAmount,
  int frequencyCode,
) {
  DateTime parseDate(String d) {
    final parts = d.split('-');
    if (parts.length != 3) {
      throw Exception("Invalid date format: $d");
    }
    return DateTime(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    );
  }

  DateTime normalize(DateTime d) => DateTime(d.year, d.month, d.day);

  int lastDayOfMonth(int y, int m) => DateTime(y, m + 1, 0).day;

  DateTime addMonthsClamped(DateTime d, int monthsToAdd) {
    final totalMonths = (d.year * 12 + (d.month - 1)) + monthsToAdd;
    final newY = totalMonths ~/ 12;
    final newM = (totalMonths % 12) + 1;

    final maxDay = lastDayOfMonth(newY, newM);
    final newDay = d.day > maxDay ? maxDay : d.day;

    return DateTime(newY, newM, newDay);
  }

  DateTime nextDate(DateTime current) {
    switch (frequencyCode) {
      case 1:
        return current.add(const Duration(days: 1));
      case 7:
        return current.add(const Duration(days: 7));
      case 14:
        return current.add(const Duration(days: 14));
      case 1001:
        return addMonthsClamped(current, 1);
      case 1003:
        return addMonthsClamped(current, 3);
      case 1012:
        return addMonthsClamped(current, 12);
      default:
        throw Exception('Unsupported frequencyCode: $frequencyCode');
    }
  }

  final DateTime s = normalize(parseDate(startDate));
  final DateTime e = normalize(parseDate(endDate));

  if (totalAmount <= 0) {
    return {"success": false, "error": "totalAmount must be > 0"};
  }

  if (e.isBefore(s)) {
    return {"success": false, "error": "endDate must be >= startDate"};
  }

  int count = 0;
  DateTime cursor = s;

  while (!cursor.isAfter(e)) {
    count += 1;
    cursor = nextDate(cursor);
  }

  final installmentAmount = totalAmount / count;

  return {
    "success": true,
    "installmentsCount": count,
    "installmentAmount": installmentAmount,
  };
}

List<String> buildTransferScheduleDatesFn(
  String startDate,
  String endDate,
  int frequencyCode,
) {
  DateTime parseDate(String value) {
    final parts = value.split('-');

    if (parts.length != 3) {
      throw Exception('Invalid date format: $value');
    }

    return DateTime(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    );
  }

  String toDateString(DateTime d) {
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');

    return '$y-$m-$day';
  }

  DateTime normalize(DateTime d) => DateTime(d.year, d.month, d.day);

  int lastDayOfMonth(int y, int m) => DateTime(y, m + 1, 0).day;

  DateTime addMonthsClamped(DateTime d, int monthsToAdd) {
    final totalMonths = (d.year * 12 + (d.month - 1)) + monthsToAdd;
    final newY = totalMonths ~/ 12;
    final newM = (totalMonths % 12) + 1;

    final maxDay = lastDayOfMonth(newY, newM);
    final newDay = d.day > maxDay ? maxDay : d.day;

    return DateTime(newY, newM, newDay);
  }

  DateTime nextDate(DateTime current) {
    switch (frequencyCode) {
      case 1:
        return current.add(const Duration(days: 1));
      case 7:
        return current.add(const Duration(days: 7));
      case 14:
        return current.add(const Duration(days: 14));
      case 1001:
        return addMonthsClamped(current, 1);
      case 1003:
        return addMonthsClamped(current, 3);
      case 1012:
        return addMonthsClamped(current, 12);
      default:
        throw Exception('Unsupported frequencyCode: $frequencyCode');
    }
  }

  final s = normalize(parseDate(startDate));
  final e = normalize(parseDate(endDate));

  if (e.isBefore(s)) return <String>[];

  final List<String> dates = [];
  DateTime cursor = s;

  const int maxItems = 50000;

  while (!cursor.isAfter(e)) {
    dates.add(toDateString(cursor));

    if (dates.length > maxItems) {
      throw Exception('Too many dates generated. Check inputs.');
    }

    final nxt = nextDate(cursor);

    if (!nxt.isAfter(cursor)) {
      throw Exception('Invalid next date (non-increasing).');
    }

    cursor = nxt;
  }

  return dates;
}

dynamic goalCurrentStatusFn(
  double currentAmount,
  String startDate,
  String endDate,
  DateTime currentTime,
  int frequencyCode,
  double installmentAmount,
  int installmentsCount,
) {
// Helpers
  DateTime parseDate(String value) {
    final parts = value.split('-');

    if (parts.length != 3) {
      throw Exception('Invalid date format: $value');
    }

    return DateTime(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    );
  }

  DateTime normalize(DateTime d) => DateTime(d.year, d.month, d.day);

  int lastDayOfMonth(int y, int m) => DateTime(y, m + 1, 0).day;

  DateTime addMonthsClamped(DateTime d, int monthsToAdd) {
    final totalMonths = (d.year * 12 + (d.month - 1)) + monthsToAdd;
    final newY = totalMonths ~/ 12;
    final newM = (totalMonths % 12) + 1;

    final maxDay = lastDayOfMonth(newY, newM);
    final newDay = d.day > maxDay ? maxDay : d.day;

    return DateTime(newY, newM, newDay);
  }

  DateTime nextDate(DateTime current) {
    switch (frequencyCode) {
      case 1:
        return current.add(const Duration(days: 1));
      case 7:
        return current.add(const Duration(days: 7));
      case 14:
        return current.add(const Duration(days: 14));
      case 1001:
        return addMonthsClamped(current, 1);
      case 1003:
        return addMonthsClamped(current, 3);
      case 1012:
        return addMonthsClamped(current, 12);
      default:
        throw Exception('Unsupported frequencyCode: $frequencyCode');
    }
  }

  double clamp01(double v) => v < 0 ? 0 : (v > 1 ? 1 : v);

  // 🔹 Normalización
  final DateTime s = normalize(parseDate(startDate));
  final DateTime e = normalize(parseDate(endDate));
  final DateTime now = normalize(currentTime);

  // 🔹 Validaciones
  if (installmentsCount <= 0) {
    return {"success": false, "error": "installmentsCount must be > 0"};
  }

  if (installmentAmount <= 0) {
    return {"success": false, "error": "installmentAmount must be > 0"};
  }

  if (e.isBefore(s)) {
    return {"success": false, "error": "endDate must be >= startDate"};
  }

  // 🔹 Total objetivo
  final totalGoalAmount = installmentAmount * installmentsCount;

  // 🔹 Porcentaje actual
  final currentPercent = clamp01(
        totalGoalAmount == 0 ? 0 : (currentAmount / totalGoalAmount),
      ) *
      100;

  // 🔹 Monto restante
  final remainingAmount = (totalGoalAmount - currentAmount) <= 0
      ? 0.0
      : (totalGoalAmount - currentAmount);

  // 🔹 Cuotas pagadas
  final paidInstallments =
      currentAmount <= 0 ? 0 : (currentAmount / installmentAmount).floor();

  // 🔹 Cuotas restantes
  final remainingInstallments = (installmentsCount - paidInstallments) <= 0
      ? 0
      : (installmentsCount - paidInstallments);

  // 🔹 Cuotas esperadas según calendario
  int expectedInstallments = 0;

  if (!now.isBefore(s)) {
    DateTime cursor = s;
    const int maxIter = 50000;

    while (!cursor.isAfter(e) && !cursor.isAfter(now)) {
      expectedInstallments += 1;

      if (expectedInstallments > maxIter) {
        return {"success": false, "error": "Too many iterations"};
      }

      final nxt = nextDate(cursor);

      if (!nxt.isAfter(cursor)) {
        return {"success": false, "error": "Invalid next date"};
      }

      cursor = nxt;
    }
  }

  if (expectedInstallments > installmentsCount) {
    expectedInstallments = installmentsCount;
  }

  return {
    "success": true,
    "currentPercent": currentPercent,
    "remainingAmount": remainingAmount,
    "remainingInstallments": remainingInstallments,
    "expectedInstallments": expectedInstallments,
  };
}

List<DateTime> buildGoalPeriodDatesExcludeStart(
  DateTime startDate,
  DateTime endDate,
  int? frequencyCode,
) {
  if (frequencyCode == null) return <DateTime>[];

  int lastDayOfMonth(int y, int m) => DateTime(y, m + 1, 0).day;

  DateTime normalizeToMidnight(DateTime d) =>
      DateTime(d.year, d.month, d.day, 0, 0, 0);

  DateTime makeMonthlyDateAtMidnight(int y, int m, int targetDay) {
    final int safeDay = math.min(targetDay, lastDayOfMonth(y, m));
    return DateTime(y, m, safeDay, 0, 0, 0);
  }

  final DateTime start = normalizeToMidnight(startDate);
  final DateTime end = normalizeToMidnight(endDate);

  if (end.isBefore(start)) return <DateTime>[];

  final List<DateTime> out = <DateTime>[];

  int stepDays = 0;
  int stepMonths = 0;

  if (frequencyCode < 1000) {
    stepDays = frequencyCode; // 1,7,14
    if (stepDays <= 0) return <DateTime>[];
  } else {
    stepMonths = frequencyCode - 1000; // 1001->1, 1003->3, 1012->12
    if (stepMonths <= 0) return <DateTime>[];
  }

  DateTime current = start;
  final int targetDay = start.day;

  while (true) {
    if (stepDays > 0) {
      current = normalizeToMidnight(current.add(Duration(days: stepDays)));
    } else {
      final int totalMonths =
          (current.year * 12 + (current.month - 1)) + stepMonths;
      final int ny = totalMonths ~/ 12;
      final int nm = (totalMonths % 12) + 1;
      current = makeMonthlyDateAtMidnight(ny, nm, targetDay);
    }

    if (current.isAfter(end)) break;

    out.add(current);
  }

  return out;
}

DateTime stringToDateTime(String? date) {
  if (date == null || date.isEmpty) {
    throw Exception('Date is null or empty');
  }

  final parts = date.split('-');

  if (parts.length != 3) {
    throw Exception('Invalid date format: $date');
  }

  return DateTime(
    int.parse(parts[0]),
    int.parse(parts[1]),
    int.parse(parts[2]),
  );
}
