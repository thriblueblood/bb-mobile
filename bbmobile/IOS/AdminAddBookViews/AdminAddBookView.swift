//
//  AddBookView.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 4/6/2564 BE.
//

import SwiftUI

struct AdminAddBookView: View {

    @Binding var showAddNewBook : Bool
    @State var title : String = ""

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
                //Bottom Section
                ZStack{
                    VStack{
                        Text("Add new book")
                            .font(.custom("Lato-Bold", size: 30))
                            .foregroundColor(Color("MainColor"))
                            .frame(maxWidth:.infinity, alignment: .leading)
                            .padding(.top,25)
                        TextField("Title name", text: $title)
                        TextField("Author", text: $title)
                        TextField("Genres", text: $title)
                        HStack {
                            Text("Divide genres using comma( , )")
                                .font(.custom("Lato-Bold", size: 12))
                                .foregroundColor(Color("MainColor"))
                            Spacer()
                        }
                        TextField("Description", text: $title)
                        Button(action: {

                        }, label: {
                            HStack{
                                Image(systemName: "arrow.down.square.fill")
                                Text("Upload Content( in .pdf format)")
                                Spacer()
                            }
                            .font(.custom("Lato-Bold", size: 16))
                            .foregroundColor(Color("MainColor"))
                        })
                        CustomButton(img: "plus.rectangle.fill", text: "Add new book")
                            .foregroundColor(Color("CustomBlack"))
                            .background(Color("MainColor"))
                            .clipShape(Capsule())
                            .onTapGesture {
//                                adminVM.save()
                                showAddNewBook = false
                            }

                        Spacer()
                    }.padding(.horizontal)
                    .textFieldStyle(OvalTextFieldStyle())
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
        AdminAddBookView(showAddNewBook: .constant(false))
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
