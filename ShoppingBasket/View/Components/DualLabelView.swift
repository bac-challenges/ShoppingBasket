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
//	ID: 5FB65BB8-7C2E-4560-B81E-FAEE2C810E0F
//
//	Pkg: ShoppingBasket
//
//	Swift: 5.0 
//
//	MacOS: 10.15
//

import UIKit

class DualLabelView: UIStackView {

	public lazy var textLabel = UILabel()
	public lazy var detailLabel: UILabel = {
		let label = UILabel()
		label.textColor = .lightGray
		label.textAlignment = .right
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - UI
extension DualLabelView {
	private func setupView() {
		preservesSuperviewLayoutMargins = true
		axis = .horizontal
		spacing = 5
		addArrangedSubview(textLabel)
		addArrangedSubview(detailLabel)
	}
}
