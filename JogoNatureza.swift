import SwiftUI
import AVFoundation

struct Flower: Identifiable {
    let id = UUID()
    let imageName: String
    var position: CGPoint = .zero
    var initialPosition: CGPoint = .zero
    var isFixed: Bool = false
    var isDraggable: Bool = true
}


func distance(from: CGPoint, to: CGPoint) -> CGFloat {
    return sqrt(
        pow(from.x - to.x, 2) + pow(from.y - to.y, 2)
    )
}

struct DraggableView: View {
    @Binding var count: Int
    @Binding var flower: Flower

    var body: some View {
        ZStack {
            if flower.isDraggable {
                Image(flower.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .offset(x: flower.position.x - 50, y: flower.position.y - 50)
                    .gesture(DragGesture()
                        .onChanged { value in
                            flower.position = value.location
                        }
                        .onEnded { value in
                            let distance = distance(
                                from: CGPoint(x: flower.position.x - 50, y: flower.position.y - 50),
                                to: flower.initialPosition
                            )
                            
                            if distance < 30 {
                                flower.isDraggable = false
                                SoundPlayer.shared.playEffects(soundName: "twinkle")
                                count += 1
                            }
                        }
                    )
            } else {
                Image(flower.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .offset(x: flower.initialPosition.x, y: flower.initialPosition.y)
                    .opacity(flower.isFixed ? 0.3 : 1)
            }
        }
    }
}

struct JogoNatureza: View {
    @Binding var count: Int
    @Binding var wasUsedCabelo1: Bool
    @Binding var cenaAtual:Cena
    @State private var flowers: [Flower] = [
        Flower(
            imageName: "flor1",
            initialPosition: CGPoint(x: 170, y: 150),
            isFixed: true,
            isDraggable: false
        ),
        Flower(
            imageName: "flor2",
            initialPosition: CGPoint(x: 140, y: -50),
            isFixed: true,
            isDraggable: false
        ),
        Flower(
            imageName: "flor3",
            initialPosition: CGPoint(x: -215, y: 50),
            isFixed: true,
            isDraggable: false
        ),
        Flower(
            imageName: "flor4",
            initialPosition: CGPoint(x: -80, y: -120),
            isFixed: true,
            isDraggable: false
        ),
        Flower(
            imageName: "flor1",
            position: CGPoint(x: 380, y: -50),
            initialPosition: CGPoint(x: 170, y: 150)
        ),
        Flower(
            imageName: "flor2",
            position: CGPoint(x: -320, y: -100),
            initialPosition: CGPoint(x: 140, y: -50)
        ),
        Flower(
            imageName: "flor3",
            position: CGPoint(x: -380, y: 200),
            initialPosition: CGPoint(x: -215, y: 50)
        ),
        Flower(
            imageName: "flor4",
            position: CGPoint(x: 400, y: 180),
            initialPosition: CGPoint(x: -80, y: -120)
        ),
    ]
    var body: some View {
        
        ZStack {
            ForEach(flowers.indices, id: \.self) { index in
                DraggableView(count: $count, flower: $flowers[index])
            }
            VStack{
                Spacer()
                HStack{
                    Button(action: {
                        wasUsedCabelo1 = false
                        cenaAtual = .primEscolha
                        count = 0
                    }, label: {
                        Image("BtnPrevRoxo").padding(.bottom, 20).padding(.leading, 29)
                    })
                    Spacer()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("DragBackground")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
        )
        .onChange(of: count) { _ in
            if count == 4{
                SoundPlayer.shared.playEffects(soundName: "taskCompleted")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            cenaAtual = .rioCastelo
                        }
            }
        }
    }
}


#Preview {
    JogoNatureza(count: .constant(0), wasUsedCabelo1: .constant(true), cenaAtual: .constant(.jogoNatureza))
    
}
