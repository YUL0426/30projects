//9강 옵셔널
옵셔널 : 선택적인
=>값이 있을 수도 있고 없을 수도 있다

var name: String? //일반 타입뒤에 물음표(옵셔널), 초기값 지정하지 않아도 nil이 들어가있음

var optionalName: String? = "YUL" //

//10강 옵셔널바인딩
명시적해제 : 강제 해제, 비강제해제(옵셔널 바인딩)

var number: Int? = 3
print(number)       // "Optional(3)"
print(number!)      // 3, 강제해제는 매우위험, 예를들어 nil

if let result = number {
  print(result)
} else {
  
}
// 3

func test() {
  let number: Int? = 5
  guard let result = number else { return }
  print(result)
}

test()
//guard문은 조건이 true일 떄만 통과함

묵시적해제 : 컴파일러에 의한 자동해제, 옵셔널의 묵시적 해제

let value: Int? = 6
if value == 6 {
  print("value가 6입니다.")
} else {
  print("value가 6이 아니 아닙니다.")
}

let string = "12"
var StringToInt: Int! = Int(string)
print(StringToInt + 1)
