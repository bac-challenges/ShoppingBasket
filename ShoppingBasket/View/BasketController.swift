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
//	ID: 33781857-C3CC-4BC1-8DE6-C7E896E6A4C3
//
//	Pkg: ShoppingBasket
//
//	Swift: 5.0 
//
//	MacOS: 10.15
//

import UIKit

class BasketController: UIViewController {
	
	// Model
	private var model = BasketViewModel.shared
	
	// UI
	private var tableView = UITableView()
	
	// Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}
}

// MARK: - UI
extension  BasketController {
	private func setupView() {
		title = "Basket"
		tableView = UITableView(frame: CGRect.zero, style: .grouped)
		tableView.register(GenericCell.self, forCellReuseIdentifier: GenericCell.identifier)
		tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.identifier)
		tableView.separatorStyle = .none
		tableView.contentInsetAdjustmentBehavior = .automatic
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 70
		tableView.dataSource = self
		view.addSubview(tableView)
		setupLayout()
	}
	
	private func setupLayout() {
		tableView.anchor(top: view.topAnchor,
						 bottom: view.bottomAnchor,
						 left: view.leftAnchor,
						 right: view.rightAnchor)
	}
}

// MARK: - UITableViewDataSource
extension BasketController: UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return BasketViewModel.Section.all.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let section = BasketViewModel.Section(rawValue: section) else {
			return 0
		}
		return section.rows
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let section = BasketViewModel.Section.all[indexPath.section]
		switch section {
		case .product:
			if let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell {
				let product = model.products[indexPath.row]
				cell.textLabel?.text = product.name
				cell.detailTextLabel?.text = model.unitTotalAmount(product)
				return cell
			}
			
		default:
			if let row = section.caseForRow(row: indexPath.row) {
				let cell = tableView.dequeueReusableCell(withIdentifier: row.identifier, for: indexPath)
				cell.accessoryType = row.accessoryType
				cell.selectionStyle = row.selectionStyle
				cell.textLabel?.text = row.title
				cell.detailTextLabel?.text = row.detail
				return cell
			}
		}
		
		return UITableViewCell(style: .value1, reuseIdentifier: nil)
	}
}
