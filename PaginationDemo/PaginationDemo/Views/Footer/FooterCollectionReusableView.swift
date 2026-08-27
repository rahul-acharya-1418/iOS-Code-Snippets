//
//  FooterCollectionReusableView.swift
//  PaginationDemo
//
//  Created by Rahul Acharya on 27/08/26.
//

import UIKit

class FooterCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var vwBG: UIView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        spinner.hidesWhenStopped = true
    }
    
    public func startAnimating() {
        spinner.startAnimating()
    }
}
