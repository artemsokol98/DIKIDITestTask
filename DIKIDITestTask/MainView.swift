//
//  ContentView.swift
//  DIKIDITestTask
//
//  Created by Артем Соколовский on 26.12.2022.
//

import SwiftUI
import CoreData



struct MainView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @ObservedObject private var viewModel = MainViewModel()
    

    var body: some View {
        
         
        NavigationView {
            List {
                CategoryCell(
                    link: ($viewModel.link.wrappedValue) ?? "Unknowned",
                    name: (viewModel.data?.data?.blocks?.catalog?[0].name) ?? "Unknowned",
                    address: (viewModel.data?.data?.blocks?.catalog?[0].street) ?? "Unknowned"
                )
                CategoryCell(
                    link: (viewModel.data?.data?.blocks?.catalog?[1].image?.origin) ?? "Unknowned",
                    name: (viewModel.data?.data?.blocks?.catalog?[1].name) ?? "Unknowned",
                    address: (viewModel.data?.data?.blocks?.catalog?[1].street) ?? "Unknowned"
                )
                /*
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                    } label: {
                        Text(item.timestamp!, formatter: itemFormatter)
                    }
                }
                .onDelete(perform: deleteItems)
                 */
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Download", action: {
                        viewModel.downloadingData()
                    })
                        
                    /*
                    Button(action: download) {
                        Label("Download", systemImage: "network")
                    }
                     */
                }
            }
            Text("Select an item")
        }
    }
    
    private func download() {
        NetworkManager.shared.fetchData(urlString: "https://api-beauty.test.dikidi.ru/home/info?") { result in
            switch result {
            case .success(let data): print(data)
            case .failure(let error): print(error)
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
*/
