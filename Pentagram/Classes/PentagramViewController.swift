//
//  PentagramViewController.swift
//  Pods
//
//  Created by Lucas Coelho on 7/18/16.
//
//

import UIKit

public class PentagramViewController: UIViewController {
    
    var presenter: PentagramPresenter!
    
    public var key: MusicKey {
        get {
            return presenter.key
        }
        set {
            presenter.key = newValue
            presenter.updateFinalPositionsArray()
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
    
    static public func getPentagram(lineWidth: CGFloat, spaceBetweenLines: CGFloat, topPosition: CGFloat) -> PentagramViewController {
        let podBundle = NSBundle(forClass: self.classForCoder())
        var nibBundle: NSBundle!
        
        if let bundleURL = podBundle.URLForResource("Pentagram", withExtension: "bundle") {
            if let bundle = NSBundle(URL: bundleURL) {
                nibBundle = bundle
            } else {
                nibBundle = nil
            }
        } else {
            nibBundle = nil
        }
        let viewController = PentagramViewController(nibName: "PentagramViewController", bundle: nibBundle)
        viewController.presenter = PentagramPresenter(topPosition: topPosition, lineWidth: lineWidth, spaceBetweenLines: spaceBetweenLines)
        viewController.presenter.updateFinalPositionsArray()
        return viewController
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        setupLayoutConstraints()
    }
    
    override public func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        guard let newCenter = change!["new"]?.CGPointValue else {
            return
        }
        let note = object as! MusicNoteView
        addSupplementaryLineIfNeeded(newCenter.y, note: note)
    }
    
    // Other Public methods
    public func drawNoteAtPosition(position: CGFloat) -> MusicNoteView {
        let note = MusicNoteView()
        note.frame = CGRect(x: 100, y: position, width: presenter.spaceBetweenLines * 1.5, height: presenter.spaceBetweenLines + 2)
        note.backgroundColor = UIColor.clearColor()
        note.center.y = position

        note.addObserver(self, forKeyPath: "center", options: NSKeyValueObservingOptions.New, context: nil)
        note.observer = self
        view.addSubview(note)
        note.supplementaryLineHidden = !presenter.shouldAddSupplementaryLine(position)
        return note
    }
    
    public func drawNoteForName(name: NoteId) -> MusicNoteView {
        return drawNoteAtPosition(presenter.getFinalPositionForNote(name))
    }
    
    public func getNameForNoteInPosition(position: CGFloat) -> String {
        return presenter.getNameForNoteInPosition(position)
    }
    
    public func getFinalPositionForPosition(position: CGFloat) -> CGFloat {
        return presenter.getFinalPositionForPosition(position)
    }
        
    // Private methods
    private func setupLayoutConstraints() {
        for constraint in [space1, space2, space3, space4] {
            constraint.constant = presenter.spaceBetweenLines
        }
        yPosition.constant = presenter.topPosition
        lineHeight.constant = presenter.lineWidth
    }
    
    private func addSupplementaryLineIfNeeded(position: CGFloat, note: MusicNoteView) {
        note.showSupplementaryLine(presenter.shouldAddSupplementaryLine(position))
    }
}