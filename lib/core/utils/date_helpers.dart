String shortDate(DateTime date) {
  const List<String> months = <String>[
    'Jan',
    'Feb',
    'Mär',
    'Apr',
    'Mai',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Okt',
    'Nov',
    'Dez',
  ];
  return '${date.day}. ${months[date.month - 1]}';
}

String expiryLabel(DateTime expiry) {
  final DateTime today = DateTime.now();
  final DateTime start = DateTime(today.year, today.month, today.day);
  final DateTime target = DateTime(expiry.year, expiry.month, expiry.day);
  final int days = target.difference(start).inDays;

  if (days < 0) return 'abgelaufen';
  if (days == 0) return 'heute';
  if (days == 1) return 'morgen';
  return 'in $days Tagen';
}
