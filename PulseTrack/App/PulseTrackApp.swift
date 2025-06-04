//
//  PulseTrackApp.swift
//  PulseTrack
//
//  Created by Tina G on 6/3/25.
//

import SwiftUI

// MARK: - Main Application Entry Point
/// PulseTrackApp: Primary application struct that defines the app's lifecycle and root scene

@main
struct PulseTrackApp: App {
    
    // MARK: - Scene Configuration
    /// Defines the main window group for the iOS app

    var body: some Scene {
        WindowGroup {
            // Root view controller - delegates navigation logic to ContentView
            ContentView()
        }
    }
}

// MARK: - Application Lifecycle Management
/// Extension to handle app-wide state and lifecycle events
extension PulseTrackApp {
    
    /// Initialize any app-wide services or configurations here
    private func configureAppServices() {
        // Configure health data permissions
        // Set up analytics tracking
        // Initialize crash reporting
        // Configure network layer for API calls
    }
    
    /// Handle app state transitions (background/foreground)
    private func handleAppStateChanges() {
        // Pause health tracking when app goes to background
        // Resume data collection when app becomes active
        // Handle memory management for optimal performance
    }
}

// MARK: - Development and Testing Support
#if DEBUG
/// Development-only configurations and debugging tools
extension PulseTrackApp {
    
    /// Enable SwiftUI preview support for development
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
    
    /// Development flags for testing different app states
    private var isDevelopmentMode: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
}
#endif

// MARK: - App Configuration Constants
/// Centralized configuration similar to your Infrastructure as Code principles
struct AppConfiguration {
    
    /// App metadata and versioning
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    static let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
    
    /// Feature flags for gradual rollout
    struct FeatureFlags {
        static let enableAdvancedMetrics = true
        static let enableAppleWatchSync = true
        static let enableBetaFeatures = false
    }
    
    /// Health data collection intervals
    struct HealthTracking {
        static let heartRateUpdateInterval: TimeInterval = 30.0  // 30 seconds
        static let stepCountUpdateInterval: TimeInterval = 60.0  // 1 minute
        static let sleepDataSyncInterval: TimeInterval = 3600.0  // 1 hour
    }
}
