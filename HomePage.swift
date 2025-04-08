//
//  HomePage.swift
//  Projeto_final
//
//  Created by Turma02-25 on 04/04/25.
//

import SwiftUI

struct HomePage: View {
    @StateObject var viewModel = ViewModel()
    var body: some View {
        ZStack{
            VStack{
                ScrollView{
//                    ForEach(viewModel.exercicios){ exercicio in
//                        if(exercicio.image != nil){
//                            AsyncImage(url: URL(string: exercicio.image!)){ image in
//                                image
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                //                .offset(y:50)
//                            } placeholder: {
//                                Image(systemName: "questionmark.diamond")
//                                    .foregroundStyle(.white)
//                            }
//                        }
//                    }
                    ForEach(viewModel.treinos) { treino in
                        if(treino.nome != nil){
                            Text(treino.nome!)
                        }
                        if(treino.exercicios != nil){
                            ForEach(treino.exercicios!, id:\.self) { i in
                               // Text(String(i))
                                ForEach(viewModel.exercicios){ ex in
                                    //Text("Exercicio não presente: \(ex.id)")
                                    if(ex.id == i){
                                        Text(ex.nome!)
                                    }
                                
                                }
                            }
                        }
                    }
                }
            }
        }.onAppear(){
            viewModel.fetchExercicios()
            viewModel.fetchTreinos()
        }
        
    }
}

#Preview {
    HomePage()
}
