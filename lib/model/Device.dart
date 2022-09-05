class Device{
  String nickname="";

  String imageUrl="";

  //기기 고유의 MAC주소
  String macAddress="";

  String ipAddress="";

  //CD키 개념, 변경 가능
  String uuid="";

  String model="";

  String plant="";

  String owner="";
  String createDate = "";

  int number=0;

  int temperature = 20;
  int humidity = 50;
  int fertilizer = 1;
  bool ledOn = false;

  Device(Map<String,dynamic> data){
    if(data['plant']!=null) {
      plant = data['plant'];
    }else{
      plant = "미등록";
    }
    nickname = data['nickname'];
    imageUrl = data['imageUrl'];
    model = data['model'];
    createDate = data['createDate'].toString();
  }
}