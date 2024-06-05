//
//  Tela5.swift
//  Kurland
//
//  Created by Giovana Nogueira on 30/01/24.
//

import SwiftUI

struct Tela5: View {
    @Binding var cenaAtual:Cena
    @Binding var wasUsedCabelo1: Bool
    @Binding var wasUsedCabelo2: Bool
    var body: some View {
        VStack{
            Spacer()
            HStack{
                Button(action: {
                    cenaAtual = .espelho
                }, label: {
                    Image("BtnPrevVerde").padding(.bottom, 20).padding(.leading, 29)
                })
                Spacer()
                Button(action: {
                    cenaAtual = .primEscolha
                    wasUsedCabelo1 = false
                    wasUsedCabelo2 = false
                }, label: {
                    Image("BtnNext").padding(.trailing, 29).padding(.bottom, 20)
                })
            }
        }.background(Image("Tela5")
            .resizable()
            .ignoresSafeArea()
            .scaledToFill())
    }
}

#Preview {
    Tela5(cenaAtual: .constant(.abreCastelo), wasUsedCabelo1: .constant(true), wasUsedCabelo2: .constant(true))
}


