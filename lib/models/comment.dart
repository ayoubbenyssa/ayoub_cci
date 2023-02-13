class Comment {
  var id;
  var idUser;
  var text;
  var imgUrl;
  bool delete;
  var idPost;
  DateTime createdat;
  var updatedat;
  var author1;
  var post;
  Comment(
      {this.id,
        this.idUser,
        this.text,
        this.author1,
        this.delete= false,
        this.imgUrl,
        this.idPost,
        this.post,
        this.createdat,
        this.updatedat});
  Comment.fromMap(Map<String, dynamic> map)
      : text = map['text'].toString(),
        id = map['objectId'].toString(),
        imgUrl = map['photo'].toString(),
        createdat =  DateTime.parse(map['createdAt'].toString()),
        updatedat = map['updatedAt'].toString(),
        idUser = map['idUser'].toString(),
        idPost = map['idPost'].toString(),
        author1 = map['author1'],
        post = map['post'];
}
