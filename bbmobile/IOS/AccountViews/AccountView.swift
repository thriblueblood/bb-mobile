//
//  AccountView.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 21/4/2564 BE.
//

import SwiftUI
import Firebase
struct AccountView: View {
    @Binding var showAccountView : Bool
    @Binding var goToHome : Bool
    @ObservedObject var viewModel = AccountViewModel()
    
    
    var body: some View {
        ZStack{
            Color("SecondaryColor")
                .edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    Button(action: {
                        showAccountView = false
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color("MainColor"))
                    })

                    Spacer()
                }.padding(.leading)
                .font(.system(size: 36))
                HStack{
                    Button(action: {
                        
                        viewModel.switchStatus()
                        
                    }, label: {
                        HStack{
                            if viewModel.userStatus{
                                Spacer()
                                Image(systemName: "person.fill.xmark")
                                Text("Unsubscribe")
                                Spacer()
                            }
                            else{
                                Spacer()
                                Image(systemName: "person.fill.xmark")
                                Text("subscribe now!")
                                Spacer()
                            }
                            
                        }
                    })
                    .padding()
                    .font(.custom("Lato-Bold", size: 24))
                    .foregroundColor(Color("MainColor"))
                    .background(Color("CustomBlack"))
                    .padding(.leading,5)
                    Spacer()
                    
                    Button(action: {
                        goToHome = false
                        self.signout()
                    }, label: {
                        HStack{
                            Spacer()
                            Image(systemName: "person.fill.xmark")
                            Text("Logout")
                            Spacer()
                        }
                    })
                    .padding()
                    .font(.custom("Lato-Bold", size: 24))
                    .foregroundColor(Color("MainColor"))
                    .background(Color("CustomBlack"))
                    .padding(.leading,5)
                    Spacer()
                    
                }
            Spacer()
            }
        }
    }
    func signout(){
            do{
                try Auth.auth().signOut()
            }
            catch{
                print("error")
            }

        }
//    func subscribe(){
//
//        let db = Firestore.firestore()
//        let userID = Auth.auth().currentUser!.uid
//
//        db.collection("users").whereField("id", isEqualTo: "\(userID)").getDocuments() { (document, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            }
//            else{
//                if let snapshotDocuments = document?.documents {
//                    for doc in snapshotDocuments {
//                        let data = doc.data()
//                        let postBody = data["subscribe"] as? Bool
//                        print(postBody!)
//
//                        print(data)
//                    }
//
//
//                }
//
//
//
//            }
//        }
//        db.collection("users").document("\(self.email)").updateData([
//            "subscribe": true
//        ])
//    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(showAccountView: .constant(true), goToHome: .constant(true))
    }
}
