//
//  AddBookView.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 4/6/2564 BE.
//

import SwiftUI

enum SourceType {
    case photoLibrary
    case camera
}

enum Mode {
    case add
    case edit
}

struct AdminAddBookView: View {
    
    var mode : Mode = .add
    @Binding var showAddNewBook : Bool
    @Binding var showBookDetail : Book?
    
    var bookName : String?
    @State var image: Image? = nil
    @State var title : String = ""
    @State var author : String = ""
    @State var genres : String = ""
    @State var overview : String = ""
    @State  var filePath : URL? = nil
    
    @State private var showActionSheet : Bool = false
    @State private var showImagePicker : Bool = false
    @State private var sourceType: SourceType = .photoLibrary
    
    @State private var originalImage: UIImage? = nil
    @State private var showDocumentPicker : Bool = false
    
    @State var deleteFileClicked : Bool = false
    @State var deleteCoverClicked : Bool = false
    
    
    @ObservedObject private var viewModel = AdminAddBookViewModel()
    
    private func uploadImage(){
        DispatchQueue.main.async {
            viewModel.loadinState = .loading
        }
        if let originalImage = originalImage {
            if let data = originalImage.pngData(){
                viewModel.uploadPhoto(data: data) { (url) in
                    if let url = url{
                        print("Image url :" ,url)
                        viewModel.savebook(title: title, author: author, genres: viewModel.divGenres(genres: genres), overview: overview, coverURL: url)
                    }
                }
            }
        }
    }
    
    private func uploadFile(){
        if let filePath = filePath{
            viewModel.uploadPdf(url: filePath) { (url) in
                if let url = url{
                    print("pdf : ", url)
                    viewModel.savePdf(title: title, url: url)
                    DispatchQueue.main.async {
                        viewModel.loadinState = .success
                    }
                }else{
                    DispatchQueue.main.async {
                        viewModel.loadinState = .failure
                    }
                }
            }
        }
    }
    
    
    var body: some View {
        ZStack {
            Color("MainColor")
                .edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    Button(action: {
                        showAddNewBook = false
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color("SecondaryColor"))
                            .font(.system(size:32))
                    }).padding(.leading)
                    Spacer()
                }
                //Top Section
                if image != nil{
                    image?.resizable()                                .frame(width:UIScreen.main.bounds.width/3,height:UIScreen.main.bounds.height/4.5)
                        .overlay(Group{
                            ZStack{
                                Button(action: {
                                    image = nil
                                    deleteCoverClicked = true
                                }, label: {
                                    Image(systemName: "minus.circle.fill")
                                        .foregroundColor(.red)
                                        .font(.system(size: 24))
                                })
                            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        })
                    
                }else{
                    Button(action: {
                        showActionSheet = true
                        deleteCoverClicked = true
                    }, label: {
                        ZStack{
                            Rectangle()
                                .fill(Color.gray)
                                .frame(width:UIScreen.main.bounds.width/3,height:UIScreen.main.bounds.height/4.5)
                            VStack{
                                HStack{
                                    Image(systemName: "arrow.down.circle.fill")
                                    Text("Upload cover here")
                                }
                                .font(.custom("Lato-Regular", size: 12))
                                .foregroundColor(Color("CustomBlack"))
                            }
                        }
                        
                    }).actionSheet(isPresented: $showActionSheet, content: {
                        ActionSheet(title: Text("Select the cover's image"), message: nil, buttons: [
                            .default(Text("From Photo Library")){
                                showImagePicker = true
                                sourceType = .photoLibrary
                            }, .cancel()
                        ])
                    })
                    .sheet(isPresented: $showImagePicker, content: {
                        PhotoCaptureView(showImagePicker: $showImagePicker, image: $image, originalImage: $originalImage, sourceType: sourceType)
                    })
                }
                //Bottom Section
                ZStack{
                    VStack(alignment: .leading){
                        Text(mode == .add ? "Add new book" : "Edit a book")
                            .font(.custom("Lato-Bold", size: 30))
                            .foregroundColor(Color("MainColor"))
                            .frame(maxWidth:.infinity, alignment: .leading)
                            .padding(.top,25)
                        TextField("Title name", text: $title)
                        TextField("Author", text: $author)
                        TextField("Genres", text: $genres)
                        HStack {
                            Text("Divide genres using comma( , )")
                                .font(.custom("Lato-Bold", size: 12))
                                .foregroundColor(Color("MainColor"))
                            Spacer()
                        }
                        TextField("Description", text: $overview)
                        if filePath != nil{
                            HStack{
                                Image(systemName: "checkmark")
                                Text("Succesfully.")
                                Button(action: {
                                    filePath = nil
                                    deleteFileClicked = true
                                }, label: {
                                    Text("(Delete the file)")
                                        .foregroundColor(.red)
                                })
                                
                            }
                            .font(.custom("Lato-Bold", size: 16))
                            .foregroundColor(Color("MainColor"))
                        }else{
                            
                            Button(action: {
                                showDocumentPicker = true
                                deleteFileClicked = true
                            }, label: {
                                HStack{
                                    Image(systemName: "arrow.down.square.fill")
                                    Text("Upload Content( in .pdf format)")
                                    Spacer()
                                }
                                .font(.custom("Lato-Bold", size: 16))
                                .foregroundColor(Color("MainColor"))
                            }).sheet(isPresented: $showDocumentPicker, content: {
                                DocumentPicker(filePath: $filePath)
                            })
                        }
                        
                        CustomButton(
                            img: mode == .add ? "plus.rectangle.fill" : "square.and.arrow.down.fill",
                            text:  mode == .add ? "Add new book" : "Save your book"
                        )
                        .foregroundColor(Color("CustomBlack"))
                        .background(Color("MainColor"))
                        .clipShape(Capsule())
                        .onTapGesture {
                            if deleteFileClicked == false && deleteCoverClicked == false{
                                print("Edit book")
                                viewModel.editBook(title: title, author: author, genres: viewModel.divGenres(genres: genres), overview: overview)
                                showAddNewBook = false
                                showBookDetail = nil
                                
                            }else if deleteFileClicked == true && deleteCoverClicked == false{
                                viewModel.editBook(title: title, author: author, genres:viewModel.divGenres(genres: genres), overview: overview)
                                uploadFile()
                                showAddNewBook = false
                                showBookDetail = nil
                            }else if deleteFileClicked == false && deleteCoverClicked == true{
                                uploadImage()
                                showAddNewBook = false
                                showBookDetail = nil
                            }
                            else{
                                let group = DispatchGroup()
                                group.enter()
                                uploadImage()
                                uploadFile()
                                print("Sucessfully add book")
                                group.leave()
                                group.notify(queue: DispatchQueue.global(qos: .background)){
                                    print("To main screen")
                                    showAddNewBook = false
                                }
                                
                            }
                        }
                        if mode == .edit{
                            CustomButton(img: "trash.fill", text: "Delete this book")
                                .foregroundColor(Color("CustomWhite"))
                                .background(Color.red)
                                .clipShape(Capsule())
                                .onTapGesture {
                                    self.showActionSheet = true
                                    
                                }
                                .actionSheet(isPresented: $showActionSheet, content: {
                                    ActionSheet(title: Text("Delete"), message: Text("Are you sure you want to delte this book?"), buttons: [
                                        .default(Text("Yes"), action: {
                                            print("Success")
                                            viewModel.deleteBook(title: bookName ?? "")
                                            print(bookName ?? ""+" has been deleted!")
                                            self.showBookDetail = nil
                                        }),
                                        .cancel()
                                    ])
                                })
                        }
                        Spacer()
                    }.padding(.horizontal)
                    .textFieldStyle(OvalTextFieldStyle())
                    LoadingView(loadingState: viewModel.loadinState)

                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("SecondaryColor").clipShape(CustomCorner(corner: [.topLeft,.topRight])))
                .ignoresSafeArea(.all, edges: .all)
            }
            .background(Color("MainColor"))
        }
        
    }
}

struct AdminAddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AdminAddBookView(showAddNewBook: .constant(false), showBookDetail: .constant(nil))
    }
}

struct CustomCorner : Shape{
    var corner : UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: CGSize(width: 30, height: 30))
        
        return Path(path.cgPath)
    }
}

struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(Color("CustomWhite"))
            .cornerRadius(20)
    }
}

struct TextView: UIViewRepresentable {
    
    typealias UIViewType = UITextView
    var configuration = { (view: UIViewType) in }
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIViewType {
        UIViewType()
    }
    
    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<Self>) {
        configuration(uiView)
    }
    
}
