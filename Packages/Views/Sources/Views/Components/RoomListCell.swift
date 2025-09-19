import Entities
import SwiftUI

public struct RoomListCell: View {
    let room: Room
    
    public init(room: Room) {
        self.room = room
    }
    
    public var body: some View {
        HStack {
            AsyncImage(url: URL(string: room.iconPath)) { phase in
                switch phase {
                case .success(let image):
                    image.resizable().aspectRatio(contentMode: .fill)
                case .empty, .failure:
                    Image(systemName: room.type.defaultIconSystemName)
                        .resizable()
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 50, height: 50)
            .clipShape(.circle)
            Text(room.name)
                .foregroundStyle(Color(uiColor: .label))
            Spacer(minLength: 0)
            if room.unreadNum > 0 {
                Text("\(room.unreadNum)")
                    .foregroundStyle(.background)
                    .padding(.vertical, 3)
                    .padding(.horizontal, 10)
                    .background(.secondary)
                    .clipShape(Capsule())
                    .padding(6)
                    .overlay(alignment: .topTrailing) {
                        if room.mentionNum > 0 {
                            Circle()
                                .foregroundStyle(.green)
                                .frame(width: 16)
                        }
                    }
            }
            Image(systemName: "pin.fill")
                .opacity(room.sticky ? 1 : 0)
        }
    }
}

extension RoomType {
    public var defaultIconSystemName: String {
        switch self {
        case .group: "person.2.circle"
        case .direct, .my: "person.circle"
        }
    }
}