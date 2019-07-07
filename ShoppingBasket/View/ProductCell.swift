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

	private lazy var titleLabel = UILabel()
	
	private lazy var container = UIStackView()
	
	private lazy var textField = UITextField()
	private lazy var stepper = UIStepper()
	
	private lazy var totalPriceValueLabel = UILabel()
	private lazy var unitPriceLabel = UILabel()
	private lazy var unitPriceValueLabel = UILabel()
	private lazy var totalPriceLabel = UILabel()
	
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
	}
}

// MARK: - UI
extension ProductCell {
	private func setupView() {
		accessoryType = .none
		selectionStyle = .none
		preservesSuperviewLayoutMargins = true
		addSubview(titleLabel)
		setupLayout()
	}
	
	private func setupLayout() {
		titleLabel.anchor(top: layoutMarginsGuide.topAnchor,
						  left: layoutMarginsGuide.leftAnchor)
		
		//		view.anchor(top: layoutMarginsGuide.topAnchor,
		//					bottom: layoutMarginsGuide.bottomAnchor,
		//					left: layoutMarginsGuide.leftAnchor,
		//					right: layoutMarginsGuide.rightAnchor,
		//					height: 200)
		
	}
}
