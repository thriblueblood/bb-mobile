//
//  AdminBookDetailViewModel.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 13/6/2564 BE.
//

import Foundation
import Firebase
import FirebaseStorage

class AdminBookDetailViewModel : ObservableObject{
    
    var db = Firestore.firestore()
    var storage = Storage.storage()
    
    func deleteBook(title : String){
        db.collection("test").whereField("title", isEqualTo: title).getDocuments { (result, error) in
            if error == nil{
                print(result!.documents)
                for document in result!.documents{
                    document.reference.delete()
                }
            }
        }
    }
//
//    func deleteFile(coverUrl : String, pdfUrl : String){
//        let storageRef1 = storage.reference(forURL: coverUrl)
//        let storageRed2 = storage.reference(forURL: pdfUrl)
//
//        storageRef1.delete { error in
//            if let error = error {
//                print(error)
//            } else {
//                // File deleted successfully
//            }
//        }
//
//        storageRef1.delete { error in
//            if let error = error {
//                print(error)
//            } else {
//                // File deleted successfully
//            }
//        }
//    }
//
}
