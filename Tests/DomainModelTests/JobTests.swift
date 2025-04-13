import XCTest
@testable import DomainModel

class JobTests: XCTestCase {
  
    func testCreateSalaryJob() {
        let job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
        XCTAssert(job.calculateIncome(50) == 1000)
        XCTAssert(job.calculateIncome(100) == 1000)
        // Salary jobs pay the same no matter how many hours you work
    }

    func testCreateHourlyJob() {
        let job = Job(title: "Janitor", type: Job.JobType.Hourly(15.0))
        XCTAssert(job.calculateIncome(10) == 150)
        XCTAssert(job.calculateIncome(20) == 300)
    }

    func testSalariedRaise() {
        let job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
        XCTAssert(job.calculateIncome(50) == 1000)

        job.raise(byAmount: 1000)
        XCTAssert(job.calculateIncome(50) == 2000)

        job.raise(byPercent: 0.1)
        XCTAssert(job.calculateIncome(50) == 2200)
    }

    func testHourlyRaise() {
        let job = Job(title: "Janitor", type: Job.JobType.Hourly(15.0))
        XCTAssert(job.calculateIncome(10) == 150)

        job.raise(byAmount: 1.0)
        XCTAssert(job.calculateIncome(10) == 160)

        job.raise(byPercent: 1.0) // Nice raise, bruh
        XCTAssert(job.calculateIncome(10) == 320)
    }
    
    // Extra Credit Tests + Convert Method Test
    func testConvert() {
        let job = Job(title: "TA", type: Job.JobType.Hourly(23.0))
        XCTAssert(job.calculateIncome(10) == 230)
        
        let convertWorks = job.convert()
        XCTAssert(convertWorks);
        XCTAssert(job.calculateIncome(10) == 46000)
        //I wish lol
    }
    
    func testConvertNegative() {
        let job = Job(title: "TA", type: Job.JobType.Hourly(-23.0))
        XCTAssert(job.calculateIncome(10) == 0)
        
        let convertWorks = job.convert()
        XCTAssert(convertWorks);
        XCTAssert(job.calculateIncome(10) == 0)
    }
    
    func testConvertAnnualToSalary() {
        let job = Job(title: "High School Teacher", type: Job.JobType.Salary(60000))
        let convertIsFalse = job.convert()
        XCTAssert(!convertIsFalse)
        XCTAssert(job.calculateIncome(10) == 60000)
    }
    
    func testCreateNegativeSalaryJob() {
        let job = Job(title: "Guest Lecturer", type: Job.JobType.Hourly(-20))
        XCTAssert(job.calculateIncome(1230) == 0)
        XCTAssert(job.calculateIncome(34593) == 0)
        // Since hourly is negative, we shouldn't be stealing from people's salaries.
    }
    
    func testDecreasePayAmountSalary() {
        let job = Job(title: "Teacher", type: Job.JobType.Salary(5000))
        job.raise(byAmount: -50)
        XCTAssert(job.calculateIncome(5) == 4950)
    }
    
    func testDecreasePayAmountHourly() {
        let job = Job(title: "TA", type: Job.JobType.Hourly(24))
        job.raise(byAmount: -0.50)
        XCTAssert(job.calculateIncome(5) == 117)
    }
    
    func testDecreasePayPercentageSalary() {
         let job = Job(title: "Teacher", type: Job.JobType.Salary(5000))
        job.raise(byPercent: -0.25)
        XCTAssert(job.calculateIncome(5) == 3750)
    }
    
    func testDecreasePayPercentageHourly() {
         let job = Job(title: "TA", type: Job.JobType.Hourly(20))
        job.raise(byPercent: -0.1)
        XCTAssert(job.calculateIncome(5) == 90)
    }
  
    static var allTests = [
        ("testCreateSalaryJob", testCreateSalaryJob),
        ("testCreateHourlyJob", testCreateHourlyJob),
        ("testSalariedRaise", testSalariedRaise),
        ("testHourlyRaise", testHourlyRaise),
        
        ("testConvert", testConvert),
        ("testConvertNegative", testConvertNegative),
        ("testConvertAnnualToSalary", testConvertAnnualToSalary),
        ("testCreateNegativeSalaryJob", testCreateNegativeSalaryJob),
        ("testDecreasePayAmountSalary", testDecreasePayAmountSalary),
        ("testDecreasePayAmountHourly", testDecreasePayAmountHourly),
        ("testDecreasePayPercentageSalary", testDecreasePayPercentageSalary),
        ("testDecreasePayPercentageHourly", testDecreasePayPercentageHourly),
    ]
}
