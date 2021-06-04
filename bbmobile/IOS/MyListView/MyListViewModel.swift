import Foundation
import Firebase


class MyListViewModel: ObservableObject{
    @Published var myList = [Book]()
    @Published var isLoading : Bool = false
    @Published var viewState: MyListState = .loading
    var myListInString: [String]?
    
    
    init(){
        getMyListData()
    }
    
    public func addToMyList(bookname: String){
        let db = Firestore.firestore()
        let userID = Auth.auth().currentUser!.uid
        db.collection("users").whereField("id", isEqualTo: "\(userID)").getDocuments() { (document, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            }
            else{
                if let snapshotDocuments = document?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        let email = data["email"] as? String
                        self.myListInString = data["myList"] as? [String]
                        db.collection("users").document("\(email!)").updateData([
                            "myList": FieldValue.arrayUnion([bookname])
                        ])
                    }
                }
            }
            self.setState(state: .loading)
            print("To loading state...")
            print("Adding To my list.")
        }
    }
    
    func getMyListData(){
        let group = DispatchGroup()
        group.enter()
        if let userId = Auth.auth().currentUser?.uid {
            let db = Firestore.firestore()
            db.collection("users").whereField("id", isEqualTo: "\(userId)").getDocuments() { (document, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                }
                else{
                    if let snapshotDocuments = document?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            self.myListInString = data["myList"] as? [String]
                        }
                    group.leave()
                    }
                    group.notify(queue: DispatchQueue.global(qos: .background)){
                            self.displayData()
                        }
                }
            }
        }
    }
    
    func displayData(){
        if let myList = myListInString{
            let group = DispatchGroup()
            group.enter()
            for name in myList{
                let db = Firestore.firestore()
                db.collection("categories").whereField("title",isEqualTo: name).addSnapshotListener { (snap, err) in
                    if (err != nil){
                        print((err?.localizedDescription)!)
                        return
                    }
                    for i in snap!.documentChanges{
                        let id = i.document.documentID
                        let name = i.document.get("title") as? String
                        let author = i.document.get("author") as! String
                        let overview = i.document.get("overview") as! String
                        let url = i.document.get("URL") as! String
                        let pages = i.document.get("pages") as! [String]
                        let categories = i.document.get("category") as! [String]
                        self.myList.append(Book(id: id, name: name ?? "", URL: URL(string:url)!, category: categories, pages: pages, author: author, overview: overview))
                    }
                }
            }
            group.leave()
            group.notify(queue: DispatchQueue.global(qos: .background)){
                self.setState(state: .ready)
                }
           
        }
    }
    
    private func setState(state:MyListState){
        DispatchQueue.main.async {
            self.viewState = state
            self.isLoading = state == .loading //if state is equal loading then isLoading = true
        }
    }
}

enum MyListState{
    case loading
    case ready
}

//=================================================================================//



////
////  MyListViewModel.swift
////  bbmobile
////
////  Created by Sathienpong Polachan on 26/4/2564 BE.
////
//
//import Foundation
//import Firebase
//
//
//class MyListViewModel: ObservableObject{
//    @Published var myList = [Book]()
//    @Published var dataIsLoaded : Bool = false
//    var myListInString: [String]?
//
//    init(){
//        getMyListData()
//    }
//
//    public func addToMyList(bookname: String){
//        let group = DispatchGroup()
//        group.enter()
//        dataIsLoaded = false
//        print("Data is load = ", dataIsLoaded)
//        let db = Firestore.firestore()
//        let userID = Auth.auth().currentUser!.uid
//        db.collection("users").whereField("id", isEqualTo: "\(userID)").getDocuments() { (document, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            }
//            else{
//                if let snapshotDocuments = document?.documents {
//
//                    for doc in snapshotDocuments {
//                        let data = doc.data()
//                        let email = data["email"] as? String
//
//                        self.myListInString = data["myList"] as? [String]
//
//                        db.collection("users").document("\(email!)").updateData([
//                            "myList": FieldValue.arrayUnion([bookname])
//                        ])
//                    }
//                }
//                group.leave()
//                group.notify(queue: DispatchQueue.global(qos: .background)){
//                    self.getMyListData()
//                }
//            }
//        }
//    }
//
//    func getMyListData(){
//        if let userIDOptional = Auth.auth().currentUser?.uid {
//            let group = DispatchGroup()
//            group.enter()
//            let db = Firestore.firestore()
//            db.collection("users").whereField("id", isEqualTo: "\(userIDOptional)").getDocuments() { (document, err) in
//                if let err = err {
//                    print("Error getting documents: \(err)")
//                }
//                else{
//                    if let snapshotDocuments = document?.documents {
//                        for doc in snapshotDocuments {
//                            let data = doc.data()
//                            self.myListInString = data["myList"] as? [String]
//                        }
//                        print("Received Object")
//                    }
//                    group.leave()
//                }
//                group.notify(queue: DispatchQueue.global(qos: .background)){
//                    self.displayData();
//                }
//            }
//        }
//
//
//    }
//
//    func displayData(){
//        DispatchQueue.main.async {
//            print("Enter Display Data")
//            print("MyList in string before loop :", self.myListInString ?? [])
//            for name in self.myListInString ?? [] {
//                print("Name", name)
//                let db = Firestore.firestore()
//                db.collection("categories").whereField("title",isEqualTo: name).addSnapshotListener { (snap, err) in
//                    if (err != nil){
//                        print((err?.localizedDescription)!)
//                        return
//                    }
//                    for i in snap!.documentChanges{
//                        let id = i.document.documentID
//                        let name = i.document.get("title") as? String
//                        let author = i.document.get("author") as! String
//                        let overview = i.document.get("overview") as! String
//                        let url = i.document.get("URL") as! String
//                        let pages = i.document.get("pages") as! [String]
//                        let categories = i.document.get("category") as! [String]
//                        self.myList.append(Book(id: id, name: name ?? "", URL: URL(string:url)!, category: categories, pages: pages, author: author, overview: overview))
//                    }
//                }
//            }
//            self.dataIsLoaded = true
//
//        }
//
//    }
//}
