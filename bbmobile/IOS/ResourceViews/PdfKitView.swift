//
//  PdfKitView.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 11/6/2564 BE.
//

import Foundation
import SwiftUI
import PDFKit

struct PDFKitView : UIViewRepresentable {
    
    var url: URL?
    
    func makeUIView(context: Context) -> UIView {
        let pdfView = PDFView()
        pdfView.autoScales = true

        if let url = url {
            pdfView.document = PDFDocument(url: url)
        }
        
        return pdfView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // Empty
    }
    
}
