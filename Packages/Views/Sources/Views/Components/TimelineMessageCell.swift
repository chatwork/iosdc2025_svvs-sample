import SwiftUI
import Entities

public struct TimelineMessageCell: View {
    private let message: Message
    private let account: Account?
    
    public init(message: Message, account: Account?) {
        self.message = message
        self.account = account
    }
    
    public var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: account?.avatarImageURL ?? "")) { phase in
                switch phase {
                case .success(let image):
                    image.resizable().aspectRatio(contentMode: .fill)
                case .empty, .failure:
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 40, height: 40)
            .clipShape(.circle)

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(account?.name ?? "")
                        .font(.headline)
                        .lineLimit(1)
                    Spacer()
                    Text(message.displayTime)
                        .lineLimit(1)
                }

                Text(message.body)
                    .lineSpacing(4)
            }
        }
    }
}

extension Message {
    public var displayTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: Date(timeIntervalSince1970: max(sendTime, updateTime)))
    }
}