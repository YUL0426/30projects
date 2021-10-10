구조체

struct 구조체 이름 {
  프로퍼티와 메서드
}

struct User {
  var nickname: String
  var age: Int
  
  func information() {
    print("\(nickname) \(age)")
}

var user = User(nickname: "YUL", age: 25)

user.nickname
user.nickname = "irellia"
user.nickname

user.information()
