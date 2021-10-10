프로퍼티 : 클래스,구조체 또는 열거형 등에 관련된 값
- 저장 프로퍼티, 연산 프로퍼티, 타입 프로퍼티

저장 프로퍼티 : 프로퍼티를 사용하는 가장 간단한 방법

struct Dog {
  var name:String
  let gender: String
}

var dog = Dog(name: "happy", gender : "male")
print(dog)
//Dog(name: "happy", gender: "male")

dog.name = "해피"
dog.gender = "female"
// error, 상수는 값 변경이 불가능하므로

let dog2 = Dog(name: "demon", gender: "male")
dog2.name = "lemon" 
//error, dog2가 상수로 선언되었기 때문에 변경 불가

c
