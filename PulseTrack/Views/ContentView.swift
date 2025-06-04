//
//  ContentView.swift
//  PulseTrack
//
//  Created by Tina G on 6/3/25.
//

import SwiftUI

// MARK: - Root Content View Controller
/// ContentView: Primary navigation controller that manages app-wide user flow
struct ContentView: View {
    
    // MARK: - State Management
    /// Persistent storage for onboarding completion status
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    
    /// Loading state for smooth app initialization
    @State private var isAppInitializing = true
    
    // MARK: - Main Navigation Logic
    /// Primary view composition that determines user flow
    var body: some View {
        Group {
            if isAppInitializing {
                // Show loading state during app startup
                AppLoadingView()
            } else if hasCompletedOnboarding {
                // Returning users: Direct to main application dashboard
                DashboardView()
            } else {
                // New users: Guide through onboarding flow
                OnboardingFlow()
            }
        }
        .onAppear {
            // Initialize app services and perform startup checks
            initializeAppServices()
        }
    }
    
    // MARK: - App Initialization
    /// Handles app startup sequence and service initialization
    private func initializeAppServices() {
        // Simulate app initialization time (health checks, service validation)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(.easeInOut(duration: 0.5)) {
                isAppInitializing = false
            }
        }
        
        // Initialize core app services here:
        // - Health data permissions
        // - Analytics setup
        // - Network configuration
        // - Background task registration
    }
}

// MARK: - App Loading View Component
/// Loading screen displayed during app initialization
struct AppLoadingView: View {
    
    /// Animation state for pulse effect
    @State private var isPulsing = false
    
    /// Interactive state for user feedback
    @State private var isPressed = false
    
    /// Animation state for tap feedback
    @State private var tapScale: CGFloat = 1.0
    
    var body: some View {
        VStack(spacing: 24) {
            // Animated app logo with pulse effect and interactive feedback
            ZStack {
                Circle()
                    .fill(Color.red.opacity(0.2))
                    .frame(width: 100, height: 100)
                    .scaleEffect(isPulsing ? 1.3 : 1.0)
                    .opacity(isPulsing ? 0.3 : 0.7)
                    .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: isPulsing)
                
                Image(systemName: "heart.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.red)
                    .scaleEffect(isPressed ? 0.9 : 1.0)
                    .scaleEffect(tapScale)
                    .animation(.easeInOut(duration: 0.1), value: isPressed)
                    .animation(.easeInOut(duration: 0.2), value: tapScale)
            }
            .onTapGesture {
                // Provide visual feedback for user interaction
                withAnimation(.easeInOut(duration: 0.1)) {
                    tapScale = 0.95
                }
                
                // Return to normal size after brief delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        tapScale = 1.0
                    }
                }
            }
            .onLongPressGesture(
                minimumDuration: 0,
                pressing: { isPressing in
                    // Handle press state for visual feedback
                    isPressed = isPressing
                }
            ) {
                // Optional: Handle long press completion if needed
            }
            
            // App branding and tagline
            VStack(spacing: 8) {
                Text("PulseTrack")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text("Heart Health Monitoring Made Simple")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            // Loading indicator
            ProgressView()
                .scaleEffect(1.2)
                .padding(.top, 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
        .onAppear {
            // Start pulse animation when view appears
            isPulsing = true
        }
    }
}

// MARK: - Development and Testing Support
#if DEBUG
/// Preview provider for SwiftUI canvas development
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Preview with onboarding completed
            ContentView()
                .previewDisplayName("Returning User")
                .onAppear {
                    UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
                }
            
            // Preview with fresh installation
            ContentView()
                .previewDisplayName("New User")
                .onAppear {
                    UserDefaults.standard.set(false, forKey: "hasCompletedOnboarding")
                }
            
            // Preview loading state
            AppLoadingView()
                .previewDisplayName("App Loading")
        }
    }
}
#endif

// MARK: - Navigation State Management
/// Extension for handling complex navigation scenarios
extension ContentView {
    
    /// Reset app to initial state for testing and development
    func resetAppState() {
        hasCompletedOnboarding = false
        isAppInitializing = true
        
        // Reset any cached user data
        // Clear temporary files
        // Reset user preferences to defaults
    }
    
    /// Handle deep linking and external navigation
    func handleDeepLink(_ url: URL) {
        // Parse incoming URLs for navigation
        // Handle health data sharing links
        // Process notification actions
        // Navigate to specific app sections
    }
    
    /// Validate app state and handle edge cases
    private func validateAppState() {
        // Check for corrupted user data
        // Validate health permissions
        // Ensure network connectivity
        // Handle offline scenarios
    }
}
