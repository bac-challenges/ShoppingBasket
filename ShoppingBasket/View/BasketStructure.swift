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
//	ID: 915D6CA8-56C2-4ACA-B53B-4748F3082374
//
//	Pkg: ShoppingBasket
//
//	Swift: 5.0 
//
//	MacOS: 10.15
//

import UIKit

protocol Row {
	var identifier: String { get }
	var accessoryType: UITableViewCell.AccessoryType { get }
	var selectionStyle: UITableViewCell.SelectionStyle { get }
	var title: String { get }
}

// MARK: - Sections
enum Section: Int {
	case product, address, breakdown, total
	
	static var all: [Section] {
		return [.product, .address, .breakdown, .total]
	}
	
	var rows: Int {
		switch self {
		case .product: return 5
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

// MARK: - Section Address Row
enum SectionAddress: Int, Row {
	
	case total
	
	var identifier: String {
		return "GenericCell"
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
}

// MARK: - Section Breakdown Row
enum SectionBreakdown: Int, Row {
	
	case total, discount, tax
	
	static var all: [SectionBreakdown] {
		return [.total, .discount, .tax]
	}
	
	var identifier: String {
		return "GenericCell"
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
		case .tax: return "Tax 6.75%"
		}
	}
}

// MARK: - Section Total Row
enum SectionTotal: Int, Row {
	
	case total
	
	var identifier: String {
		return "GenericCell"
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
}
