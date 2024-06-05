//
//  JogoPedra.swift
//  Kurland
//
//  Created by Giovana Nogueira on 01/02/24.
//

import SwiftUI
import CoreMotion

class MotionManager: ObservableObject {
    
    @Published var alturaDoChao: Double = 0.0
    
    private var motionManager: CMMotionManager
    
    init() {
        motionManager = CMMotionManager()
        motionManager.deviceMotionUpdateInterval = 1/60
        motionManager.startDeviceMotionUpdates(to: .main) { (motionData, error) in
            guard error == nil else {
                print(error!)
                return
            }
            
            if let motionData = motionData {
                if abs(motionData.gravity.y - self.alturaDoChao) > 0.35 {
                    self.alturaDoChao = motionData.gravity.y
                    print(self.alturaDoChao)
                }
            }
        }
        
    }
}

struct RotatingIpadAnimation: View {
    @State private var rotationAngle: Double = 0
    @State private var rotationDirection: Double = 1

    var body: some View {
        VStack {
            Image("GIFIpad")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .rotationEffect(.degrees(rotationAngle))
                .onAppear {
                    rotateIpad()
                }
        }
    }

    func rotateIpad() {
        withAnimation(
            Animation.timingCurve(0.5, 0.1 + 0.5, 0.1, 1, duration: 1)
                .repeatForever(autoreverses: true)
        ) {
            rotationAngle = 45 * rotationDirection
        }
    }
}


struct JogoPedra: View {
    
    @Binding var cenaAtual:Cena
    @Binding var wasUsedCabelo1: Bool
    @Binding var wasUsedCabelo2: Bool
    
    @StateObject var motionManager = MotionManager()
    @State var progresso = 0
    
    var nomeImgFundo: String {
        if wasUsedCabelo1 {
            return "JogoPedraCaminho"
        }
        
        else{
            return "JogoFaltaAgua"
        }
    }
    
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                HStack{
                    Button(action: {
                        wasUsedCabelo2 = false
                        cenaAtual = .primEscolha
                    }, label: {
                        Image("BtnPrevVerde").padding(.bottom, 20).padding(.leading, 29)
                    })
                    Spacer()
                }
            }
            HStack{
                
                Image("Barra\(progresso)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 200)
                    .padding(.leading, 80)
                Spacer()
            }
            VStack{
                Spacer()
                RotatingIpadAnimation()
                    .padding(.bottom, 0)
                    .offset(y:-30)
                
//                HStack{
//                    Spacer()
//                    Button(action: {
//                        cenaAtual = .rioCastelo
//                    }, label: {
//                        Image("BtnNext")
//                        
//                    })
//                    .padding(.trailing, 29)
//                    .padding(.bottom, 20)
//                }
            }
        }.background(Image(nomeImgFundo)
            .resizable()
            .ignoresSafeArea()
            .scaledToFill())
        .onChange(of: motionManager.alturaDoChao, perform: { _ in
            progresso += 1
            
            if progresso == 10 {
                SoundPlayer.shared.playEffects(soundName: "taskCompleted")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    cenaAtual = .rioCastelo
                }
            }
        })
    }
    
}

#Preview {
    JogoPedra(cenaAtual: .constant(.jogoPedra), wasUsedCabelo1: .constant(true), wasUsedCabelo2: .constant(true))
}

#Preview {
    JogoPedra(cenaAtual: .constant(.jogoPedra), wasUsedCabelo1: .constant(false), wasUsedCabelo2: .constant(true))
}
