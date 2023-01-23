//
//  AssignmentItem.swift
//  Assignment Notebook
//
//  Created by Chris Markiewicz on 1/13/23.
//

import Foundation

struct AssignmentItem: Identifiable, Codable {
    var id = UUID()
    var course = ""
    var description = ""
    var dueDate = Date()
}
