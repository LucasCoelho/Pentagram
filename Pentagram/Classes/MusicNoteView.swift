//
//  MusicNote.swift
//  Pods
//
//  Created by Lucas Coelho on 7/25/16.
//
//

import UIKit

public class MusicNoteView: UIView {
    
    var observer: NSObject!
    private var supplementaryLine: UIView!

    var supplementaryLineHidden = false
    
    deinit {
        if observer != nil {
            removeObserver(observer, forKeyPath: "center", context: nil)
        }
    }

    override public func drawRect(rect: CGRect) {
        let path = UIBezierPath(ovalInRect: CGRect(x: 0, y: 0, width: rect.width, height: rect.height))
        UIColor.grayColor().setFill()
        transform = CGAffineTransformMakeRotation(CGFloat(-M_PI/8));
        path.fill()

        let bounds = CGPathGetBoundingBox(path.CGPath)
        let center = CGPoint(x: CGRectGetMidX(bounds), y: CGRectGetMidY(bounds))
        supplementaryLine = UIView(frame: CGRect(x: 0, y: 0, width: rect.width*2, height: 5))
        supplementaryLine.backgroundColor = UIColor.grayColor()
        supplementaryLine.center = center
        supplementaryLine.hidden = supplementaryLineHidden
        supplementaryLine.transform = CGAffineTransformMakeRotation(CGFloat(M_PI/8));
        addSubview(supplementaryLine)
    }
    
    public func showSupplementaryLine(show: Bool) {
        supplementaryLine.hidden = !show
    }
}