//
//  DetailViewController.swift
//  TodolistApp
//
//  Created by ADMIN on 6/24/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Detail"
        let rightButton = UIBarButtonItem(image: UIImage(systemName: "chevron.up"), style: .done, target: self, action: #selector(saveData))
        navigationItem.rightBarButtonItem = rightButton
        rightButton.tintColor = .red
      
    }
    @objc func saveData() {

    }

  

}
