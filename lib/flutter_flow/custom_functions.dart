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
  List<DateTime>? docDates,
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

  final List<DateTime> dates = docDates ?? <DateTime>[];
  final List<bool?> incomes = docIsIncome ?? <bool?>[];
  final List<bool?> events = docIsEvent ?? <bool?>[];
  final List<bool?> saves = docIsSave ?? <bool?>[];
  final List<bool?> expenses = docIsExpense ?? <bool?>[];
  final List<bool?> internalTransfers = docIsInternalTransfer ?? <bool?>[];

  DateTime dayOnly(DateTime d) {
    return DateTime(d.year, d.month, d.day);
  }

  String dayKey(DateTime d) {
    final dt = dayOnly(d);
    return '${dt.year.toString().padLeft(4, '0')}-'
        '${dt.month.toString().padLeft(2, '0')}-'
        '${dt.day.toString().padLeft(2, '0')}';
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
    final String key = dayKey(dates[i]);

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

    final bool hasIncome = incomeDays.contains(key);
    final bool hasExpense = expenseDays.contains(key);
    final bool hasEvent = eventDays.contains(key);
    final bool hasSave = saveDays.contains(key);
    final bool hasInternalTransfer = internalTransferDays.contains(key);

    calendar.add(
      CalendarDayStruct(
        calendarDate: DateTime(d.year, d.month, d.day),
        isPreviousMonth: d.isBefore(firstOfMonth),
        isNextMonth: d.isAfter(lastOfMonth),
        hasIncome: hasIncome,
        hasExpense: hasExpense,
        hasEvent: hasEvent,
        hasSave: hasSave,
        hasInternalTransfer: hasInternalTransfer,
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

DateTime normalizeToCalendarDatedateTime(DateTime dateTime) {
  final utc = dateTime.toUtc();

  final year = utc.year;

  // Segundo domingo de marzo
  final march1 = DateTime.utc(year, 3, 1);
  final firstSundayMarch =
      march1.weekday == DateTime.sunday ? 1 : 8 - march1.weekday;
  final secondSundayMarch = firstSundayMarch + 7;
  final dstStart = DateTime.utc(year, 3, secondSundayMarch, 10);

  // Primer domingo de noviembre
  final november1 = DateTime.utc(year, 11, 1);
  final firstSundayNovember =
      november1.weekday == DateTime.sunday ? 1 : 8 - november1.weekday;
  final dstEnd = DateTime.utc(year, 11, firstSundayNovember, 9);

  final isDST = !utc.isBefore(dstStart) && utc.isBefore(dstEnd);

  final offsetHours = isDST ? -7 : -8;

  final laTime = utc.add(Duration(hours: offsetHours));

  // 👇 CLAVE: devolver fecha local (no UTC)
  return DateTime(
    laTime.year,
    laTime.month,
    laTime.day,
  );
}

String dateToOccurrenceKey(DateTime date) {
  final d = DateTime(date.year, date.month, date.day);
  return '${d.year.toString().padLeft(4, '0')}${d.month.toString().padLeft(2, '0')}${d.day.toString().padLeft(2, '0')}';
}

List<DateTime> generateRecurrenceDatesByCode(
  DateTime startDate,
  int frequencyCode,
  bool includeStart,
) {
  // frequencyCode:
  // 1=diario, 7=semanal, 14=quincenal,
  // 1001=mensual, 1003=trimestral, 1012=anual.

  int lastDayOfMonth(int y, int m) => DateTime(y, m + 1, 0).day;

  // Normaliza SIEMPRE a 12:00 AM (00:00)
  DateTime normalizeToMidnight(DateTime d) =>
      DateTime(d.year, d.month, d.day, 0, 0, 0);

  DateTime makeMonthlyDateAtMidnight(int y, int m, int targetDay) {
    final int safeDay = math.min(targetDay, lastDayOfMonth(y, m));
    return DateTime(y, m, safeDay, 0, 0, 0);
  }

  // Start (normalizado)
  final DateTime start = normalizeToMidnight(startDate);

  // ✅ Límite: crear recurrencias SOLO hasta el 31 de diciembre del mismo año
  final DateTime limitDate = DateTime(start.year, 12, 31, 23, 59, 59);

  final List<DateTime> out = <DateTime>[];

  // Determina el paso
  int stepDays = 0;
  int stepMonths = 0;

  if (frequencyCode < 1000) {
    // 1, 7, 14
    stepDays = frequencyCode;
    if (stepDays <= 0) return <DateTime>[];
  } else {
    // 1001, 1003, 1012 -> meses = code - 1000
    stepMonths = frequencyCode - 1000;
    if (stepMonths <= 0) return <DateTime>[];
  }

  DateTime current = start;

  if (includeStart) {
    out.add(current);
  }

  // Día objetivo para mensual/trimestral/anual
  // (mantiene 29/30/31 con “safe day” en febrero)
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

    // ✅ Para al llegar al fin de año
    if (current.isAfter(limitDate)) break;

    out.add(current);
  }

  return out;
}

String selectedDayToOccurrenceKey(DateTime selectedDay) {
  final d = DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
  return '${d.year.toString().padLeft(4, '0')}${d.month.toString().padLeft(2, '0')}${d.day.toString().padLeft(2, '0')}';
}

List<DateTime> monthBoundaries(DateTime inputDate) {
  final d = inputDate.toUtc();

  final startOfMonth = DateTime.utc(d.year, d.month, 1);

  final startOfNextMonth = (d.month == 12)
      ? DateTime.utc(d.year + 1, 1, 1)
      : DateTime.utc(d.year, d.month + 1, 1);

  return [startOfMonth, startOfNextMonth];
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
  List<DateTime>? dates,
  DateTime referenceDate,
) {
  // Normalizamos las listas (aquí se acaba el dolor)
  final safeAmounts = amounts ?? <double>[];
  final safeDates = dates ?? <DateTime>[];

  final startOfYear = DateTime(referenceDate.year, 1, 1);
  final endOfYear = DateTime(referenceDate.year + 1, 1, 1);

  double total = 0.0;

  final len = math.min(safeAmounts.length, safeDates.length);

  for (int i = 0; i < len; i++) {
    final d = safeDates[i];

    if (!d.isBefore(startOfYear) && d.isBefore(endOfYear)) {
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
  DateTime startDate,
  DateTime endDate,
  double totalAmount,
  int frequencyCode,
) {
// Normaliza fechas sin hora
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
      case 1: // diario
        return current.add(const Duration(days: 1));
      case 7: // semanal
        return current.add(const Duration(days: 7));
      case 14: // quincenal
        return current.add(const Duration(days: 14));
      case 1001: // mensual
        return addMonthsClamped(current, 1);
      case 1003: // trimestral
        return addMonthsClamped(current, 3);
      case 1012: // anual
        return addMonthsClamped(current, 12);
      default:
        throw Exception('Unsupported frequencyCode: $frequencyCode');
    }
  }

  final s = normalize(startDate);
  final e = normalize(endDate);

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

List<DateTime> buildTransferScheduleDatesFn(
  DateTime startDate,
  DateTime endDate,
  int frequencyCode,
) {
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
      case 1: // diario
        return current.add(const Duration(days: 1));
      case 7: // semanal
        return current.add(const Duration(days: 7));
      case 14: // quincenal
        return current.add(const Duration(days: 14));
      case 1001: // mensual
        return addMonthsClamped(current, 1);
      case 1003: // trimestral
        return addMonthsClamped(current, 3);
      case 1012: // anual
        return addMonthsClamped(current, 12);
      default:
        throw Exception('Unsupported frequencyCode: $frequencyCode');
    }
  }

  final s = normalize(startDate);
  final e = normalize(endDate);

  // Si la meta está mal, devuelve lista vacía
  if (e.isBefore(s)) return <DateTime>[];

  final dates = <DateTime>[];
  DateTime cursor = s;

  // Safety cap (evita loops accidentales)
  const int maxItems = 50000;

  while (!cursor.isAfter(e)) {
    dates.add(cursor);
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
  DateTime startDate,
  DateTime endDate,
  DateTime currentTime,
  int frequencyCode,
  double installmentAmount,
  int installmentsCount,
) {
// Helpers
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
      case 1: // diario
        return current.add(const Duration(days: 1));
      case 7: // semanal
        return current.add(const Duration(days: 7));
      case 14: // quincenal
        return current.add(const Duration(days: 14));
      case 1001: // mensual
        return addMonthsClamped(current, 1);
      case 1003: // trimestral
        return addMonthsClamped(current, 3);
      case 1012: // anual
        return addMonthsClamped(current, 12);
      default:
        throw Exception('Unsupported frequencyCode: $frequencyCode');
    }
  }

  double clamp01(double v) => v < 0 ? 0 : (v > 1 ? 1 : v);

  // Normalize dates (sin hora)
  final s = normalize(startDate);
  final e = normalize(endDate);
  final now = normalize(currentTime);

  // Validations
  if (installmentsCount <= 0) {
    return {"success": false, "error": "installmentsCount must be > 0"};
  }
  if (installmentAmount <= 0) {
    return {"success": false, "error": "installmentAmount must be > 0"};
  }
  if (e.isBefore(s)) {
    return {"success": false, "error": "endDate must be >= startDate"};
  }

  // Total goal amount
  final totalGoalAmount = installmentAmount * installmentsCount;

  // Real progress by amount
  final currentPercent = clamp01(
        totalGoalAmount == 0 ? 0 : (currentAmount / totalGoalAmount),
      ) *
      100;

  // Remaining amount
  final remainingAmount = (totalGoalAmount - currentAmount) <= 0
      ? 0.0
      : (totalGoalAmount - currentAmount);

  // Paid installments by amount
  final paidInstallments =
      currentAmount <= 0 ? 0 : (currentAmount / installmentAmount).floor();

  // Remaining installments by amount
  final remainingInstallments = (installmentsCount - paidInstallments) <= 0
      ? 0
      : (installmentsCount - paidInstallments);

  // (Extra útil) Expected installments up to currentTime (por calendario)
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
  if (expectedInstallments > installmentsCount)
    expectedInstallments = installmentsCount;

  return {
    "success": true,
    "currentPercent": currentPercent, // 0..100
    "remainingAmount": remainingAmount,
    "remainingInstallments": remainingInstallments,
    // opcional (por si lo quiere usar después):
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
