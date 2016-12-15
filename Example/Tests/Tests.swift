import UIKit
import XCTest
@testable import Pentagram

class Tests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMiddleCPosition() {
        var sut = PentagramPresenter(topPosition: 200, lineWidth: 5, spaceBetweenLines: 24)
        sut.key = .g
        var expectedPosition: CGFloat = 347.5
        sut.updateFinalPositionsArray()
        XCTAssert(expectedPosition == sut.finalPositions[.Do4])
        
        sut.key = .f
        expectedPosition = 178.5
        sut.updateFinalPositionsArray()
        XCTAssert(expectedPosition == sut.finalPositions[.Do4])
    }
    
    func testNoteDistancesAreEqual() {
        var sut = PentagramPresenter(topPosition: 200, lineWidth: 5, spaceBetweenLines: 24)
        let expectedDistance: CGFloat = 14.5
        sut.updateFinalPositionsArray()
        
        var result = sut.finalPositions[.Mi5]! - sut.finalPositions[.Fa5]!
        XCTAssert(expectedDistance == result)
        
        result = sut.finalPositions[.Re5]! - sut.finalPositions[.Mi5]!
        XCTAssert(expectedDistance == result)
    }
    
    func testFinalPositionForPosition() {
        var sut = PentagramPresenter(topPosition: 200, lineWidth: 5, spaceBetweenLines: 24)
        sut.updateFinalPositionsArray()
        
        var expectedPosition: CGFloat = 347.5
        
        var result = sut.getFinalPositionForPosition(341)
        XCTAssert(expectedPosition == result)
        
        result = sut.getFinalPositionForPosition(350)
        XCTAssert(expectedPosition == result)
        
        expectedPosition = 202.5
        
        result = sut.getFinalPositionForPosition(200)
        XCTAssert(expectedPosition == result)
    }
    
    func testFinalPositionForNoteGKey() {
        var sut = PentagramPresenter(topPosition: 200, lineWidth: 5, spaceBetweenLines: 24)
        sut.updateFinalPositionsArray()
        sut.key = .g

        var expectedPosition: CGFloat = 231.5
        var result = sut.getFinalPositionForNote(.Re5)
        XCTAssert(expectedPosition == result)
        
        expectedPosition = 246.0
        result = sut.getFinalPositionForNote(.Do5)
        XCTAssert(expectedPosition == result)
        
        expectedPosition = 275.0
        result = sut.getFinalPositionForNote(.La4)
        XCTAssert(expectedPosition == result)
    }
    
    func testFinalPositionForNoteFKey() {
        var sut = PentagramPresenter(topPosition: 200, lineWidth: 5, spaceBetweenLines: 24)
        sut.key = .f
        sut.updateFinalPositionsArray()
        
        var expectedPosition: CGFloat = 333.0
        var result = sut.getFinalPositionForNote(.Fa2)
        XCTAssert(expectedPosition == result)
        
        expectedPosition = 289.5
        result = sut.getFinalPositionForNote(.Si2)
        XCTAssert(expectedPosition == result)
        
        expectedPosition = 260.5
        result = sut.getFinalPositionForNote(.Re3)
        XCTAssert(expectedPosition == result)
    }
    
    func testNameForPositionFKey() {
        var sut = PentagramPresenter(topPosition: 200, lineWidth: 5, spaceBetweenLines: 24)
        sut.key = .f
        sut.updateFinalPositionsArray()
        
        var expectedNote = NoteId.La2
        var result = sut.getNameForNoteInPosition(304.0)
        XCTAssert(expectedNote.rawValue == result)
        
        expectedNote = .Si3
        result = sut.getNameForNoteInPosition(190.5)
        XCTAssert(expectedNote.rawValue == result)
        
        expectedNote = .Sol2
        result = sut.getNameForNoteInPosition(318.5)
        XCTAssert(expectedNote.rawValue == result)
    }
}
