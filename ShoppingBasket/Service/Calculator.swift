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
//	ID: 9CF748AC-7A74-4CFF-80CD-B101BCFE7E42
//
//	Pkg: ShoppingBasket
//
//	Swift: 5.0 
//
//	MacOS: 10.15
//

import Foundation

public struct Calculator {
	
	func unitTotalAmount(_ unit: Product) -> Float {
		return unit.price * Float(unit.units)
	}
	
	func unitsTotalAmount(_ units: [Product]) -> Float {
		return units.compactMap { unitTotalAmount($0) }
					.reduce(0) { $0 + $1 }
	}
	
	func discountRate(_ amount: Float) -> Float {
		switch amount {
		case 0...1000:		return 0
		case 1001...5000:	return 3
		case 5001...7000:	return 5
		case 7001...10000:	return 7
		case 10001...50000: return 10
		default: return 15
		}
	}
	
	func discountAmount(_ amount: Float) -> Float {
		return amount * discountRate(amount)%
	}
	
	func taxAmount(_ amount: Float, rate: Float) -> Float {
		return amount * rate%
	}
	
	func totalAmount(_ amount: Float, rate: Float) -> Float {
		let discount = discountAmount(amount)
		let discontedAmount =  amount - discount
		let tax = taxAmount(discontedAmount, rate: rate)
		let taxedAmount = discontedAmount + tax
		return taxedAmount
	}
}

// Percantage Helper
postfix operator %
postfix func % (percentage: Float) -> Float {
	return (percentage / 100)
}
