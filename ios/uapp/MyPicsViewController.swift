//
//  MyPicsViewController.swift
//  UIPageViewController
//
//  Created by zhaofei on 2015-08-25.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit


class MyPicsViewController: UICollectionViewController {
    
    private let reuseIdentifier = "FlickrCell"
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    var myPhotos = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myPhotos = ["angry_birds_cake.jpg", "creme_brelee.jpg"]
    }
    
    
    
    
    

}
