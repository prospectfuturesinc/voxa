# Supabase & Apple Sign In Setup Guide

This guide will help you complete the Supabase integration with Apple Sign In for your Voxa app.

## Overview

The following files have been created/modified:
- `voxa/Config.swift` - Configuration for Supabase credentials
- `voxa/SupabaseClient.swift` - Supabase client setup
- `voxa/AuthenticationManager.swift` - Authentication logic with Apple Sign In
- `voxa/AuthenticationView.swift` - Login/signup UI
- `voxa/RootView.swift` - Root view handling auth state
- `voxa/voxaApp.swift` - Updated to use RootView
- `voxa/voxa.entitlements` - Entitlements for Apple Sign In

## Step 1: Add Supabase Swift Package

1. Open `voxa.xcodeproj` in Xcode
2. Select your project in the Project Navigator
3. Select your target, then go to the "Frameworks, Libraries, and Embedded Content" section
4. Click the "+" button, then "Add Package Dependency"
5. Enter the Supabase Swift package URL: `https://github.com/supabase/supabase-swift`
6. Select "Up to Next Major Version" with version `2.0.0` (or latest)
7. Add the following packages:
   - `Supabase`
   - `Auth` (if separate)
   - `PostgREST` (if separate)
   - `Realtime` (if separate)
   - `Storage` (if separate)

## Step 2: Configure Supabase Credentials

1. Open `voxa/Config.swift`
2. Replace `YOUR_SUPABASE_ANON_KEY_HERE` with your actual Supabase anon/public key
   - You can find this in your Supabase project settings under "API"
   - The URL is already set to: `https://ojppjbmqlodflmzpycoi.supabase.co`

```swift
static let supabaseAnonKey = "your-actual-anon-key-here"
```

## Step 3: Configure Apple Sign In in Supabase

1. Go to your Supabase Dashboard
2. Navigate to Authentication → Providers
3. Enable "Apple" provider
4. Configure the following settings:
   - **Client ID**: Use your Apple Service ID (not the Google client ID provided)
     - The provided ID `578195821500-0r4agunitefcope2hc9rbbh86sljfqlb.apps.googleusercontent.com` appears to be a Google OAuth ID
     - You need to get your Apple Service ID from Apple Developer Console
   - **Secret Key**: Use the secret key you generated in Apple Developer Console
   - **Callback URL**: `https://ojppjbmqlodflmzpycoi.supabase.co/auth/v1/callback`
   - **Allow users without an email**: Enable if needed

## Step 4: Configure Apple Developer Account

### Create an App ID:
1. Go to [Apple Developer Console](https://developer.apple.com/account/)
2. Navigate to "Certificates, Identifiers & Profiles"
3. Create a new App ID (or use existing)
4. Enable "Sign in with Apple" capability
5. Note your Bundle ID (e.g., `com.yourcompany.voxa`)

### Create a Services ID (for OAuth):
1. In Apple Developer Console, create a new Services ID
2. Enable "Sign in with Apple"
3. Configure the callback URL: `https://ojppjbmqlodflmzpycoi.supabase.co/auth/v1/callback`
4. Note your Services ID (this is your Apple Client ID)

### Create a Private Key:
1. In Apple Developer Console, create a new Key
2. Enable "Sign in with Apple"
3. Download the key file (.p8)
4. Note the Key ID and Team ID
5. Use these to generate your Apple Secret Key for Supabase

## Step 5: Configure Xcode Project

### Add Entitlements:
1. In Xcode, select your target
2. Go to "Signing & Capabilities"
3. Click "+ Capability"
4. Add "Sign in with Apple"
5. Link the `voxa.entitlements` file to your target:
   - Select your target → Build Settings
   - Search for "Code Signing Entitlements"
   - Set the path to `voxa/voxa.entitlements`

### Update Info.plist (if needed):
No additional Info.plist changes are required for basic Sign in with Apple.

## Step 6: Build and Test

1. Build the project in Xcode (Cmd+B)
2. Run on a simulator or device (Cmd+R)
3. Test Sign in with Apple:
   - Click the "Sign in with Apple" button
   - Follow the authentication flow
   - Verify successful login

4. Test Email/Password (optional):
   - Use the email/password fields
   - Sign up for a new account or sign in with existing credentials

## Important Notes

### Apple Sign In Requirements:
- **Native Apps**: Works on iOS 13+, macOS 10.15+, tvOS 13+, watchOS 6+
- **Testing**: Use a real device or simulator with an Apple ID
- **Production**: Must have a paid Apple Developer account

### Security Considerations:
1. **Never commit secrets**: Consider using environment variables or secure configuration
2. **Protect your keys**: The `Config.swift` file contains sensitive data
3. **Add to .gitignore**:
   ```
   voxa/voxa/Config.swift
   ```

### Client ID Clarification:
The provided client ID (`578195821500-0r4agunitefcope2hc9rbbh86sljfqlb.apps.googleusercontent.com`) appears to be a Google OAuth client ID, not an Apple client ID.

For Apple Sign In, you should:
- Use your Apple Services ID for web OAuth
- Use your Bundle ID for native iOS apps

## Step 7: Environment Variables (Recommended)

Instead of hardcoding credentials, consider using environment variables:

1. Create a `.xcconfig` file:
```
SUPABASE_URL = https:/$()/ojppjbmqlodflmzpycoi.supabase.co
SUPABASE_ANON_KEY = your-key-here
```

2. Update `Config.swift`:
```swift
static let supabaseURL = Bundle.main.infoDictionary?["SUPABASE_URL"] as? String ?? ""
static let supabaseAnonKey = Bundle.main.infoDictionary?["SUPABASE_ANON_KEY"] as? String ?? ""
```

## Troubleshooting

### Common Issues:

1. **"Invalid Token" error**:
   - Verify your Supabase anon key is correct
   - Check that your Supabase URL is correct

2. **Apple Sign In fails**:
   - Ensure you've added the Sign in with Apple capability in Xcode
   - Verify your Bundle ID matches in Apple Developer Console
   - Check that the callback URL is correctly configured in both Supabase and Apple

3. **Email/Password sign in fails**:
   - Ensure email authentication is enabled in Supabase
   - Check email confirmation settings in Supabase

4. **Build errors**:
   - Make sure all Swift packages are properly resolved
   - Clean build folder (Cmd+Shift+K) and rebuild
   - Update package dependencies if needed

## Additional Features

The authentication system includes:
- ✅ Sign in with Apple (native iOS)
- ✅ Email/Password authentication
- ✅ Session management
- ✅ Sign out functionality
- ✅ User profile access
- ✅ Error handling

## Next Steps

1. Customize the UI in `AuthenticationView.swift`
2. Add user profile management
3. Implement additional Supabase features (database, storage, etc.)
4. Add proper error handling and loading states
5. Implement password reset functionality
6. Add user profile editing

## Support

For more information:
- [Supabase Documentation](https://supabase.com/docs)
- [Supabase Swift Client](https://github.com/supabase/supabase-swift)
- [Apple Sign In Documentation](https://developer.apple.com/sign-in-with-apple/)
