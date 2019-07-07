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
//	ID: 5C5EE745-6C5C-4A27-B648-450A78DB54CB
//
//	Pkg: ShoppingBasket
//
//	Swift: 5.0 
//
//	MacOS: 10.15
//

import UIKit

struct BasketViewModel {
	
	// Singleton
	public static let shared = BasketViewModel()
	
	// Public Models
	public var products: [Product]
	public var state: State?

	init() {
		guard let model = FileManager.shared.loadJson() else {
			fatalError()
		}

		self.state = model.states.first
		self.products = model.products
	}
}

// MARK: - UI Data
extension BasketViewModel {
	func unitTotalAmount(_ unit: Product) -> String {
		let result = Calculator.shared.unitTotalAmount(unit)
		return result.formattedWithSeparator
	}
	
	var address: String {
		guard let state = BasketViewModel.shared.state else {
			return "N/A"
		}
		return "\(state.name), \(state.code)"
	}
	
	var unitsTotalAmount: String {
		let result = Calculator.shared.unitsTotalAmount(products)
		return result.formattedWithSeparator
	}
	
	var discountAmount: String {
		#warning("Use real data")
		let result = Calculator.shared.totalAmount(10000, rate: 10)
		return "- \(result.formattedWithSeparator)"
	}
	
	var taxAmount: String {
		#warning("Use real data")
		let result = Calculator.shared.taxAmount(10000, rate: 10)
		return "+ \(result.formattedWithSeparator)"
	}
	
	var totalAmount: String {
		#warning("Use real data")
		let result = Calculator.shared.totalAmount(10000, rate: 10)
		return result.formattedWithSeparator
	}
}

// MARK: - TableView Configuration
protocol Row {
	var identifier: String { get }
	var accessoryType: UITableViewCell.AccessoryType { get }
	var selectionStyle: UITableViewCell.SelectionStyle { get }
	var title: String { get }
	var detail: String { get }
	var detailColor: UIColor { get }
}

extension BasketViewModel {
	
	// Section
	enum Section: Int {
		case product, address, breakdown, total
		
		static var all: [Section] {
			return [.product, .address, .breakdown, .total]
		}
		
		var rows: Int {
			switch self {
			case .product: return BasketViewModel.shared.products.count
			case .address: return 1
			case .breakdown: return SectionBreakdown.all.count
			case .total: return 1
			}
		}
		
		func caseForRow(row: Int) -> Row? {
			switch self {
			case .product: return nil
			case .address: return SectionAddress(rawValue: row)
			case .breakdown: return SectionBreakdown(rawValue: row)
			case .total: return SectionTotal(rawValue: row)
			}
		}
	}
	
	// Section Address Row
	enum SectionAddress: Int, Row {
		
		case total
		
		var identifier: String {
			return GenericCell.identifier
		}
		
		var selectionStyle: UITableViewCell.SelectionStyle {
			return .default
		}
		
		var accessoryType: UITableViewCell.AccessoryType {
			return .disclosureIndicator
		}
		
		var title: String {
			return "Address"
		}
		
		var detail: String {
			return BasketViewModel.shared.address
		}
		
		var detailColor: UIColor {
			return .lightGray
		}
	}
	
	// Section Breakdown Row
	enum SectionBreakdown: Int, Row {
		
		case total, discount, tax
		
		static var all: [SectionBreakdown] {
			return [.total, .discount, .tax]
		}
		
		var identifier: String {
			return GenericCell.identifier
		}
		
		var selectionStyle: UITableViewCell.SelectionStyle {
			return .none
		}
		
		var accessoryType: UITableViewCell.AccessoryType {
			return .none
		}
		
		var title: String {
			switch self {
			case .total: return "Total without taxes"
			case .discount: return "Discout 5%"
			case .tax: return "Tax \(BasketViewModel.shared.state?.rate ?? 0)%"
			}
		}

		var detail: String {
			switch self {
			case .total: return BasketViewModel.shared.unitsTotalAmount
			case .discount: return BasketViewModel.shared.discountAmount
			case .tax: return BasketViewModel.shared.taxAmount
			}
		}
		
		var detailColor: UIColor {
			switch self {
			case .total: return .lightGray
			case .discount: return #colorLiteral(red: 0.4648197889, green: 0.6529648304, blue: 0.5710337758, alpha: 1)
			case .tax: return #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
			}
		}
	}
	
	// Section Total Row
	enum SectionTotal: Int, Row {
		
		case total
		
		var identifier: String {
			return GenericCell.identifier
		}
		
		var selectionStyle: UITableViewCell.SelectionStyle {
			return .none
		}
		
		var accessoryType: UITableViewCell.AccessoryType {
			return .none
		}
		
		var title: String {
			return "Total"
		}
		
		var detail: String {
			return BasketViewModel.shared.totalAmount
		}
		
		var detailColor: UIColor {
			return .lightGray
		}
	}
}
