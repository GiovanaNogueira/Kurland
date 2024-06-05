//
//  Tela4.swift
//  Kurland
//
//  Created by Giovana Nogueira on 29/01/24.
//

import SwiftUI

struct Tela4: View {
    @Binding var cenaAtual:Cena
    @State var isShowingTela5 = false
    @State var isShowingPopup = true
    @State var isShowingPopup4final = false
    var frase: String = "I am strong intelligent and pretty"
    @StateObject private var speechToText = SpeechToText(language: "en-US") //pt-BR

    var body: some View {
        ZStack{
            CameraView().ignoresSafeArea()
            VStack {
                Text("HOLD THE CAMERA TO YOUR FACE AND REPEAT THE AFFIRMATION")
                    .font(.custom("PatrickHand-Regular", size: 28))
                    .padding(10)
                    .foregroundStyle(.white)
                    .background(Color.black
                        .opacity(0.5)
                        .cornerRadius(10))
                    .padding(.top, 10)
                Spacer()
                HStack{
                    ForEach(frase.split(separator: " "), id: \.self) { word in
                        Text(word)
                            .font(.custom("PatrickHand-Regular", size: 28))
                            .foregroundStyle(speechToText.words.contains(String(word.lowercased())) && speechToText.words.count > 1 ? .green : .white)
                            
                    }
                }
                .padding(5)
                .background(Color.black
                    .opacity(0.5)
                    .cornerRadius(10))
            }

        }
        .task {
            try? await Task.sleep(for: .seconds(40))
            isShowingPopup4final = true
        }
        .onChange(of: speechToText.buscadas) { _ in
            if speechToText.buscadas.isEmpty{
                SoundPlayer.shared.playEffects(soundName: "taskCompleted")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    isShowingPopup4final = true
                }
                
            }
        }
        .overlay {
            if isShowingPopup{
                ZStack{
                    Color.black.opacity(0.3).ignoresSafeArea()
                    PopUp_tela4(isShowingPopup: $isShowingPopup)
                }
                
            }
            
            else if isShowingPopup4final{
                ZStack{
                    Color.black.opacity(0.3).ignoresSafeArea()
                    Popop_tela4_final(isShowingPopup4final: $isShowingPopup4final)
                }
            }
        }
        .onChange(of: isShowingPopup4final, perform: { value in
            if value == false {
                speechToText.stopTranscribing()
                cenaAtual = .abreCastelo
            }
        })
        .onAppear {
            speechToText.startTranscribing()
        }
    }
}

#Preview {
    Tela4(cenaAtual: .constant(.espelho))
}
