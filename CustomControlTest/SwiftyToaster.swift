
import UIKit

typealias Toast = SwiftyToaster

class SwiftyToaster: NSObject {
    enum Position {
        case top
        case bottom
        case center
    }
    
    enum Duration {
        case short
        case normal
        case long
        case custom(Double)
    }
    
    static func makeView<T: UIViewController>(_ base: T, view: UIView, position: Position = .bottom) {
        
    }
    
    static func makeImage<T: UIViewController>(_ base: T, image: UIImage, position: Position = .bottom) {
        
    }
    
    static func makeText<T: UIViewController>(
            _ base:         T,
            text:           String,
            duration:       TimeInterval = 3,
            position:       Position = .bottom,
            icon:           UIImage? = nil,
            iconWidth:      CGFloat = 40,
            offset:         CGFloat = 40,
            configuration:  SwiftyToasterConfiguration = SwiftyToasterConfiguration()
        ) {
        
        let view = viewForToast(configuration: configuration, content: SwiftyToasterLabel())
        base.view.addSubview(view)
        
        view.content.text = text
        placeToast(view, baseView: base.view, position: position, offset: offset)
        placeContent(view.content, container: view, icon: icon, iconWidth: iconWidth)
        
        toastIn(view, enter: .curlDown) { _ in
            toastOut(view, exit: .curlUp)
        }
        
        UIView.transition(with: view, duration: 0.01, options: [.curveEaseOut, .transitionCrossDissolve], animations: {
            view.isHidden = true
        }, completion: { _ in

            
            UIView.transition(with: view, duration: 0.8, options: [.curveEaseIn, .transitionCurlDown], animations: {
                view.isHidden = false
            }, completion: { _ in
                
                call(after: 3, completion: {
                    UIView.transition(with: view, duration: 0.8, options: [.curveEaseOut, .transitionCurlUp], animations: {
                        view.isHidden = true
                    }, completion: { _ in
                        view.removeFromSuperview()
                    })
                })
            })
        })
    }
    
    private static func call(after: Double, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + after, execute: completion)
    }
    
    private static func viewForToast<T: UIView>(
            configuration:  SwiftyToasterConfiguration,
            content:        T
        ) -> SwiftyToasterView<T> {
        
        let view = SwiftyToasterView<T>()
        view.configuration = configuration
        return view
    }
    
    private static func placeToast<T>(
            _ view:         SwiftyToasterView<T>,
            baseView:       UIView,
            position:       Position,
            offset:         CGFloat
        ) {
        
        var nc = [
            view.leadingAnchor.constraint(greaterThanOrEqualTo: baseView.leadingAnchor, constant: 16),
            view.trailingAnchor.constraint(lessThanOrEqualTo: baseView.trailingAnchor, constant: 16)
        ]
        
        switch position {
        case .top:
            nc.append(view.centerXAnchor.constraint(equalTo: baseView.centerXAnchor))
            nc.append(view.topAnchor.constraint(equalTo: baseView.topAnchor, constant: offset))
        case .center:
            nc.append(view.centerXAnchor.constraint(equalTo: baseView.centerXAnchor))
            nc.append(view.centerYAnchor.constraint(equalTo: baseView.centerYAnchor))
        case .bottom:
            nc.append(view.centerXAnchor.constraint(equalTo: baseView.centerXAnchor))
            nc.append(view.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: -offset))
        }
        
        NSLayoutConstraint.activate(nc)
    }
    
    private static func placeContent<T>(
            _ content:      T,
            container:      SwiftyToasterView<T>,
            icon:           UIImage? = nil,
            iconWidth:      CGFloat = 40
        ) {
        
        if let icon = icon {
            let iconView = UIImageView(image: icon)
            iconView.contentMode = .scaleToFill
            iconView.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(iconView)
            
            var nc = [
                iconView.widthAnchor.constraint(equalToConstant: iconWidth),
                iconView.heightAnchor.constraint(equalToConstant: iconWidth),
                
                iconView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 4),
                iconView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
                
                content.leftAnchor.constraint(equalTo: iconView.rightAnchor, constant: 4),
                content.trailingAnchor.constraint(equalTo: container.trailingAnchor),
                content.centerYAnchor.constraint(equalTo: container.centerYAnchor)
            ]

            if container.contentSize.height > iconWidth {
                nc.append(container.heightAnchor.constraint(equalTo: content.heightAnchor))
            } else {
                nc.append(container.heightAnchor.constraint(equalTo: iconView.heightAnchor, constant: 4))
            }
            
            NSLayoutConstraint.activate(nc)
        } else {
            NSLayoutConstraint.activate([
                container.heightAnchor.constraint(equalTo: content.heightAnchor),
                container.widthAnchor.constraint(equalTo: content.widthAnchor),
                content.centerXAnchor.constraint(equalTo: container.centerXAnchor),
                content.centerYAnchor.constraint(equalTo: container.centerYAnchor)
            ])
        }
    }
    
    private static func toastIn<T>(
            _ view:     SwiftyToasterView<T>,
            enter:      ToastEnter,
            completion: @escaping (Bool) -> ()
        ) {
        
        let origin: CGRect = view.frame
        guard let baseView = view.superview else {
            completion(false)
            return
        }
        
        UIView.transition(with: view, duration: 0.01, options: [.curveEaseOut, .transitionCrossDissolve], animations: {
            view.isHidden = true
            
            switch enter {
                case .dashFromLeft:    view.frame.origin.x = -(view.bounds.width)
                case .dashFromRight:   view.frame.origin.x = baseView.bounds.width
                case .dashFromTop:     view.frame.origin.y = -(view.bounds.height)
                case .dashFromBottom:  view.frame.origin.y = baseView.bounds.height
                case .scaleUp:         view.frame.size = CGSize(width: view.bounds.width / 2, height: view.bounds.height / 2)
                default: break
            }
        }, completion: { _ in
            let option: UIViewAnimationOptions
            
            switch enter {
                case .flipFromLeft: option = .transitionFlipFromLeft
                case .flipFromRight: option = .transitionFlipFromRight
                case .flipFromTop: option = .transitionFlipFromTop
                case .flipFromBottom: option = .transitionFlipFromBottom
                case .curlDown: option = .transitionCurlDown
                case .fadeIn: option = .transitionCrossDissolve
                default:
                    UIView.animate(withDuration: 0.72, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
                        view.isHidden = false
                        view.frame = origin
                    }, completion: completion)
                    return
            }
            UIView.transition(with: view, duration: 0.72, options: [.curveEaseIn, option], animations: {
                view.isHidden = false
            }, completion: completion)
        })
    }
    
    private static func toastOut<T>(_ view: SwiftyToasterView<T>, exit: ToastExit) {
        switch exit {
        case .dashToLeft: break
        case .dashToRight: break
        case .dashToTop: break
        case .dashToBottom: break
        case .flipFromLeft: break
        case .flipFromRight: break
        case .flipFromTop: break
        case .flipFromBottom: break
        case .curlUp: break
        case .fadeOut: break
        case .scaleDown: break
        }
        
        call(after: 3, completion: {
            UIView.transition(with: view, duration: 0.8, options: [.curveEaseOut, .transitionCurlUp], animations: {
                view.isHidden = true
            }, completion: { _ in
                view.removeFromSuperview()
            })
        })
    }
}
