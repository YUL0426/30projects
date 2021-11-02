*옵셔널 체이닝 : 옵셔널에 속해 있는 nil 일지도 모르는 프로퍼티, 메서드, 서브스크립션 등을 가져오거나 호출할 때 사용할 수 있는 일련의 과정

import Foundation

struct Developer {
  let name : String
}

struct Company {
  let name : String
  var developer : Developer?
}

var devloper = Developer(name: "han")
var company: Company(name: "y", devloper : nil)
print(company.devloper)
// => nil


print(company.devloper?.name) => 물음표로 항상 체이닝을 하면 접근한 프로퍼티으 값은 항상 옵셔널로 감싸져있다.
print(comapny.devloper!.name) => 느낌표로 체이닝을 하면 옵셔널 프로퍼티를 강제 언래핑함.
=> Optional("han") , han


