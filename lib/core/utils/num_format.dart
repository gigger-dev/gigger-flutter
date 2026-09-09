num? numFormat(num? value) {
  if (value == null) return null;

  var l = '$value'.split('.');

  num v;

  if (l.length == 2 && l[1] == '0') {
    v = int.parse(l[0]);
  } else {
    v = double.parse('$value');
  }

  if (v == 0) return null;

  return v;
}
