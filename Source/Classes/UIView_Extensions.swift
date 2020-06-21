import UIKit

extension UIView {
    func bindFrameToSuperview(top:CGFloat = 0, leading: CGFloat = 0, trailing:CGFloat = 0, bottom:CGFloat = 0) {
        guard let superview = self.superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 9.0, *) {
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: top).isActive = true
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 9.0, *) {
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leading).isActive = true
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 9.0, *) {
            superview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: trailing).isActive = true
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 9.0, *) {
            superview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: bottom).isActive = true
        } else {
            // Fallback on earlier versions
        }
    }
    
    func bindFrameToSuperview(margin:CGFloat) {
        bindFrameToSuperview(top: margin, leading: margin, trailing: margin, bottom: margin)
    }
    
    func frameRelativeToWindow() -> CGRect {
        return convert(bounds, to: nil)
    }
    
}
