import XCTest
@testable import DomainModel

class PersonTests: XCTestCase {

    func testPerson() {
        let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)
        XCTAssert(ted.toString() == "[Person: firstName:Ted lastName:Neward age:45 job:nil spouse:nil]")
    }
    
    func testAgeRestrictions() {
        let matt = Person(firstName: "Matthew", lastName: "Neward", age: 15)

        matt.job = Job(title: "Burger-Flipper", type: Job.JobType.Hourly(5.5))
        XCTAssert(matt.job == nil)

        matt.spouse = Person(firstName: "Bambi", lastName: "Jones", age: 42)
        XCTAssert(matt.spouse == nil)
    }

    func testAdultAgeRestrictions() {
        let mike = Person(firstName: "Michael", lastName: "Neward", age: 22)

        mike.job = Job(title: "Burger-Flipper", type: Job.JobType.Hourly(5.5))
        XCTAssert(mike.job != nil)

        mike.spouse = Person(firstName: "Bambi", lastName: "Jones", age: 42)
        XCTAssert(mike.spouse != nil)
    }
    
    //Extra Credit Tests + FirstName/LastName Test
    func testPersonBeyonce() {
        let beyonce = Person(firstName: "Beyonce", age: 40)
        XCTAssert(beyonce.toString() == "[Person: firstName:Beyonce lastName:nil age:40 job:nil spouse:nil]")
    }
    
    func testPersonBono() {
        let bono = Person(firstName: "Bono", age: 40)
        bono.lastName = "Famous"
        XCTAssert(bono.toString() == "[Person: firstName:Bono lastName:Famous age:40 job:nil spouse:nil]")
    }
    
    func testPersonLastName() {
        let ryuji = Person(lastName: "Sakamoto", age: 21)
        XCTAssert(ryuji.toString() == "[Person: firstName:nil lastName:Sakamoto age:21 job:nil spouse:nil]")
    }
    

    static var allTests = [
        ("testPerson", testPerson),
        ("testAgeRestrictions", testAgeRestrictions),
        ("testAdultAgeRestrictions", testAdultAgeRestrictions),
        
        ("testPersonBeyonce", testPersonBeyonce),
        ("testPersonBono", testPersonBono),
        ("testPersonLastName", testPersonLastName)
    ]
}

class FamilyTests : XCTestCase {
  
    func testFamily() {
        let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)
        ted.job = Job(title: "Gues Lecturer", type: Job.JobType.Salary(1000))

        let charlotte = Person(firstName: "Charlotte", lastName: "Neward", age: 45)

        let family = Family(spouse1: ted, spouse2: charlotte)

        let familyIncome = family.householdIncome()
        XCTAssert(familyIncome == 1000)
    }

    func testFamilyWithKids() {
        let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)
        ted.job = Job(title: "Gues Lecturer", type: Job.JobType.Salary(1000))

        let charlotte = Person(firstName: "Charlotte", lastName: "Neward", age: 45)

        let family = Family(spouse1: ted, spouse2: charlotte)

        let mike = Person(firstName: "Mike", lastName: "Neward", age: 22)
        mike.job = Job(title: "Burger-Flipper", type: Job.JobType.Hourly(5.5))

        let matt = Person(firstName: "Matt", lastName: "Neward", age: 16)
        let _ = family.haveChild(mike)
        let _ = family.haveChild(matt)

        let familyIncome = family.householdIncome()
        XCTAssert(familyIncome == 12000)
    }
    
    //Extra Credit Tests
    func testFamilyButUnderage() {
        let james = Person(firstName: "James", age: 15)
        let ryuji = Person(firstName: "Ryuji", age: 15)
        let family = Family(spouse1: james, spouse2: ryuji)
        
        let junpei = Person(firstName: "junpei", age: 12)
        let familyChild = family.haveChild(junpei)
        XCTAssert(familyChild == false);
    }
    
    func testFamilyKidOneSpouseOfAge() {
        let james = Person(firstName: "James", age: 22)
        let ryuji = Person(firstName: "Ryuji", age: 20) //can't have kid
        let family = Family(spouse1: james, spouse2: ryuji)

        let junpei = Person(firstName: "junpei", age: 12)
        let familyChild = family.haveChild(junpei)
        XCTAssert(familyChild == true);
        XCTAssert(family.members.count == 3)
    }
    
    func testCheating() {
        let james = Person(firstName: "James", age: 22)
        let ryuji = Person(firstName: "Ryuji", age: 22)
        let gekko = Person(firstName: "gekko", age: 22)
        
        james.spouse = gekko;
        let family = Family(spouse1: james, spouse2: ryuji)
        XCTAssert(family.members.count == 0);
    }
    
    func testBreakUp() {
        let james = Person(firstName: "James", age: 24)
        let ryuji = Person(firstName: "Ryuji", age: 24)
        let gekko = Person(firstName: "gekko", age: 24)
        
        james.spouse = gekko;
        james.spouse = nil;
        let family = Family(spouse1: james, spouse2: ryuji)
        XCTAssert(family.members.count == 2);
    }
    
    func testFamilyAndAlreadyMarried() {
        let james = Person(firstName: "James", age: 24)
        let gekko = Person(firstName: "gekko", age: 24)
        
        james.spouse = gekko;
        let family = Family(spouse1: james, spouse2: gekko)
        XCTAssert(family.members.count == 2);
    }
  
    static var allTests = [
        ("testFamily", testFamily),
        ("testFamilyWithKids", testFamilyWithKids),
        
        ("testFamilyButUnderage", testFamilyButUnderage),
        ("testFamilyKidOneSpouseOfAge", testFamilyKidOneSpouseOfAge),
        ("testCheating", testCheating),
        ("testBreakUp", testBreakUp),
        ("testFamilyAndAlreadyMarried", testFamilyAndAlreadyMarried)
    ]
}
