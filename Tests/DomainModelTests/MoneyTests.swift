import XCTest
@testable import DomainModel

class MoneyTests: XCTestCase {
  
  let tenUSD = Money(amount: 10, currency: "USD")
  let twelveUSD = Money(amount: 12, currency: "USD")
  let fiveGBP = Money(amount: 5, currency: "GBP")
  let fifteenEUR = Money(amount: 15, currency: "EUR")
  let fifteenCAN = Money(amount: 15, currency: "CAN")
  
  func testCanICreateMoney() {
    let oneUSD = Money(amount: 1, currency: "USD")
    XCTAssert(oneUSD.amount == 1)
    XCTAssert(oneUSD.currency == "USD")
    
    let tenGBP = Money(amount: 10, currency: "GBP")
    XCTAssert(tenGBP.amount == 10)
    XCTAssert(tenGBP.currency == "GBP")
  }
  
  func testUSDtoGBP() {
    let gbp = tenUSD.convert("GBP")
    XCTAssert(gbp.currency == "GBP")
    XCTAssert(gbp.amount == 5)
  }
  func testUSDtoEUR() {
    let eur = tenUSD.convert("EUR")
    XCTAssert(eur.currency == "EUR")
    XCTAssert(eur.amount == 15)
  }
  func testUSDtoCAN() {
    let can = twelveUSD.convert("CAN")
    XCTAssert(can.currency == "CAN")
    XCTAssert(can.amount == 15)
  }
  func testGBPtoUSD() {
    let usd = fiveGBP.convert("USD")
    XCTAssert(usd.currency == "USD")
    XCTAssert(usd.amount == 10)
  }
  func testEURtoUSD() {
    let usd = fifteenEUR.convert("USD")
    XCTAssert(usd.currency == "USD")
    XCTAssert(usd.amount == 10)
  }
  func testCANtoUSD() {
    let usd = fifteenCAN.convert("USD")
    XCTAssert(usd.currency == "USD")
    XCTAssert(usd.amount == 12)
  }
  
  func testUSDtoEURtoUSD() {
    let eur = tenUSD.convert("EUR")
    let usd = eur.convert("USD")
    XCTAssert(tenUSD.amount == usd.amount)
    XCTAssert(tenUSD.currency == usd.currency)
  }
  func testUSDtoGBPtoUSD() {
    let gbp = tenUSD.convert("GBP")
    let usd = gbp.convert("USD")
    XCTAssert(tenUSD.amount == usd.amount)
    XCTAssert(tenUSD.currency == usd.currency)
  }
  func testUSDtoCANtoUSD() {
    let can = twelveUSD.convert("CAN")
    let usd = can.convert("USD")
    XCTAssert(twelveUSD.amount == usd.amount)
    XCTAssert(twelveUSD.currency == usd.currency)
  }
  
  func testAddUSDtoUSD() {
    let total = tenUSD.add(tenUSD)
    XCTAssert(total.amount == 20)
    XCTAssert(total.currency == "USD")
  }
  
  func testAddUSDtoGBP() {
    let total = tenUSD.add(fiveGBP)
    XCTAssert(total.amount == 10)
    XCTAssert(total.currency == "GBP")
  }
    
  // Extra Credit Tests
    func testConvertZeroDollars() {
        let zeroUSD = Money(amount: 0, currency: "USD")
        XCTAssert(zeroUSD.convert("GBP").amount == 0)
    }
    
    func testAddNegativeUSDtoUSD() {
        let negativeTenUSD = Money(amount: -10, currency: "USD")
        let total = negativeTenUSD.add(tenUSD)
        XCTAssert(total.amount == 0)
    }
    
    func testAddNegativeUSDtoGBP() {
        let negativeTenUSD = Money(amount: -10, currency: "USD")
        let twoGBP = Money(amount: 2, currency: "GBP")
        let total = negativeTenUSD.add(twoGBP)
        XCTAssert(total.amount == -3)
        XCTAssert(total.currency == "GBP")
    }
    
    func testAddNegativeGBPtoUSD() {
        let negativeTenGBP = Money(amount: -10, currency: "GBP")
        let twoUSD = Money(amount: 2, currency: "USD")
        let total = negativeTenGBP.add(twoUSD)
        XCTAssert(total.amount == -18)
        XCTAssert(total.currency == "USD")
    }
    
    func testInvalidCurrency() {
        let invalidMoney = Money(amount: -10, currency: "RyujiSakamoto")
        XCTAssert(invalidMoney.amount == 0)
    }
    
    func testConvertNegativeUSDtoGBP() {
        let negativeTenUSD = Money(amount: -10, currency: "USD")
        let gbp = negativeTenUSD.convert("GBP")
        XCTAssert(gbp.currency == "GBP")
        XCTAssert(gbp.amount == -5)
    }
    
    func testConvertInvalidCurrency() {
        let validMoney = Money(amount: 10, currency: "USD")
        let fakeMoney = validMoney.convert("Persona5")
        XCTAssert(fakeMoney.currency == "USD")
        XCTAssert(fakeMoney.amount == 10)
    }
    
    func testInvalidCurrencyThenConvert() {
        let fakeMoney = Money(amount: 10, currency: "Persona5")
        let tenUSD = fakeMoney.convert("GBP")
        XCTAssert(tenUSD.currency == "GBP")
        XCTAssert(tenUSD.amount == 0)
    }
    


    static var allTests = [
        ("testCanICreateMoney", testCanICreateMoney),

        ("testUSDtoGBP", testUSDtoGBP),
        ("testUSDtoEUR", testUSDtoEUR),
        ("testUSDtoCAN", testUSDtoCAN),
        ("testGBPtoUSD", testGBPtoUSD),
        ("testEURtoUSD", testEURtoUSD),
        ("testCANtoUSD", testCANtoUSD),
        ("testUSDtoEURtoUSD", testUSDtoEURtoUSD),
        ("testUSDtoGBPtoUSD", testUSDtoGBPtoUSD),
        ("testUSDtoCANtoUSD", testUSDtoCANtoUSD),
        
        ("testAddUSDtoUSD", testAddUSDtoUSD),
        ("testAddUSDtoGBP", testAddUSDtoGBP),
        
        ("testConvertZeroDollars", testConvertZeroDollars),
        ("testAddNegativeUSDtoUSD", testAddNegativeUSDtoUSD),
        ("testAddNegativeUSDtoGBP", testAddNegativeUSDtoGBP),
        ("testAddNegativeGBPtoUSD", testAddNegativeGBPtoUSD),
        ("testInvalidCurrency", testInvalidCurrency),
        ("testConvertNegativeUSDtoGBP", testConvertNegativeUSDtoGBP),
        ("testConvertInvalidCurrency", testConvertInvalidCurrency),
        ("testInvalidCurrencyThenConvert", testInvalidCurrencyThenConvert)
    ]
}

