class AppWriteConstant {
  static const String databeseId = '6434cd80d6bf32524167';
  static const String projectId = '6434ccff9a16d8dce0fd';
  static const String endPoint = 'http://192.168.1.24/v1';
  static const String usersCollectionId = '6434cd900e086d18037a';
  static const String tweetsCollectionId = '643b15a258a3f5b2b5d3';
  static const String imagesBucketId = '643b554253dfbb12f767';
  
  
  
  
  static String getImageUrl(String imgId){
    return  "$endPoint/storage/buckets/$imagesBucketId/files/$imgId/view?project=$projectId&mode=admin";
  }
  

}
