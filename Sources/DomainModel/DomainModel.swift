struct DomainModel {
    var text = "Hello, World!"
        // Leave this here; this value is also tested in the tests,
        // and serves to make sure that everything is working correctly
        // in the testing harness and framework.
}

////////////////////////////////////
// Money
//
public struct Money {
    var amount: Int;
    var currency: String;
    
    init(amount: Int, currency: String) {
        self.amount = amount
        self.currency = currency
    }
    
    func getAmount() -> Int {
        return self.amount
    }
    
    func getCurrency() -> String {
        return self.currency
    }

    func convert(_ currencyName : String) -> Money {
        let currency : [String] = ["USD", "EUR", "CAN", "GBP"]
        guard currency.contains(currencyName) else {
            return self;
        }
        
        var amountInUSD : Int        
        if self.currency == "USD" {
            amountInUSD = self.amount;
        } else if self.currency == "GBP" {
            amountInUSD = Int(Double(self.amount) / 0.5)
        } else if self.currency == "EUR" {
            amountInUSD = Int(Double(self.amount) / 1.5)
        } else if self.currency == "CAN" {
            amountInUSD = Int(Double(self.amount) / 1.25)
        } else {
            amountInUSD = self.amount
        }
        
        switch currencyName {
            case "USD":
                return Money(amount: amountInUSD, currency: "USD")
            case "GBP":
                return Money(amount: Int(Double(amountInUSD) * 0.5), currency: "GBP")
            case "EUR":
                return Money(amount: Int(Double(amountInUSD) * 1.5), currency: "EUR")
            case "CAN":
                return Money(amount: Int(Double(amountInUSD) * 1.25), currency: "CAN")
            default:
                return self
        }
    }
    
    func add(_ moneyObj : Money) -> Money {
        if (moneyObj.currency == self.currency) {
            return Money(amount: self.amount + moneyObj.amount, currency: moneyObj.currency);
        } else {
            let convertedAmount : Money = convert(moneyObj.currency);
            return Money(amount: convertedAmount.amount + moneyObj.amount, currency: moneyObj.currency);
        }
    }
}

////////////////////////////////////
// Job
//
public class Job {
    public enum JobType {
        case Hourly(Double)
        case Salary(UInt)
    }
    
    var title : String
    var type : JobType
    
    init(title: String, type: JobType) {
        self.title = title
        self.type = type
    }
    
    func calculateIncome(_ hours: Int) -> Int {
        switch type {
            case let .Hourly(salary):
                return Int(Double(hours) * salary);
            case let .Salary(salary):
                return Int(salary)
        }
    }
    
    func raise(byAmount: Int) {

        switch type {
            case let .Hourly(hourlySalary):
                self.type = .Hourly(hourlySalary + Double(byAmount));
            case let .Salary(annualSaluary):
                self.type = .Salary(annualSaluary + UInt(byAmount));
        }
    }
    
    func raise(byAmount: Double) {
        switch type {
            case let .Hourly(hourlySalary):
                self.type = .Hourly(hourlySalary + byAmount)
            case let .Salary(annualSaluary):
                self.type = .Salary(annualSaluary + UInt(byAmount))
        }

    }
    
    func raise(byPercent: Double) {
        switch type {
            case let .Hourly(salary):
                self.type = .Hourly(salary * (1.0 + byPercent))
            case let .Salary(salary):
                self.type = .Salary(UInt(Double(salary) * (1.0 + byPercent)))
        }

    }
}

////////////////////////////////////
// Person
//
public class Person {
    var firstName : String
    var lastName : String
    var age : Int
    var job : Job?
    var spouse : Person?
    
    init(firstName: String, lastName: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    func toString() -> String {
        return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(job) spouse:\(spouse)]"
    }
    
}

////////////////////////////////////
// Family
//
public class Family {
    var members : [Person] = [];
    
    init(spouse1 : Person, spouse2 : Person) {
        guard spouse1.spouse == nil && spouse2.spouse == nil else {
            return // I would usually throw an error...
        }
        spouse1.spouse = spouse2;
        spouse2.spouse = spouse1;
        self.members = [spouse1, spouse2];
    }
    
    func haveChild(_ person : Person) -> Bool {
        guard person.age > 21 else {
            return false
        }
        members.append(person);
        return true;
    }
    
    func householdIncome() -> Int {
        guard members.count > 0 else {
            return 0;
        }
        
        var count = 0;
        
        for i in 0...members.count-1 {
            if let jobSalary = members[i].job?.calculateIncome(2000) {
                count = count + jobSalary;
            }
        }
        return count;
    }
}
