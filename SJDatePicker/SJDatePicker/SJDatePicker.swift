//
//  SJDatePicker.swift
//  SJDatePicker
//
//  Created by sabrina on 2020/11/19.
//  Copyright © 2020 Sabrina. All rights reserved.
//

import Foundation
import UIKit

typealias DirectionPoint = (start: CGPoint, end: CGPoint)

class SJDatePicker:UIDatePicker {
    
    private var screenScale: CGFloat { UIScreen.main.scale }
    private let highlightedView:UIView = UIView()
    
    var style:PickerStyle? { didSet { setupStyle() } }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialized()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialized()
    }
    
    private func initialized() {
        self.preferredDatePickerStyle = .wheels
        self.subviews.forEach { (view) in
            view.subviews.forEach { (subView) in
                subView.backgroundColor = .clear
            }
        }
        self.layer.masksToBounds = true
        self.backgroundColor = .clear
        
        highlightedView.frame = .zero
        highlightedView.backgroundColor = UIColor.clear
        highlightedView.layer.borderWidth = 1.0
        self.addSubview(highlightedView)
        highlightedView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([highlightedView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                     highlightedView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                                     highlightedView.heightAnchor.constraint(equalToConstant: 35),
                                     highlightedView.centerYAnchor.constraint(equalTo: self.centerYAnchor)])
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let text = style?.pickerColor {
            switch text {
            case .color(let color):
                self.setValue(color, forKeyPath: "textColor")
            case .colors(let colors):
                let colors = updateGradientToUIColor(colors: colors)
                self.setValue(colors, forKeyPath: "textColor")
            }
        }
    }
}

private extension SJDatePicker {
    private func setupStyle() {
        self.perform(NSSelectorFromString("setHighlightsToday:"), with: false)
        
        if let minDate = style?.minimumDate {
            self.minimumDate = minDate
        }
        
        if let maxDate = style?.maximumDate {
            self.maximumDate = maxDate
        }
        
        if let minDate = minimumDate, let maxDate = maximumDate {
            assert(minDate < maxDate, "minimum date cannot bigger then maximum date")
        }
        
        if let zone = style?.timeZone {
            self.timeZone = zone
        }
        
        if let mode = style?.pickerMode {
            self.datePickerMode = mode
        }
        
        if let color = style?.textColor {
            self.highlightedView.layer.borderColor = color.cgColor
        }
    }
    
    private func updateGradientToUIColor(colors: [UIColor]) -> UIColor? {
        let layer = createGradientLayer(colors: colors)
        guard let image = updateGradientToUIImage(gradientLayer: layer) else { return nil }
        return UIColor(patternImage: image)
    }
    
    private func updateGradientToUIImage(gradientLayer: CAGradientLayer) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(gradientLayer.bounds.size, gradientLayer.isOpaque, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        gradientLayer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    private func createGradientLayer(colors: [UIColor]) -> CAGradientLayer {
        guard colors.count > 1 else { return CAGradientLayer() }
        let layer = CAGradientLayer()
        layer.frame = self.bounds
        layer.colors = colors.map({ $0.cgColor })
        layer.startPoint = CGPoint(x: 0.5, y: 0)
        layer.endPoint = CGPoint(x: 0.5, y: 0.5)
        return layer
    }
}
