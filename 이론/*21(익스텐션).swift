익스텐션 : 기존의 클래스, 구조체, 열거형, 프로토콜에 새로운 기능을 추가하는 기능

extension Int {
  var isEven: Bool {
    return self % 2 == 0
  }
  
  var isOdd: Bool {
    return self % 2 == 1
  }
}

var number = 3
number.isOdd
number.isEven
// => true, false

extension String {
  func convertToInt() -> Int? {
    return Int(self)
  }
}

var string = "0"
string.converToInt()
// => 0
