//
//  AngeloView.swift
//  iGio
//
//  Created by Daniel Bazzani on 21/12/20.
//  Copyright © 2020 Dani Tox. All rights reserved.
//

import SwiftUI

@available(iOS 14, *)
struct AngeloView: View {
    @StateObject var model: AngeloAgent = AngeloAgent()
    
    var donePressed: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                VStack {
                    Section {
                        ForEach(model.domandeFile.domande, id: \.id) { domanda in
                            NavigationLink(destination: getDestinationView(for: domanda)) {
                                GroupBox(label: Text(domanda.str).foregroundColor(.primary)) {
                                    HStack {
                                        Text(model.risposteFile.risposte[domanda.id] ?? "Nessuna risposta")
                                            .foregroundColor(.secondary)
                                        Spacer()
                                    }
                                }
                            }
                        }
                    }
                }
                
                VStack {
                    Section(header: header) {
                       
                        ForEach(model.domandeFile.parole, id: \.id) { parola in
                            ParolaCell(parola: parola.str,
                                       isSelected: getBindingToParola(parola: parola))
                        }
                        
                    }
                }
                
                Section(header: Text("Preghiera finale").bold().font(.title)) {
                    Text(self.model.preghiera)
                }
                
            }
            .padding(.horizontal)
            .padding(.top)
        }
        .navigationBarTitle("Angelo Custode", displayMode: NavigationBarItem.TitleDisplayMode.inline)
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                Button("Fine") {
                    donePressed()
                    self.model.save()
                    self.model.stopObservingChanges()
                }
            }
        }        
    }
    
    func getDestinationView(for domanda: AngeloDomandeFile.Item) -> some View {
        let binding = self.getBindingToRisposta(domanda: domanda)
        return AngeloEditRispostaView(domanda: domanda.str, risposta: binding)
    }
    
    func getBindingToRisposta(domanda: AngeloDomandeFile.Item) -> Binding<String> {
        Binding<String> {
            self.model.risposteFile.risposte[domanda.id] ?? ""
        } set: {
            self.model.risposteFile.set(risposta: $0, forID: domanda.id)
        }
    }
    
    func getBindingToParola(parola: AngeloDomandeFile.Item) -> Binding<Bool> {
        Binding<Bool> {
            self.model.risposteFile.paroleChecked[parola.id] ?? false
        } set: {
            self.model.risposteFile.set(parolaChecked: $0, forParolaID: parola.id)
        }
    }
    
    struct ParolaCell: View {
        var parola: String
        @Binding var isSelected: Bool
        
        var body: some View {
            GroupBox {
                HStack {
                    Text(parola)
                    Spacer()
                    if isSelected {
                        Image(systemName: "checkmark.circle")
                            .foregroundColor(.green)
                    }
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                isSelected.toggle()
            }
        }
    }
    
    var header: some View {
        Text("Flagga i verbi dell’Angelo Custode in cui ti riconosci e in cui ti stai impegnando:")
            .bold()
            .font(.title)
            .fixedSize(horizontal: false, vertical: true)
    }
}
