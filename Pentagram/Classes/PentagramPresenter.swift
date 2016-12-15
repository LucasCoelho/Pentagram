//
//  PentagramPresenter.swift
//  Pods
//
//  Created by Lucas Coelho on 7/26/16.
//
//

import UIKit

public enum NoteId: String {
    case Mi2 = "MI2"
    case Fa2 = "FA2"
    case Sol2 = "SOL2"
    case La2 = "LA2"
    case Si2 = "SI2"
    case Do3 = "DO3"
    case Re3 = "RE3"
    case Mi3 = "MI3"
    case Fa3 = "FA3"
    case Sol3 = "SOL3"
    case La3 = "LA3"
    case Si3 = "SI3"
    case Do4 = "DO4"
    case Re4 = "RE4"
    case Mi4 = "MI4"
    case Fa4 = "FA4"
    case Sol4 = "SOL4"
    case La4 = "LA4"
    case Si4 = "SI4"
    case Do5 = "DO5"
    case Re5 = "RE5"
    case Mi5 = "MI5"
    case Fa5 = "FA5"
    case Sol5 = "SOL5"
    case La5 = "LA5"
    
    public func getName() -> String {
        return NSLocalizedString("_\(rawValue.substring(to: rawValue.characters.index(before: rawValue.endIndex)).lowercased())", comment: "").uppercased()
    }
    
    public static func getAllNotes() -> [NoteId] {
        return [.Do4, .Re4, .Mi4, .Fa4, .Sol4, .La4, .Si4, .Do5, .Re5, .Mi5, .Fa5, .Sol5, .La5]
    }
}

public enum MusicKey {
    case g
    case f
}

struct PentagramPresenter {
    
    var key: MusicKey = .g {
        didSet {
            updateFinalPositionsArray()
        }
    }
    
    var spaceBetweenLines: CGFloat!
    var topPosition: CGFloat!
    var lineWidth: CGFloat!
    var positionsToAddSupplementaryLine: [CGFloat]!
    var finalPositions: [NoteId: CGFloat]!

    init(topPosition: CGFloat, lineWidth: CGFloat, spaceBetweenLines: CGFloat) {
        self.topPosition = topPosition
        self.lineWidth = lineWidth
        self.spaceBetweenLines = spaceBetweenLines
        updateFinalPositionsArray()
    }
    
    mutating func updateFinalPositionsArray() {
        let firstLine = topPosition + lineWidth/2
        
        let note1 = firstLine - spaceBetweenLines
        let note2 = firstLine - 0.5 * spaceBetweenLines
        let note3 = firstLine
        let note4 = firstLine + 0.5 * (spaceBetweenLines + lineWidth)
        let note5 = firstLine + 1.0 * (spaceBetweenLines + lineWidth)
        let note6 = firstLine + 1.5 * (spaceBetweenLines + lineWidth)
        let note7 = firstLine + 2.0 * (spaceBetweenLines + lineWidth)
        let note8 = firstLine + 2.5 * (spaceBetweenLines + lineWidth)
        let note9 = firstLine + 3.0 * (spaceBetweenLines + lineWidth)
        let note10 = firstLine + 3.5 * (spaceBetweenLines + lineWidth)
        let note11 = firstLine + 4.0 * (spaceBetweenLines + lineWidth)
        let note12 = firstLine + 4.5 * (spaceBetweenLines + lineWidth)
        let note13 = firstLine + 5.0 * (spaceBetweenLines + lineWidth)
        
        if key == .g {
            finalPositions = [.La5: note1, .Sol5: note2, .Fa5: note3, .Mi5: note4, .Re5: note5, .Do5: note6,
                              .Si4: note7, .La4: note8, .Sol4: note9, .Fa4: note10, .Mi4: note11, .Re4: note12, .Do4: note13]
        } else {
            finalPositions = [.Do4: note1, .Si3: note2, .La3: note3, .Sol3: note4, .Fa3: note5, .Mi3: note6,
                              .Re3: note7, .Do3: note8, .Si2: note9, .La2: note10, .Sol2: note11, .Fa2: note12, .Mi2: note13]
        }
        positionsToAddSupplementaryLine = [note1, note13]
    }
    
    func getNameForNoteInPosition(_ position: CGFloat) -> String {
        return getNoteIdForPosition(position).rawValue
    }
    
    func getNoteIdForPosition(_ position: CGFloat) -> NoteId {
        for (key, value) in finalPositions {
            if getFinalPositionForPosition(position) == value {
                return key
            }
        }
        return .Do4
    }
    
    func getFinalPositionForPosition(_ position: CGFloat) -> CGFloat {
        var smallerValue = abs(finalPositions[.Do4]! - position)
        var finalPosition = finalPositions[.Do4]
        for note in finalPositions {
            if abs(position - note.1) < smallerValue {
                finalPosition = note.1
                smallerValue = abs(position - note.1)
            }
        }
        return finalPosition!
    }
    
    func getFinalPositionForNote(_ note: NoteId) -> CGFloat {
        return finalPositions[note]!
    }
    
    func shouldAddSupplementaryLine(_ position: CGFloat) -> Bool {
        if positionsToAddSupplementaryLine.contains(getFinalPositionForPosition(position)) {
            return true
        } else {
            return false
        }
    }
}
