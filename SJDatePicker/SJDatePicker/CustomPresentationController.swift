//
//  CustomPresentationController.swift
//  SJDatePicker
//
//  Created by Sabrina on 2017/4/12.
//  Copyright © 2017年 Sabrina. All rights reserved.
//

import UIKit

class CustomPresentationController: UIPresentationController {

    static let viewLeftPadding:CGFloat = 0
    static let viewTopPadding:CGFloat = 170
    static let viewHeight:CGFloat = 261
    static let buttonTopPadding:CGFloat = 80
    static let buttonHeight:CGFloat = 40
    
    
    var dimmingView:UIButton = UIButton.init()
    
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else {
            return
        }
        
        dimmingView.frame = containerView.bounds
        dimmingView.backgroundColor = UIColor.black
        dimmingView.alpha = 0.0
        dimmingView.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
        containerView.addSubview(dimmingView)

        if let transitionCoordinator = presentedViewController.transitionCoordinator {
            transitionCoordinator.animate(alongsideTransition: { (context) in
                self.dimmingView.alpha = 0.5
            }, completion: nil)
        }
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            dimmingView.removeFromSuperview()
        }
    }
    
    override func dismissalTransitionWillBegin() {
        if let transitionCoordinator = presentedViewController.transitionCoordinator{
            transitionCoordinator.animate(alongsideTransition: { (context) in
                self.dimmingView.alpha = 0.0
            }, completion: nil)
        }
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if !completed {
            dimmingView.removeFromSuperview()
        }
    }

    override var frameOfPresentedViewInContainerView:CGRect {
        guard let containerView = containerView else {
            print("Not find view")
            return CGRect()
        }
        
        var frame = containerView.bounds
        frame = frame.insetBy(dx: CustomPresentationController.viewLeftPadding, dy: CustomPresentationController.viewTopPadding)
        frame.origin.y = containerView.bounds.size.height - CustomPresentationController.viewHeight - CustomPresentationController.buttonTopPadding - CustomPresentationController.viewLeftPadding - containerView.safeAreaInsets.bottom + 12
        
        frame.size.height = CustomPresentationController.viewHeight + CustomPresentationController.buttonTopPadding
        
        return frame
    }
    
    @objc func dismissSelf(){
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
    
}
