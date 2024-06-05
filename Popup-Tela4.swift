//
//  Popup-Tela4.swift
//  Kurland
//
//  Created by Giovana Nogueira on 29/01/24.
//

import SwiftUI

struct PopUp_tela4: View {
    @Binding var isShowingPopup:Bool
    var body: some View {
        ZStack {
            Image("PopUp-tela4")
                .resizable()
                .scaledToFit()
                .overlay{
                    VStack{
                        
                        Spacer()
                        HStack{
                            Spacer()
                            Button{
                                isShowingPopup = false
                            } label: {
                                Image("BtnNextYellow")
                                
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
    PopUp_tela4(isShowingPopup: .constant(true))
}



