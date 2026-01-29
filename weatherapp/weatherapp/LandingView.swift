//
//  LandingView.swift
//  weatherapp
//
//  Created by rentamac on 1/22/26.
//
import SwiftUI
import Foundation

struct LandingView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                Color("backgroundcolour")
                    .ignoresSafeArea()

                VStack(){
                    Spacer()
                    Image("Image")
                        .resizable()
                        .frame(width: 100,height: 90)
                    Text("Breeze")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    
                    Text("Weather App")
                        .foregroundColor(.white)
                        Spacer()
                    
                    NavigationLink {
                         ListView()
                    } label: {
                        Image(systemName: "chevron.right.circle.fill")
                            .font(.largeTitle)
                            .padding(60)
                            .foregroundColor(.blue)
                        
                    }

                    Spacer()
                }
            }
        }
    }
}
#Preview{
    LandingView()
}
