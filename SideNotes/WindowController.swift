//
//  WindowController.swift
//  SideNotes
//
//  Created by Eero Mannik on 18.06.2024.
//

import Cocoa

class WindowController: NSWindowController 
{

    @IBAction func NewNote(_ sender: NSToolbarItem) 
    {
        if let cvc = contentViewController as? ViewController
        {
            cvc.addNote()
            //let doc = document
            //debugPrint("NewNote")
        }
    }
    
    
    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

}
