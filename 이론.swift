import UIKit

//6강 컬렉션 타입

//arr
var numbers: Array<Int> = Array<Int>() // 기본적인 array, 현재느 빈 arr
numbers.append(1) // numbers배열에 1추가

var names = [String]() // string arr생성
var names = [String] = [] // string arr생성2

//dict
var dic:Dictionary<String, Int> = Dictionary<String, Int>() // Dict선언
var dic: [String: Int] = [:] // 축약된 형태
dic["김철수"] = 3 //dic에 삽입방법

//set
var set: Set = Set<Int>() // set선언, 및 축약형 없음
set.insert(10) // set에 값 넣어주기
//set는 순서 x, 중복저장 x

//7강 함수 사용법
함수 정의와 호출
func 함수명(파라미터이름:데이터 타입) -> 반환 타입 {
  return 반환 값
}
//기본 형식
// 어떤타입이 반환될건지...
ex)
func sum(a: Int, b: Int) -> Int {
  return a+b
}
호출 : sum(a:5, b:3)

func hello() -> String { //매개변수가 없을시 소괄호란을 공란으로
  return "Hello"
}

//반환값이 없는함수
func printName() ->  {

}

func sendMessage(from myName: String, to name: String) -> String {
  return "Hello \(name)! I'm \(myName)"
}

sendMessage(from: "Gunter", to: "Json")


  
