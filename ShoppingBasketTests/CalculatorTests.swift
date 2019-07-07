//	MIT License
//
//	Copyright © 2019 Emile, Blue Ant Corp
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in all
//	copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//	SOFTWARE.
//
//	ID: 0D20B3E6-9BF9-4EBA-9A64-41B6A9647979
//
//	Pkg: ShoppingBasketTests
//
//	Swift: 5.0 
//
//	MacOS: 10.15
//

import XCTest
@testable import ShoppingBasket

class CalculatorTests: XCTestCase {
	
	// Verify data
	private let unitTotalAmount: Float = 1000
	private let unitsTotalAmount: Float = 10000
	
	func testUnitTotal() {
		let result = calc.unitTotalAmount(product)
		XCTAssertEqual(result, unitTotalAmount)
	}
	
	func testUnitsTotal() {
		let result = calc.unitsTotalAmount(products)
		XCTAssertEqual(result, unitsTotalAmount)
	}
	
	func testDiscountRate() {
		XCTAssertEqual(calc.discountRate(999), 0)
		XCTAssertEqual(calc.discountRate(1001), 3)
		XCTAssertEqual(calc.discountRate(5001), 5)
		XCTAssertEqual(calc.discountRate(7001), 7)
		XCTAssertEqual(calc.discountRate(10001), 10)
		XCTAssertEqual(calc.discountRate(50001), 15)
	}
	
	func testDiscountAmount() {
		let result = calc.discountAmount(unitsTotalAmount)
		XCTAssertEqual(result, 700)
	}
	
	func testTaxAmount() {
		let result = calc.taxAmount(unitsTotalAmount, rate: 10)
		XCTAssertEqual(result, 1000)
	}
	
	func testTotal() {
		XCTAssertEqual(calc.totalAmount(1000,  rate: 10), 1100)
		XCTAssertEqual(calc.totalAmount(1001,  rate: 10), 1068.067)
		XCTAssertEqual(calc.totalAmount(5001,  rate: 10), 5226.0454)
		XCTAssertEqual(calc.totalAmount(7001,  rate: 10), 7162.0234)
		XCTAssertEqual(calc.totalAmount(10001, rate: 10), 9900.99)
		XCTAssertEqual(calc.totalAmount(50001, rate: 10), 46750.938)
	}
}
