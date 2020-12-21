//
//  AngeloEditRisposta.swift
//  iGio
//
//  Created by Daniel Bazzani on 21/12/20.
//  Copyright © 2020 Dani Tox. All rights reserved.
//

import SwiftUI

@available(iOS 14, *)
struct AngeloEditRispostaView: View {
    
    var domanda: String
    @Binding var risposta: String
    
    var body: some View {
        GroupBox(label: Text(domanda).bold()) {
            TextEditor(text: $risposta)
        }
        .padding()
    }
}

