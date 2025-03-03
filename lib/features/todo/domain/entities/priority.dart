enum Priority {
  high,
  medium,
  low
}

extension PriorityExtension on Priority {
  String get label {
    switch (this) {
      case Priority.high:
        return "High";
      case Priority.medium:
        return "Medium";
      case Priority.low:
        return "Low";
    }
  }
}