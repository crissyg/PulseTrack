//
//  DashboardView.swift
//  PulseTrack
//
//  Created by Tina G on 6/3/25.
//

import SwiftUI

// MARK: - Main Application Dashboard
/// DashboardView: Primary user interface for health monitoring and engagement
struct DashboardView: View {
    
    // MARK: - State Management
    /// Controls feedback modal presentation
    @State private var showingFeedback = false
    
    /// Controls notification alert display
    @State private var showingNotification = false
    
    /// Health data refresh state
    @State private var isRefreshingData = false
    
    /// Onboarding reset capability for development and testing
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    
    /// Current user's health metrics
    @State private var healthMetrics = HealthMetrics.sampleData
    
    // MARK: - Main User Interface
    /// Primary dashboard layout with health metrics and engagement features
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Welcome section with personalized greeting
                    WelcomeHeaderView(userName: "User")
                    
                    // Health metrics grid with real-time data
                    HealthMetricsGridView(
                        metrics: healthMetrics,
                        isRefreshing: isRefreshingData,
                        onRefresh: refreshHealthData
                    )
                    
                    // User engagement and feedback section
                    FeedbackPromptView(onFeedbackTap: {
                        showingFeedback = true
                    })
                    
                    // Additional health insights and recommendations
                    HealthInsightsView(metrics: healthMetrics)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
            .navigationTitle("PulseTrack")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                // Notification and engagement controls
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NotificationButton(onTap: {
                        showingNotification = true
                    })
                }
                
                // Development and testing controls
                #if DEBUG
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    DevelopmentControlsView(onReset: {
                        hasCompletedOnboarding = false
                    })
                }
                #endif
            }
            .refreshable {
                // Pull-to-refresh functionality
                await refreshHealthDataAsync()
            }
        }
        .sheet(isPresented: $showingFeedback) {
            // Modal feedback collection interface
            FeedbackView()
        }
        .alert("Daily Health Tip", isPresented: $showingNotification) {
            Button("Got it!") { }
        } message: {
            Text(generateHealthTip())
        }
        .onAppear {
            // Initialize dashboard data and services
            initializeDashboard()
        }
    }
    
    // MARK: - Data Management
    /// Refresh health data from connected devices and services
    private func refreshHealthData() {
        isRefreshingData = true
        
        // Simulate data refresh from health services
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            healthMetrics = HealthMetrics.refreshedData
            isRefreshingData = false
        }
    }
    
    /// Asynchronous health data refresh for pull-to-refresh
    private func refreshHealthDataAsync() async {
        isRefreshingData = true
        
        // Simulate async data fetch from health APIs
        try? await Task.sleep(nanoseconds: 1_500_000_000) // 1.5 seconds
        
        await MainActor.run {
            healthMetrics = HealthMetrics.refreshedData
            isRefreshingData = false
        }
    }
    
    /// Initialize dashboard services and data sources
    private func initializeDashboard() {
        // Initialize health data connections
        // Set up real-time monitoring
        // Configure notification preferences
        // Load user preferences and settings
    }
    
    /// Generate personalized health tips based on user data
    private func generateHealthTip() -> String {
        let tips = [
            "Your resting heart rate is excellent! Keep up the healthy habits.",
            "Consider taking a short walk to boost your daily step count.",
            "Your heart rate variability indicates good recovery. Great job!",
            "Stay hydrated - it helps maintain optimal heart function."
        ]
        return tips.randomElement() ?? tips[0]
    }
}

// MARK: - Welcome Header Component
/// Personalized welcome section with user greeting and summary
struct WelcomeHeaderView: View {
    let userName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Good \(timeOfDayGreeting()), \(userName)!")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Here's your pulse and health summary")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    /// Generate time-appropriate greeting
    private func timeOfDayGreeting() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 5..<12: return "morning"
        case 12..<17: return "afternoon"
        case 17..<22: return "evening"
        default: return "evening"
        }
    }
}

// MARK: - Health Metrics Grid Component
/// Grid layout for displaying health metrics with refresh capability
struct HealthMetricsGridView: View {
    let metrics: HealthMetrics
    let isRefreshing: Bool
    let onRefresh: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Health Metrics")
                    .font(.headline)
                
                Spacer()
                
                Button(action: onRefresh) {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(.blue)
                        .rotationEffect(.degrees(isRefreshing ? 360 : 0))
                        .animation(.linear(duration: 1).repeatCount(isRefreshing ? .max : 1, autoreverses: false), value: isRefreshing)
                }
                .disabled(isRefreshing)
            }
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 16) {
                HealthMetricCard(title: "Heart Rate", value: "\(metrics.heartRate) BPM", icon: "heart.fill", color: .red)
                HealthMetricCard(title: "Resting HR", value: "\(metrics.restingHeartRate) BPM", icon: "heart.circle", color: .orange)
                HealthMetricCard(title: "HRV", value: "\(metrics.heartRateVariability) ms", icon: "waveform.path.ecg", color: .blue)
                HealthMetricCard(title: "Steps", value: "\(metrics.stepCount)", icon: "figure.walk", color: .green)
            }
        }
    }
}

// MARK: - Health Insights Component
/// Additional health insights and recommendations section
struct HealthInsightsView: View {
    let metrics: HealthMetrics
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Health Insights")
                .font(.headline)
            
            VStack(spacing: 12) {
                InsightCard(
                    title: "Heart Rate Zone",
                    insight: generateHeartRateInsight(heartRate: metrics.heartRate),
                    icon: "heart.fill",
                    color: .red
                )
                
                InsightCard(
                    title: "Activity Level",
                    insight: generateActivityInsight(steps: metrics.stepCount),
                    icon: "figure.walk",
                    color: .green
                )
                
                InsightCard(
                    title: "Recovery Status",
                    insight: generateRecoveryInsight(hrv: metrics.heartRateVariability),
                    icon: "waveform.path.ecg",
                    color: .blue
                )
            }
        }
    }
    
    /// Generate heart rate zone insight based on current heart rate
    private func generateHeartRateInsight(heartRate: Int) -> String {
        switch heartRate {
        case 60...100:
            return "Your heart rate is in the normal range. Great job maintaining healthy cardiovascular fitness!"
        case 101...120:
            return "Slightly elevated heart rate. Consider relaxation techniques or check if you've been active recently."
        case 40..<60:
            return "Lower heart rate detected. This could indicate excellent fitness or may need medical attention."
        default:
            return "Monitor your heart rate closely and consult your healthcare provider if you have concerns."
        }
    }
    
    /// Generate activity level insight based on step count
    private func generateActivityInsight(steps: Int) -> String {
        switch steps {
        case 12000...:
            return "Outstanding! You're exceeding recommended daily activity levels. Keep up the excellent work!"
        case 10000..<12000:
            return "Excellent! You've met the daily step goal. Your activity level supports great cardiovascular health."
        case 7000..<10000:
            return "Good progress! You're close to your daily step goal. Consider a short walk to reach 10,000 steps."
        case 5000..<7000:
            return "Moderate activity level. Try to increase your daily movement with short walks or active breaks."
        default:
            return "Consider increasing your daily activity level. Even small increases in movement can benefit your health."
        }
    }
    
    /// Generate recovery insight based on heart rate variability
    private func generateRecoveryInsight(hrv: Int) -> String {
        switch hrv {
        case 50...:
            return "Excellent heart rate variability! Your body shows great recovery and stress resilience."
        case 30..<50:
            return "Good HRV levels indicate healthy recovery. Maintain your current wellness routine."
        case 20..<30:
            return "Moderate HRV. Consider stress management techniques and ensure adequate sleep for better recovery."
        default:
            return "Lower HRV detected. Focus on rest, stress reduction, and recovery activities for optimal health."
        }
    }
}

// MARK: - Insight Card Component
/// Individual insight display card
struct InsightCard: View {
    let title: String
    let insight: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(color)
                .frame(width: 24, height: 24)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                Text(insight)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.05), radius: 1, x: 0, y: 1)
    }
}

// MARK: - Notification Button Component
/// Notification bell button for user engagement
struct NotificationButton: View {
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            Image(systemName: "bell.badge")
                .foregroundColor(.red)
        }
    }
}

// MARK: - Development Controls Component
/// Development and testing controls (Debug only)
struct DevelopmentControlsView: View {
    let onReset: () -> Void
    
    var body: some View {
        Button("Reset") {
            onReset()
        }
        .font(.caption)
    }
}

// MARK: - Health Data Models
/// Structured health metrics data model
struct HealthMetrics {
    let heartRate: Int
    let restingHeartRate: Int
    let heartRateVariability: Int
    let stepCount: Int
    let lastUpdated: Date
    
    /// Sample data for development and testing
    static let sampleData = HealthMetrics(
        heartRate: 72,
        restingHeartRate: 65,
        heartRateVariability: 42,
        stepCount: 8247,
        lastUpdated: Date()
    )
    
    /// Refreshed data simulation
    static let refreshedData = HealthMetrics(
        heartRate: Int.random(in: 68...78),
        restingHeartRate: Int.random(in: 60...70),
        heartRateVariability: Int.random(in: 35...50),
        stepCount: Int.random(in: 7000...12000),
        lastUpdated: Date()
    )
}

// MARK: - Preview Support
#if DEBUG
struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
#endif
