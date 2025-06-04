//
//  FeedbackView.swift
//  PulseTrack
//
//  Created by Tina G on 6/3/25.
//

import SwiftUI

// MARK: - User Feedback Collection Interface
/// FeedbackView: Comprehensive feedback collection system for continuous improvement
struct FeedbackView: View {
    
    // MARK: - State Management
    /// Modal dismissal control
    @Environment(\.dismiss) private var dismiss
    
    /// User's text feedback input
    @State private var feedbackText = ""
    
    /// User's numerical rating selection
    @State private var selectedRating = 5
    
    /// Feedback category selection
    @State private var selectedCategory: FeedbackCategory = .general
    
    /// Form validation state
    @State private var isFormValid = true
    
    /// Submission confirmation state
    @State private var showingThankYou = false
    
    /// Submission processing state
    @State private var isSubmitting = false
    
    // MARK: - Feedback Categories
    /// Structured feedback categorization for efficient analysis
    enum FeedbackCategory: String, CaseIterable {
        case general = "General"
        case pulseTracking = "Pulse Tracking"
        case userInterface = "User Interface"
        case performance = "Performance"
        case features = "Feature Requests"
        
        var icon: String {
            switch self {
            case .general: return "bubble.left.and.bubble.right"
            case .pulseTracking: return "heart.fill"
            case .userInterface: return "paintbrush"
            case .performance: return "speedometer"
            case .features: return "plus.circle"
            }
        }
    }
    
    // MARK: - Main User Interface
    /// Comprehensive feedback collection form with validation
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Header section with clear purpose statement
                    FeedbackHeaderView()
                    
                    // Rating selection with visual feedback
                    RatingSelectionView(selectedRating: $selectedRating)
                    
                    // Category selection for structured feedback
                    CategorySelectionView(selectedCategory: $selectedCategory)
                    
                    // Detailed text feedback input
                    TextFeedbackView(
                        feedbackText: $feedbackText,
                        category: selectedCategory,
                        isValid: $isFormValid
                    )
                    
                    // Contact information (optional)
                    ContactInformationView()
                    
                    Spacer(minLength: 20)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
            }
            .navigationTitle("Feedback")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Navigation controls with submission handling
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Submit") {
                        submitFeedback()
                    }
                    .disabled(!isFormValid || isSubmitting)
                }
            }
        }
        .alert("Thank You!", isPresented: $showingThankYou) {
            Button("Done") {
                dismiss()
            }
        } message: {
            Text("Your feedback helps us improve PulseTrack's pulse monitoring capabilities and user experience.")
        }
        .onAppear {
            // Initialize feedback form and analytics
            initializeFeedbackForm()
        }
    }
    
    // MARK: - Feedback Submission Logic
    /// Process and submit user feedback with validation
    private func submitFeedback() {
        // Validate form inputs before submission
        guard validateFeedbackForm() else {
            isFormValid = false
            return
        }
        
        isSubmitting = true
        
        // Simulate feedback submission to backend services
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            // Process feedback submission
            processFeedbackSubmission()
            
            // Show confirmation and dismiss
            isSubmitting = false
            showingThankYou = true
        }
    }
    
    /// Validate feedback form inputs
    private func validateFeedbackForm() -> Bool {
        // Validate rating selection
        guard selectedRating > 0 else { return false }
        
        // Validate text feedback for meaningful content
        let trimmedFeedback = feedbackText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmedFeedback.count >= 10 else { return false }
        
        // Additional validation rules can be added here
        return true
    }
    
    /// Process feedback submission and analytics
    private func processFeedbackSubmission() {
        let feedbackData = FeedbackSubmission(
            rating: selectedRating,
            category: selectedCategory,
            text: feedbackText,
            timestamp: Date(),
            appVersion: Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
        )
        
        // Submit to analytics service
        // Log feedback for analysis
        // Update user engagement metrics
        // Trigger follow-up workflows if needed
    }
    
    /// Initialize feedback form and tracking
    private func initializeFeedbackForm() {
        // Set default values
        // Initialize analytics tracking
        // Load user preferences
        // Configure form validation rules
    }
}

// MARK: - Feedback Header Component
/// Clear header explaining feedback purpose and value
struct FeedbackHeaderView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "heart.text.square")
                .font(.system(size: 48))
                .foregroundColor(.red)
            
            Text("Help Improve PulseTrack")
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            
            Text("Your feedback drives our development priorities and helps us create better pulse monitoring experiences for everyone.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

// MARK: - Rating Selection Component
/// Interactive star rating selection with visual feedback
struct RatingSelectionView: View {
    @Binding var selectedRating: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("How would you rate PulseTrack?")
                .font(.headline)
            
            HStack(spacing: 8) {
                ForEach(1...5, id: \.self) { star in
                    Button(action: {
                        selectedRating = star
                    }) {
                        Image(systemName: star <= selectedRating ? "star.fill" : "star")
                            .foregroundColor(.yellow)
                            .font(.title2)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                Spacer()
                
                Text("\(selectedRating)/5")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

// MARK: - Category Selection Component
/// Structured category selection for organized feedback analysis
struct CategorySelectionView: View {
    @Binding var selectedCategory: FeedbackView.FeedbackCategory
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Feedback Category")
                .font(.headline)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(FeedbackView.FeedbackCategory.allCases, id: \.self) { category in
                        CategoryButton(
                            category: category,
                            isSelected: selectedCategory == category,
                            onTap: {
                                selectedCategory = category
                            }
                        )
                    }
                }
                .padding(.horizontal, 4)
            }
        }
    }
}

// MARK: - Category Button Component
/// Individual category selection button with visual state
struct CategoryButton: View {
    let category: FeedbackView.FeedbackCategory
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 8) {
                Image(systemName: category.icon)
                    .font(.caption)
                
                Text(category.rawValue)
                    .font(.caption)
                    .fontWeight(.medium)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(isSelected ? Color.blue : Color.gray.opacity(0.2))
            .foregroundColor(isSelected ? .white : .primary)
            .cornerRadius(20)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Text Feedback Component
/// Detailed text input with category-specific prompts
struct TextFeedbackView: View {
    @Binding var feedbackText: String
    let category: FeedbackView.FeedbackCategory
    @Binding var isValid: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Tell us more")
                .font(.headline)
            
            Text(placeholderText)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            TextField("", text: $feedbackText, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .lineLimit(4...8)
                .onChange(of: feedbackText) { _, newValue in
                    validateInput(newValue)
                }
            
            HStack {
                Text("\(feedbackText.count) characters")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                if !isValid {
                    Text("Please provide at least 10 characters")
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
        }
    }
    
    /// Generate category-specific placeholder text
    private var placeholderText: String {
        switch category {
        case .general:
            return "Share your overall experience with PulseTrack"
        case .pulseTracking:
            return "How can we improve pulse monitoring accuracy and features?"
        case .userInterface:
            return "What interface improvements would enhance your experience?"
        case .performance:
            return "Tell us about any performance issues or suggestions"
        case .features:
            return "What new features would you like to see in PulseTrack?"
        }
    }
    
    /// Validate text input in real-time
    private func validateInput(_ text: String) {
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        isValid = trimmedText.count >= 10
    }
}

// MARK: - Contact Information Component
/// Optional contact information for follow-up communication
struct ContactInformationView: View {
    @State private var contactEmail = ""
    @State private var allowFollowUp = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Contact Information (Optional)")
                .font(.headline)
            
            Text("Provide your email if you'd like us to follow up on your feedback")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            TextField("your.email@example.com", text: $contactEmail)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            
            Toggle("Allow follow-up communication", isOn: $allowFollowUp)
                .font(.subheadline)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

// MARK: - Feedback Data Models
/// Structured feedback submission data model
struct FeedbackSubmission {
    let rating: Int
    let category: FeedbackView.FeedbackCategory
    let text: String
    let timestamp: Date
    let appVersion: String
    let contactEmail: String?
    let allowFollowUp: Bool
    
    init(rating: Int, category: FeedbackView.FeedbackCategory, text: String, timestamp: Date, appVersion: String, contactEmail: String? = nil, allowFollowUp: Bool = false) {
        self.rating = rating
        self.category = category
        self.text = text
        self.timestamp = timestamp
        self.appVersion = appVersion
        self.contactEmail = contactEmail
        self.allowFollowUp = allowFollowUp
    }
}

// MARK: - Preview Support
#if DEBUG
struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackView()
    }
}
#endif
