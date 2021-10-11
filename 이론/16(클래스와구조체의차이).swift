class someClass {
  var count: Int = 0
}

struct SomeStruct {
  var count: Int = 0
}

var class1 = someClass()
var class2 = class1
var class3 = class1

class3.count = 2
class1.count

// 결과값 2

var struct1 = someStruct()
var struct2 = struct1
var struct3 = struct1

struct2.count = 3
struct3.count = 4

struct1.count
struct2.count
strcut3.count

// 0, 3, 4
