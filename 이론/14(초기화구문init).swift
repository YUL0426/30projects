초기화 : 클래스 구조체 또는 열거형의 인스턴스를 사용하기 위한 준비 과정

class User {
  var nickname: String
  var age: Int
  
  init(nickname: String, age: Int) {
    self.nickname = nickname
    self.age = age
  }
  
  init(age: Int) {
    self.nickname ="albert"
    self.age = age
}
  deinit {
  print("deinit user")
}

var user = User(nickname: "depot", age: 24)
user.nickname
user.age
  
var user2 = User(age: 27)
user2.nickname
user2.age
