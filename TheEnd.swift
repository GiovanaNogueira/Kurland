//
//  TheEnd.swift
//  Kurland
//
//  Created by Giovana Nogueira on 04/02/24.
//

import SwiftUI

struct TheEnd: View {
    @Binding var cenaAtual:Cena
    @Binding var count: Int
    @Binding var wasUsedCabelo1: Bool
    @Binding var wasUsedCabelo2: Bool
    @Binding var hasFinished: Bool
    
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                HStack{
                    Button(action: {
                        cenaAtual = .princesas
                    }, label: {
                        Image("BtnPrevAmarelo").padding(.leading, 29).padding(.bottom, 20)
                    })
                    Spacer()
                }
            }
            VStack{
                Spacer()
                Button(action: {
                    cenaAtual = .abertura
                    count = 0
                    wasUsedCabelo1 = false
                    wasUsedCabelo2 = false
                    hasFinished = false
                }, label: {
                    Text("Play again")
                        .font(.custom("PatrickHand-Regular", size: 30))
                        .foregroundStyle(.white)
                })
                .padding(.bottom, 45)
            }
        }
        .background(Image("TheEnd")
            .resizable()
            .ignoresSafeArea()
            .scaledToFill())
    }
}

#Preview {
    TheEnd(cenaAtual: .constant(.theEnd), count: .constant(0), wasUsedCabelo1: .constant(false), wasUsedCabelo2: .constant(false), hasFinished: .constant(false))
}
