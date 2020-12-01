//
//  ViewController.swift
//  SJDatePicker
//
//  Created by Sabrina on 2017/4/12.
//  Copyright © 2017年 Sabrina. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var txtShowDate: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.systemBackground
        self.txtShowDate.textColor = UIColor(named: "textColor")
        self.txtShowDate.backgroundColor = UIColor(named: "backColor")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func txtDateEditingBegin(_ sender: UITextField) {
        sender.resignFirstResponder()
        showPicker()
    }
    
    private func showPicker() {
        var style = DefaultStyle()
        style.pickerColor = StyleColor.colors([style.textColor, .red, .blue])
        style.pickerMode = .date
        style.titleString = "This is Date Picker"
        style.returnDateFormat = .d_m_yyyy
        style.titleFont = UIFont.systemFont(ofSize: 25, weight: .bold)
        
        let pick:PresentedViewController = PresentedViewController()
        pick.style = style
        pick.block = { [weak self] (date) in
            self?.txtShowDate.text = date
        }
        self.present(pick, animated: true, completion: nil)
    }
}

