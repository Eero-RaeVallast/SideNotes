//
//  Document.swift
//  SideNotes
//
//  Created by Eero Mannik on 07.04.2024.
//

import Cocoa

class Document: NSDocument 
{

    var documentContent: String = ""
    var documentURL: URL?
    var viewController: ViewController?
    
    override init() {
        super.init()
        // Add your subclass-specific initialization here.
    }

//    override class var autosavesInPlace: Bool {
//        return true
//    }

    override func makeWindowControllers() 
    {
        // Returns the Storyboard that contains your Document window.
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        let windowController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("Document Window Controller")) as! NSWindowController
        self.addWindowController(windowController)
        
        if documentURL != nil
        {
            windowController.contentViewController?.representedObject = documentURL
        }
        else
        {
            windowController.contentViewController?.representedObject = documentContent
        }
        if let vc = windowController.contentViewController as? ViewController
        {
            viewController = vc
        }
    }

    override func data(ofType typeName: String) throws -> Data {
        // Insert code here to write your document to data of the specified type, throwing an error in case of failure.
        // Alternatively, you could remove this method and override fileWrapper(ofType:), write(to:ofType:), or write(to:ofType:for:originalContentsURL:) instead.
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }
    
//    override func read(from url: URL, ofType typeName: String) throws 
//    {
//        if url.isFileURL
//        {
//            // saata url window controllerisse läbi makeWindowControllers()
//            documentURL = url
//        }
//    }

    override func read(from data: Data, ofType typeName: String) throws 
    {
        if let fileText = String(bytes: data, encoding: .utf8)
        {
            documentContent = fileText
        }
        else
        {
            throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
        }
    }

    //@IBAction
    override func save(_ sender: Any?)
    {
        // NSDocument
        // fileURL
        // fileType
        debugPrint("save")
    }
    
//    - (void)saveToURL:(NSURL *)url
//               ofType:(NSString *)typeName
//     forSaveOperation:(NSSaveOperationType)saveOperation
//    completionHandler:(void (^)(NSError *errorOrNil))completionHandler;
    
    override func write( to url: URL, ofType typeName: String ) throws
    {
        if let text = viewController?.getStringsFromNotes()
        {
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let filename = path.appendingPathComponent("output.txt")
            
            do {
                try text.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
            } catch {
                // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
            }
        }
    }

    override func write(
        to url: URL,
        ofType typeName: String,
        for saveOperation: NSDocument.SaveOperationType,
        originalContentsURL absoluteOriginalContentsURL: URL?
    ) throws
    {
        if let text = viewController?.getStringsFromNotes()
        {
            //fileURL
//            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//            let filename = path.appendingPathComponent("output.txt")
            
            do {
                if let originalURL = absoluteOriginalContentsURL
                {
                    //try text.write(to: originalURL, atomically: true, encoding: String.Encoding.utf8)
                }
            } catch {
                // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
                debugPrint("Viga")
            }
        }
    }
}

