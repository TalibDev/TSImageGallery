//
//  Protocol.swift
//  SeeNow
//
//  Created by Nouman Gul Junejo on 7/31/18.
//  Copyright © 2018 APP. All rights reserved.
//

//import IHProgressHUD
import UIKit


public protocol ReusableView: class {}

public extension ReusableView where Self: UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

public protocol CellDelegate: class {
    func openImageOnFullScreen(index: Int)
}

public protocol NibLoadableView: class { }

public extension NibLoadableView where Self: UIView {
    
    static var NibName: String {
        return String(describing: self)
    }
}

public protocol ShowsAlert {}
public extension ShowsAlert where Self: UIViewController {
    func showDefaultAlertMessage(title: String , message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
//    func showCustomAlertMessage(title: String , message: String) {
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alertController.addAction(UIAlertAction(title: "\(ValidationErrors.getTitleFor(title: .Okay))", style: .default, handler: nil))
//        present(alertController, animated: true, completion: nil)
//    }
//    func showAlertAndDisappear(title:String, message:String,completionHandler:@escaping (Bool) -> ()) {
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        present(alertController, animated: true, completion: nil)
//        alertController.view.backgroundColor = .gray
//        // change to desired number of seconds (in this case 3 seconds)
//        let when = DispatchTime.now() + 1
//        DispatchQueue.main.asyncAfter(deadline: when){
//            // your code with delay
//            alertController.dismiss(animated: true, completion: nil)
//            completionHandler(true)
//        }
//    }
    
}

public protocol ShowsLoader {}
public extension ShowsLoader where Self: UIViewController {
    
    func showLoader() {
        //IHProgressHUD.show()
    }
    
    func hideLoader(){
        //IHProgressHUD.dismiss()
    }
}

//extension Bundle {
//    static func loadView<T>(fromNib name: String, withType type: T.Type) -> T {
//        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
//            return view
//        }
//        
//        fatalError("Could not load view with type " + String(describing: type))
//    }
//}




