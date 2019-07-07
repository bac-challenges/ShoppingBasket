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
//	ID: 38B53708-871C-4719-8C87-B129EFE87C9A
//
//	Pkg: ShoppingBasket
//
//	Swift: 5.0 
//
//	MacOS: 10.15
//

import UIKit

class DataSource: NSObject, UITableViewDataSource {

	private let model = ViewModel(FileManager.shared.loadJson()!)
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return Section.all.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		if let section = Section(rawValue: section) {
			switch section {
			case .product: return model.products.count
			default: return section.rows
			}
		}
		return 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let product = model.products[indexPath.row]
		let section = Section.all[indexPath.section]
		
		switch section {
		case .product: return configureProductCell(product: product,
												   section: section,
												   tableView: tableView,
												   indexPath: indexPath)
			
		default: let cell = configureGenericCell(section: section,
												 tableView: tableView,
												 indexPath: indexPath)
			return cell
		}
	}
}

// MARK: - Helpers
extension DataSource {
	
	func configureGenericCellLabels(cell: inout GenericCell, row: Row) {
		cell.textLabel?.text = row.title
	}
	
	func configureGenericCell(section: Section, tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
		if let row = section.caseForRow(row: indexPath.row),
		   var cell = tableView.dequeueReusableCell(withIdentifier: row.identifier, for: indexPath) as? GenericCell {
			configureGenericCellLabels(cell: &cell, row: row)
			cell.configure(row)
			return cell
		}
		return UITableViewCell(style: .value1, reuseIdentifier: nil)
	}
	
	func configureProductCell(product: Product, section: Section, tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier,
													for: indexPath) as? ProductCell {
			cell.textLabel?.text = product.name
			cell.detailTextLabel?.text = "$\(product.price)"
			return cell
		}
		
		return UITableViewCell(style: .value1, reuseIdentifier: nil)
	}
}
