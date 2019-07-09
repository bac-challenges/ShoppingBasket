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
//	ID: BD56F036-DF64-4F52-8095-5078035C8C4C
//
//	Pkg: ShoppingBasket
//
//	Swift: 5.0 
//
//	MacOS: 10.15
//

import UIKit

class ProductCell: UITableViewCell, ReusableCell {

	// UI
	private lazy var container: UIStackView = {
		let view = UIStackView(arrangedSubviews: [titleLabel, containerLeft])
		view.alignment = .firstBaseline
		return view
	}()
	
	private lazy var titleLabel = UILabel()
	
	private lazy var containerLeft: UIStackView = {
		let view = UIStackView(arrangedSubviews: [unitCount, unitPrice, totalPrice])
		view.axis = .vertical
		view.spacing = 10
		return view
	}()
	
	private lazy var unitCount = DualLabelView()
	private lazy var unitPrice = DualLabelView()
	private lazy var totalPrice = DualLabelView()
	
	// Init
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .value1, reuseIdentifier: nil)
		setupView()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
}

// MARK: - Configurable
extension ProductCell: Configurable {
	func configure(_ item: Product) {
		titleLabel.text = item.name
		unitCount.textLabel.text = "Quantity:"
		unitCount.detailLabel.text = "x\(item.units)"
		unitPrice.textLabel.text = "Price:"
		unitPrice.detailLabel.text = "\(item.price.formattedWithSeparator)"
		totalPrice.textLabel.text = "Total:"
		totalPrice.detailLabel.text = "\((Float(item.units)*item.price).formattedWithSeparator)"
	}
}

// MARK: - UI
extension ProductCell {
	private func setupView() {
		selectionStyle = .none
		preservesSuperviewLayoutMargins = true
		addSubview(container)
		setupLayout()
	}
	
	private func setupLayout() {
		container.anchor(top: layoutMarginsGuide.topAnchor,
						 bottom: layoutMarginsGuide.bottomAnchor,
						 left: layoutMarginsGuide.leftAnchor,
						 right: layoutMarginsGuide.rightAnchor)
	}
}

// MARK: - Actions
extension ProductCell {
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		UIView.animate(withDuration: 0.3) {
			self.backgroundColor = selected ? #colorLiteral(red: 0, green: 0.6566036344, blue: 1, alpha: 1):#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
			self.unitCount.detailLabel.textColor = selected ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0):.lightGray
			self.unitPrice.detailLabel.textColor = selected ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0):.lightGray
			self.totalPrice.detailLabel.textColor = selected ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0):.lightGray
		}
	}
	
	override func setEditing(_ editing: Bool, animated: Bool) {
		super.setEditing(editing, animated: animated)
		container.anchor(paddingLeft: editing ? 260:0)
	}
}
