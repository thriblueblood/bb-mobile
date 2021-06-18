//
//  AdminAddBookViewModel.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 11/6/2564 BE.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestoreSwift

enum LoadingState{
    case idle
    case loading
    case failure
    case success
}

class AdminAddBookViewModel : ObservableObject{
    
    @Published var loadinState : LoadingState = .idle
    let storage = Storage.storage()
    let db = Firestore.firestore()
    var genresArray : [String] = []
    
    func divGenres(genres: String) -> [String]{
        genresArray = genres.components(separatedBy: ",")
        return genresArray
    }
    
    func savebook(title : String, author: String, genres : [String], overview : String , coverURL : URL){
        var ref: DocumentReference? = nil
        ref = db.collection("categories").addDocument(data: [
            "title": "\(title)",
            "author": "\(author)",
            "category": genres,
            "overview" : "\(overview)",
            "URL" : "\(coverURL.absoluteString)"
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    func editBook(title : String, author: String, genres : [String], overview : String){
        db.collection("categories").whereField("title", isEqualTo: title).getDocuments { (result, error) in
            if error == nil{
               print("Edit book")
                for document in result!.documents{
                    self.db.collection("categories").document(document.documentID).setData([
                        "title": "\(title)",
                        "author": "\(author)",
                        "category": genres,
                        "overview" : "\(overview)",
                    ], merge: true)
                }
            }
        }
    }
    
    func savePdf(title : String, url : URL){
        db.collection("categories").whereField("title", isEqualTo: title).getDocuments { (result, error) in
            if error == nil{
                print(result!.documents)
                for document in result!.documents{
                    self.db.collection("categories").document(document.documentID).setData([ "content": "\(url.absoluteString)" ], merge: true)
                }
            }
        }
    }
    
    func uploadPhoto(data: Data, completion: @escaping (URL?) -> Void){
        let storageRef = storage.reference()
        let imageName = UUID().uuidString
        let photoRef = storageRef.child("images/\(imageName).png")
        
        photoRef.putData(data, metadata: nil){ metadata, error in
            photoRef.downloadURL { (url, error) in
                if let error = error {
                    print(error.localizedDescription)
                }else{
                    completion(url)
                }
            }
        }
    }
    
    func uploadPdf(url : URL, completion: @escaping (URL?) -> Void){
        let storageRef = storage.reference()
        let fileName = UUID().uuidString
        let fileRef = storageRef.child("content/\(fileName)")
        
        fileRef.putFile(from: url, metadata: nil) { (metadata, error) in
            fileRef.downloadURL { (url, error) in
                if let error = error {
                    print(error.localizedDescription)
                }else{
                    completion(url)
                }
            }
        }
    }
    
    func deleteBook(title : String){
        db.collection("categories").whereField("title", isEqualTo: title).getDocuments { (result, error) in
            if error == nil{
                print(result!.documents)
                for document in result!.documents{
                    document.reference.delete()
                }
            }
        }
    }
    
}
