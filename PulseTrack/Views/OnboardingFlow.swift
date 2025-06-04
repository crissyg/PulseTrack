//
//  OnboardingFlow.swift
//  PulseTrack
//
//  Created by Tina G on 6/3/25.
//

import SwiftUI

// MARK: - Onboarding Flow with User Engagement Strategy
struct OnboardingFlow: View {
    @State private var currentPage = 0
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    
    var body: some View {
        VStack(spacing: 0) {
            switch currentPage {
            case 0:
                OnboardingScreen1(onNext: { advanceToNextPage() })
            case 1:
                OnboardingScreen2(
                    onConnect: { advanceToNextPage() },
                    onSkip: { advanceToNextPage() }
                )
            case 2:
                OnboardingScreen3(onComplete: { completeOnboarding() })
            default:
                OnboardingScreen1(onNext: { advanceToNextPage() })
            }
        }
        .background(Color(.systemBackground))
    }
    
    // MARK: - Navigation Logic
    private func advanceToNextPage() {
        withAnimation(.easeInOut(duration: 0.5)) {
            currentPage += 1
        }
    }
    
    private func completeOnboarding() {
        withAnimation(.easeInOut(duration: 0.5)) {
            hasCompletedOnboarding = true
        }
    }
}

// MARK: - Onboarding Screen 1: Welcome
struct OnboardingScreen1: View {
    @State private var isPulsing = false
    let onNext: () -> Void
    
    var body: some View {
        VStack {
            // Top section with animated heart
            VStack(spacing: 32) {
                Spacer()
                    .frame(height: 96)
                
                // Heart icon with background circle
                ZStack {
                    Circle()
                        .fill(Color.red.opacity(0.1))
                        .frame(width: 128, height: 128)
                    
                    Image(systemName: "heart.fill")
                        .font(.system(size: 64))
                        .foregroundColor(.red)
                        .scaleEffect(isPulsing ? 1.1 : 1.0)
                        .animation(
                            .easeInOut(duration: 1.0)
                            .repeatForever(autoreverses: true),
                            value: isPulsing
                        )
                }
                
                // Title and subtitle
                VStack(spacing: 8) {
                    Text("Welcome to PulseTrack")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                    
                    Text("Heart Health Monitoring Made Simple")
                        .font(.system(size: 16))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
            }
            
            Spacer()
            
            // Bottom button
            VStack {
                Button(action: onNext) {
                    Text("Get Started")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.red)
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            isPulsing = true
        }
    }
}

// MARK: - Onboarding Screen 2: Apple Watch Connection
struct OnboardingScreen2: View {
    let onConnect: () -> Void
    let onSkip: () -> Void
    
    var body: some View {
        VStack {
            // Top section with Apple Watch illustration
            VStack(spacing: 32) {
                Spacer()
                    .frame(height: 96)
                
                // Apple Watch with heartbeat illustration
                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.gray.opacity(0.1))
                        .frame(width: 192, height: 192)
                    
                    VStack(spacing: 16) {
                        Image(systemName: "applewatch")
                            .font(.system(size: 64))
                            .foregroundColor(.primary)
                        
                        Image(systemName: "waveform.path.ecg")
                            .font(.system(size: 32))
                            .foregroundColor(.red)
                    }
                }
                
                // Title and subtitle
                VStack(spacing: 8) {
                    Text("Connect Apple Watch")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                    
                    Text("Real-time pulse monitoring and health insights")
                        .font(.system(size: 16))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
            }
            
            Spacer()
            
            // Bottom buttons
            VStack(spacing: 12) {
                Button(action: onConnect) {
                    Text("Connect Device")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.red)
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                }
                .padding(.horizontal, 24)
                
                Button(action: onSkip) {
                    Text("Skip for Now")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.secondary)
                }
                .padding(.bottom, 40)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Onboarding Screen 3: Health Insights Preview
struct OnboardingScreen3: View {
    let onComplete: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            // Top section with title
            VStack(spacing: 24) {
                Spacer()
                    .frame(height: 48)
                
                Text("Health Insights Preview")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                
                // Health card with pulse data
                VStack(spacing: 16) {
                    HealthPreviewCard()
                    InsightPreviewCard()
                }
                .padding(.horizontal, 24)
            }
            
            Spacer()
            
            // Bottom button
            VStack {
                Button(action: onComplete) {
                    Text("Start Tracking")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.red)
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Health Preview Card Component
struct HealthPreviewCard: View {
    var body: some View {
        VStack(spacing: 16) {
            // Header with current pulse
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Current Pulse")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    HStack(alignment: .bottom, spacing: 4) {
                        Text("72")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.primary)
                        
                        Text("BPM")
                            .font(.system(size: 18))
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
                
                // Heart icon
                ZStack {
                    Circle()
                        .fill(Color.red.opacity(0.1))
                        .frame(width: 48, height: 48)
                    
                    Image(systemName: "waveform.path.ecg")
                        .font(.system(size: 20))
                        .foregroundColor(.red)
                }
            }
            
            // Chart bars
            HStack(alignment: .bottom, spacing: 16) {
                ChartBar(height: 64, label: "6AM")
                ChartBar(height: 96, label: "12PM")
                ChartBar(height: 128, label: "6PM")
                ChartBar(height: 80, label: "12AM")
            }
        }
        .padding(20)
        .background(Color(.systemGray6))
        .cornerRadius(16)
    }
}

// MARK: - Chart Bar Component
struct ChartBar: View {
    let height: CGFloat
    let label: String
    
    var body: some View {
        VStack(spacing: 4) {
            RoundedRectangle(cornerRadius: 2)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.red.opacity(0.3), Color.red]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                )
                .frame(width: 4, height: height)
            
            Text(label)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - Insight Preview Card Component
struct InsightPreviewCard: View {
    var body: some View {
        HStack(spacing: 12) {
            // Lightbulb icon
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 32, height: 32)
                
                Image(systemName: "lightbulb.fill")
                    .font(.system(size: 16))
                    .foregroundColor(.yellow)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Personalized Recommendation")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
                
                Text("Take a 5-minute walk. Your resting heart rate is slightly elevated compared to your average.")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
        }
        .padding(20)
        .background(Color(.systemGray6))
        .cornerRadius(16)
    }
}

// MARK: - Preview Support
#if DEBUG
struct OnboardingFlow_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingFlow()
    }
}
#endif

//// MARK: - User Onboarding Flow Controller
///// OnboardingFlow: Manages new user introduction and engagement strategy
//
//struct OnboardingFlow: View {
//    
//    // MARK: - State Management
//    /// Current page index for onboarding progression
//    /// Tracks user progress through introduction flow
//    @State private var currentPage = 0
//    
//    /// Persistent flag for onboarding completion
//    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
//    
//    /// Animation state for smooth page transitions
//    @State private var isTransitioning = false
//    
//    // MARK: - Onboarding Content Configuration
//    /// Static content array defining onboarding screens
//    let onboardingPages = [
//        OnboardingPage(
//            title: "Welcome to PulseTrack",
//            subtitle: "Your personal pulse and heart rate monitoring companion for comprehensive health insights",
//            imageName: "heart.fill",
//            color: .red
//        ),
//        OnboardingPage(
//            title: "Real-Time Pulse Monitoring",
//            subtitle: "Connect your Apple Watch for continuous heart rate tracking and instant health alerts",
//            imageName: "applewatch",
//            color: .blue
//        ),
//        OnboardingPage(
//            title: "Personalized Health Insights",
//            subtitle: "Get data-driven recommendations based on your pulse patterns and health trends",
//            imageName: "waveform.path.ecg",
//            color: .green
//        )
//    ]
//    
//    // MARK: - Main User Interface
//    /// Primary onboarding interface with progressive disclosure
//    var body: some View {
//        VStack(spacing: 0) {
//            // Progress indicator for user orientation
//            ProgressIndicatorView(currentPage: currentPage, totalPages: onboardingPages.count)
//                .padding(.top, 20)
//            
//            // Swipeable content pages with smooth transitions
//            TabView(selection: $currentPage) {
//                ForEach(0..<onboardingPages.count, id: \.self) { index in
//                    OnboardingPageView(page: onboardingPages[index])
//                        .tag(index)
//                }
//            }
//            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//            .disabled(isTransitioning) // Prevent interaction during transitions
//            
//            // Navigation controls with dynamic behavior
//            NavigationControlsView(
//                currentPage: currentPage,
//                totalPages: onboardingPages.count,
//                buttonColor: onboardingPages[currentPage].color,
//                onNext: advanceToNextPage,
//                onComplete: completeOnboarding
//            )
//            .padding(.horizontal, 24)
//            .padding(.bottom, 30)
//        }
//        .background(Color(.systemBackground))
//        .onAppear {
//            // Initialize onboarding analytics and tracking
//            trackOnboardingStart()
//        }
//    }
//    
//    // MARK: - Navigation Logic
//    /// Advance to next onboarding page with smooth animation
//    private func advanceToNextPage() {
//        guard currentPage < onboardingPages.count - 1 else { return }
//        
//        isTransitioning = true
//        withAnimation(.easeInOut(duration: 0.3)) {
//            currentPage += 1
//        }
//        
//        // Re-enable interaction after animation completes
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//            isTransitioning = false
//        }
//        
//        // Track page progression for analytics
//        trackOnboardingProgress(page: currentPage)
//    }
//    
//    /// Complete onboarding flow and transition to main app
//    private func completeOnboarding() {
//        // Mark onboarding as completed with smooth transition
//        withAnimation(.easeInOut(duration: 0.5)) {
//            hasCompletedOnboarding = true
//        }
//        
//        // Track successful onboarding completion
//        trackOnboardingCompletion()
//        
//        // Initialize user preferences and default settings
//        initializeUserDefaults()
//    }
//    
//    // MARK: - Analytics and Tracking
//    /// Track onboarding start for user engagement metrics
//    private func trackOnboardingStart() {
//        // Log onboarding initiation
//    }
//    
//    /// Track user progress through onboarding pages
//    private func trackOnboardingProgress(page: Int) {
//        // Log page completion and time spent
//    }
//    
//    /// Track successful onboarding completion
//    private func trackOnboardingCompletion() {
//        // Record successful onboarding completion
//    }
//    
//    /// Initialize default user settings after onboarding
//    private func initializeUserDefaults() {
//        // Set default health tracking preferences
//        // Configure notification settings
//    }
//}
//
//// MARK: - Progress Indicator Component
///// Visual progress indicator for onboarding flow
//struct ProgressIndicatorView: View {
//    let currentPage: Int
//    let totalPages: Int
//    
//    var body: some View {
//        HStack(spacing: 8) {
//            ForEach(0..<totalPages, id: \.self) { index in
//                Circle()
//                    .fill(index == currentPage ? Color.primary : Color.secondary.opacity(0.3))
//                    .frame(width: 8, height: 8)
//                    .animation(.easeInOut(duration: 0.2), value: currentPage)
//            }
//        }
//    }
//}
//
//// MARK: - Navigation Controls Component
///// Reusable navigation controls for onboarding flow
//struct NavigationControlsView: View {
//    let currentPage: Int
//    let totalPages: Int
//    let buttonColor: Color
//    let onNext: () -> Void
//    let onComplete: () -> Void
//    
//    var body: some View {
//        Button(action: {
//            if currentPage < totalPages - 1 {
//                onNext()
//            } else {
//                onComplete()
//            }
//        }) {
//            Text(currentPage == totalPages - 1 ? "Start Tracking" : "Next")
//                .font(.headline)
//                .foregroundColor(.white)
//                .frame(maxWidth: .infinity)
//                .padding(.vertical, 16)
//                .background(buttonColor)
//                .cornerRadius(12)
//        }
//        .disabled(false) // Add validation logic here if needed
//    }
//}
