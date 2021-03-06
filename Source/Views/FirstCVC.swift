//
//  FirstCVC.swift
//  TSImageGallery
//
//  Created by Talib Shabbir Hussain on 18/06/2020.
//  Copyright © 2020 Talib Shabbir Hussain. All rights reserved.
//

import UIKit

class FirstCVC: UICollectionViewCell, NibLoadableView, ReusableView {

    var delegate: CellDelegate?
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappped(sender:)))
        tap.numberOfTapsRequired = 1
        img1.addGestureRecognizer(tap)
        img1.isUserInteractionEnabled = true
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(tappped(sender:)))
        tap2.numberOfTapsRequired = 1
        img2.addGestureRecognizer(tap2)
        img2.isUserInteractionEnabled = true
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(tappped(sender:)))
        tap3.numberOfTapsRequired = 1
        img3.addGestureRecognizer(tap3)
        img3.isUserInteractionEnabled = true
    }
    
    @objc func tappped(sender: UITapGestureRecognizer){
        delegate?.openImageOnFullScreen(index: sender.view?.tag ?? 0)
    }

}
