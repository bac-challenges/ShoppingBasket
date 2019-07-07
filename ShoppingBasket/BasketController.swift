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
	
	// Delegates
	private lazy var dataSource = BasketDataSource()
	
	// UI
	private lazy var tableView: UITableView = {
		let view = UITableView(frame: CGRect.zero, style: .grouped)
		view.register(UITableViewCell.self, forCellReuseIdentifier: "GenericCell")
		view.separatorStyle = .none
		view.contentInsetAdjustmentBehavior = .automatic
		view.rowHeight = UITableView.automaticDimension
		view.estimatedRowHeight = 70
		view.dataSource = dataSource
		view.debugMode()
		return view
	}()

	// Init
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}
}

// MARK: - UI
extension  BasketController {
	
	private func setupView() {
		title = "Basket"
		view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
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
