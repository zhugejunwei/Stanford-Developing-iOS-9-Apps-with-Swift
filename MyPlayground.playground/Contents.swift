//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]


func nonescapingClosure(@noescape closure: () -> Void) {
    closure()
}

var completion: [() -> Void] = []
func escapingClosure(completionHandler: () -> Void) {
    completion.append(completionHandler)
}

class SomeClass {
    var x = 10
    func doSomething() {
        escapingClosure { [weak weakSelf = self] in weakSelf?.x = 100 }
        nonescapingClosure { x = 200 }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)
// Prints "200"

completion.last?()
print(instance.x)
// Prints "100"


func find(@autoclosure  closure: () ->String) {
    print(closure())
}

// { "找不到啊找不到" }会被编译器自动转化为@autoclosure
find( "找不到啊找不到" )

var myArray = ["1","2","3","4","5"]
func addOneElement(@autoclosure arrayOne: () -> Void) {
    print("Last element of myArray is \(arrayOne())!")
}

print("Last element of myArray is \(myArray.last)!")
addOneElement( myArray.append("6") )
print("Last element of myArray is \(myArray.last)!")


// customersInLine is ["Alex", "Ewa", "Barry", "Daniella"]
func serveCustomer(customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serveCustomer( { customersInLine.removeAtIndex(0) } )
// Prints "Now serving Alex!"


