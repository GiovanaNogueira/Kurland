//
//  Tela6.swift
//  Kurland
//
//  Created by Giovana Nogueira on 31/01/24.
//

import SwiftUI

struct Tela6: View {
    
    @Binding var cenaAtual:Cena
    @State var isShowingPopUpCabelo1: Bool = false
    @State var isShowingPopUpCabelo2: Bool = false
    @Binding var wasUsedCabelo1: Bool
    @Binding var wasUsedCabelo2: Bool
    @Binding var  lastIsNatu: Bool
    @Binding var  count: Int
    
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                HStack{
                    Button(action: {
                        cenaAtual = .abreCastelo
                        count = 0
                    }, label: {
                        Image("BtnPrevAmarelo").padding(.bottom, 20).padding(.leading, 29)
                    })
                    Spacer()
                }
            }
            VStack{
                HStack{
                    Button(action: {
                        isShowingPopUpCabelo1 = true
                        wasUsedCabelo1 = true
                        lastIsNatu = true
                    }, label: {
                        Image("BtnCabelo1")
                    })
                    .opacity(wasUsedCabelo1 ? 0.5 : 1)
                    .disabled(wasUsedCabelo1)
                    Button(action: {
                        isShowingPopUpCabelo2 = true
                        wasUsedCabelo2 = true
                        lastIsNatu = false
                    }, label: {
                        Image("BtnCabelo2").padding(.leading, 50)
                    })
                    .opacity(wasUsedCabelo2 ? 0.5 : 1)
                    .disabled(wasUsedCabelo2)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }.background(Image("Tela6")
            .resizable()
            .ignoresSafeArea()
            .scaledToFill()
        )
        .overlay {
            if isShowingPopUpCabelo1{
                ZStack{
                    Color.black.opacity(0.3).ignoresSafeArea()
                    PopUp_Cabelo1(cenaAtual: $cenaAtual)
                }
                
            }
            
            else if isShowingPopUpCabelo2{
                ZStack{
                    Color.black.opacity(0.3).ignoresSafeArea()
                    PopUp_Cabelo2(cenaAtual: $cenaAtual)
                }
                
            }
        }
    }
}

#Preview {
    Tela6(cenaAtual: .constant(.primEscolha), wasUsedCabelo1: .constant(true), wasUsedCabelo2: .constant(false), lastIsNatu: .constant(true), count: .constant(0))
}
