import Foundation
import Firebase


class MyListViewModel: ObservableObject{
    @Published var myList : [Book] = []
    @Published var myListInString: [String]?
    @Published var isMyList : Bool = false
    private var db : Firestore
    
    init(){
        db = Firestore.firestore()
    }
    
//    public func deleteMyList(bookname:String){
//        let userID = Auth.auth().currentUser!.uid
//        db.collection("users").whereField("id", isEqualTo: "\(userID)").getDocuments { (document, err) in
//            if let err = err{
//                print(err.localizedDescription)
//            }
//            else{
//                if let document = document?.documents{
//                    for doc in document{
//                        let data = doc.data()
//                        let email = data["email"] as? String
////                        self.myListInString = data["myList"] as? [String]
//                        self.db.collection("users").document("\(email!)").updateData([
//                            "myList": FieldValue.arrayRemove([bookname])
//                        ])
//                    }
//                }
//            }
//        }
//    }
    
    public func checkIsMyList(title : String){
        DispatchQueue.main.async {
            if ((self.myListInString?.contains(title)) == true){
                self.isMyList = true
                print("My List True")
            }else{
                self.isMyList = false
                print("My List False")
            }
        }

    }
    
    public func switchMyList(title:String){
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
                        if self.isMyList{
                            self.db.collection("users").document("\(email!)").updateData([
                                "myList": FieldValue.arrayRemove([title])
                            ])
                            let group = DispatchGroup()
                            group.enter()
                            self.getMyListData()
                            group.leave()
                            group.notify(queue: DispatchQueue.global(qos: .background)){
                                self.checkIsMyList(title: title)
                            }
                        }else{
                            
                            self.myListInString = data["myList"] as? [String]
                            self.db.collection("users").document("\(email!)").updateData([
                                "myList": FieldValue.arrayUnion([title])
                            ])
                            print("what's up")
                            let group = DispatchGroup()
                            group.enter()
                            print("get myList")
                            self.getMyListData()
                            group.leave()
                            group.notify(queue: DispatchQueue.global(qos: .background)){
                                self.checkIsMyList(title: title)
                            }
                        }
 
                    }
                }
            }
        }
    }
    
//    public func addToMyList(bookname: String){
//        let userID = Auth.auth().currentUser!.uid
//        db.collection("users").whereField("id", isEqualTo: "\(userID)").getDocuments() { (document, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            }
//            else{
//                if let snapshotDocuments = document?.documents {
//                    for doc in snapshotDocuments {
//                        let data = doc.data()
//                        let email = data["email"] as? String
//                        self.myListInString = data["myList"] as? [String]
//                        self.db.collection("users").document("\(email!)").updateData([
//                            "myList": FieldValue.arrayUnion([bookname])
//                        ])
//                    }
//                }
//            }
//            //            self.isLoaded = false
//            print("Adding To my list.")
//        }
//    }
    
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
                            let categories = i.document.get("category") as! [String]
                            self.myList.append(Book(id: id, name: title ?? "", URL: URL(string:url)!, category: categories, author: author, overview: overview))
                            
                        }
                    }
                }
            }
        }
    }
}
