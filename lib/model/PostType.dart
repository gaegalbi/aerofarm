/*
enum BoardValue {
  announcement('ANNOUNCEMENT', '공지사항'),
  hot('HOT','인기게시판'),
  all('ALL','전체게시판'),
  free('FREE','자유게시판'),
  question('QUESTION','질문게시판'),
  information('INFORMATION','정보게시판'),
  picture('PICTURE','사진게시판'),
  trade('TRADE','거래게시판'),
  undefined('undefined','게시판 선택');

  const BoardValue(this.code, this.displayName);
  final String code;
  final String displayName;

  factory BoardValue.getByCode(String code){
    return BoardValue.values.firstWhere((value) => value.code == code);
  }
}

enum FilterValue{
  normal('NORMAL','일반'),
  hobby('HOBBY','취미'),
  game('GAME','게임'),
  daily('DAILY','일상'),
  travel('TRAVEL','여행'),
  undefined('undefined','분류 선택');

  const FilterValue(this.code, this.displayName);
  final String code;
  final String displayName;

  factory FilterValue.getByCode(String code){
    return FilterValue.values.firstWhere((value) => value.code == code);
  }
}*/
