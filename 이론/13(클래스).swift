class Dog {
  var name: String = ""
  var age: Int = 0
  
  func introduce() {
    print("name \(name) age \(age)")
  }
}

var dog = Dog()
dog.name = "Coco"
dog.age = 3
dog.name
dog.age

dog.introduce()
