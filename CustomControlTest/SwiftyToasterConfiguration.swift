
import UIKit

struct SwiftyToasterConfiguration {
    
    var height: CGFloat = 40
    
    var backgroundColor: CGColor = UIColor.black.cgColor
    
    var textColor: UIColor = .white
    
    var cornerRadius: CGFloat = 6
    
    var font: UIFont = UIFont.systemFont(ofSize: 12)
    
    var enter: ToastEnter = .fadeIn
    var exit: ToastExit = .fadeOut
    
    
    
    init() {
    }
    
    init(enter: ToastEnter, exit: ToastExit) {
        self.enter = enter
        self.exit = exit
    }
}
