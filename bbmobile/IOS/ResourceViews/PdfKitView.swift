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
    let pdfView = PDFView()

    func makeUIView(context: Context) -> UIView {
        
        pdfView.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.2666666667, blue: 0.2941176471, alpha: 1)
        pdfView.displayMode = .singlePage
        pdfView.displayDirection = .vertical
        pdfView.usePageViewController(true, withViewOptions: [:])
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
