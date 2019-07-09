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
	private lazy var titleLabel = UILabel()
	
	private lazy var container: UIStackView = {
		let view = UIStackView(arrangedSubviews: [unitCountContainer, bottomSubContainer])
		view.axis = .vertical
		view.spacing = 10
		return view
	}()
	
	private lazy var unitCountContainer: UIStackView = {
		let view = UIStackView(arrangedSubviews: [unitCountLablel, unitCountValueLablel])
		view.axis = .horizontal
		view.spacing = 5
		return view
	}()
	
	private lazy var unitCountLablel = UILabel()
	private lazy var unitCountValueLablel: UILabel = {
		let label = UILabel()
		label.textColor = .lightGray
		label.textAlignment = .right
		return label
	}()
	
	private lazy var bottomSubContainer: UIStackView = {
		let view = UIStackView(arrangedSubviews: [unitContainer, totalContainer])
		view.axis = .vertical
		view.spacing = 5
		return view
	}()
	
	private lazy var unitContainer: UIStackView = {
		let view = UIStackView(arrangedSubviews: [unitPriceLabel, unitPriceValueLabel])
		view.axis = .horizontal
		view.spacing = 5
		return view
	}()
	
	private lazy var unitPriceLabel = UILabel()
	private lazy var unitPriceValueLabel: UILabel = {
		let label = UILabel()
		label.textColor = .lightGray
		label.textAlignment = .right
		return label
	}()
	
	private lazy var totalContainer: UIStackView = {
		let view = UIStackView(arrangedSubviews: [totalPriceLabel, totalPriceValueLabel])
		view.axis = .horizontal
		view.spacing = 5
		return view
	}()
	
	private lazy var totalPriceLabel = UILabel()
	private lazy var totalPriceValueLabel: UILabel = {
		let label = UILabel()
		label.textColor = .lightGray
		label.textAlignment = .right
		return label
	}()
	
	private lazy var separator: UIView = {
		let view = UIView()
		view.backgroundColor = .lightGray
		view.alpha = 0.3
		return view
	}()
	
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
		unitCountLablel.text = "Unit:"
		unitCountValueLablel.text = "x\(item.units)"
		unitPriceLabel.text = "Unit Price:"
		unitPriceValueLabel.text = "\(item.price.formattedWithSeparator)"
		totalPriceLabel.text = "Unit Total:"
		totalPriceValueLabel.text = "\((Float(item.units)*item.price).formattedWithSeparator)"
	}
}

// MARK: - UI
extension ProductCell {
	private func setupView() {
		accessoryType = .none
		selectionStyle = .none
		preservesSuperviewLayoutMargins = true
		addSubview(titleLabel)
		addSubview(container)
		addSubview(separator)
		setupLayout()
	}
	
	private func setupLayout() {
		titleLabel.anchor(top: layoutMarginsGuide.topAnchor,
						  paddingTop: 6,
						  left: layoutMarginsGuide.leftAnchor,
						  width: 100)
		
		container.anchor(top: layoutMarginsGuide.topAnchor,
						 bottom: layoutMarginsGuide.bottomAnchor,
						 left: titleLabel.rightAnchor,
						 paddingLeft: 60,
						 right: layoutMarginsGuide.rightAnchor)
		
		unitCountLablel.anchor(width: 80)
		
		separator.anchor(bottom: bottomAnchor,
						 left: layoutMarginsGuide.leftAnchor,
						 right: layoutMarginsGuide.rightAnchor,
						 height: 1)
	}
}
