//
//  ViewController.swift
//  SJDatePicker
//
//  Created by Sabrina on 2017/4/12.
//  Copyright © 2017年 Sabrina. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func dateButton_Click(_ sender: Any) {
        let pick:PresentedViewController = PresentedViewController()
        pick.titleString = "This is Date picker"
        pick.buttonColor = UIColor.init(red: 10/255.0, green: 186/255.0, blue: 181/255.0, alpha: 1.0)
        pick.block = { (date) in
            print(date ?? "No Date")
        }
        self.present(pick, animated: true, completion: nil)
    }
}

