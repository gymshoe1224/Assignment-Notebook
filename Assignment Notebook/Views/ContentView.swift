//
//  ContentView.swift
//  Assignment Notebook
//
//  Created by Chris Markiewicz on 1/9/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var assignmentList = AssignmentList()
    @State private var showingAddItemView = false
    var body: some View {
            NavigationView {
                List{
                    ForEach(assignmentList.items) { item in
                        HStack(spacing: 0.0) {
                            VStack(alignment: .leading) {
                                Text(item.course)
                                    .font(.headline)
                                Text(item.description)
                            }
                            Spacer()
                            Text(item.dueDate, style: .date)
                        }
                        .listRowBackground(color(course: item.course).opacity(0.5))
                    }
                    .onMove { indices, newOffset in
                        assignmentList.items.move(fromOffsets: indices, toOffset: newOffset)
                    }
                    .onDelete { indexSet in
                        assignmentList.items.remove(atOffsets: indexSet)
                    }
                }
                .sheet(isPresented: $showingAddItemView, content: {
                    AddItemView(assignmentList: assignmentList)
                })
                .scrollContentBackground(.hidden)
                .navigationTitle("Assignments")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                    showingAddItemView = true}) {
                        Image(systemName: "plus")
                })
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
