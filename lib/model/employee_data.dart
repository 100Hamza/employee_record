
class employee_record
{
  String? commentTitle, commentUserName, hours;
  int? comments, likes, dislikes, share;
  bool isImage;
  employee_record({this.commentTitle, this.commentUserName,this.comments, this.likes ,this.dislikes , this.share ,this.isImage = false , this.hours});

}


List<employee_record> employee_recordList = [
  employee_record(commentTitle: '08033155292' , commentUserName: 'Adaeze' , likes: 2 , dislikes: 3, comments: 4, share: 5, hours: '2h'),
  employee_record(commentTitle: '08103474143' , commentUserName: 'Ibrahim' , isImage: true, likes: 3 , dislikes: 4, comments: 5, share: 6, hours: '20mint'),
  employee_record(commentTitle: '08145744056' , commentUserName: 'Chidiadi' , isImage: true, likes: 4 , dislikes: 5, comments: 6, share: 7, hours: '12h'),
  employee_record(commentTitle: '08184681854' , commentUserName: 'Debare' , likes: 5 , dislikes: 6, comments: 7, share: 8, hours: '1h'),
  employee_record(commentTitle: '08037245837' , commentUserName: 'Enofe' , isImage: true, likes: 6 , dislikes: 7, comments: 8, share: 9, hours: '3h'),
  employee_record(commentTitle: '07061694507' , commentUserName: 'Ifemyolunna' , likes: 7 , dislikes: 8, comments: 9, share: 10, hours: '4h'),
];