//
//  ContentView.swift
//  suift_ui_course
//
//  Created by Increase Okechukwu Divine-Wisdom on 01/07/2023.


import SwiftUI

struct ContentView: View {
    @State private var isHidden = true
   @State var imageSize = 25.0
    @State var year = Calendar.current.component(.year, from: Date())
    @State var opacityNumber: Double = 0.8
    @State private var isToggled = false
      @State private var buttonText = "To Remove Card Opacity, Click Here"
    var database: Database = Database()
  @State private  var cardItems: [CardItem] = [CardItem]()
    
    
    var body: some View {

        ZStack {
            Image("_uhdtexture72")
                           .resizable()
            VStack {
                if isHidden {
                    Color.clear
                } else {
                    Text("A Project by Okechukwu \(String(year))©").font(.title3).foregroundColor(.white).onAppear {
                            withAnimation(Animation.easeInOut(duration: 1.0).delay(2.0)) {
                                isHidden.toggle()
                            }
                        }
                }
            }.onAppear {
                withAnimation {
                    isHidden.toggle()
                }
            }

                List(cardItems) { item in
                    // Button ontop placement
                    if let index = cardItems.firstIndex(where: { $0.id == item.id }) {
                        if index == 0 {
                            VStack(alignment: .center) {
                                Spacer().frame(height: 50)
                                HStack {
                                    Spacer()
                                    Button(buttonText) {
                                        if isToggled {
                                            opacityNumber = 0.7
                                            buttonText = "Click To Remove Card Opacity"
                                            isToggled.toggle()
                                            
                                        } else {
                                            opacityNumber = 1
                                            buttonText = "Click To Make Card Transparent"
                                            isToggled.toggle()
                                        }
                                        
                                    }.padding(.all, 8.0).background(Color.white).cornerRadius(15).opacity(opacityNumber)
                                    Spacer()
                                }
                            }.listRowBackground(Color(.clear))
                        }
                        
                        
                        CustomCard(name: item.name, age: item.age, status: item.status, state: item.state, notes: item.notes, imageString: item.imageString, opacityDouble: opacityNumber)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color(.clear)).onTapGesture {
                                if isToggled {
                                    opacityNumber = 0.7
                                    buttonText = "Click To Remove Card Opacity"
                                    isToggled.toggle()
                                    
                                } else {
                                    opacityNumber = 1
                                    buttonText = "Click To Make Card Transparent"
                                    isToggled.toggle()
                                }
                            }
                        //Button below placement
                        if index == cardItems.count - 1 {                            VStack {
                                Text("Designed by Okechukwu in the year \(String(year))")
                                    .fontWeight(.bold).foregroundColor(Color.white)
                                    .multilineTextAlignment(.center)
                                    .padding(.bottom)
                                ReusableButton (buttonText: "Change Year", buttonForegroundColor: Color.black, buttonBackgroundColor: Color.white) {
                                    year = Int.random(in: 1820...1967)
                                    
        
                                }

                                Spacer().frame(height: 30)
                                    
                            }.listRowBackground(Color(.clear))
                        }
                    }
                }.listStyle(.plain).onAppear{
                   cardItems = database.getData()
                }

        }
        .ignoresSafeArea()
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
