//
//  ContentView.swift
//  ToDo
//
//  Created by 杜赛 on 2022/5/3.
//

import SwiftUI

struct ContentView: View {
  @StateObject private var viewModel = ToDoViewModel()
  
  @State private var newName: String = ""
  
  var body: some View {
    VStack {
      HStack {
        TextField("输入新事项", text: $newName)
        Button("确认") {
          let newItem = ToDoItem(name: newName)
          viewModel.append(newItem)
          newName = ""
        }
      }
      .padding()
      
      List {
        ForEach(viewModel.todoList) { item in
          HStack {
            Text(item.name)
              .foregroundColor(item.isOn ? .primary : .gray)
            
            Spacer()
            
            Group {
              if item.isOn {
                Image(systemName: "circle")

              }
              else {
                Image(systemName: "checkmark.circle.fill")
              }
            }
              .foregroundColor(.blue)
              .onTapGesture {
                viewModel.toggle(item)
              }
          }
        }
      }
    }
  }
}

class ToDoViewModel: ObservableObject {
  @Published private(set) var todoList: [ToDoItem]
  
  init() {
    self.todoList = [
      ToDoItem(name: "Apple"),
      ToDoItem(name: "Pear"),
      ToDoItem(name: "Tomato")
    ]
  }
  
  func append(_ item: ToDoItem) {
    todoList.append(item)
  }
  
  func toggle(_ item: ToDoItem) {
    if let index = todoList.firstIndex(where: {$0.id == item.id}) {
      todoList[index].isOn.toggle()
    }
  }
}

struct ToDoItem: Identifiable {
  let id    = UUID()
  var isOn  = true
  let name: String
}



struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
