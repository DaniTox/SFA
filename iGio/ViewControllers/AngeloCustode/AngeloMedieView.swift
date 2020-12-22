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
    
    var doneAction: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack {
                    Text("PREGARE").bold()
                    Text("Pregare per il mio Cliente è un gesto di carità molto alto, posso farlo anche se non lo conosco ancora bene, anche a distanza e") + Text(" anche se la timidezza mi frena ancora un po’. Se prego per lui, lo conosco in una luce nuova e sarò più pronto ad incontrarlo nella quotidianità.").foregroundColor(.red)
                }
                
                VStack {
                    Text("GIOCARE").bold()
                    Text("Giocare insieme è un modo per superare la timidezza, conoscerci e aiutarlo a fare gruppo con altri amici.")
                }
                
                VStack {
                    Text("RACCONTARE").bold()
                    Text("Raccontare qualcosa di bello che ho fatto e chiedere a lui di raccontare a me qualcosa è un modo per approfondire il nostro legame e darci buoni consigli e buoni esempi.")
                }
                
                VStack {
                    Text("CORREGGERE").bold()
                    Text("Talvolta il mio Cliente avrà bisogno di essere corretto e aiutato a far proprio l’atteggiamento che anche io ho appreso nella casa di Don Bosco.")
                }.foregroundColor(.red)
            }
            .padding()
        }
        .navigationBarTitle(Text("Angelo Custode"), displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                Button("Fine") {
                    self.doneAction()
                }
            }
        }
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
