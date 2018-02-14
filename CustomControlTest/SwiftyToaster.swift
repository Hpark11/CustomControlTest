//
//  SwiftyToaster.swift
//  CustomControlTest
//
//  Created by croquiscom on 2018. 2. 13..
//  Copyright © 2018년 personal. All rights reserved.
//

import UIKit

typealias Toast = SwiftyToaster

class SwiftyToaster: UIView {

    private let labelOnly: UIView = {
        let view = UIView()
        return view
    }()
    
    private let imageAttached: UIView = {
        let view = UIView()
        return view
    }()
    
    private let imageOnly: UIView = {
        let view = UIView()
        return view
    }()
    
    private let custom: UIView = {
        let view = UIView()
        return view
    }()
    
    // superview
    // textColor
    // image?
    // backgroundColor
    // open
    // close
    // position
    
    open var offset: CGFloat = 30
    
    open var position: Position = .bottom
    
    enum Enter {
        case dashFromLeft
        case dashFromRight
        case dashFromTop
        case dashFromBottom
        case flipFromLeft
        case flipFromRight
        case flipFromTop
        case flipFromBottom
        case curlUp
        case curlDown
        case dissolve
    }
    
    enum Exit {
        case dashToLeft
        case dashToRight
        case dashToTop
        case dashToBottom
        case flipFromLeft
        case flipFromRight
        case flipFromTop
        case flipFromBottom
        case curlUp
        case curlDown
        case dissolve
    }
    
    enum Position {
        case left
        case right
        case top
        case bottom
        case center
    }
    
    static func makeText<T: UIViewController>(_ base: T, position: Position) {
        let view = UIView()
        view.layer.backgroundColor = UIColor.black.cgColor
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        base.view.addSubview(view)
        
        let label = SwiftyToasterLabel()
        label.textColor = .white
        label.text = "Just for TestJust for TestJust for TestJust for TestJust for TestJust for TestJust for TestJust for TestJust for TestJust for TestJust for TestJust for TestJust for Test"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        if position == .top {
            view.centerXAnchor.constraint(equalTo: base.view.centerXAnchor)
            view.topAnchor.constraint(equalTo: base.view.topAnchor, constant: 50)
        } else if position == .center {
            view.centerXAnchor.constraint(equalTo: base.view.centerXAnchor)
            view.centerYAnchor.constraint(equalTo: base.view.centerYAnchor)
        } else if position == .bottom {
            let lx = label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            let ly = label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            
            let x = view.centerXAnchor.constraint(equalTo: base.view.centerXAnchor)
            let y = view.bottomAnchor.constraint(equalTo: base.view.bottomAnchor, constant: -50)
            let lead = view.leadingAnchor.constraint(greaterThanOrEqualTo: base.view.leadingAnchor, constant: 16)
            let trail = view.trailingAnchor.constraint(lessThanOrEqualTo: base.view.trailingAnchor, constant: 16)

//            let h = view.heightAnchor.constraint(equalToConstant: 30)
//            let w = view.widthAnchor.constraint(equalToConstant: 100)
            
            let h = view.heightAnchor.constraint(equalTo: label.heightAnchor)
            let w = view.widthAnchor.constraint(equalTo: label.widthAnchor)
            
            NSLayoutConstraint.activate([x, y, lead, trail, h, w, lx, ly])
            base.view.layoutIfNeeded()
            
            
            UIView.transition(with: view, duration: 3, options: [.transitionCrossDissolve], animations: {
                view.alpha = 1
            }, completion: { _ in
                UIView.transition(with: view, duration: 4, options: [.transitionCrossDissolve], animations: {
                    view.alpha = 0
                }, completion: { _ in
                    view.removeFromSuperview()
                })
            })
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
