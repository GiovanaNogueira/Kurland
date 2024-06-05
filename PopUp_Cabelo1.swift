//
//  PopUp_Cabelo1.swift
//  Kurland
//
//  Created by Giovana Nogueira on 31/01/24.
//

import SwiftUI

struct PopUp_Cabelo1: View {
    
    @Binding var cenaAtual: Cena
    var body: some View {
        ZStack {
            Image("PopUp_Cabelo1")
                .resizable()
                .scaledToFit()
                .overlay{
                    VStack{
                        
                        Spacer()
                        HStack{
                            Spacer()
                            Button{
                                cenaAtual = .jogoNatureza
                            } label: {
                                Image("BtnNext")
                                
                            }
                            .padding(.bottom, 70)
                            .padding(.trailing, 70)
                        }
                    }
                }
        }
    }
}

#Preview {
    PopUp_Cabelo1(cenaAtual: .constant(.primEscolha))
}
