//
//  HealthMetricCard.swift
//  PulseTrack
//
//  Created by Tina G on 6/3/25.
//

import SwiftUI

// MARK: - Health Metric Display Component
/// HealthMetricCard: Reusable component for displaying individual health metrics
struct HealthMetricCard: View {
    
    // MARK: - Component Properties
    /// Metric display title (e.g., "Heart Rate", "Steps")
    let title: String
    
    /// Formatted metric value (e.g., "72 BPM", "8,247")
    let value: String
    
    /// SF Symbol icon name for visual identification
    let icon: String
    
    /// Theme color for metric categorization
    let color: Color
    
    /// Optional trend indicator for data changes
    var trend: MetricTrend? = nil
    
    /// Animation state for interactive feedback
    @State private var isPressed = false
    
    // MARK: - Component Layout
    /// Main card interface with structured metric presentation
    var body: some View {
        VStack(spacing: 12) {
            // Icon section with visual emphasis
            MetricIconView(
                icon: icon,
                color: color,
                isPressed: isPressed
            )
            
            // Value section with primary data display
            MetricValueView(
                value: value,
                trend: trend
            )
            
            // Title section with metric identification
            MetricTitleView(title: title)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .padding(.horizontal, 12)
        .background(CardBackgroundView())
        .scaleEffect(isPressed ? 0.95 : 1.0)
        .animation(.easeInOut(duration: 0.1), value: isPressed)
        .onTapGesture {
            // Provide haptic feedback for user interaction
            handleCardTap()
        }
        .onLongPressGesture(
            minimumDuration: 0,
            pressing: { isPressing in
                // Handle press state for visual feedback
                isPressed = isPressing
            },
            perform: {
                // Optional: Handle long press completion if needed
            }
        )
    }
    
    // MARK: - Interaction Handling
    /// Handle card tap interaction with visual feedback
    private func handleCardTap() {
        // Provide visual feedback for better user experience
        withAnimation(.easeInOut(duration: 0.1)) {
            // Visual feedback through animation
        }
        
        // Log interaction for analytics
        logMetricInteraction()
    }
    
    /// Log metric card interaction for analytics
    private func logMetricInteraction() {
        // Track user engagement with specific metrics
        // Log interaction timestamp and metric type
        // Update user behavior analytics
    }
}

// MARK: - Metric Icon Component
/// Icon display with color theming and animation
struct MetricIconView: View {
    let icon: String
    let color: Color
    let isPressed: Bool
    
    var body: some View {
        Image(systemName: icon)
            .font(.title2)
            .foregroundColor(color)
            .opacity(isPressed ? 0.7 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: isPressed)
    }
}

// MARK: - Metric Value Component
/// Value display with optional trend indicator
struct MetricValueView: View {
    let value: String
    let trend: MetricTrend?
    
    var body: some View {
        HStack(spacing: 4) {
            // Primary metric value
            Text(value)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            // Optional trend indicator
            if let trend = trend {
                TrendIndicatorView(trend: trend)
            }
        }
    }
}

// MARK: - Metric Title Component
/// Title display with consistent typography
struct MetricTitleView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.caption)
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
    }
}

// MARK: - Trend Indicator Component
/// Visual trend indicator for metric changes
struct TrendIndicatorView: View {
    let trend: MetricTrend
    
    var body: some View {
        HStack(spacing: 2) {
            Image(systemName: trend.icon)
                .font(.caption2)
                .foregroundColor(trend.color)
            
            Text(trend.percentage)
                .font(.caption2)
                .foregroundColor(trend.color)
        }
    }
}

// MARK: - Card Background Component
/// Consistent card background styling
struct CardBackgroundView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.white)
            .shadow(
                color: Color.black.opacity(0.1),
                radius: 2,
                x: 0,
                y: 1
            )
    }
}

// MARK: - Metric Trend Data Model
/// Data model for representing metric trends and changes
struct MetricTrend {
    let direction: TrendDirection
    let percentage: String
    
    /// Trend direction enumeration
    enum TrendDirection {
        case up, down, stable
    }
    
    /// Icon representation for trend direction
    var icon: String {
        switch direction {
        case .up: return "arrow.up"
        case .down: return "arrow.down"
        case .stable: return "minus"
        }
    }
    
    /// Color representation for trend direction
    var color: Color {
        switch direction {
        case .up: return .green
        case .down: return .red
        case .stable: return .gray
        }
    }
}

// MARK: - Preview Support
#if DEBUG
/// Preview configurations for development and testing
struct HealthMetricCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 16) {
            // Heart rate metric with upward trend
            HealthMetricCard(
                title: "Heart Rate",
                value: "72 BPM",
                icon: "heart.fill",
                color: .red,
                trend: MetricTrend(direction: .up, percentage: "+2%")
            )
            
            // Steps metric with stable trend
            HealthMetricCard(
                title: "Steps",
                value: "8,247",
                icon: "figure.walk",
                color: .green,
                trend: MetricTrend(direction: .stable, percentage: "0%")
            )
            
            // Sleep metric without trend
            HealthMetricCard(
                title: "Sleep",
                value: "7h 23m",
                icon: "bed.double.fill",
                color: .purple
            )
            
            // HRV metric with downward trend
            HealthMetricCard(
                title: "HRV",
                value: "42 ms",
                icon: "waveform.path.ecg",
                color: .blue,
                trend: MetricTrend(direction: .down, percentage: "-5%")
            )
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
#endif
