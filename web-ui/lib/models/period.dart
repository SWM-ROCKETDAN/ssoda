class Period {
  DateTime _startDate;
  DateTime? _finishDate;

  DateTime get startDate => _startDate;
  DateTime? get finishDate => _finishDate;

  set startDate(DateTime startDate) => _startDate = startDate;
  set finishDate(DateTime? finishDate) => _finishDate = finishDate;

  Period(this._startDate, this._finishDate);
}
