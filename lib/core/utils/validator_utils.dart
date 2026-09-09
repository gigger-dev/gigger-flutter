String? passwordValidator(String password) {
  return !RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$',
  ).hasMatch(password)
      ? 'must be 8 chars, 1 uppercase, 1 lowercase, 1 number, 1 special char'
      : null;
}
