# PulseTrack

A iOS health monitoring app focused on heart rate tracking and pulse analysis, built with SwiftUI.

## Overview

PulseTrack is a personal health companion that provides real-time pulse monitoring, heart rate insights, and personalized health recommendations. The app features a clean, intuitive interface designed specifically for continuous heart health tracking.

## Features

### 📱 Core Functionality
- **Real-time Heart Rate Monitoring** - Track your pulse with precision
- **Health Metrics Dashboard** - View heart rate, resting HR, HRV, and daily steps
- **Personalized Insights** - Get AI-driven health recommendations based on your data
- **Apple Watch Integration** - Seamless connection for continuous monitoring

### 🎨 User Experience
- **Smooth Onboarding** - Three-screen introduction to app features
- **Interactive Feedback System** - 5-star rating with category-based feedback collection
- **Pull-to-Refresh** - Real-time data updates with visual feedback
- **Dark/Light Mode Support** - Adapts to system preferences

### 💡 Health Insights
- Heart rate zone analysis
- Activity level recommendations
- Recovery status monitoring
- Personalized health tips

## Technical Stack

- **Framework:** SwiftUI
- **Platform:** iOS 15.0+
- **Architecture:** MVVM with modular components
- **Data Storage:** AppStorage for user preferences
- **Animation:** Native SwiftUI animations with smooth transitions

## Project Structure

```
PulseTrackApp/
├── App/
│   └── PulseTrackApp.swift
├── Views/
│   ├── ContentView.swift
│   ├── OnboardingFlow.swift
│   ├── DashboardView.swift
│   └── FeedbackView.swift
├── Components/
│   ├── OnboardingPageView.swift
│   ├── HealthMetricCard.swift
│   └── FeedbackPromptView.swift
├── Models/
│   └── OnboardingPage.swift
└── Assets.xcassets/
```

## Getting Started

### Prerequisites
- Xcode 15.0 or later
- iOS 15.0+ deployment target
- macOS Monterey or later

### Installation
1. Clone the repository
2. Open `PulseTrackApp.xcodeproj` in Xcode
3. Select your target device or simulator
4. Press `Cmd + R` to build and run

### First Launch
The app will guide you through a three-step onboarding process:
1. Welcome screen with app introduction
2. Apple Watch connection setup
3. Health insights preview

## App Flow

1. **Launch** - Animated loading screen with pulse effect
2. **Onboarding** - First-time user introduction (skipped for returning users)
3. **Dashboard** - Main health metrics display with real-time data
4. **Insights** - Personalized recommendations based on health data
5. **Feedback** - User engagement system for continuous improvement

## Key Components

### Health Metrics
- Heart Rate (BPM)
- Resting Heart Rate
- Heart Rate Variability (HRV)
- Daily Step Count

### Interactive Elements
- Tap-to-refresh health data
- Star rating feedback system
- Category-based feedback collection
- Smooth page transitions

## Design Philosophy

PulseTrack follows Apple's Human Interface Guidelines with emphasis on:
- **Clarity** - Clean typography and visual hierarchy
- **Deference** - Content-focused design that highlights health data
- **Depth** - Layered interface with smooth animations

## Future Enhancements

- HealthKit integration for comprehensive data collection
- Advanced analytics and trend visualization
- Social features for health goal sharing
- Customizable notification preferences
- Export functionality for health reports

## Demo

Try the interactive demo: [PulseTrack Live Demo](https://appetize.io/app/b_orgczisbezjgfyzahlu3ihqja4)


---