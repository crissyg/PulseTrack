//
//  OnboardingPage.swift
//  PulseTrack
//
//  Created by Tina G on 6/3/25.
//

import SwiftUI

// MARK: - Onboarding Page Data Model
/// OnboardingPage: Data structure for onboarding flow content management
struct OnboardingPage {
    
    // MARK: - Core Properties
    /// Primary page title for user engagement
    let title: String
    
    /// Supporting subtitle with detailed information
    let subtitle: String
    
    /// SF Symbol icon name for visual representation
    let imageName: String
    
    /// Theme color for visual consistency and categorization
    let color: Color
    
    /// Optional unique identifier for analytics tracking
    let id: String
    
    /// Optional animation configuration for enhanced user experience
    let animationConfig: AnimationConfiguration?
    
    // MARK: - Initialization
    /// Primary initializer with required content properties
    init(
        title: String,
        subtitle: String,
        imageName: String,
        color: Color,
        id: String? = nil,
        animationConfig: AnimationConfiguration? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.imageName = imageName
        self.color = color
        self.id = id ?? UUID().uuidString
        self.animationConfig = animationConfig ?? .default
    }
    
    /// Convenience initializer for basic onboarding pages
    init(title: String, subtitle: String, imageName: String, color: Color) {
        self.init(
            title: title,
            subtitle: subtitle,
            imageName: imageName,
            color: color,
            id: nil,
            animationConfig: nil
        )
    }
}

// MARK: - Animation Configuration
/// Configuration structure for onboarding page animations
struct AnimationConfiguration {
    
    /// Animation duration for entrance effects
    let duration: Double
    
    /// Animation delay before starting
    let delay: Double
    
    /// Animation spring response for natural motion
    let springResponse: Double
    
    /// Animation damping for smooth transitions
    let dampingFraction: Double
    
    /// Default animation configuration
    static let `default` = AnimationConfiguration(
        duration: 0.8,
        delay: 0.2,
        springResponse: 0.6,
        dampingFraction: 0.8
    )
    
    /// Fast animation configuration for quick transitions
    static let fast = AnimationConfiguration(
        duration: 0.4,
        delay: 0.1,
        springResponse: 0.4,
        dampingFraction: 0.7
    )
    
    /// Slow animation configuration for emphasis
    static let slow = AnimationConfiguration(
        duration: 1.2,
        delay: 0.3,
        springResponse: 0.8,
        dampingFraction: 0.9
    )
}

// MARK: - Onboarding Content Factory
/// Factory class for creating standardized onboarding content
struct OnboardingContentFactory {
    
    /// Create pulse tracking focused onboarding pages
    static func createPulseTrackingPages() -> [OnboardingPage] {
        return [
            OnboardingPage(
                title: "Welcome to PulseTrack",
                subtitle: "Your personal pulse and heart rate monitoring companion for comprehensive health insights and wellness tracking",
                imageName: "heart.fill",
                color: .red,
                id: "welcome_pulse_track",
                animationConfig: .slow
            ),
            
            OnboardingPage(
                title: "Real-Time Pulse Monitoring",
                subtitle: "Connect your Apple Watch for continuous heart rate tracking, instant health alerts, and detailed pulse analysis",
                imageName: "applewatch",
                color: .blue,
                id: "pulse_monitoring",
                animationConfig: .default
            ),
            
            OnboardingPage(
                title: "Personalized Health Insights",
                subtitle: "Get data-driven recommendations based on your pulse patterns, health trends, and personalized wellness goals",
                imageName: "waveform.path.ecg",
                color: .green,
                id: "health_insights",
                animationConfig: .fast
            )
        ]
    }
    
    /// Create general wellness onboarding pages
    static func createWellnessPages() -> [OnboardingPage] {
        return [
            OnboardingPage(
                title: "Welcome to Wellness Tracking",
                subtitle: "Comprehensive health monitoring and wellness optimization for better daily habits",
                imageName: "figure.mind.and.body",
                color: .purple,
                id: "wellness_welcome"
            ),
            
            OnboardingPage(
                title: "Track Your Activities",
                subtitle: "Monitor steps, exercise, sleep patterns, and daily health metrics for complete wellness insights",
                imageName: "figure.walk",
                color: .orange,
                id: "activity_tracking"
            ),
            
            OnboardingPage(
                title: "Achieve Your Goals",
                subtitle: "Set personalized health goals and receive guidance to maintain optimal wellness and fitness levels",
                imageName: "target",
                color: .mint,
                id: "goal_achievement"
            )
        ]
    }
}

// MARK: - Protocol Conformance
/// Equatable conformance for onboarding page comparison
extension OnboardingPage: Equatable {
    static func == (lhs: OnboardingPage, rhs: OnboardingPage) -> Bool {
        return lhs.id == rhs.id
    }
}

/// Identifiable conformance for SwiftUI list and iteration support
extension OnboardingPage: Identifiable {
    // Uses existing id property for Identifiable conformance
}

/// Hashable conformance for set operations and advanced collections
extension OnboardingPage: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Validation and Quality Assurance
/// Extension for content validation and quality checks
extension OnboardingPage {
    
    /// Validate page content for completeness and quality
    var isValid: Bool {
        return !title.isEmpty &&
               !subtitle.isEmpty &&
               !imageName.isEmpty &&
               title.count <= 50 &&
               subtitle.count <= 200
    }
    
    /// Generate accessibility description for screen readers
    var accessibilityDescription: String {
        return "\(title). \(subtitle)"
    }
    
    /// Estimate reading time for subtitle content
    var estimatedReadingTimeSeconds: Double {
        let wordsPerMinute = 200.0
        let wordCount = Double(subtitle.split(separator: " ").count)
        return (wordCount / wordsPerMinute) * 60.0
    }
}

// MARK: - Development and Testing Support
#if DEBUG
/// Sample data for development and testing
extension OnboardingPage {
    
    /// Sample onboarding page for development
    static let samplePulseTracking = OnboardingPage(
        title: "Sample Pulse Tracking",
        subtitle: "This is a sample onboarding page for development and testing purposes",
        imageName: "heart.fill",
        color: .red,
        id: "sample_pulse_tracking"
    )
    
    /// Sample onboarding page with long content
    static let sampleLongContent = OnboardingPage(
        title: "Long Content Sample",
        subtitle: "This is a sample onboarding page with longer subtitle content to test text wrapping, layout behavior, and visual presentation across different device sizes and orientations for comprehensive testing coverage",
        imageName: "text.alignleft",
        color: .blue,
        id: "sample_long_content"
    )
    
    /// Array of sample pages for testing
    static let samplePages = [
        samplePulseTracking,
        sampleLongContent,
        OnboardingPage(
            title: "Test Page Three",
            subtitle: "Third sample page for comprehensive testing",
            imageName: "3.circle.fill",
            color: .green,
            id: "sample_page_three"
        )
    ]
}
#endif
