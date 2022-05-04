//
//  ContentView.swift
//  ToDo
//
//  Created by 杜赛 on 2022/5/3.
//

import SwiftUI

struct ContentView: View {
  @State private var todoList = [
    ToDoItem(name: "Apple"),
    ToDoItem(name: "Pear"),
    ToDoItem(name: "Tomato")
  ]
  
  @State private var newName: String = ""
  
  var body: some View {
    VStack {
      HStack {
        TextField("输入新事项", text: $newName)
        Button("确认") {
          let newItem = ToDoItem(name: newName)
          todoList.append(newItem)
          newName = ""
        }
      }
      .padding()
      
      List {
        ForEach(todoList) { item in
          HStack {
            Toggle("", isOn: item.$isOn)
              .toggleStyle(.checkbox)
            Text(item.name)

          }
        }
      }
    }
  }
}

struct ToDoItem: Identifiable {
  let id    = UUID()
  @Binding var isOn: Bool
  let name: String
  
  init(name: String) {
    self.name = name
    self._isOn = Binding.constant(true)
  }
}



struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
