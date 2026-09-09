String durationAgo(Duration duration) {
  if (duration.inDays > 0) {
    return '${duration.inDays}d${duration.inDays > 1 ? 's' : ''}';
  }

  if (duration.inHours > 0) {
    return '${duration.inHours}hr${duration.inHours > 1 ? 's' : ''}';
  }

  return '${duration.inMinutes}min${duration.inMinutes > 1 ? 's' : ''}';
}
