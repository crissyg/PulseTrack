//
//  FeedbackPromptView.swift
//  PulseTrack
//
//  Created by Tina G on 6/3/25.
//

import SwiftUI

import SwiftUI

// MARK: - Feedback Prompt Component
/// Interactive feedback prompt card for user engagement
struct FeedbackPromptView: View {
    let onFeedbackTap: () -> Void
    
    var body: some View {
        HStack {
            // Left side with icon and text
            HStack(spacing: 12) {
                // Feedback icon with background
                ZStack {
                    Circle()
                        .fill(Color.yellow.opacity(0.1))
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: "face.smiling")
                        .font(.system(size: 20))
                        .foregroundColor(.yellow)
                }
                
                Text("Help us improve")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
            }
            
            Spacer()
            
            // Right side chevron button
            Button(action: onFeedbackTap) {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.red)
            }
        }
        .padding(20)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(16)
    }
}

// MARK: - Preview Support
#if DEBUG
struct FeedbackPromptView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackPromptView(onFeedbackTap: {
            print("Feedback tapped")
        })
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
#endif
