//
//  MusicNote.swift
//  Pods
//
//  Created by Lucas Coelho on 7/25/16.
//
//

import UIKit

open class MusicNoteView: UIView {
    
    var observer: NSObject!
    fileprivate var supplementaryLine: UIView!

    var color = UIColor.gray {
        didSet {
            changeColor(color)
        }
    }
    var supplementaryLineHidden = false
    var path: UIBezierPath!
    
    deinit {
        if observer != nil {
            removeObserver(observer, forKeyPath: "center", context: nil)
        }
    }

    override open func draw(_ rect: CGRect) {
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: rect.width, height: rect.height))
        color.setFill()
        path.fill()
        transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI/8));

        let bounds = path.cgPath.boundingBox
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        supplementaryLine = UIView(frame: CGRect(x: 0, y: 0, width: rect.width*2, height: 5))
        supplementaryLine.backgroundColor = color
        supplementaryLine.center = center
        supplementaryLine.isHidden = supplementaryLineHidden
        supplementaryLine.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI/8));
        addSubview(supplementaryLine)
    }
    
    open func showSupplementaryLine(_ show: Bool) {
        supplementaryLine?.isHidden = !show
    }
    
    func changeColor(_ color: UIColor) {
        guard supplementaryLine != nil && path != nil else { return }

        let fillLayer = CAShapeLayer()
        fillLayer.path = path.cgPath
        fillLayer.fillColor = color.cgColor
        layer.addSublayer(fillLayer)
        
        supplementaryLine.backgroundColor = color
    }
}
