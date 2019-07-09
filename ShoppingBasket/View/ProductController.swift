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
//	ID: 6A4DAD02-1A70-48CD-A346-065A88D41ECA
//
//	Pkg: ShoppingBasket
//
//	Swift: 5.0 
//
//	MacOS: 10.15
//

import UIKit

class ProductController: UITableViewController {

	private lazy var model = BasketViewModel.shared
	private var products = [Product]()
	
    override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}
}

// MARK: - Actions
extension ProductController {
	@objc func selectProduct() {
		
		// Filter duplicates
		model.basket.forEach { product in
			products = products.filter {
				$0.name != product.name
			}
		}
		
		// Add new products to basket
		model.basket.append(contentsOf: products)
		
		navigationController?.dismiss(animated: true, completion: nil)
	}
	
	@objc func cancel() {
		navigationController?.dismiss(animated: true, completion: nil)
	}
}

// MARK: - UI
extension  ProductController {
	private func setupView() {
		title = "Products"
		tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.identifier)
		tableView.allowsMultipleSelection = true
		
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
																style: .done,
																target: self,
																action:  #selector(cancel))
		
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add",
																 style: .done,
																 target: self,
																 action: #selector(selectProduct))
	}
}

// MARK: UITableViewDelegate
extension ProductController {
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let cell = tableView.cellForRow(at: indexPath)
		cell?.isSelected = true
		products.append(model.products[indexPath.row])
	}
	
	override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
		let cell = tableView.cellForRow(at: indexPath)
		cell?.isSelected = false
		products = products.filter {
			$0.name != model.products[indexPath.row].name
		}
	}
}

// MARK: UITableViewDataSource
extension ProductController {
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return model.products.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell {
			cell.configure(model.products[indexPath.row])
			return cell
		}
		fatalError("Invalid Section")
	}
}
