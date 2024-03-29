//Created by Halbus Development

//import Foundation
//import Firebase
//import FirebaseFirestoreSwift
//
//final class FirebaseRepository {
//    private var db: Firestore
//    
//    init() {
//        db = Firestore.firestore()
//    }
//    
//    func getPantryCategories(completion: @escaping(Result<[Category]?, Error>) -> Void ) {
//        db.collection(Constants.pantryCategory)
//        .getDocuments { snapshot, error in
//            guard let snapshot = snapshot, error == nil else {
//                completion(.failure(error ?? NSError(domain: "No category found.", code: 101, userInfo: nil)))
//                return
//            }
//            
//            let categories: [Category]? = snapshot.documents.compactMap { document in
//                var category = try? document.data(as: Category.self)
//                if category != nil {
//                    category!.id = document.documentID
//                }
//                return category
//            }
//            completion(.success(categories))
//        }
//    }
    
//    func add(item: Item, completion: @escaping(Result<Item?, Error>) -> Void) {
//        do {
//            let ref = try db.collection(Constants.pantry)
//            .addDocument(from: item)
//            
//            ref.getDocument { snapshot, error in
//                guard let snapshot = snapshot, error == nil else {
//                    completion(.failure(error ?? NSError(domain: "snapshot is nil", code: 102, userInfo: nil)))
//                    return
//                }
//                
//                let item = try? snapshot.data(as: Item.self)
//                completion(.success(item))
//            }
//        } catch let error {
//            completion(.failure(error))
//        }
//    }
//    
//    func get(completion: @escaping (Result<[Item]?, Error>) -> Void) {
//        db.collection(Constants.pantry)
//        .getDocuments { snapshot, error in
//            guard let snapshot = snapshot, error == nil else {
//                completion(.failure(error ?? NSError(domain: "Fatch for items failed", code: 103, userInfo: nil)))
//                return
//            }
//            
//            let items: [Item]? = snapshot.documents.compactMap { document in
//                var item = try? document.data(as: Item.self)
//                if item != nil {
//                    item!.id = document.documentID
//                }
//                
//                return item
//            }
//            completion(.success(items))
//        }
//    }
//    
//    func update(item: Item, completion: @escaping(Result<Bool, Error>) -> Void) {
//        guard let itemId = item.id else {
//            completion(.failure(NSError(domain: "Invalid item id", code:  104, userInfo: nil)))
//            return
//        }
//        
//        do {
//            try db.collection(Constants.pantry)
//            .document(itemId)
//            .setData(from: item)
//            completion(.success(true))
//        } catch let error {
//            completion(.failure(error))
//        }
//    }
//    
//    func delete(item: Item, completion: @escaping(Error?) -> Void) {
//        
//        guard let itemId: String = item.id else {
//            completion(NSError(domain: "Item id is null", code:  105, userInfo: nil))
//            return
//        }
//        
//        db.collection(Constants.pantry).document(itemId).delete { error in
//            if error == nil {
//                completion(nil)
//            }
//            completion(error)
//        }
//    }
    
// }
