String formatarData(DateTime data) {
  String dataForm = '';
  if (data.day > 9) {
    dataForm = '${data.day}/';
  } else {
    dataForm = '0${data.day}/';
  }
  if (data.month > 9) {
    dataForm += '${data.month}/';
  } else {
    dataForm += '0${data.month}/';
  }
  dataForm += data.year.toString();
  return dataForm;
}
