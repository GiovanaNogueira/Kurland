import SwiftUI


struct ContentView: View {
    @Binding var cenaAtual:Cena
    var body: some View {
        VStack{
            Button(action: {
                cenaAtual = .introducao
            }, label: {
                Image("BtnPlay")
                    .padding(.top, 50)
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }.background(Image("Tela1")
            .resizable()
            .ignoresSafeArea()
            .scaledToFill()
        )
    }
}

#Preview {
    ContentView(cenaAtual: .constant(.abertura))
}
