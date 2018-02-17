

import UIKit

class SwiftyToasterView<T: UIView>: UIView {

    let content = T()
    
    var configuration: SwiftyToasterConfiguration = SwiftyToasterConfiguration() {
        didSet {
            layer.backgroundColor = UIColor.black.cgColor
            layer.cornerRadius = 6
            
            clipsToBounds = true
            isHidden = true
            layer.shadowColor = UIColor.clear.cgColor
            translatesAutoresizingMaskIntoConstraints = false
        
            content.translatesAutoresizingMaskIntoConstraints = false
            
            if let label = content as? SwiftyToasterLabel {
                label.textColor = .white
                label.numberOfLines = 0
                label.font = configuration.font
            } else if let imageView = content as? UIImageView {
                
            }
            
            self.addSubview(content)
        }
    }
    
    var contentSize: CGSize {
        guard let baseView = superview else { return CGSize.zero }
        
        if let label = content as? SwiftyToasterLabel {
            let size = CGSize(width: baseView.bounds.width - 32, height: baseView.bounds.height)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            
            return NSString(string: label.text!).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: configuration.font], context: nil).size
        } else if let imageView = content as? UIImageView {
            return CGSize.zero
        } else {
            return CGSize.zero
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
