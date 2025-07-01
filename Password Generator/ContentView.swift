//
//  ContentView.swift
//  Password Generator
//
//  Created by Humayun Tariq on 14/08/2024.
//
import SwiftUI


struct ContentView: View {
    @State private var generatedPassword: String = ""
    @State private var characterlength : Double = 10
    @FocusState private var isKeyboardVisible: Bool
    
    @State private var showNotification: Bool = false
    
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    
    @State private var NumeberState = false
    @State private var abcSate = false
    @State private var ABCstate = false
    @State private var symbolState = false
    
    @State private var lastFeedbackTime: TimeInterval = 0
    private let feedbackInterval: TimeInterval = 0.01
    
    
    var fontName = "CourierNewPSMT"
    
    let backgroundPhoto = Image("backgroundImage")
    
    
    var body: some View
    {
        VStack
        {
            //this displaying app name
            VStack {
                Text("Secure Key")
                    .foregroundColor(Color.white)
                    .bold()
                    .font(.custom(fontName, size: 30))
                    .frame(alignment: .top)
                    .padding(.top, 10)
                
            }
            
            ZStack {
                
                //this is the place were random generated password will be displayed
                VStack(alignment: .leading)
                {
                    Text("Password")
                        .foregroundColor(.white)
                        .font(.custom(fontName, size: 24))
                        .padding(.leading, 14.0)
                        .bold()
                    
                    //where password will be displayed
                    TextField("", text: $generatedPassword)
                        .font(.custom(fontName, size: 24))
                        .foregroundColor(.black)
                        .padding(.trailing, 15.0).padding(.leading, 10).padding(.vertical,17)
                        .background(Color.white) //Set background color if needed
                        .cornerRadius(22)
                    
                    
                    
                }.padding(.top, 27) .padding(.bottom, 37)
                    .padding(.leading, 23) .padding(.trailing, 25)
            }.glassmorphicCardStyle(width: 355, height: 170, gradientStartPoint: .topLeading, gradientEndPoint: .bottomTrailing)
                .overlay
                {
                    if showNotification
                    {
                        NotificationView()
                            .transition(.move(edge: .top).combined(with: .opacity))
                            .zIndex(1)
                            .padding(.top, -150) // Adjust this value to control the notification's position
                    }
                }
            Spacer()
            
            //it will be the stack in which we will display the option to use number, special characters etc and slidder for length of characters
            ZStack {
                
                VStack
                {
                    HStack{
                        Spacer()
                        Image(systemName: "at")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                        Spacer(minLength: 14)
                        
                        Toggle("Symbols", isOn: $symbolState)
                            .foregroundColor(.white)
                            .tint(symbolState ? Color("backColor") : Color.black)
                            .font(.custom(fontName,size: 25))
                            .onChange(of: symbolState) {
                                feedbackGenerator.impactOccurred()
                            }
                    }.padding(.top,6)
                    Color.white.opacity(0.4)
                        .frame(width: 353,height: 1).padding(.vertical,1)
                    
                    HStack{
                        Image(systemName: "textformat.123")
                            .resizable()
                            .frame(width: 30, height: 15)
                            .foregroundColor(.white)
                        Spacer(minLength: 14)
                        Toggle("Numbers", isOn: $NumeberState)
                            .foregroundColor(.white)
                            .font(.custom(fontName,size: 25))
                            .tint(Color("backColor"))
                            .onChange(of: NumeberState) {
                                feedbackGenerator.impactOccurred()
                            }
                    }
                    Color.white.opacity(0.4)
                        .frame(width: 353,height: 1).padding(.vertical,1)
                    
                    HStack {
                        Image(systemName: "textformat.abc")
                            .resizable()
                            .frame(width: 35, height: 18)
                            .foregroundColor(.white)
                        
                        Toggle("Lowercase", isOn: $abcSate)
                            .foregroundColor(.white)
                            .font(.custom(fontName,size: 25))
                            .tint(Color("backColor"))
                            .onChange(of: abcSate) {
                                feedbackGenerator.impactOccurred()
                            }
                    }
                    Color.white.opacity(0.4)
                        .frame(width: 353,height: 1).padding(.vertical,1)
                    
                    HStack {
                        
                        Image(systemName: "abc")
                            .resizable()
                            .frame(width: 35, height: 16)
                            .foregroundColor(.white)
                        
                        Toggle("UpperCase", isOn: $ABCstate)
                            .foregroundColor(.white)
                            .font(.custom(fontName,size: 25))
                            .tint(Color("backColor"))
                            .onChange(of: ABCstate) {
                                feedbackGenerator.impactOccurred()
                            }
                        
                    }
                    Color.white.opacity(0.4)
                        .frame(width: 353,height: 1).padding(.vertical,1)
                    
                    //this the stack of characters length
                    
                        VStack {
                            HStack
                            {
                                Text("Character Length")
                                    .font(.custom(fontName, size: 25))
                                    .foregroundColor(.white)
                                Spacer()
                                
                                //where length of password will be displayed
                                TextField("", value: $characterlength, formatter: NumberFormatter())
                                                .keyboardType(.numberPad) // Shows the numeric keypad
                                                .foregroundColor(.black)
                                                .background(Color.white)
                                                .font(.custom(fontName, size: 17))
                                                .textFieldStyle(RoundedBorderTextFieldStyle()).cornerRadius(8)
                                                .frame(width:46)
                                                .focused($isKeyboardVisible)
                                                .onChange(of: characterlength) { oldValue, newValue in
                                                    if newValue > 100 { characterlength = 100}
                                                    else if newValue < 1 {
                                                        characterlength = 1
                                                    }
                                                }
                                
                                
                            }.padding(.bottom,2)
                            Slider(value: $characterlength, in: 1...100, step: 1)
                                .shadow(radius: 5)
                                .tint(Color("backColor"))
                                .onChange(of: characterlength) { oldValue, newValue in
                                    let currentTime = Date().timeIntervalSince1970
                                    if currentTime - lastFeedbackTime > feedbackInterval {
                                        feedbackGenerator.impactOccurred()
                                        lastFeedbackTime = currentTime
                                    }
                                }
                    
                    } //closing VStack of characters length
                    
                    
                }.padding(.all, 10)
                
            }
            .glassmorphicCardStyle(width: 355, height: 300, gradientStartPoint: .topLeading, gradientEndPoint: .bottomTrailing)
            if isKeyboardVisible{
                Button(action: {
                    isKeyboardVisible = false
                }, label: {
                    Image(systemName: "keyboard.chevron.compact.down")
                        .foregroundColor(.white)
                }).buttonStyle(.borderedProminent).tint(Color("backColor")).opacity(1)
            }
           
            Spacer()
            HStack
            {
                
                Button(action: {
                    generatedPassword = passwordGenerator.generatePassowrd(length: Int(characterlength), num: NumeberState, lowerAlpha: abcSate, upperAlpha: ABCstate, symbols: symbolState)
                    feedbackGenerator.impactOccurred()

                }, label: {
                    Text("Generate")
                        .font(.custom(fontName, size: 20))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .glassmorphicCardStyle(width: 277, height: 69, gradientStartPoint: .topLeading, gradientEndPoint: .bottomTrailing)
                })
                
                Button(action: {
                    copyToClipboard(text: generatedPassword)
                    showNotificationMessage()
                    feedbackGenerator.impactOccurred()
                }, label: {
                                    Image(systemName: "doc.on.doc")
                                        .resizable()
                                        .frame(width: 29.6, height: 36)
                                        .tint(.white)
                                        .frame(width:29.6, height:36)
                                        
                                        .glassmorphicCardStyle(width: 69, height: 69, gradientStartPoint: .topLeading, gradientEndPoint: .bottomTrailing)
                
                                    })

                
                
                
            }
        }
            .padding(.horizontal, 20.0)
            .background(backgroundPhoto)
        }
    
    
    // Function to copy text to the clipboard
    func copyToClipboard(text: String) {
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        UIPasteboard.general.string = text
    }
    
    func showNotificationMessage() {
            withAnimation {
                showNotification = true
            }

            // Hide the notification after 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    showNotification = false
                }
            }
        }
    
    }
    
    


#Preview {
    ContentView()
}


struct GlassmorphicCard: ViewModifier {
    var width: CGFloat
    var height: CGFloat
    var gradientStartPoint: UnitPoint
    var gradientEndPoint: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .frame(width: width, height: height)
            .background(
                Color.white.opacity(0.1)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            )
            .shadow(color: .black.opacity(0.5), radius: 5, x: 5, y: 5)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.white.opacity(0.5),
                                Color.gray.opacity(0.4)
                            ]),
                            startPoint: gradientStartPoint,
                            endPoint: gradientEndPoint
                        ),
                        lineWidth: 2
                    )
            )
    }
}

extension View {
    func glassmorphicCardStyle(width: CGFloat, height: CGFloat, gradientStartPoint: UnitPoint, gradientEndPoint: UnitPoint) -> some View {
        self.modifier(GlassmorphicCard(width: width, height: height, gradientStartPoint: gradientStartPoint, gradientEndPoint: gradientEndPoint))
    }
}

struct NotificationView: View {
    var body: some View {
        Text("Copied")
            .padding()
            .background(Color.black.opacity(0.8))
            .foregroundColor(.white)
            .cornerRadius(30)
            .shadow(radius: 10)
            .opacity(1)
    }
}




    
