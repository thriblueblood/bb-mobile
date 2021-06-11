import Foundation
import Firebase


class MyListViewModel: ObservableObject{
    @Published var myList : [Book] = []
    //    @Published var isLoaded : Bool = false
    @Published var myListInString: [String]?
    private var db : Firestore
    private var alreadyFetch : Bool
    
    init(){
        db = Firestore.firestore()
        alreadyFetch = false
    }
    
    public func addToMyList(bookname: String){
        
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
                        self.db.collection("users").document("\(email!)").updateData([
                            "myList": FieldValue.arrayUnion([bookname])
                        ])
                    }
                }
            }
            //            self.isLoaded = false
            print("Adding To my list.")
        }
    }
    func getMyListData(){
        let group = DispatchGroup()
        group.enter()
        if let userId = Auth.auth().currentUser?.uid {
            self.db.collection("users").whereField("id", isEqualTo: "\(userId)").getDocuments() { (document, err) in
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
        DispatchQueue.main.async {
            if let myList = self.myListInString{
                
                self.myList.removeAll()
                
                for name in myList{
                    print("name: ", name)
                    self.db.collection("categories").whereField("title",isEqualTo: name).addSnapshotListener { (snap, err) in
                        if (err != nil){
                            print((err?.localizedDescription)!)
                            return
                        }
                        
                        for i in snap!.documentChanges{
                            
                            let id = i.document.documentID
                            let title = i.document.get("title") as? String
                            print("title:", title!)
                            let author = i.document.get("author") as! String
                            let overview = i.document.get("overview") as! String
                            let url = i.document.get("URL") as! String
                            let pages = i.document.get("pages") as! [String]
                            let categories = i.document.get("category") as! [String]
                            self.myList.append(Book(id: id, name: title ?? "", URL: URL(string:url)!, category: categories, pages: pages, author: author, overview: overview))
                            
                        }
                    }
                }
            }
        }
    }
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
