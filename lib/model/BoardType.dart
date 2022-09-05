enum BoardType {
  announcement('ANNOUNCEMENT', '공지사항'),
  hot('HOT','인기게시판'),
  all('ALL','전체게시판'),
  free('FREE', '자유게시판'),
  question('QUESTION','질문게시판'),
  info('INFORMATION','정보게시판'),
  picture('PICTURE','사진게시판'),
  trade('TRADE','거래게시판'),
  undefined('undefined','미정');

  const BoardType(this.code, this.displayName);
  final String code;
  final String displayName;

  factory BoardType.getByCode(String code){
    return BoardType.values.firstWhere((value) => value.code == code);
  }
}


