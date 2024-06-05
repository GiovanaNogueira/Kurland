import SwiftUI
import AVFoundation

enum Cena: Int {
    case abertura
    case introducao
    case ayanaTriste
    case espelho
    case abreCastelo
    case primEscolha
    case jogoNatureza
    case pedraNoCaminho
    case rioCastelo
    case jogoPedra
    case convFinal1
    case convFinal2
    case princesas
    case theEnd
}

class SoundPlayer: ObservableObject {
    static var shared = SoundPlayer()

    var effectsPlayer: AVAudioPlayer?
    var backgroundPlayer: AVAudioPlayer?
    var currentSoundName: String?

    func playEffects(soundName: String) {
        if let path = Bundle.main.path(forResource: soundName, ofType: "mp3") {
            do {
                if soundName != currentSoundName {
                    effectsPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                    effectsPlayer?.setVolume(0.8, fadeDuration: 0)
                    effectsPlayer?.play()
                    currentSoundName = soundName
                } else {
                    effectsPlayer?.play()
                }
            } catch {
                print("Error playing sound: \(error.localizedDescription)")
            }
        }
    }

    func playBackground(soundName: String) {
        if let path = Bundle.main.path(forResource: soundName, ofType: "mp3") {
            do {
                if soundName != currentSoundName {
                    backgroundPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                    backgroundPlayer?.numberOfLoops = -1 
                    backgroundPlayer?.setVolume(0.5, fadeDuration: 0)
                    backgroundPlayer?.play()
                    currentSoundName = soundName
                } else {
                    backgroundPlayer?.play()
                }
            } catch {
                print("Error playing sound: \(error.localizedDescription)")
            }
        }
    }
    
    func stopEffects() {
        effectsPlayer?.stop()
    }
    
    func stopBackground() {
        backgroundPlayer?.stop()
    }
}

@main
struct MyApp: App {
    @StateObject var soundPlayer = SoundPlayer.shared
    @State var cenaAtual = Cena.abertura
    @State var wasUsedCabelo1: Bool = false
    @State var wasUsedCabelo2: Bool = false
    @State var lastIsNatu: Bool = false
    @State var count = 0
    @State var hasFinished: Bool = false
    init() {
        let cfURL = Bundle.main.url(forResource: "PatrickHand-Regular", withExtension: "ttf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
    }

    var body: some Scene {
        WindowGroup {
            ZStack {
                switch cenaAtual {
                case .abertura:
                    ContentView(cenaAtual: $cenaAtual)
                        .transition(.opacity)
                        .onAppear {
                            soundPlayer.playBackground(soundName: "trilhaSonora")
                        }
                case .introducao:
                    Tela2(cenaAtual: $cenaAtual)
                        .transition(.opacity)
                        .onAppear {
                            soundPlayer.playBackground(soundName: "trilhaSonora")
                        }
                case .ayanaTriste:
                    Tela3(cenaAtual: $cenaAtual)
                        .transition(.opacity)
                        .onAppear {
                            soundPlayer.stopBackground()
                            soundPlayer.playBackground(soundName: "musicaTriste")
                            
                        }
                case .espelho:
                    Tela4(cenaAtual: $cenaAtual)
                        .transition(.opacity)
                        .onAppear {
                            soundPlayer.stopBackground()
                            soundPlayer.playBackground(soundName: "trilhaSemInicio")
//                            var timer: Timer?
//                                        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: false) { _ in
//                                            // Ajusta a currentTime após 60 segundos
//                                            soundPlayer.backgroundPlayer?.currentTime = 60
//                                            timer?.invalidate()
//                                            timer = nil
//                                        }
                        }
                case .abreCastelo:
                    Tela5(cenaAtual: $cenaAtual,
                          wasUsedCabelo1: $wasUsedCabelo1,
                          wasUsedCabelo2: $wasUsedCabelo2)
                        .transition(.opacity)
                        .onAppear {
                            soundPlayer.playBackground(soundName: "trilhaSemInicio")
                        }
                case .primEscolha:
                    Tela6(cenaAtual: $cenaAtual,
                          wasUsedCabelo1: $wasUsedCabelo1,
                          wasUsedCabelo2: $wasUsedCabelo2, lastIsNatu: $lastIsNatu,
                          count: $count)
                        .transition(.opacity)
                        .onAppear {
                            soundPlayer.playBackground(soundName: "trilhaSemInicio")
                        }
                case .jogoNatureza:
                    JogoNatureza(count: $count, wasUsedCabelo1: $wasUsedCabelo1, cenaAtual: $cenaAtual)
                        .transition(.opacity)
                        .onAppear {
                            soundPlayer.stopBackground()
                            soundPlayer.playBackground(soundName: "trilhaJogos")
                        }
                case .pedraNoCaminho:
                    RioCastelo(cenaAtual: $cenaAtual,
                               wasUsedCabelo1: $wasUsedCabelo1,
                               wasUsedCabelo2: $wasUsedCabelo2, lastIsNatu: $lastIsNatu, count: $count)
                        .transition(.opacity)
                        .onAppear {
                            soundPlayer.stopBackground()
                            soundPlayer.playBackground(soundName: "trilhaSemInicio")
                        }
                case .rioCastelo:
                    RioCastelo(cenaAtual: $cenaAtual,
                               wasUsedCabelo1: $wasUsedCabelo1,
                               wasUsedCabelo2: $wasUsedCabelo2, lastIsNatu: $lastIsNatu, count: $count)
                        .transition(.opacity)
                        .onAppear {
                            soundPlayer.playBackground(soundName: "trilhaSemInicio")
                        }
                case .jogoPedra:
                    JogoPedra(cenaAtual: $cenaAtual, wasUsedCabelo1: $wasUsedCabelo1, wasUsedCabelo2: $wasUsedCabelo2)
                        .transition(.opacity)
                        .onAppear {
                            soundPlayer.playBackground(soundName: "trilhaSemInicio")
                        }
                case .convFinal1:
                    ConversaFinal1(cenaAtual: $cenaAtual, lastIsNatu: $lastIsNatu)
//                        .transition(.opacity)
                        .onAppear {
                            soundPlayer.playBackground(soundName: "trilhaSemInicio")
                        }
                case .convFinal2:
                    ConversaFinal2(cenaAtual: $cenaAtual, lastIsNatu: $lastIsNatu)
//                        .transition(.opacity)
                        .onAppear {
                            soundPlayer.playBackground(soundName: "trilhaSemInicio")
                        }
                case .princesas:
                    Princesas(cenaAtual: $cenaAtual, lastIsNatu: $lastIsNatu,
                              hasFinished: $hasFinished)
//                        .transition(.opacity)
                        .onAppear {
                            soundPlayer.stopBackground()
                            soundPlayer.playBackground(soundName: "trilhaFinal")
                        }
                case .theEnd:
                    TheEnd(
                        cenaAtual: $cenaAtual,
                        count: $count,
                        wasUsedCabelo1: $wasUsedCabelo1,
                        wasUsedCabelo2: $wasUsedCabelo2, 
                        hasFinished: $hasFinished)
                        .transition(.opacity)
                        .onAppear {
                            soundPlayer.stopBackground()
                            soundPlayer.playBackground(soundName: "trilhaFinal")
                        }
                }
            }
            .onChange(of: cenaAtual) { newCena in
                // Salva a cena atual para retomar a música
                UserDefaults.standard.set(newCena.rawValue, forKey: "cenaAtual")
                // Muda a música com base na cena atual (se necessário)
                switch newCena {
                case .ayanaTriste:
                    soundPlayer.playBackground(soundName: "musicaTriste")
                default:
                    soundPlayer.stopBackground()
                }
            }
            .onChange(of: ScenePhase.background) { phase in
                if phase == .background {
                    cenaAtual = .abertura
                }
                if phase == .active {
                    soundPlayer.backgroundPlayer?.play()
                }
            }
            .animation(.default, value: cenaAtual)
        }
    }
}
