//
//  AngeloMedieView.swift
//  iGio
//
//  Created by Daniel Bazzani on 22/12/20.
//  Copyright © 2020 Dani Tox. All rights reserved.
//

import SwiftUI

@available(iOS 14, *)
struct AngeloMedieView: View {
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @StateObject var agent = AngeloMedieAgent()
    var doneAction: () -> Void
    
    private let keys: [String] = [
        "PREGARE", "GIOCARE", "RACCONTARE", "CORREGGERE"
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                ForEach(keys, id: \.self) { key in
                    VStack {
                        Text(key).bold()
                        Text(domande[key]!)
                        HStack {
                            EmojiSlider(value: binding(for: key))
                            Text("\(Int(agent.getValue(forKey: key)))")                            
                        }
                        .padding(.horizontal, horizontalSizeClass == .compact ? 0 : 30)
                    }
                }
            }
            .padding()
        }
        .navigationBarTitle(Text("Angelo Custode"), displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                Button("Fine") {
                    self.agent.save()
                    self.doneAction()
                }
            }
        }
    }
    
    func binding(for key: String) -> Binding<Int> {
        Binding {
            self.agent.getValue(forKey: key)
        } set: {
            self.agent.set(value: $0, forKey: key)
        }
    }
    
}


@available(iOS 14, *)
extension AngeloMedieView {
    var domande: [String: String] {
        [
            "PREGARE": """
Pregare per il mio Cliente è un gesto di carità molto alto, posso farlo anche se non lo conosco ancora bene, anche a distanza e anche se la timidezza mi frena ancora un po’. Se prego per lui, lo conosco in una luce nuova e sarò più pronto ad incontrarlo nella quotidianità.
Prego per il mio Cliente?
""",
            "GIOCARE": """
Giocare insieme è un modo per superare la timidezza, conoscerci e aiutarlo a fare gruppo con altri amici.
Gioco con il mio Cliente?
""",
            "RACCONTARE": """
Raccontare qualcosa di bello che ho fatto e chiedere a lui di raccontare a me qualcosa è un modo per approfondire il nostro legame e darci buoni consigli e buoni esempi.
Racconto al mio Cliente?
""",
            "CORREGGERE": """
Talvolta il mio Cliente avrà bisogno di essere corretto e aiutato a far proprio l’atteggiamento che anche io ho appreso nella casa di Don Bosco.
Correggo il mio Cliente?
"""
        ]
    }
}

/*
 
 
PREGARE
Pregare per il mio Cliente è un gesto di carità molto alto, posso farlo anche se non lo conosco ancora bene, anche a distanza e anche se la ?midezza mi frena ancora un po’. Se prego per lui, lo conosco in una luce nuova e sarò più pronto ad incontrarlo nella quo?dianità.
GIOCARE
Giocare insieme è un modo per superare la ?midezza, conoscerci e aiutarlo a fare gruppo con altri amici.
RACCONTARE
Raccontare qualcosa di bello che ho fa^o e chiedere a lui di raccontare a me qualcosa è un modo per approfondire il nostro legame e darci buoni consigli e buoni esempi.
CORREGGERE
Talvolta il mio Cliente avrà bisogno di essere corre^o e aiutato a far proprio l’a^eggiamento che anche io ho appreso nella casa di Don Bosco.
*/
