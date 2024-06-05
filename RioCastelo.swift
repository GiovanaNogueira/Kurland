//
//  PedraNoCaminho.swift
//  Kurland
//
//  Created by Giovana Nogueira on 31/01/24.
//

import SwiftUI

struct RioCastelo: View {
    @Binding var cenaAtual:Cena
    @Binding var wasUsedCabelo1: Bool
    @Binding var wasUsedCabelo2: Bool
    @Binding var lastIsNatu: Bool
    @Binding var count: Int
    
    var nomeImgFundo: String {
        if wasUsedCabelo1 && wasUsedCabelo2 {
            return "CasteloPronto"
        }
        else if wasUsedCabelo1 {
            return "PedraNoCaminho"
        }
        else{
            return "FaltaAgua"
        }
    }
    var body: some View {
        VStack{
            Spacer()
            HStack{
                Button(action: {
                    prevScene()
                }, label: {
                    Image("BtnPrevVerde")
                        .padding(.leading, 29)
                        .padding(.bottom, 20)

                    
                })
                Spacer()
                Button(action: {
                    nextScene()
                }, label: {
                    Image("BtnNext")
                    
                })
                .padding(.trailing, 29)
                .padding(.bottom, 20)
            }
        }.background(Image(nomeImgFundo)
            .resizable()
            .ignoresSafeArea()
            .scaledToFill())
        
        .onAppear(){
            if nomeImgFundo == "PedraNoCaminho" {
                SoundPlayer.shared.playEffects(soundName: "river")
            }
            
            else if nomeImgFundo == "CasteloPronto"{
                SoundPlayer.shared.playEffects(soundName: "casteloPronto")
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    SoundPlayer.shared.playEffects(soundName: "river")
                }
            }
            
        }

    }
    
    func nextScene() {
        if wasUsedCabelo1 && wasUsedCabelo2 {
            SoundPlayer.shared.stopEffects()
            cenaAtual = .convFinal1
        }
        else {
            SoundPlayer.shared.stopEffects()
            cenaAtual = .primEscolha
        }
    }
    
    func prevScene() {
        if lastIsNatu {
            SoundPlayer.shared.stopEffects()
            cenaAtual = .jogoNatureza
            count = 0
        }
        else {
            SoundPlayer.shared.stopEffects()
            cenaAtual = .jogoPedra
        }
    }
}

//
//#Preview {
//    RioCastelo(
//        cenaAtual: .constant(.pedraNoCaminho),
//        wasUsedCabelo1: .constant(true),
//        wasUsedCabelo2: .constant(false),
//        lastIsNatu: .constant(true)
//    )
//}
//
//#Preview {
//    RioCastelo(
//        cenaAtual: .constant(.pedraNoCaminho),
//        wasUsedCabelo1: .constant(true),
//        wasUsedCabelo2: .constant(true),
//        lastIsNatu: .constant(true)
//    )
//}
//
//#Preview {
//    RioCastelo(
//        cenaAtual: .constant(.pedraNoCaminho),
//        wasUsedCabelo1: .constant(false),
//        wasUsedCabelo2: .constant(true),
//        lastIsNatu: .constant(true)
//    )
//}
