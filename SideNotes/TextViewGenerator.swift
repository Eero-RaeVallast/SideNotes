//
//  TextViewGenerator.swift
//  SideNotes
//
//  Created by Eero Mannik on 25.04.2024.
//

import Cocoa


struct TextViewGenerator
{
    // saata siia url
    // Funktsioon käivitub outline avamisel
    static func makeTextView(frame frameRect: NSRect, text: String = "", delegate: NSTextViewDelegate? = nil)->TextView
    {
        let textContentStorage = NSTextContentStorage()
        
        //textContentStorage.textStorage?.setAttributedString(NSAttributedString(string: text))
        
        let textLayoutManager = NSTextLayoutManager()
        let textContainer: NSTextContainer = NSTextContainer(size: NSSize(width: 300, height: CGFloat.greatestFiniteMagnitude))
        textContainer.widthTracksTextView = true
        
        textLayoutManager.textContainer = textContainer
        textContentStorage.addTextLayoutManager(textLayoutManager)
//        textContentStorage.textStorage?.setAttributedString(NSAttributedString(string: text))
        
        let textView = TextView(frame: frameRect, textContainer: textLayoutManager.textContainer)
        if let textViewdelegate = delegate
        {
            textView.delegate = textViewdelegate
        }
        //textLayoutManager.delegate = textView
//        if let mgr = textView.textLayoutManager
//        {
//            mgr.delegate = textView
//        }
        //textLayoutManager.delegate = textView
        //textView.textContentStorage
        textView.isEditable = true
        textView.isSelectable = true
        textView.autoresizingMask = [.width, .height]
        textView.string = text
        //textContentStorage.textStorage?.setAttributedString(NSAttributedString(string: text))
        //textContentStorage.attributedString = NSAttributedString(string: text)
        
        return textView
    }
}
