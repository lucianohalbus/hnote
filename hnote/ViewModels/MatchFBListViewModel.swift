//Created by Halbus Development

import Foundation
import SwiftUI

final class MatchFBListViewModel: ObservableObject {
    @Environment(\.modelContext) private var context
    private var repo: FirebaseRepository
    @Published var items: [MatchFBViewModel] = []
    @Published var filterBy: String = ""
    @Published var searchText: String = ""
    
    init() {
        repo = FirebaseRepository()
        getAll()
    }
    
    var matches: [MatchFBViewModel] {
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
                        self.items = fetchedItems.map(MatchFBViewModel.init)
                            //.filter({ self.filterBy.isEmpty ? true : $0.playerOne == self.filterBy })
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
