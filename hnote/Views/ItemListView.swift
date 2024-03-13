//Created by Halbus Development

import SwiftUI

struct ItemListView: View {
    @State private var isPresented: Bool = false
    @ObservedObject private var itemListVM = ItemListViewModel()
    
    
    var body: some View {
        NavigationView {
            VStack {
                // filter buttons
              //  filterButton
                
                // pantryList
                pantryList
                    .sheet(isPresented: $isPresented) {
                        itemListVM.getAll()
                    } content: {
                        Text("AddItemView()")
                    }

            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isPresented = true }) {
                        Image(systemName: "plus.circle")
                            .font(.title)
                    }
                }
            }
        }
        .searchable(text: $itemListVM.searchText)
    }
    
//    @ViewBuilder
//    private var filterButton: some View {
//        HStack(spacing: 20) {
//            
//            Button(action: {
//                itemListVM.filterBy = CategoryEnum.all.rawValue
//                itemListVM.getAll()
//            }) {
//                Text(CategoryEnum.all.desc())
//                    .foregroundStyle(itemListVM.filterBy.isEmpty ? Color.orange : Color.white)
//                    .padding()
//                    .background(itemListVM.filterBy.isEmpty ? Color.white : Color.orange)
//                    .clipShape(Circle())
//                    .clipped()
//                    .shadow(radius: 5)
//            }
//            
//            Button(action: {
//                itemListVM.filterBy = CategoryEnum.freezer.rawValue
//                itemListVM.getAll()
//            }) {
//                Image(systemName: "thermometer.snowflake")
//                    .foregroundStyle(itemListVM.filterBy == CategoryEnum.freezer.rawValue ? Color.blue : Color.white)
//                    .padding()
//                    .background(itemListVM.filterBy == CategoryEnum.freezer.rawValue ? Color.white : Color.blue)
//                    .clipShape(Circle())
//                    .clipped()
//                    .shadow(radius: 5)
//            }
//            
//            Button(action: {
//                itemListVM.filterBy = CategoryEnum.fridge.rawValue
//                itemListVM.getAll()
//            }) {
//                Image(systemName: "square.3.stack.3d.bottom.filled")
//                    .foregroundStyle(itemListVM.filterBy == CategoryEnum.fridge.rawValue ? Color.pink : Color.white)
//                    .padding()
//                    .background(itemListVM.filterBy == CategoryEnum.fridge.rawValue ? Color.white : Color.pink)
//                    .clipShape(Circle())
//                    .clipped()
//                    .shadow(radius: 5)
//
//            }
//            
//            Button(action: {
//                itemListVM.filterBy = CategoryEnum.dryPantry.rawValue
//                itemListVM.getAll()
//            }) {
//                Image(systemName: "bag.fill")
//                    .foregroundStyle(itemListVM.filterBy == CategoryEnum.dryPantry.rawValue ? Color.green : Color.white)
//                    .padding()
//                    .background(itemListVM.filterBy == CategoryEnum.dryPantry.rawValue ? Color.white : Color.green)
//                    .clipShape(Circle())
//                    .clipped()
//                    .shadow(radius: 5)
//
//            }
//        }
//        .font(.title3)
//    }
    
    @ViewBuilder
    private var pantryList: some View {
        List {
            ForEach(itemListVM.matchesItem, id: \.id) { item in
              //  NavigationLink(destination: UpdateItemView(itemVM: item)) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text(item.playerOne)
                            .font(.headline)
                        
                        Text(item.playerTwo)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        Text(item.myDate.formatted(date: .abbreviated, time: .omitted))
                            .italic()
                            .font(.subheadline)
                            .foregroundStyle(.secondary)

                    }
               // }
            }
//            .onDelete { indexSet in
//                indexSet.forEach { idx in
//                    let item = itemListVM.items[idx]
//                    itemListVM.delete(item: item)
//                }
//            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Pantry")
        .onAppear {
            itemListVM.getAll()
        }
    }
    
    
}

#Preview {
    ItemListView()
}
