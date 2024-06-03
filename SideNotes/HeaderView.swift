//
//  HeaderView.swift
//  SideNotes
//
//  Created by Eero Mannik on 20.05.2024.
//

import Cocoa

class HeaderView: NSView 
{

    override func draw(_ dirtyRect: NSRect) 
    {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override func mouseEntered(with event: NSEvent)
    {
        debugPrint("Entered")
    }
    
}


class TimeLabel: NSTextField
{
    private var show_Popower: Bool = true
    var popover_isvisible: Bool = false
    
    var headerVC: NoteHeaderVC?
    
    var note: NoteContent?
    {
        didSet
        {
            stringValue = note?.modificationTime() ?? ""
        }
    }
    
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        //toolTip = "Hover over label"
    }
    
    override func mouseEntered(with event: NSEvent)
    {
        perform(#selector(showPopower), with: nil, afterDelay: 1)
        show_Popower = true
    }
    
    @objc func showPopower()
    {
        if show_Popower
        {
            debugPrint("Pop")
            let storyboard = NSStoryboard(name: "Main", bundle: nil)
            
            if popover_isvisible == false,
                let popoverVC = storyboard.instantiateController(withIdentifier: "TimeNTags") as? PopoverVC
            {
                popoverVC.presenter = self
                //popoverVC.view.frame = NSRect(x: 0, y: 0, width: 120, height: 100)
                
                if let header = headerVC
                {
                    let middle: CGFloat = frame.width / 2
                    popoverVC.preferredContentSize = NSSize(width: 200, height: 120)
                    header.present(popoverVC, asPopoverRelativeTo: NSRect(x: middle, y: 0, width: 100, height: 120), of: self, preferredEdge: .maxY, behavior: .semitransient)
                    popover_isvisible = true
                }
            }
        }
    }
    
    override func mouseExited(with event: NSEvent)
    {
        show_Popower = false
    }
    
    
//    override func mouseDown(with event: NSEvent)
//    {
//        debugPrint("mouseDown")
//    }
}
