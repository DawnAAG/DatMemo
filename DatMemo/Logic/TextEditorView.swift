//
//  TextEditorView.swift
//  DatMemo
//
//  Created by Artiom Gramatin on 29.06.2024.
//

import SwiftUI

struct TextEditorView: View {
    @Binding var text: String
    var onSave: (String) -> Void
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $text)
                    .padding()
                    .border(Color.gray, width: 1)
                    .frame(height: 200)
                    .font(Font.custom("PressStart2P", size: 12))
                
                Button("Save") {
                    onSave(text)
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding()
            .font(Font.custom("PressStart2P", size: 12))
        }
    }
}
