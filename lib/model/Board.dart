import 'package:capstone/model/BoardType.dart';
import 'package:capstone/provider/Controller.dart';
import '../utils/CheckTimer.dart';
import 'FilterType.dart';

class Board{
  String id="";
  FilterType filter = FilterType.undefined;
  BoardType category = BoardType.undefined;
  String title="";
  //내용
  String content="";
  //변경 안한 date값
  String modifiedDate="";
  //dateFormat으로 변경한 date값
  String date="";
  //현재 시간
  String current = dateFormat.format(DateTime.now());
  String writer="";
  int views=0;
  int likeCount=0;
  int commentCount=0;
  String groupId="";
  bool deleteTnF = false;
  bool like = false;
  String parentId = "";

  Board();

  Board.activityFetch(Map<String, dynamic> data){
    id = data['id'].toString();
    title = data['title'];
    writer = data['writer'];
    deleteTnF = data['deleteTnF'];
    modifiedDate = data['modifiedDate'];
    date = dateInfoFormat.format(DateTime.parse(modifiedDate));
  }

  Board.fetch(Map<String, dynamic> data){
    id = data['id'].toString();
    title = data['title'];
    writer = data['writer'];
    filter = FilterType.getByCode(data['filter'].toString());
    category = BoardType.getByCode(data['category'].toString());

    modifiedDate = data['modifiedDate'];
    date = dateInfoFormat.format(DateTime.parse(modifiedDate));

   if(current == date.substring(0, 10)) {
      date = date.substring(10,date.length);
    }else{
      date = date.substring(2,10);
    }

    views = data['views'];
    commentCount = data['commentCount'];
    likeCount = data['likeCount'];
    groupId = data['groupId'].toString();
    deleteTnF = data['deleteTnF'];
    if(data['parentId']!=null){
      parentId = data['parentId'].toString();
    }
  }

  void fetchLike(String input){
    if(input=="true"){
      like = true;
    }else{
      like = false;
    }
  }

  void setLike(bool input){
    if(!input){
      like = true;
      likeCount++;
    }else{
      like = false;
      likeCount--;
    }
  }
}