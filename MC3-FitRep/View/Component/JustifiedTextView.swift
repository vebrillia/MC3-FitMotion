import SwiftUI
import UIKit

struct JustifiedTextView: UIViewRepresentable {
    var text: String
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = false
        textView.isSelectable = false
        textView.textAlignment = .justified
        textView.font = UIFont.systemFont(ofSize: 12)
        textView.text = text
        textView.backgroundColor = .clear
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}
