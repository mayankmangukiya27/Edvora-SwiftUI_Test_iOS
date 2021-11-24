//
//  ContentView.swift
//  swiftuiTask
//
//  Created by Shubham on 23/11/21.
//

import SwiftUI
import AlertToast

struct ContentView: View {
    
    var body: some View {
        VStack{
                subView()
          
        }
        
    }
   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct subView: View {
    
    @State var selectedTab = Tabs.FirstTextfield
    @ObservedObject var validation = validationViewModel()
    
    var primary:Color = Color("Primary")
    var black:Color = Color.black
    
    @State var isPasswrodSecure : Bool = true
    @State var isEmailValid : Bool = false
    @State var isPasswordValid:Bool = false
    @State var notempty: Bool = false
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                VStack{ Image("icon").resizable().frame(width: 160, height: 40, alignment: .center)
                }
                
                Spacer()
                VStack(alignment: .leading){
                    ZStack{ Image(selectedTab == .FirstTextfield ?  "backdesign" : "withoutborder")
                            .resizable()
                        VStack{
                            HStack{
                                Text("Username")
                                    .font(.system(size: 14))
                                    .frame(width: 70, height: 15, alignment: .center)
                                    .background(.white)
                                    .foregroundColor(.gray)
                                    .padding(.leading, 15)
                                    .padding(.top, -8)
                                Spacer()
                            }
                            Spacer()
                        }
                        
                        HStack{
                            Image("person").resizable().frame(width: 20, height: 18, alignment: .center)
                            TextField("", text: $validation.userName) { _ in
                                validation.userName = validation.userName.filter {!$0.isWhitespace}
                                self.validation.userName = self.validation.userName.lowercased()
                                    
                            }.textCase(.lowercase)
                                .textInputAutocapitalization(.never)
                                .onTapGesture {
                                    selectedTab = .FirstTextfield
                                }
                        }
                        .padding(10)
                    }
                }.frame(width: UIScreen.main.bounds.width/1.2, height: 50, alignment: .center)
                
                    .padding(15)
                
                VStack(alignment: .leading){
                    ZStack{
                        Image(selectedTab == .SecondTextfield ?  "backdesign" : "withoutborder")
                            .resizable()
                        VStack{
                            HStack{
                                Text("Password")
                                    .font(.system(size: 14))
                                    .frame(width: 70, height: 15, alignment: .center)
                                    .background(.white)
                                    .foregroundColor(.gray)
                                    .padding(.leading, 15)
                                    .padding(.top, -8)
                                Spacer()
                            }
                            Spacer()
                        }
                        HStack{
                            Image("Vector").resizable().frame(width: 15, height: 15, alignment: .center)
                            if isPasswrodSecure{
                                SecureField("", text: $validation.password) {
                                    if validation.isPasswordValid(validation.password){
                                        isPasswordValid = false
                                    }else{
                                        isPasswordValid = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                            withAnimation {
                                                isPasswordValid = false
                                            }
                                           
                                        }
                                    }
                                }.onTapGesture {
                                    selectedTab = .SecondTextfield
                                }
                               
                            }else{
                                TextField("", text: $validation.password) { ischeck in
                                    if !ischeck{
                                        if validation.isPasswordValid(validation.password){
                                            isPasswordValid = false
                                        }else{
                                            isPasswordValid = true
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                                withAnimation {
                                                    isPasswordValid = false
                                                }
                                               
                                            }
                                        }
                                    }
                                        
                                }
                                .onTapGesture {
                                    selectedTab = .SecondTextfield
                                }
                                
                            }
                            
                            Spacer()
                            Button {
                                if isPasswrodSecure{
                                    isPasswrodSecure = false
                                }else{
                                    isPasswrodSecure = true
                                   
                                  
                                }
                            } label: {
                                Image("eye").resizable().frame(width: 20, height: 20, alignment: .center)
                            }
                            
                        }
                        .padding(10)
                    }
                    
                    
                }.frame(width: UIScreen.main.bounds.width/1.2, height: 50, alignment: .center)
                    .padding(.horizontal, 15.0)
                
                
                VStack{
                    VStack(alignment: .leading){
                        ZStack{
                            Text("Email")
                            
                            Image(selectedTab == .ThirdTextfield ?  "backdesign" : "withoutborder")
                                .resizable()
                            
                            VStack{
                                HStack{
                                    Text("Email")
                                        .font(.system(size: 14))
                                        .frame(width: 40, height: 15, alignment: .center)
                                        .background(.white)
                                        .foregroundColor(.gray)
                                        .padding(.leading, 15)
                                        .padding(.top, -8)
                                    Spacer()
                                }
                                Spacer()
                            }
                            HStack{
                                Image("email").resizable().frame(width: 15, height: 15, alignment: .center)
                                TextField("", text: $validation.email) { isChanged in
                                    if !isChanged {
                                        if self.validation.isEmailValid(validation.email) {
                                            self.isEmailValid = false
                                        } else {
                                            self.isEmailValid = true
                                          
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                                withAnimation {
                                                    isEmailValid = false
                                                }
                                               
                                            }
                                           // self.email = ""
                                        }
                                    }
                                }
                                .onTapGesture {
                                    selectedTab = .ThirdTextfield
                                }
                                
                            }
                            .padding([.leading, .trailing], 10)
                        }
                    }
                    
                }.frame(width: UIScreen.main.bounds.width/1.2, height: 50, alignment: .center)
                
                    .padding([.top, .leading, .trailing], 15.0)
                
                VStack{
                    HStack{
                        Spacer()
                        Button {
                            
                        } label: {
                            Text("Forgotten Password ?")
                            
                                .foregroundColor(primary)
                        }
                    }
                }
                .padding(.trailing, 25)
                Spacer()
                
                VStack{
                    
                    Button {
                        if !validation.notEmpty(){
                            notempty = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                withAnimation {
                                    notempty = false
                                }
                               
                            }
                            
                        }else{
                            notempty = false
                        }
                         
                        
                    } label: {
                        VStack{
                            Text("LOGIN")
                                .font(.system(size: 15, weight: .bold, design: .default))
                                .foregroundColor(.white)
                        }.frame(width: UIScreen.main.bounds.width/1.2, height: 50, alignment: .center)
                            .background(primary)
                            .cornerRadius(10)
                            .padding()
                    }
                    
                }
                
                VStack{
                    HStack{
                        Spacer()
                        Text("Don’t have an account?")
                            .foregroundColor(.gray)
                        Button {
                            
                        } label: {
                            Text("Sign up")
                                .bold()
                                .foregroundColor(primary)
                        }
                        Spacer()
                        
                    }.padding()
                }
            }
            VStack{
                
                if isEmailValid{
                    AlertToast(displayMode: .hud, type: .regular, title: validation.emailPrompt)
                }
                if isPasswordValid{
                    AlertToast(displayMode: .hud, type: .regular, title: validation.passwordPrompt)
                }
                if notempty{
                    AlertToast(displayMode: .hud, type: .regular, title: validation.emptyPrompt)

                }
                Spacer()
            }
        }
    }
}


//use for slider button
enum Tabs {
    case FirstTextfield
    case SecondTextfield
    case ThirdTextfield
}
