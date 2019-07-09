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
//	ID: E0086E3A-A346-4EE8-91E1-2C26C3A048F0
//
//	Pkg: ShoppingBasket
//
//	Swift: 5.0 
//
//	MacOS: 10.15
//

import UIKit

class StatesController: UITableViewController {
	
	private lazy var model = BasketViewModel.shared
	private lazy var state: State = model.state

    override func viewDidLoad() {
        super.viewDidLoad()
		setupView()
    }
}

// MARK: - Actions
extension StatesController {
	@objc func selectState() {
		model.state = state
		navigationController?.popViewController(animated: true)
	}
	
	@objc func cancel() {
		navigationController?.popViewController(animated: true)
	}
}

// MARK: - UI
extension  StatesController {
	private func setupView() {
		title = "States"
		tableView = UITableView(frame: CGRect.zero, style: .grouped)
		tableView.register(GenericCell.self, forCellReuseIdentifier: GenericCell.identifier)
		
		let leftButtonItem = UIBarButtonItem.init(
			title: "Cancel",
			style: .done,
			target: self,
			action:  #selector(cancel)
		)
		self.navigationItem.leftBarButtonItem = leftButtonItem
		
		let rightButtonItem = UIBarButtonItem.init(
			title: "Select",
			style: .done,
			target: self,
			action: #selector(selectState)
		)
		self.navigationItem.rightBarButtonItem = rightButtonItem
	}
}

// MARK: UITableViewDelegate
extension StatesController {
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		state = model.states[indexPath.row]
		tableView.reloadData()
	}
}

// MARK: UITableViewDataSource
extension StatesController {
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return model.states.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let state = model.states[indexPath.row]
		
		let cell = tableView.dequeueReusableCell(withIdentifier: GenericCell.identifier, for: indexPath)
		cell.accessoryType = state.code == self.state.code ? .checkmark : .none
		cell.accessoryView?.tintColor = #colorLiteral(red: 0.4648197889, green: 0.6529648304, blue: 0.5710337758, alpha: 1)
		cell.selectionStyle = .none
		cell.textLabel?.text = state.name
		cell.detailTextLabel?.text = "\(state.rate)%"
		return cell
	}
}
