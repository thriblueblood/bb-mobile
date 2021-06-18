//
//  AdminBookDetailView.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 3/6/2564 BE.
//

import SwiftUI
import Kingfisher

struct AdminBookDetailView: View {
    var book : Book
    @Binding var showBookDetail : Book?
    @State var showActionSheet : Bool = false
    @State var goToEditView : Bool = false
    @State var showContent : Bool = false
    @ObservedObject private var viewModel = AdminViewModel()
    
    
    private func arrayToString(array : [String]) -> String{
        return array.joined(separator: ",")
    }
    
    private func urlToimage(url : URL)-> Image{
        let imageUrl = URL(string: "\(url)")!
        let imageData = try! Data(contentsOf: imageUrl)
        let image = UIImage(data: imageData)
        
        let image2 = Image(uiImage: image!)
        
        return image2
    }
    
    var genresList : String{
        var l : String = ""
        for i in book.category {
            l += "\(i), "
        }
        return l
    }
    
    var body: some View {
        ZStack{
            Color("SecondaryColor")
                .edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    Button(action: {
                        showBookDetail = nil
                    }, label: {
                        Image(systemName: "arrow.left.circle.fill")
                            .foregroundColor(Color("MainColor"))
                            .font(.system(size:32))
                            .padding(.leading)
                            .padding(.bottom)
                    })
                    Spacer()
                    Button(action: {
                        print(book.category)
                        goToEditView = true
                    }, label: {
                        Image(systemName: "pencil.circle.fill")
                            .foregroundColor(Color("CustomWhite"))
                            .font(.system(size:32))
                            .padding(.trailing)
                            .padding(.bottom)
                    })
                }
                VStack{
                    HStack(alignment:.top){
                        Text("Cover:\t\t")
                            .font(.custom("Lato-Bold", size: 18))
                            .foregroundColor(Color("MainColor"))
                        KFImage(book.URL)
                            .resizable()
                            .frame(width:UIScreen.main.bounds.width/3,height:UIScreen.main.bounds.height/4)
                            .padding(.bottom,4)
                        Spacer()
                    }
                    DetailStack(topic: "Title:\t\t", detail: book.name)
                    DetailStack(topic: "Author:\t", detail: book.author ?? "Unknown")
                    DetailStack(topic: "Genres:\t", detail: genresList)
                    DetailStack(topic: "Overview:", detail: book.overview ?? "Unknown")
                    HStack(alignment:.top){
                        Text("Content:\t")
                            .font(.custom("Lato-Bold", size: 18))
                            .foregroundColor(Color("MainColor"))
                        Button(action: {
                            showContent.toggle()
                        }, label: {
                            Text(showContent == true ? "Hide":"View")
                                .font(.custom("Lato-Regular", size: 18))
                                .foregroundColor(Color("MainColor"))
                            Spacer()
                        })
                        
                    }
                    if showContent == true{
                        PDFKitView(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/bb-mobile-2fa59.appspot.com/o/examPdf.pdf?alt=media&token=6bce7931-c4a8-4c7e-9c00-b25c0462b760") )
                            .padding(.trailing)
                    }
                }.padding(.leading)
                Spacer()
            }
            
            if goToEditView != false {
                AdminAddBookView(mode: .edit, showAddNewBook: $goToEditView, showBookDetail: $showBookDetail,bookName: book.name,image: urlToimage(url: book.URL), title: book.name, author: book.author ?? "", genres: arrayToString(array: book.category), overview: book.overview ?? "", filePath: book.content)
            }
            
        }.edgesIgnoringSafeArea(.bottom)
    }
}

struct AdminBookDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        AdminBookDetailView(book: examBook3, showBookDetail: .constant(nil))
    }
    
}

struct DetailStack: View {
    var topic : String
    var detail : String
    
    var body: some View {
        HStack(alignment:.top){
            Text(topic)
                .font(.custom("Lato-Bold", size: 18))
                .foregroundColor(Color("MainColor"))
            
            Text(detail)
                .font(.custom("Lato-Regular", size: 18))
                .foregroundColor(Color("CustomWhite"))
            Spacer()
        }
    }
}
