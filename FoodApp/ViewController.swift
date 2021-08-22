//
//  ViewController.swift
//  FoodApp
//
//  Created by SaiKiran Panuganti on 21/08/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var menuView: MenuView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuView.items = ["Salads", "Starters", "Rotis", "Veg Curries", "Non-Veg Curries", "Biryanis", "Desserts", "Juices", "Ice Creams"]
    }


}

