//
//  TextView.swift
//  SideNotes
//
//  Created by Eero Mannik on 21.05.2024.
//

import Cocoa

class TextView: NSTextView//, NSTextLayoutManagerDelegate
{
    // TODO: muuta ka header
    // teksti esimese rea muutumisel
    
    var note: NoteContent?
    {
        didSet
        {
            self.string = note?.text ?? ""
        }
    }
    
    /// called on text did end editing
    func saveNote()
    {
        //note?.text = string
        note?.textChanged(newtext: string)
        //debugPrint(note)
    }
    
//    func textChanged()
//    {
//        // modification date
//        // header
//        if note?.text != string
//        {
//            if let header_line = note?.text.components(separatedBy: CharacterSet.newlines).first,
//               let new_line = string.components(separatedBy: CharacterSet.newlines).first
//            {
//                if header_line != new_line
//                {
//                    note?.textChanged(newtext: string)
//                    header = header_line
//                    if let headerVC = myView
//                    {
//                        myView?.headerChanged(newHeader: header)
//                    }
//                }
//            }
//            note?.text = string
//        }
//    }
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


