//
//  PentagramViewController.swift
//  Pods
//
//  Created by Lucas Coelho on 7/18/16.
//
//

import UIKit

open class PentagramViewController: UIViewController {
    
    var presenter: PentagramPresenter!
    
    open var key: MusicKey = .g {
        didSet {
            presenter.key = key
        }
    }
    
    open var color = UIColor.black {
        didSet {
            changeLinesColor(color)
        }
    }
        
    @IBOutlet weak var yPosition: NSLayoutConstraint!
    @IBOutlet weak var lineHeight: NSLayoutConstraint!
    
    @IBOutlet weak var space1: NSLayoutConstraint!
    @IBOutlet weak var space2: NSLayoutConstraint!
    @IBOutlet weak var space3: NSLayoutConstraint!
    @IBOutlet weak var space4: NSLayoutConstraint!
    
    @IBOutlet weak var line1: UIView!
    @IBOutlet weak var line2: UIView!
    @IBOutlet weak var line3: UIView!
    @IBOutlet weak var line4: UIView!
    @IBOutlet weak var line5: UIView!
    
    private var myContext = 0
    
    static open func getPentagram(lineWidth: CGFloat, spaceBetweenLines: CGFloat, topPosition: CGFloat) -> PentagramViewController {
        let podBundle = Bundle(for: self.classForCoder())
        var nibBundle: Bundle!
        
        if let bundleURL = podBundle.url(forResource: "Pentagram", withExtension: "bundle") {
            if let bundle = Bundle(url: bundleURL) {
                nibBundle = bundle
            } else {
                nibBundle = nil
            }
        } else {
            nibBundle = nil
        }
        let viewController = PentagramViewController(nibName: "PentagramViewController", bundle: nibBundle)
        viewController.presenter = PentagramPresenter(topPosition: topPosition, lineWidth: lineWidth, spaceBetweenLines: spaceBetweenLines)
        return viewController
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        setupLayoutConstraints()
    }
    
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        guard let newCenter = change!["new"]?.cgPointValue else {
//            return
//        }
//        let note = object as! MusicNoteView
//        addSupplementaryLineIfNeeded(newCenter.y, note: note)
        
        
        if context == &myContext {
            if let newValue = change?[.newKey] {
                if let newCenter = (newValue as AnyObject).cgPointValue {
                    let note = object as! MusicNoteView
                    addSupplementaryLineIfNeeded(newCenter.y, note: note)
                }
            }
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    // Other Public methods
    open func drawNoteAtPosition(_ position: CGFloat) -> MusicNoteView {
        let note = MusicNoteView()
        note.frame = CGRect(x: 100, y: position, width: presenter.spaceBetweenLines * 1.5, height: presenter.spaceBetweenLines + 2)
        note.backgroundColor = .clear
        note.center.y = position
        note.center.x = view.center.x
        note.addObserver(self, forKeyPath: "center", options: NSKeyValueObservingOptions.new, context: &myContext)
        note.observer = self
        view.addSubview(note)
        note.supplementaryLineHidden = !presenter.shouldAddSupplementaryLine(position)
        return note
    }
    
    open func drawNoteForName(_ name: NoteId) -> MusicNoteView {
        return drawNoteAtPosition(presenter.getFinalPositionForNote(name))
    }
    
    open func getNameForNoteInPosition(_ position: CGFloat) -> String {
        return presenter.getNameForNoteInPosition(position)
    }
    
    open func getNoteIdForPosition(_ position: CGFloat) -> NoteId {
        return presenter.getNoteIdForPosition(position)
    }

    open func getFinalPositionForPosition(_ position: CGFloat) -> CGFloat {
        return presenter.getFinalPositionForPosition(position)
    }
    
    open func getYPositionForNote(_ note: NoteId) -> CGFloat {
        return presenter.getFinalPositionForNote(note)
    }
    
    // Private methods
    fileprivate func setupLayoutConstraints() {
        for constraint in [space1, space2, space3, space4] {
            constraint?.constant = presenter.spaceBetweenLines
        }
        yPosition.constant = presenter.topPosition
        lineHeight.constant = presenter.lineWidth
    }
    
    fileprivate func addSupplementaryLineIfNeeded(_ position: CGFloat, note: MusicNoteView) {
        note.showSupplementaryLine(presenter.shouldAddSupplementaryLine(position))
    }
    
    fileprivate func changeLinesColor(_ color: UIColor) {
        let lines = [line1, line2, line3, line4, line5]
        for line in lines {
            line?.backgroundColor = color
        }
    }
}
