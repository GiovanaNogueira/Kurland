//
//  Tela3.swift
//  Kurland
//
//  Created by Giovana Nogueira on 29/01/24.
//

import SwiftUI

struct Tela3: View {
    @Binding var cenaAtual:Cena
    var body: some View {
        VStack{
            Spacer()
            HStack{
                Button(action: {
                    cenaAtual = .introducao
                }, label: {
                    Image("BtnPrevVerde").padding(.bottom, 20).padding(.leading, 29)
                })
                Spacer()
                Button(action: {
                    cenaAtual = .espelho
                }, label: {
                    Image("BtnNext").padding(.trailing, 29).padding(.bottom, 20)
                })
            }
        }.background(Image("Tela3")
            .resizable()
            .ignoresSafeArea()
            .scaledToFill())

            
    }
}

#Preview {
    Tela3( cenaAtual: .constant(.ayanaTriste))
}


