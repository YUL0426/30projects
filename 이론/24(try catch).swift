try catch : 프로그래 내에 에러가 발생한 상황에 대해 대응하고 이를 복구하느 과정
swith의 에러 처리 : 발생(throwing), 감지(catching), 전파(propagating), 조작(manipulating)

enum PhoneError : Error {
  case unknown
  case battery(batteryLevel: Int)
}

throw PhoneError.batteryLow(batteryLevel: 20)
//오류가 떳을시 던져준다.

ffunc checkPhoneBattteryStatus(batteryLevel: Int) throw -> String {
  //스로잉 함수
  //반환값이 있다면 함수 뒤에 작성
  guard batteryLevel != -1 else { throw PhoneError.unknown }
  //guard문 : false 일 때 else가 실행되며 조기종료됨
  guard betteryLevel >= 20 else { throw PhoneError.batteryLow(batteryLevel: 20)}
  
  return "배터리 상태가 정상입니다."
}

/*
//do catch문
do {
  try 오류 발생 가능 코드
} catch 오류 패턴 {
  처리코드
}
*/

do {
  try 
