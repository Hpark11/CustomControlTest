//
//  SwiftyToasterLabel.swift
//  CustomControlTest
//
//  Created by croquiscom on 2018. 2. 14..
//  Copyright © 2018년 personal. All rights reserved.
//

import UIKit

class SwiftyToasterLabel: UILabel {
    var topInset: CGFloat = 4
    var bottomInset: CGFloat = 4
    var leftInset: CGFloat = 4
    var rightInset: CGFloat = 4
    
    override func drawText(in rect: CGRect) {
        let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    
    override public var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += topInset + bottomInset
        contentSize.width += leftInset + rightInset
        return contentSize
    }
}
