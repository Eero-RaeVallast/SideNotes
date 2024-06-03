//
//  TextView.swift
//  SideNotes
//
//  Created by Eero Mannik on 21.05.2024.
//

import Cocoa

class TextView: NSTextView//, NSTextLayoutManagerDelegate
{
//    override func draw(_ dirtyRect: NSRect) {
//        super.draw(dirtyRect)
//
//        // Drawing code here.
//    }
    
//    override func mouseEntered(with event: NSEvent)
//    {
//        debugPrint("Entered")
//    }
    // TODO: arvutada uus outline kõrgus
    func textLayoutManager(
        _ textLayoutManager: NSTextLayoutManager,
        shouldBreakLineBefore location: NSTextLocation,
        hyphenating: Bool
    ) -> Bool
    {
        return true
    }
    
//    func textLayoutManager(
//        _ textLayoutManager: NSTextLayoutManager,
//        textLayoutFragmentFor location: NSTextLocation,
//        in textElement: NSTextElement
//    ) -> NSTextLayoutFragment
//    {
//        NSTextLayoutFragment(textElement: textElement, range: nil)
//    }
    
}


