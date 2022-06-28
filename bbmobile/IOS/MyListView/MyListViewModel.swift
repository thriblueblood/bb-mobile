import Foundation
import Firebase


class MyListViewModel: ObservableObject{
    
    @Published var isLoading : Bool = false
    @Published var viewState: AccountState = .loading
    @Published var myList : [Book] = []
    @Published var myListInString: [String]?
    @Published var isMyList : Bool = false
    private var db : Firestore
    
    init(){
        db = Firestore.firestore()
    }
    
    public func checkIsMyList(title : String){
        DispatchQueue.main.async {
            if ((self.myListInString?.contains(title)) == true){
                self.isMyList = true
                self.setState(state: .ready)
                print("My List True")
            }else{
                self.isMyList = false
                self.setState(state: .ready)
                print("My List False")
            }
        }
        
    }
    
    public func switchMyList(title:String){
        self.setState(state: .loading)
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
                            
                            print("Now is in my list, then remove, status:",self.isMyList)
                            self.db.collection("users").document("\(email!)").updateData([
                                "myList": FieldValue.arrayRemove([title])
                            ])
                            self.fetchMyList(title: title)
                        }else{
                            print("Now isn't in my list, then add, status:",self.isMyList)
                            self.myListInString = data["myList"] as? [String]
                            self.db.collection("users").document("\(email!)").updateData([
                                "myList": FieldValue.arrayUnion([title])
                            ])
                            self.fetchMyList(title: title)
                        }
                        
                    }
                }
            }
        }
    }
    
    func fetchMyList(title:String){
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
                            print("Succesfully fetch my list")
                        }
                        group.leave()
                    }
                    group.notify(queue: DispatchQueue.global(qos: .background)){
                        self.checkIsMyList(title: title)
                    }
                }
            }
        }
    }
    
    func getMyListData(){
        let group = DispatchGroup()
        group.enter()
        setState(state: .loading)
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
                            print("my list in string: ", self.myListInString ?? [""]  )
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
                        print(self.myList)
                        print("Successfully appendBook")
                        self.setState(state: .ready)
                        print("State:", self.isLoading)
                    }
                }
            }
        }
    }
    
    private func setState(state:AccountState){
        DispatchQueue.main.async {
            self.viewState = state
            self.isLoading = state == .loading //if state is equal loading then isLoading = true
        }
    }
}


