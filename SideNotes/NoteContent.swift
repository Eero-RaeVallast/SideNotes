//
//  NoteContent.swift
//  SideNotes
//
//  Created by Eero Mannik on 13.04.2024.
//
// TODO: Use real dates
import Foundation

struct DocumentData
{
    enum Content
    {
        case header, text
    }
    
    var type: Content
    var note: NoteContent
    
}

class NoteContent
{
    var creationDate: Date
    var modificationDate: Date
    var tags:Set<String>
    var text: String
    var header: String
    
    init()
    {
        creationDate = Date()
        modificationDate = Date()
        tags = []
        text = ""
        header = ""
    }
    
    init(creationDate: Date, modificationDate: Date, tags: Set<String>, text: String, header: String)
    {
        self.creationDate = creationDate
        self.modificationDate = modificationDate
        self.tags = tags
        self.text = text //
        while self.text.last?.isWhitespace == true
        {
            self.text = String(self.text.dropLast())
        }
        self.header = header
//        extension StringProtocol {
//
//            @inline(__always)
//            var trailingSpacesTrimmed: Self.SubSequence {
//                var view = self[...]
//
//                while view.last?.isWhitespace == true {
//                    view = view.dropLast()
//                }
//
//                return view
//            }
//        }
    }
    
    var description: String
    {
        header + "\n" + text +  "tags: " + tags.joined(separator: ".") + "\n" + creationDate.description + "\n" + modificationDate.description
    }
    
    func stringRepresentation() -> String
    {
        var stringRepresentation: String = ""
        if !text.isEmpty
        {
            stringRepresentation = "\n## " + text +
            "\n# tags: \"" + tags.joined(separator: " ") +
            "\"\n# creationDate: " + creationTime() +
            "\n# modificationDate" + modificationTime()
        }
        
        return stringRepresentation
    }
    
    func modificationTime() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "dd/mm/yyyy"
        //dateFormatter.setLocalizedDateFormatFromTemplate("dd/mm/yyyy")
        
        return dateFormatter.string(from: modificationDate)
    }
    func creationTime() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "dd/mm/yyyy"
        //dateFormatter.setLocalizedDateFormatFromTemplate("dd/mm/yyyy")
        
        return dateFormatter.string(from: creationDate)
    }
    
    
    // Parse string into NoteContent
    // let parts = split(separator: "@")
    // kui ei saa kuupäeva trükin terve rea
    static func getNoteContent( text: String )->[NoteContent]
    {
        var content:[NoteContent] = [NoteContent]()
        // DateFormatter
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        //dateFormatter.setLocalizedDateFormatFromTemplate("dd/mm/yyyy")
        
        //let string = "01/02/2016"
        dateFormatter.dateFormat = "dd/mm/yyyy"
        
//        if let date = dateFormatter.date(from: string)
//        {
//            print(dateFormatter.string(from: date))
//        }
        // DateFormatter
        
        let rawNotes:[Substring] = text.split(separator: "##")
        
        for substring in rawNotes
        {
            var creationDate: Date = Date()
            var modificationDate: Date = Date()
            var tags:Set<String> = []
            var text: String = ""
            var header: String = ""
            let dateRegex = "\\d{2}/\\d{2}/\\d{4}"
            
            substring.enumerateLines
            { line, stop in
                let trimmedLine = line.trimmingCharacters(in: .whitespacesAndNewlines)
                
                if trimmedLine.firstIndex(of: "#") == trimmedLine.startIndex
                {
                    if trimmedLine.contains("creationDate")
                    {
                        if let range = trimmedLine.range(of:dateRegex, options: .regularExpression)
                        {
                            let dateString = trimmedLine[range]
                            if let date = dateFormatter.date(from: String(dateString))
                            {
                                creationDate = date
                            }
                        }
                    }
                    else if trimmedLine.contains("modificationDate")
                    {
                        if let range = trimmedLine.range(of:dateRegex, options: .regularExpression)
                        {
                            let dateString = trimmedLine[range]
                            if let date = dateFormatter.date(from: String(dateString))
                            {
                                modificationDate = date
                            }
                        }
                    }
                    else if trimmedLine.contains("tags")
                    {
                        if let r1 = trimmedLine.range(of: "\""),
                           let r2 = trimmedLine.range(of: "\"", range: r1.upperBound..<trimmedLine.endIndex)
                        {
                            let tagsRange = r1.upperBound..<r2.lowerBound
                            let tagsSubString: Substring = trimmedLine[tagsRange]
                            let tagsArray:[Substring] = tagsSubString.split(separator: " ")
                            for tag in tagsArray
                            {
                                tags.insert(String(tag))
                            }
                        }
                    }
                }
                    else // no #
                {
                        // TODO: viimasel real ekstra uus rida
                    if !trimmedLine.isEmpty
                    {
                        if header.isEmpty
                        {
                            header = trimmedLine
                        }
                        text.append(trimmedLine + "\n")
                    }
                }
            }
            if !text.isEmpty
            {
                let noteContent: NoteContent = NoteContent(creationDate: creationDate, modificationDate: modificationDate, tags: tags, text: text, header: header)
                content.append(noteContent)
            }
        }
        return content
    }
}
