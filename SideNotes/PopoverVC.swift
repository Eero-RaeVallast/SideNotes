//
//  PopoverVC.swift
//  SideNotes
//
//  Created by Eero Mannik on 23.05.2024.
//

// TODO: Korduvad lipikud
//       lipikute kustutamine
// algsetel lipikutel ei ole lipikut

import Cocoa

class PopoverVC: NSViewController, NSPopoverDelegate
{

    @IBOutlet weak var TagStack: NSStackView!
    @IBOutlet weak var ModificationTime: NSTextField!
    @IBOutlet weak var CreationTime: NSTextField!
    
    var presenter: TimeLabel?
    {
        didSet
        {
            note = presenter?.note
        }
    }
    
    var note: NoteContent?
    
    @IBAction func AddTag(_ sender: NSButton)
    {
        let tf: TextField = TextField(string: "")
        
        
        let labelTrackingArea = NSTrackingArea(rect: tf.bounds, options: [NSTrackingArea.Options.mouseMoved, NSTrackingArea.Options.activeInKeyWindow], owner: tf, userInfo: nil)
        tf.addTrackingArea(labelTrackingArea)
        
        
        let addHeight = tf.frame.height
        
        if let font = tf.font?.fontName
        {
            tf.font = NSFont(name: font, size: 14)
        }

        let attachment = NSTextAttachment()
        attachment.image = NSImage(named: "tag")
        attachment.bounds = NSRect(x: 0, y: 0, width: 20, height: 20)
        let string = NSAttributedString(attachment: attachment)
        
        tf.placeholderAttributedString = string
        
        //let size:NSSize = preferredContentSize
        //let fframe: NSRect = view.frame
        
        let oldHeight = preferredContentSize.height
        let oldWidth = preferredContentSize.width
        
        self.preferredContentSize = NSSize(width: oldWidth, height: oldHeight + addHeight)
        let views = TagStack.views
        if let removeview = views.last
        {
            TagStack.removeView(removeview)
            TagStack.addView(tf, in: NSStackView.Gravity.top)
            TagStack.addView(removeview, in: NSStackView.Gravity.top)
        }
    }
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        ModificationTime.stringValue = note?.modificationTime() ?? ""
        CreationTime.stringValue = note?.creationTime() ?? ""
        showTags()
    }
    
    /// Read from file
    private func showTags()
    {
        if let notes = note
            , !notes.tags.isEmpty
        {
            
            var oldHeight = preferredContentSize.height
            let oldWidth = preferredContentSize.width
            
            let views = TagStack.views
            if let removeview = views.last
            {
                TagStack.removeView(removeview)
                for tag in notes.tags
                {
                    let tf: NSTextField = NSTextField(string: tag)
                    if let font = tf.font?.fontName
                    {
                        tf.font = NSFont(name: font, size: 14)
                    }
                    oldHeight += tf.frame.height
                    
                    TagStack.addView(tf, in: NSStackView.Gravity.top)
                    self.preferredContentSize = NSSize(width: oldWidth, height: oldHeight)
                }
                TagStack.addView(removeview, in: NSStackView.Gravity.top)
            }
            
        }
    }
    
    func popoverWillClose(_ notification: Notification)
    {
        let views = TagStack.views
        
        if let notes = note
        {
            notes.tags.removeAll(keepingCapacity: true)
            for viewItem in views
            {
                if let label = viewItem as? NSTextField
                    , !label.stringValue.isEmpty
                {
                    notes.tags.insert(label.stringValue)
                }
            }
        }
        //debugPrint("popoverWillClose")
    }
    
    func popoverDidClose(_ notification: Notification)
    {
        //debugPrint("Popover closed")
        presenter?.popover_isvisible = false
    }
    
//    override func mouseDragged(with event: NSEvent)
//    {
//        debugPrint("mouse dragged")
//    }
}


class TextField: NSTextField
{
    var location_x: CGFloat = 0
    var delta:CGFloat = 0
    var down: Bool = false
    
    // ? Kui teksti ala on aktiivne võtab ta vastu ainult
    // klahvivajutusi?
    override func mouseDragged(with event: NSEvent)
    {
        debugPrint("mouse dragged")
    }
    
    override func mouseDown(with event: NSEvent)
    {
        down = true
        location_x = event.locationInWindow.x
            //debugPrint("mouse down")
    }
    
    override func mouseUp(with event: NSEvent)
    {
        debugPrint("mouse up", delta)
        if delta > 10
        {
            //debugPrint("mouse up", delta)
        }
        location_x = 0
        //down = false
        delta = 0
    }
    
    override func mouseMoved(with event: NSEvent)
    {
        if down
        {
            delta = location_x + event.locationInWindow.x
        }
//        debugPrint("mouse moved", ev)
    }
}
