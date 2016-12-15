//
//  ViewController.swift
//  Pentagram
//
//  Created by Lucas on 07/18/2016.
//  Copyright (c) 2016 Lucas. All rights reserved.
//

import UIKit
import Pentagram

class ViewController: UIViewController {

    var note: MusicNoteView!
    let pentagram = PentagramViewController.getPentagram(lineWidth: 5, spaceBetweenLines: 24, topPosition: 200)
    let label = UILabel(frame: CGRect(x: 0, y: 400, width: 150, height: 100))

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewController(pentagram)
        view.addSubview(pentagram.view)
        pentagram.key = .f
        note = pentagram.drawNoteForName(.Do3)
        view.addSubview(label)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        let position = touches.first!.location(in: view)
        let yPosition = pentagram.getFinalPositionForPosition(position.y)
        note.center = CGPoint(x: position.x, y: yPosition)
        label.text = pentagram.getNameForNoteInPosition(pentagram.getFinalPositionForPosition(position.y))
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        let position = touches.first!.location(in: view)
        note.center = position
        label.text = pentagram.getNameForNoteInPosition(pentagram.getFinalPositionForPosition(position.y))
    }
}
