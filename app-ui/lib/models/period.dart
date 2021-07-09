class Period {
  DateTime _startDate;
  DateTime _finishDate;
  bool _isPermanent;

  DateTime get startDate => _startDate;
  DateTime get finishDate => _finishDate;
  bool get isPermanent => _isPermanent;

  set startDate(DateTime startDate) => _startDate = startDate;
  set finishDate(DateTime finishDate) => _finishDate = finishDate;
  set isPermanent(bool isPermanent) => _isPermanent = isPermanent;

  Period(this._startDate, this._finishDate, this._isPermanent);
}
