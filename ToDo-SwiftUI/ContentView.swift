//
//  ContentView.swift
//  ToDo-SwiftUI
//
//  Created by Przemysław Budziszewski on 15/08/2019.
//  Copyright © 2019 Przemysław Budziszewski. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: ToDoItem.getAllToDoItems()) var toDoItems:FetchedResults<ToDoItem>
    @State private var newToDoItem = ""
    
    
    var body: some View {
        NavigationView{
            List {
                Section(header: Text("What's next?")) {
                    HStack{
                        TextField("New item", text: self.$newToDoItem)
                        Button(action: {
                            let toDoItem = ToDoItem(context: self.managedObjectContext)
                            toDoItem.title = self.newToDoItem
                            toDoItem.createdAt = Date()
                            
                            do {
                                try self.managedObjectContext.save()
                            }catch{
                                print(error)
                            }
                            
                            self.newToDoItem = ""
                                
                        }){
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                                .imageScale(.large)
                        }
                    }
                }.font(.headline)
                Section(header: Text("To do's:")) {
                    ForEach(self.toDoItems) {todoItem in
                        ToDoItemView(title: todoItem.title!, createdAt: "\(todoItem.createdAt!)")
                        
                    }.onDelete {IndexSet in
                        let deleteItem = self.toDoItems[IndexSet.first!]
                        self.managedObjectContext.delete(deleteItem)
                        
                        do {
                            try self.managedObjectContext.save()
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("My list"))
            .navigationBarItems(trailing: EditButton())
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
