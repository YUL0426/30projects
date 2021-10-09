조건문
: 주어진 조건에 따라서 어플리케이션을 다르게 동작하도록 하는 것
=>if, switch, guard

/*
if 조건식 {
  실행할 구문
}
*/

let age = 12

if age < 19 {
  print("미성년자입니다.")
}

/*
switch 비교대상 {
  case 패턴1:
    // 패턴1 일치할 때 실행되는 구문
  case 패턴2, 3:
    // 패턴2,3이 일치할 때 실행되는 구문
  default:
    // 어느 비교 패턴과도 일치하지 않을 때 실행되는 구문
*/

let color = "green"

switch color {
  case "blue":
  print("파란색 입니다.")
  case "green":
  print("초록색 입니다.")
  case "red":
  print("빨간색 입니다.")
  default:
  print("there is no color that you want.")
}
