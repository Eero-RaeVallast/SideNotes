//
//  ViewController.swift
//  SideNotes
//
//  Created by Eero Mannik on 07.04.2024.
//

import Cocoa

class ViewController: NSViewController, NSTextLayoutManagerDelegate
{
    // RemoveMe
    var testHeight: CGFloat = 0
    /// Lisatud tekstiosa kõrgus
    var containerHeight: CGFloat = 0
    var sizeRect = NSRect(x: 0, y: 0, width: 120, height: 10)
    var notes = Notes()
    var content: [NoteContent] = [NoteContent]()
    var placeholderTextView: TextView = TextView()
    
    @IBOutlet weak var outlineView: NSOutlineView!
    
    @IBAction func createCollection(_ sender: Any) 
    {        
        notes.notes.append(Note(withTitle: "title", id: notes.getNoteID()))
        // Reload the outline view.
        outlineView.reloadData()
        // Expand the collection if possible.
        // outlineView.expandItem(collectionToExpand)
    }
    
    @IBAction func addColor(_ sender: Any) {
        // Make sure that there is a target collection to add a new color to.
        guard let collection = getCollectionForSelectedItem() else { return }

        // Create and get the instance of the new color.
        //let newColor = viewModel.addColor(to: collection)

        // Reload the outline view and expand the collection.
        outlineView.reloadData()
        outlineView.expandItem(collection)

        // Get the row of the new color item and select it automatically.
        //let colorRow = outlineView.row(forItem: newColor)
        //outlineView.selectRowIndexes(IndexSet(arrayLiteral: colorRow), byExtendingSelection: false)
        
    }
    
    func getCollectionForSelectedItem() -> Notes?
    {
        _ = outlineView.item(atRow: outlineView.selectedRow)
        
        //guard let selectedCollection = selectedItem as? Collection
        //    else { return outlineView.parent(forItem: selectedItem) as? Collection }
        return Notes()
    }
    /**
     Create a new color and add it as an item to the given collection.
    */
//    func addColor(to collection: Collection) -> Color {
//        let newColor = Color(withID: model.getColorID())
//        collection.items.append(newColor)
//        return newColor
//    }
    
        
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        
        outlineView.dataSource = self
        outlineView.delegate = self
        // Do any additional setup after loading the view.
    }

    // 2
    override var representedObject: Any?
    {
        didSet 
        {
            if let text = representedObject as? String
            {
                content = NoteContent.getNoteContent(text: text)
                outlineView.reloadData()
            }
//            else if let url = representedObject as? URLRequest
//            {
//                
//            }
        }
    }
    
    
    func getStringsFromNotes() -> String
    {
        var text: String = ""
        for note in content
        {
            text.append(note.stringRepresentation())
        }
        return text
    }
    
    
    // TODO: arvutada uus outline kõrgus
    func textLayoutManager(
        _ textLayoutManager: NSTextLayoutManager,
        shouldBreakLineBefore location: NSTextLocation,
        hyphenating: Bool
    ) -> Bool
    {
        if let range = textLayoutManager.textContentManager?.documentRange
        {
            textLayoutManager.ensureLayout(for: range)
        }
        let newHeight = textLayoutManager.usageBoundsForTextContainer.height
        return true
//        if let textview = textLayoutManager.textContainer?.textView
//        {
//            
//        }
//        if let container = textLayoutManager.textContainer
//        {
            //manager.delegate = placeholderTextView
//            if let range = textLayoutManager.textContentManager?.documentRange
//            {
//                textLayoutManager.ensureLayout(for: range)
//            }
//            //manager.ensureLayout(for: container)
//            //newHeight = manager.usedRect(for: container).size.height
//            let newHeight = textLayoutManager.usageBoundsForTextContainer.height
        //}
        
//        if let manager = textView.layoutManager, let container = textView.textContainer
//        {
//            //manager.ensureLayout(for: container)
//            let old_height = textView.frame.height
//            let height = manager.usedRect(for: container).size.height
//            
//            if height > old_height
//            {
//                containerHeight = height
//                outlineView.noteHeightOfRows(withIndexesChanged: IndexSet(integer: row))
//            }
//        }
    }
    
}


extension ViewController: NSOutlineViewDataSource 
{
    // 1
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int
    {
        if item == nil 
        {
            return content.count
        }
        else
        {
            if item is NoteContent
            {
                return 1
            } 
            else
            {
                return 0
            }
        }
    }
    
    // 3 Returns the child item at the specified index of a given item
    func outlineView( _ outlineView: NSOutlineView, child index: Int, ofItem item: Any? ) -> Any
    {
        if item == nil 
        {
            return content[index]
        } 
        else
        {
            if let note = item as? NoteContent
            {
                return note.text
            }
            else if let text = item as? String
            {
                return text
            }
        }
        return "ERROR!"
    }
    
    // 4
    func outlineView( _ outlineView: NSOutlineView, isItemExpandable item: Any ) -> Bool
    {
        if item is NoteContent
        {
            return true
        }
        else
        {
            return false
        }
    }
    
//    func outlineView( _ outlineView: NSOutlineView, objectValueFor tableColumn: NSTableColumn?, byItem item: Any? ) -> Any?
//    {
//        return nil
//    }
//    
//    func outlineView(
//        _ outlineView: NSOutlineView,
//        setObjectValue object: Any?,
//        for tableColumn: NSTableColumn?,
//        byItem item: Any?
//    )
//    {
//        
//    }
//    
//    func outlineView(
//        _ outlineView: NSOutlineView,
//        sortDescriptorsDidChange oldDescriptors: [NSSortDescriptor]
//    )
//    {
//        
//    }
}



extension ViewController: NSOutlineViewDelegate 
{
    
    // TODO: calculate text view size
    // peale juurdekirjutust!
    func outlineView( _ outlineView: NSOutlineView, heightOfRowByItem item: Any ) -> CGFloat
    {
        // default to height of NoteContent
        var newHeight: CGFloat = 21
        
//        if let note = item as? NoteContent
//        {
//            // return header view
//            return newHeight
//        }
//        else 
        if let text = item as? String
        {
            // juhul kui olemasolev kõrgus muutus
            if containerHeight > 0
            {
                newHeight = containerHeight
                containerHeight = 0
            }
            else
            {
                placeholderTextView = TextViewGenerator.makeTextView(frame: sizeRect, text: text, delegate: self)
                //placeholderTextView.string = text
                //textContentStorage.textStorage?.setAttributedString(NSAttributedString(string: text))
                //placeholderTextView.textContentStorage?.textStorage?.setAttributedString(NSAttributedString(string: text))
                
                //placeholderTextView.delegate = self
                if let mgr = placeholderTextView.textLayoutManager
                {
                    mgr.delegate = self
                }
                //NotificationCenter.default.addObserver(self, selector: #selector(self.textViewFrameChanged), name: NSView.frameDidChangeNotification, object: placeholderTextView)

                if let manager = placeholderTextView.textLayoutManager, let container = placeholderTextView.textContainer
                {
                    //manager.delegate = placeholderTextView
                    if let range = placeholderTextView.textContentStorage?.documentRange
                    {
                        manager.ensureLayout(for: range)
                    }
                    //manager.ensureLayout(for: container)
                    //newHeight = manager.usedRect(for: container).size.height
                    newHeight = manager.usageBoundsForTextContainer.height
                }
            }
        }
        return newHeight
    }
    
    
    func outlineView( _ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any ) -> NSView?
    {
        let myWidth: CGFloat = CGFloat(tableColumn?.width ?? 200)
        sizeRect = NSRect(x: 0, y: 0, width: myWidth, height: 10)
        
        if let note = item as? NoteContent
        {
            // return header view
            let storyboard = NSStoryboard(name: "Main", bundle: nil)
            if let headerVC = storyboard.instantiateController(withIdentifier: "HeaderView") as? NoteHeaderVC
            {
                //popoverVC.documentViewController = self
                //headerVC.header = note.header
                headerVC.note = note
                return headerVC.view
            }
            //return v
        } // TODO: See ei toimi taaslaadimisel ??
        // ? reload item ?
        else if let text = item as? String
        {
            if text == placeholderTextView.string
            {
                return placeholderTextView
            }
            else
            {
                let textView = TextViewGenerator.makeTextView(frame: sizeRect, text: text, delegate: self)
                if let mgr = textView.textLayoutManager
                {
                    mgr.delegate = self
                }
                //textView.string = text
                //textView.delegate = self
                //NotificationCenter.default.addObserver(self, selector: #selector(self.textViewFrameChanged), name: NSView.frameDidChangeNotification, object: textView)
                return textView
            }
        }
        
        return nil
    }
    
    
    func tableView( _ tableView: NSTableView, heightOfRow row: Int ) -> CGFloat
    {
        return 50
    }
//    func outlineView(_ outlineView: NSOutlineView, shouldSelectItem item: Any ) -> Bool
//    {
//        return true
//    }
//    
//    func outlineViewSelectionDidChange(_ notification: Notification)
//    {
//        debugPrint("Selection changed")
//    }
//    
//    func outlineView(
//        _ outlineView: NSOutlineView,
//        shouldEdit tableColumn: NSTableColumn?,
//        item: Any
//    ) -> Bool
//    {
//        debugPrint("Editing allowed")
//        return true
//    }
//    
    // TODO: textviewdelegate - outlineView.item(atRow: outlineView.selectedRow)
//    func outlineView(
//        _ outlineView: NSOutlineView,
//        selectionIndexesForProposedSelection proposedSelectionIndexes: IndexSet
//    ) -> IndexSet
//    
    
    
    
//    func outlineView(
//        _ outlineView: NSOutlineView,
//        mouseDownInHeaderOf tableColumn: NSTableColumn
//    )
//    {
//        debugPrint("outlineView mouseDownInHeaderOf")
//    }
//    
//    func outlineView(
//        _ outlineView: NSOutlineView,
//        didClick tableColumn: NSTableColumn
//    )
//    {
//        debugPrint("outlineView didClick")
//    }
    
    
    @objc func textViewFrameChanged(sender: Notification)
    {
        debugPrint(sender.name)
    }
}


extension ViewController: NSTextViewDelegate
{
    func textDidChange(_ notification: Notification)
    {
        //let item = outlineView.item(atRow: outlineView.selectedRow)
        //outlineView.row(for: <#T##NSView#>)
        if let textView = notification.object as? NSTextView
        {
            if let manager = textView.textLayoutManager
            //if let manager = textView.layoutManager
            {
                let preChange = testHeight
                let postChange = manager.usageBoundsForTextContainer.height
                debugPrint("textDidChange")
            }
        }
        
        //[aTableView setNeedsDisplayInRect:[aTableView rectOfRow:row]];
        
    }
    
//    func textDidEndEditing(_ notification: Notification)
//    {
//        
//    }
//    
    
    // To monitor the height of the text views, it should suffice to observe the NSViewFrameDidChangeNotification that they will post.
    func textView(
        _ textView: NSTextView,
        shouldChangeTextIn affectedCharRange: NSRange,
        replacementString: String?
    ) -> Bool
    {
        // row counts only open rows
        // TODO: kaotasin suuruse muudatuse
        // peale tühjade ridade eemaldamist
        // ja peaks ka telsti muudatuse salvestama (note content)
        if let newText = replacementString
        {
            for index in newText.indices
            {
                if newText[index].isNewline
                {
                    let row = outlineView.row(for: textView)
                    if let manager = textView.layoutManager, let container = textView.textContainer
                    {
                        //manager.ensureLayout(for: container)
                        let old_height = textView.frame.height
                        let height = manager.usedRect(for: container).size.height
                        
                        if height > old_height
                        {
                            containerHeight = height
                            outlineView.noteHeightOfRows(withIndexesChanged: IndexSet(integer: row))
                        }
                    }
                }
                //print(newText[index], terminator: " ")
            }
        }
        
        //\\\\\\\\\\\\\\\\
        
        if let manager = textView.textLayoutManager
        {
            testHeight = manager.usageBoundsForTextContainer.height
        }
        //\\\\\\\\\\\\\\\\\\
        
        
        
        //let row = outlineView.row(for: textView)
        //let col = outlineView.column(for: textView)
        //let item = outlineView.item(atRow: row)
        
//        if let manager = textView.layoutManager, let container = textView.textContainer
//        {
//            //manager.ensureLayout(for: container)
//            let height = manager.usedRect(for: container).size.height
//        }
        
        //let displayRect = outlineView.rect(ofRow: row)
        //outlineView.setNeedsDisplay(displayRect)
        //outlineView.reloadItem(item)
        //outlineView.usesAutomaticRowHeights = true
        // outlineView.noteHeightOfRows(withIndexesChanged: IndexSet(integer: row))  //noteHeightOfRows(withIndexesChanged indexSet: IndexSet)
        //debugPrint("textview shouldChangeTextIn")
        return true
    }
}
