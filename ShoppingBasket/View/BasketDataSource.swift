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

class BasketDataSource: NSObject, UITableViewDataSource {

	private let model = FileManager.shared.loadJson()!.products
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return Section.all.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return Section(rawValue: section)?.rows ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
//		let product = model[indexPath.row]
		
		let sectionCase = Section.all[indexPath.section]
		
		return configureGenericCell(section: sectionCase,
									tableView: tableView,
									indexPath: indexPath)
	}
}

// MARK: - Helpers
extension BasketDataSource {
	func configureGenericCell(section: Section, tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
		
		if let rowCase = section.caseForRow(row: indexPath.row) {
			let cell = tableView.dequeueReusableCell(withIdentifier: rowCase.identifier, for: indexPath)
			cell.textLabel?.text = rowCase.title
			cell.accessoryType = rowCase.accessoryType
			cell.selectionStyle = rowCase.selectionStyle
			return cell
		}
		
		return UITableViewCell(style: .value1, reuseIdentifier: nil)
	}
}
