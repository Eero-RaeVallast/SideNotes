//
//  NoteHeaderVC.swift
//  SideNotes
//
//  Created by Eero Mannik on 15.05.2024.
//

import Cocoa

class NoteHeaderVC: NSViewController 
{

    // @IBOutlet private var commentField: NSTextField!
    //var documentViewController: NSViewController! = nil
    @IBOutlet weak var HeaderLabel: NSTextField!
    @IBOutlet weak var TimeLabel: TimeLabel!
    
    
    var header: String = ""
    var note: NoteContent?
    {
        didSet
        {
            header = note?.header ?? ""
        }
    }
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        HeaderLabel.stringValue = header
        TimeLabel.note = note
        //TimeLabel.stringValue = note?.modificationTime() ?? ""
        // Do view setup here.
        let labelTrackingArea = NSTrackingArea(rect: TimeLabel.bounds, options: [NSTrackingArea.Options.mouseEnteredAndExited, NSTrackingArea.Options.cursorUpdate, NSTrackingArea.Options.activeInKeyWindow], owner: TimeLabel, userInfo: nil)
        TimeLabel.addTrackingArea(labelTrackingArea)
        TimeLabel.headerVC = self
    }
    
    // see osa on mingis teises klassis
//    func showCommentPopover(for layoutFragment: NSTextLayoutFragment) 
//    {
//        let storyboard = NSStoryboard(name: "Main", bundle: nil)
//        if let popoverVC = storyboard.instantiateController(withIdentifier: "CommentPopoverViewController") as? NSViewController 
//        {
//            //popoverVC.documentViewController = self
//        }
//    }
//    
    
}
