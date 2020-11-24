//
//  PresentedViewController.swift
//  SJDatePicker
//
//  Created by Sabrina on 2017/4/12.
//  Copyright © 2017年 Sabrina. All rights reserved.
//

import UIKit

typealias returnDate = (String?) -> ()

class PresentedViewController: UIViewController {
    
    private var picker:SJDatePicker = SJDatePicker()
    private var confirmButton:UIButton = UIButton()
    private let cornerRadius:CGFloat = 7.5
    private let pickerHeight:CGFloat = 216
    private let pickerWidth:CGFloat = UIScreen.main.bounds.size.width - 10
    
    var block:returnDate?
    var style:PickerStyle = DefaultStyle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        injected()
    }
    
    func injected() {
        let btnConfirm = UIButton(type: .custom)
        btnConfirm.setTitle("OK", for: .normal)
        btnConfirm.backgroundColor = style.textColor
        btnConfirm.layer.cornerRadius = cornerRadius
        btnConfirm.layer.masksToBounds = true
        btnConfirm.addTarget(self, action: #selector(confirmButton_Click), for: .touchUpInside)
        btnConfirm.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(btnConfirm)
        NSLayoutConstraint.activate([btnConfirm.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                                     btnConfirm.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
                                     btnConfirm.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
                                     btnConfirm.heightAnchor.constraint(equalToConstant: CustomPresentationController.buttonHeight)])
        
        
        let viewPicker = UIView(frame: .zero)
        viewPicker.backgroundColor = .white
        viewPicker.layer.cornerRadius = cornerRadius
        viewPicker.layer.masksToBounds = true
        viewPicker.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(viewPicker)
        NSLayoutConstraint.activate([viewPicker.bottomAnchor.constraint(equalTo: btnConfirm.topAnchor, constant: -10),
                                     viewPicker.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
                                     viewPicker.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
                                     viewPicker.heightAnchor.constraint(equalToConstant: pickerHeight)])
        
        picker.frame = .zero
        picker.style = style
        picker.translatesAutoresizingMaskIntoConstraints = false
        viewPicker.addSubview(picker)
        NSLayoutConstraint.activate([picker.topAnchor.constraint(equalTo: viewPicker.topAnchor),
                                     picker.leadingAnchor.constraint(equalTo: viewPicker.leadingAnchor),
                                     picker.trailingAnchor.constraint(equalTo: viewPicker.trailingAnchor),
                                     picker.bottomAnchor.constraint(equalTo: viewPicker.bottomAnchor)])
        
        if let title = style.titleString {
            let titleLabel:UILabel = UILabel(frame: .zero)
            titleLabel.backgroundColor = .white
            titleLabel.layer.cornerRadius = cornerRadius
            titleLabel.layer.masksToBounds = true
            titleLabel.textColor = style.textColor
            titleLabel.textAlignment = .center
            titleLabel.font = style.titleFont
            titleLabel.text = title
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(titleLabel)
            NSLayoutConstraint.activate([titleLabel.bottomAnchor.constraint(equalTo: viewPicker.topAnchor, constant: -10),
                                         titleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
                                         titleLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
                                         titleLabel.heightAnchor.constraint(equalToConstant: 40)])
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initialize() {
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
    }
    
    @objc func confirmButton_Click(){
        self.dismiss(animated: true, completion: nil)
        let df:DateFormatter = DateFormatter.init()
        df.dateFormat = style.returnDateFormat?.rawValue
        df.timeZone = TimeZone(secondsFromGMT: TimeZone.current.secondsFromGMT())
        let returnDate:String = df.string(from: picker.date)
        block?(returnDate)
    }
}

extension PresentedViewController:UIViewControllerTransitioningDelegate{
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        if presented == self {
            return  CustomPresentationController(presentedViewController: presented, presenting: presenting)
        }else{
            return nil
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if presented == self {
            return CustomPresentationAnimationController(isPresenting: true)
        } else {
            return nil
        }
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if dismissed == self {
            return CustomPresentationAnimationController(isPresenting: false)
        } else {
            return nil
        }
    }
}
