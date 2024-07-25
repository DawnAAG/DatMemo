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
    let maxCharacters = 200
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $text)
                    .padding()
                    .border(Color.gray, width: 1)
                    .frame(height: 200)
                    .font(Font.custom("PressStart2P", size: 12))
                
                HStack {
                    Spacer()
                    Text("\(text.count)/\(maxCharacters)")
                        .font(Font.custom("PressStart2P", size: 12))
                        .foregroundColor(text.count > maxCharacters ? .red : .gray)
                        .padding(.trailing)
                }
                
                Button("Save") {
                    if text.count <= maxCharacters {
                        onSave(text)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                .padding()
                .background(text.count <= maxCharacters ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(8)
                .disabled(text.count > maxCharacters)
            }
            .padding()
            .font(Font.custom("PressStart2P", size: 12))
        }
    }
}
