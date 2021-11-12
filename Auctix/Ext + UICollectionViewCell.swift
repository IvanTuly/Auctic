//
//  Ext + UICollectionViewCell.swift
//  Auctix
//
//  Created by Владимир Камнев on 13.11.2021.
//

import UIKit

extension UICollectionViewCell {
    
    static var nib  : UINib{
        return UINib(nibName: identifire, bundle: nil)
    }
    
    static var identifire : String{
        return String(describing: self)
    }
}
