try catch : 프로그래 내에 에러가 발생한 상황에 대해 대응하고 이를 복구하느 과정
swith의 에러 처리 : 발생(throwing), 감지(catching), 전파(propagating), 조작(manipulating)

enum PhoneError : Error {
  case unknown
  case battery(batteryLevel: Int)
}

throw PhoneError.batteryLow(batteryLevel: 20)
//오류가 떳을시 던져준다.
