//
//  SideNotesTests.swift
//  SideNotesTests
//
//  Created by Eero Mannik on 13.04.2024.
//

import XCTest

final class SideNotesTests: XCTestCase 
{

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws 
    {
        let märkused = """
        ## Esimene märkus
        # creationDate 12/04/2023
        # modificationDate 14/04/2023
        # tags "movie actor "
        Vaatasin filmi Alain Deloniga peaosas.
        ## Teine märkus
        # creationDate 12/04/2023
        # modificationDate 14/04/2023
        Vaatasin filmi Alain Deloniga nimiosas.
        """
        
        let notes = NoteContent.getNoteContent(text: märkused)
        for note in notes
        {
            print(note.description)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
