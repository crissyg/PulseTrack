//
//  OnboardingPageView.swift
//  PulseTrack
//
//  Created by Tina G on 6/3/25.
//

import SwiftUI

// MARK: - Reusable Onboarding Page Component
/// OnboardingPageView: Individual page component for onboarding flow presentation

struct OnboardingPageView: View {
    
    // MARK: - Component Properties
    /// Onboarding page data model containing display content
    let page: OnboardingPage
    
    /// Animation state for enhanced user engagement
    @State private var isAnimating = false
    
    // MARK: - Component Layout
    /// Main component interface with structured visual hierarchy
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            // Animated icon section with visual impact
            IconDisplayView(
                imageName: page.imageName,
                color: page.color,
                isAnimating: isAnimating
            )
            
            // Content section with clear information hierarchy
            ContentDisplayView(
                title: page.title,
                subtitle: page.subtitle
            )
            
            Spacer()
        }
        .onAppear {
            // Trigger entrance animation when component appears
            withAnimation(.easeOut(duration: 0.8).delay(0.2)) {
                isAnimating = true
            }
        }
        .onDisappear {
            // Reset animation state when component disappears
            isAnimating = false
        }
    }
}

// MARK: - Icon Display Component
/// Animated icon presentation with visual feedback
struct IconDisplayView: View {
    let imageName: String
    let color: Color
    let isAnimating: Bool
    
    var body: some View {
        ZStack {
            // Background pulse effect for enhanced visual engagement
            Circle()
                .fill(color.opacity(0.1))
                .frame(width: 120, height: 120)
                .scaleEffect(isAnimating ? 1.2 : 1.0)
                .opacity(isAnimating ? 0.6 : 0.3)
                .animation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true), value: isAnimating)
            
            // Primary icon with entrance animation
            Image(systemName: imageName)
                .font(.system(size: 80, weight: .light))
                .foregroundColor(color)
                .scaleEffect(isAnimating ? 1.0 : 0.5)
                .opacity(isAnimating ? 1.0 : 0.0)
                .animation(.spring(response: 0.8, dampingFraction: 0.6), value: isAnimating)
        }
    }
}

// MARK: - Content Display Component
/// Text content presentation with structured hierarchy
/// Information architecture reflects your efficient data processing capabilities
struct ContentDisplayView: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(spacing: 16) {
            // Primary title with emphasis
            // Typography hierarchy similar to your clear platform documentation
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)
            
            // Supporting subtitle with contextual information
            // Information density reflects your streamlined data presentation expertise
            Text(subtitle)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
                .lineLimit(nil)
        }
    }
}

// MARK: - Preview Support
#if DEBUG
/// Preview configurations for development and testing
struct OnboardingPageView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Preview with sample pulse tracking content
            OnboardingPageView(
                page: OnboardingPage(
                    title: "Welcome to PulseTrack",
                    subtitle: "Your personal pulse and heart rate monitoring companion",
                    imageName: "heart.fill",
                    color: .red
                )
            )
            .previewDisplayName("Pulse Tracking Page")
            
            // Preview with Apple Watch integration content
            OnboardingPageView(
                page: OnboardingPage(
                    title: "Connect Your Apple Watch",
                    subtitle: "Real-time heart rate monitoring and health insights",
                    imageName: "applewatch",
                    color: .blue
                )
            )
            .previewDisplayName("Apple Watch Page")
            
            // Preview with health insights content
            OnboardingPageView(
                page: OnboardingPage(
                    title: "Personalized Health Insights",
                    subtitle: "Data-driven recommendations based on your pulse patterns",
                    imageName: "waveform.path.ecg",
                    color: .green
                )
            )
            .previewDisplayName("Health Insights Page")
        }
    }
}
#endif
