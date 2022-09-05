
enum Screen {
  login,
  register,
  resetPassword,
  main,
  profile,
  profileCommunity,
  profileMain,
  profileEdit,
  deviceList,
  deviceInfo,
  community,
  readPost,
  reply,
  replyDetail,
  activity,
  updatePost,
  undefined,
}

/*

enum Screen {
  login('login','로그인'),
  register('register','회원등록'),
  resetPassword('resetPassword','비밀번호재설정'),
  main('main','메인'),
  profile('profile','프로필'),
  profileEdit('profileEdit','프로필수정'),
  deviceList('deviceList','기기목록'),
  deviceInfo('deviceInfo','기기정보'),
  community('community','커뮤니티'),
  readPost('readPost','게시글읽기'),
  reply('reply','댓글'),
  replyDetail('replyDetail','댓글상세'),
  activity('activity','활동'),
  undefined('undefined','미정');

  const Screen(this.code, this.displayName);
  final String code;
  final String displayName;

  factory Screen.getByCode(String code){
    return Screen.values.firstWhere((value) => value.code == code,
        orElse: () => Screen.undefined);
  }
}
*/
