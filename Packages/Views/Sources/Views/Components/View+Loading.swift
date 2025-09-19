import SwiftUI

public extension View {
    @ViewBuilder
    func loading(_ isLoading: Bool) -> some View {
        overlay {
            if isLoading {
                Color.primary.opacity(0.2)
                    .overlay {
                        ProgressView()
                    }
                    .ignoresSafeArea()
            }
        }
    }
}