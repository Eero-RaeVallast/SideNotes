//
//  File.swift
//  SideNotes
//
//  Created by Eero Mannik on 08.04.2024.
//

import Foundation


struct Notes
{
    var notes = [Note]()
    var totalNotes: Int { get { return notes.count }}
    private var nextNoteID = 1
    
    /**
     It returns the current Collection ID and increases
     it by 1 to the next value.
    */
    mutating func getNoteID() -> Int {
        nextNoteID += 1
        return nextNoteID - 1
    }
}

class Note
{
    var id: Int?
    var text: String?

    init(withTitle title: String, id: Int)
    {
        self.text = title
        self.id = id
    }
}
