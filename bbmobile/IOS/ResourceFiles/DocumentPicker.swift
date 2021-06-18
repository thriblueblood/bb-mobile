//
//  DocumentPicker.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 13/6/2564 BE.
//

import SwiftUI
import Foundation
import MobileCoreServices
import FirebaseStorage

//struct DocumentView: View {
//
//    @Binding var file : [URL]
//
//    var body: some View {
//       DocumentPicker(file: file)
//
//    }
//}
    
struct DocumentPicker : UIViewControllerRepresentable{
    
    @Binding var filePath :URL?
    func makeCoordinator() -> DocumentPicker.Coordinator {
        return DocumentPicker.Coordinator(parent1: self)
    }
    
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPicker>) -> UIDocumentPickerViewController{
        let picker = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .open)
        picker.allowsMultipleSelection = false
        picker.delegate = context.coordinator
        return picker
    }
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<DocumentPicker>) {
        
    }
    
    class Coordinator : NSObject, UIDocumentPickerDelegate{
        var parent : DocumentPicker
        
        init(parent1 : DocumentPicker){
            parent = parent1
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            parent.filePath = urls[0]
        }
        
    }
}


