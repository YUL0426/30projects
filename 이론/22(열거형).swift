열거형 : 연관성이 있는 값으 모아 놓은것
키워드 : enum

enum CompassPoint {
  case north
  case south
  case east
  case west //연관되 항목, 한줄 로도 나열 가능 및 각 자체가 고유값
}

//하나의 타입처럼 가용

var direction = CompassPoint.east
// => east
direction = .west

switch direction {
  case .north:
   print("north")
  case .south:
   print("south")
  case .east:
   print("east")
  case .west:
   print("west")
}

//원시값

enum CompassPoint: String {
  case norht ="북"
  case south ="남"
  case east ="동"
  case west = "서"
}

switch direction {
  case .north:
  print(direction.rawValue)
}

let direction2 = CompassPoint(rawValue : "남") // 상수선언
