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
            VStack(alignment: .leading) {
                Section {
                    ForEach(model.domandeFile.domande, id: \.id) { domanda in
                        NavigationLink(destination: getDestinationView(for: domanda)) {
                            GroupBox(label: Text(domanda.str).foregroundColor(.primary)) {
                                Text(model.risposteFile.risposte[domanda.id] ?? "Nessuna risposta")
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle(Text("Angelo Custode"))
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                Button("Fine") {
                    donePressed()
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
}
