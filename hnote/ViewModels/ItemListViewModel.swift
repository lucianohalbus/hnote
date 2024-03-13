//Created by Halbus Development

import Foundation

final class ItemListViewModel: ObservableObject {
    private var repo: FirebaseRepository
    @Published var items: [MatchFBViewModel] = []
    @Published var filterBy: String = ""
    @Published var searchText: String = ""
    
    init() {
        repo = FirebaseRepository()
        getAll()
    }
    
    var matchesItem: [MatchFBViewModel] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { $0.playerOne.lowercased().contains(searchText.lowercased())}
        }
    }
    
    func getAll() {
        repo.get { result in
            switch result {
            case .success(let fetchedItems):
                if let fetchedItems = fetchedItems {
                    DispatchQueue.main.async {
                        self.items = fetchedItems.map(MatchFBViewModel.init).filter({ self.filterBy.isEmpty ? true : $0.playerOne == self.filterBy })
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
//    func delete(item: ItemViewModel) {
//        repo.delete(item: Item(id: item.id, name: item.name, quantity: item.quantity, categoryName: item.categoryName, expirationDate: item.expirationDate)) { error in
//            if error == nil {
//                self.getAll()
//            } else {
//                print(error?.localizedDescription ?? "")
//            }
//        }
//    }
}
