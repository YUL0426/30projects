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
