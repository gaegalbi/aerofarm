enum FilterType {
  normal('NORMAL','일반'),
  hobby('HOBBY','취미'),
  game('GAME','게임'),
  daily('DAILY','일상'),
  travel('TRAVEL','여행'),
  undefined('undefined','미정');

  const FilterType(this.code, this.displayName);
  final String code;
  final String displayName;


  factory FilterType.getByCode(String code){
    return FilterType.values.firstWhere((value) => value.code == code);
  }
}


