import SwiftUI

public struct MessageEditor: View {
    /// TextEditorの内部的な上下のpadding合計
    private static let textEditorVerticalPadding: CGFloat = 18
    
    @Binding var text: String
    @State var textEditorHeight : CGFloat
    let maxHeight: CGFloat
    let uiFont: UIFont
    let placeholder: String
    
    public init(uiFont: UIFont = .preferredFont(forTextStyle: .body), text: Binding<String>, placeholder: String = "", maxHeight: CGFloat) {
        _text = .init(projectedValue: text)
        self.maxHeight = maxHeight
        self.uiFont = uiFont
        self.placeholder = placeholder
        textEditorHeight = uiFont.lineHeight
    }
    
    public var body: some View {
        TextEditor(text: $text)
            .autocapitalization(.none)
            .font(.init(uiFont))
            .frame(height: min(maxHeight, textEditorHeight))
            .cornerRadius(10.0)
            .padding(.horizontal, 4)
            .background {
                ZStack {
                    Text(text)
                        .font(.init(uiFont))
                        .foregroundColor(.clear)
                        .onGeometryChange(for: CGSize.self) { proxy in
                            proxy.size
                        } action: {
                            textEditorHeight = max($0.height, uiFont.lineHeight) + Self.textEditorVerticalPadding
                        }
                }
                .frame(height: maxHeight)
            }
            .overlay(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(Color(uiColor: .placeholderText))
                        .padding(.horizontal, 10)
                        .allowsHitTesting(false)
                }
            }
    }
    
    public static func minHeight(uiFont: UIFont) -> CGFloat {
        uiFont.lineHeight + textEditorVerticalPadding
    }
}