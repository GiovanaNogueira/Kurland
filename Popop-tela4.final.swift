//
//  Popop-tela4.final.swift
//  Kurland
//
//  Created by Giovana Nogueira on 31/01/24.
//

import SwiftUI

struct Popop_tela4_final: View {
    
    @Binding var isShowingPopup4final:Bool
    @State var isShowingTela5 = false
    
    var body: some View {
        ZStack {
            Image("PopUp-tela4.final")
                .resizable()
                .scaledToFit()
                .overlay{
                    VStack{
                        HStack{
                            Button{
                                isShowingPopup4final = false
                                isShowingTela5 = true
                            } label: {
                                Image("BtnChave")
                            }
                            .padding(.top, 50)
                            .padding(.trailing, 250)
                            .shadow(radius: 50)
                        }
                    }
                }
        }
//        .navigationDestination(isPresented: $isShowingTela5, destination: {
//            Tela5(cenaAtual: .constant(.abreCastelo))
//              })
    }
}

#Preview {
    Popop_tela4_final(isShowingPopup4final: .constant(true))
}

