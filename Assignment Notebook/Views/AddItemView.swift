//
//  AddItemView.swift
//  Assignment Notebook
//
//  Created by Chris Markiewicz on 1/19/23.
//

import SwiftUI

struct AddItemView: View {
    @ObservedObject var assignmentList: AssignmentList
    @State private var course = ""
    @State private var description = " "
    @State private var dueDate = Date()
    @State private var color = Color.white
    @Environment(\.presentationMode) var presentationMode
    static let courses = ["", "Math", "English", "Science", "Social Studies", "Computer Science"]
    var body: some View {
        ZStack {
            NavigationView {
                Form {
                    Group {
                        Picker("Course", selection: $course) {
                            ForEach(Self.courses, id: \.self) { course in
                                Text(course)
                            }
                        }
                        .onChange(of: course) { newValue in
                            color = color(course: course)
                        }
                        TextField("Description", text: $description)
                        DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                    }
                    .listRowBackground(color.opacity(0.5).edgesIgnoringSafeArea(.all))
                }
                .navigationTitle("Add New Assignment")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: Button("Save") {
                    if course.count > 0 && description.count > 0 {
                        let item = AssignmentItem(id: UUID(), course: course, description: description, dueDate: dueDate)
                        assignmentList.items.append(item)
                        presentationMode.wrappedValue.dismiss()
                    }
                })
            }
        }
    }
    func color(course: String) -> Color {
        switch course{
        case "Math":
            return Color.red
        case "English":
            return Color.brown
        case "Science":
            return Color.green
        case "Social Studies":
            return Color.blue
        case "Computer Science":
            return Color.purple
        default:
            return Color.white
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(assignmentList: AssignmentList())
    }
}
