//
//  ContentView.swift
//  Tic_Tae_Toe
//
//  Created by Raghav Bansal on 8/7/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var  viewModel = ViewModel()
    
    var body: some View {
            GeometryReader{geometry in
                VStack {
                    Spacer()
                    Text("Tic Tae Toe")
                        .font(.system(size: 36, weight: .heavy, design: .rounded))
                        

                    LazyVGrid(columns:viewModel.columns){
                    ForEach(0..<9){ i in
                        ZStack{
                            
                            Circle()
                                .foregroundColor(.orange).opacity(0.8)
                                .frame(width:geometry.size.width/3 - 10, height: geometry.size.width/3 - 5)
                            
                            Image(systemName: viewModel.moves[i]?.indicator ?? " ")
                                .resizable()
                                .frame(width: 40, height: 40)
                            
                            
                            
                        }.onTapGesture {
                            viewModel.processPlayerMoves(for: i)
                        }
                    }
                }
                    Spacer()
            }
        }
        
        .disabled(viewModel.isGameBoardDisabled)
        .padding()
        .alert(item: $viewModel.alertproduct, content: { alertproduct in
            Alert(title: alertproduct.title, message: alertproduct.message,
                  dismissButton: .default(alertproduct.buttonTitle, action: {viewModel.resetGame()}))
        })
    }
    
    
    
}


enum Player{
    case human
    case computer
}

struct move{
    let player:Player
    let boardIndex:Int
    var indicator:String{
        return player == .human ? "xmark" : "circle"
    }
}


#Preview {
    ContentView()
}
