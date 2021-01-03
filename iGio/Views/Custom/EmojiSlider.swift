//
//  EmojiSlider.swift
//  iGio
//
//  Created by Daniel Bazzani on 03/01/21.
//  Copyright © 2021 Dani Tox. All rights reserved.
//

import SwiftUI
import UIKit

@available(iOS 13, *)
struct EmojiSlider: UIViewRepresentable {
    
    @Binding var value: Int
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        slider.maximumValue = 10
        slider.minimumValue = 0
        slider.value = Float(value)
        slider.addTarget(context.coordinator, action: #selector(Coordinator.valueChanged(sender:)), for: .valueChanged)
        
        context.coordinator.update(slider: slider, value: value)
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(value: $value)
    }
    
    class Coordinator: NSObject {
        
        var valueBinding: Binding<Int>
        
        init(value: Binding<Int>) {
            self.valueBinding = value
        }
        
        @objc func valueChanged(sender: UISlider) {
            sender.value = roundf(sender.value)
            let integerValue = Int(roundf(sender.value))
            
            update(slider: sender, value: integerValue)
            
            valueBinding.wrappedValue = integerValue
        }
        
        
        public func update(slider: UISlider, value: Int) {
            slider.setThumbImage(getThumbImage(from: value), for: .normal)
            slider.setThumbImage(self.getThumbImage(from: value), for: .highlighted)
        }
        
        private func getThumbImage(from integer: Int) -> UIImage? {            
            switch integer {
            case 0, 1:
                return "🙁".image(with: 30)
            case 2, 3, 4:
                return "😐".image(with: 30)
            case 5, 6:
                return "😌".image(with: 30)
            case 7, 8:
                return "😃".image(with: 30)
            case 9, 10:
                return "😁".image(with: 30)
            default:
                return "".image()
            }
        }
        
    }
    
}
