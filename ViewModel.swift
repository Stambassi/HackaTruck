//
//  ViewModel.swift
//  Desafio_11
//
//  Created by Turma02-5 on 01/04/25.
//

import Foundation

let url_api : String = "http://192.168.128.10:1880/"

class ViewModel : ObservableObject {
    
    @Published var exercicios : [Exercicio] = []
    @Published var treinos : [Treino] = []
    
    func fetchExercicios(){
        let url_get_exercicio = url_api+"exercicioGET"
        guard let url = URL(string: url_get_exercicio ) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let parsed = try JSONDecoder().decode([Exercicio].self, from: data)
                
                DispatchQueue.main.async{
                    self?.exercicios = parsed
                }
            } catch {
                print(error)
            }
            
        }
        
        task.resume()
        
    }
    func fetchTreinos(){
        let url_get_treino = url_api+"treinoGET"
        guard let url = URL(string: url_get_treino ) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let parsed = try JSONDecoder().decode([Treino].self, from: data)
                
                DispatchQueue.main.async{
                    self?.treinos = parsed
                }
            } catch {
                print(error)
            }
            
        }
        
        task.resume()
        
    }
    
    func postExercicio(ex: Exercicio, completion: @escaping ([String: Any]?, Error?) -> Void){
        let url_post_exercicio = url_api+"exercicioPOST"
        //URL válida
            guard let URL = URL(string: url_post_exercicio) else {
                completion(nil, nil)
                return
            }
                
            //Cria a representacão da requisição
        let request = NSMutableURLRequest(url: URL)

            let params = [
                "nome":ex.nome!,
                "musculo": ex.musculo!
            ]
            //Converte as chaves em valores pares para os parametros em formato de String
            let postString = params.map { "\($0.0)=\($0.1)" }.joined(separator: "&")

            //Atribui à requisiçāo o método POST
            request.httpMethod = "POST"

            //Codifica o corpo da mensagem em "data" usando utf8
            request.httpBody = postString.data(using: String.Encoding.utf8)


            //Cria a tarefa de requisição
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                (data, response, error) in
                do {

                    if let data = data {
                        //A resposta chegou
                        let response = try JSONSerialization.jsonObject(with: data, options: [])
                        completion(response as? [String : Any], nil)
                    }
                    else {
                        //Não houve resposta
                        completion(nil, nil)
                    }
                } catch let error as NSError {
                    //Houve um erro na comunicao com o servidor
                    completion(nil, error)
                }
            }


            //Aciona a tarefa
            task.resume()

    }
    
    
}
