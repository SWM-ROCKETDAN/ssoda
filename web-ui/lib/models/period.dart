class Period {
  DateTime _startDate;
  DateTime? _finishDate;
  int _dateShortcut;

  DateTime get startDate => _startDate;
  DateTime? get finishDate => _finishDate;
  int get dateShortcut => _dateShortcut;

  set startDate(DateTime startDate) => _startDate = startDate;
  set finishDate(DateTime? finishDate) => _finishDate = finishDate;
  set dateShortcut(int dateShortcut) => _dateShortcut = dateShortcut;

  Period(this._startDate, this._finishDate, this._dateShortcut);
}
