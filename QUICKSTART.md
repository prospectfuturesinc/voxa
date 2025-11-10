# Quick Start Guide

## Prerequisites
- Xcode 15+ (for iOS 17+ support)
- macOS 13+ (Ventura or later)
- Apple Developer Account
- Supabase Account

## Quick Setup (5 minutes)

### 1. Install Dependencies (2 min)
1. Open `voxa.xcodeproj` in Xcode
2. Go to File → Add Package Dependencies
3. Add: `https://github.com/supabase/supabase-swift`
4. Select version 2.0.0 or later
5. Wait for package resolution

### 2. Configure Credentials (1 min)
1. Copy `voxa/voxa/Config.swift.template` to `voxa/voxa/Config.swift`
2. Open `voxa/voxa/Config.swift`
3. Replace `YOUR_SUPABASE_ANON_KEY_HERE` with your Supabase anon key
   - Find it at: Supabase Dashboard → Settings → API → anon/public key

### 3. Enable Sign in with Apple (1 min)
1. Select your target in Xcode
2. Go to "Signing & Capabilities"
3. Click "+ Capability"
4. Add "Sign in with Apple"
5. Ensure the entitlements file is linked

### 4. Configure Supabase Dashboard (1 min)
1. Go to Supabase Dashboard → Authentication → Providers
2. Enable "Apple" provider
3. Add your Apple Service ID (from Apple Developer Console)
4. Add your Apple Secret Key
5. Save configuration

### 5. Build & Run
```bash
# From Xcode:
Cmd+B to build
Cmd+R to run
```

## What's Included

✅ **Authentication System**
- Sign in with Apple (native iOS)
- Email/Password authentication
- Session management
- Auto-login on app launch
- Sign out functionality

✅ **UI Components**
- Login/Signup screen
- User profile menu
- Error handling
- Loading states

✅ **Security**
- Secure token storage
- Apple's privacy-preserving authentication
- Supabase authentication backend

## File Structure
```
voxa/
├── voxa/
│   ├── voxaApp.swift              # App entry point
│   ├── Config.swift                # Supabase credentials (KEEP PRIVATE)
│   ├── SupabaseClient.swift        # Supabase setup
│   ├── AuthenticationManager.swift # Auth logic
│   ├── AuthenticationView.swift    # Login UI
│   ├── RootView.swift              # Root with auth state
│   ├── ContentView.swift           # Main app content
│   └── voxa.entitlements           # Sign in with Apple capability
├── SUPABASE_SETUP.md               # Detailed setup guide
└── QUICKSTART.md                   # This file
```

## Testing

### Test Sign in with Apple
1. Run the app on a simulator or device
2. Click "Sign in with Apple" button
3. Follow the authentication flow
4. You should see the main content view

### Test Email/Password
1. Enter email and password
2. Click "Sign Up" to create account
3. Or click "Sign In" to login with existing account

## Troubleshooting

**Issue**: Build errors about missing Supabase module
- **Solution**: Make sure Swift packages are added and resolved

**Issue**: Sign in with Apple button doesn't work
- **Solution**: Check that capability is enabled in Signing & Capabilities

**Issue**: Authentication fails with "Invalid token"
- **Solution**: Verify your Supabase anon key in Config.swift

**Issue**: Apple Sign In shows error on device
- **Solution**: Ensure you're signed in with an Apple ID in Settings

## Next Steps

1. **Customize the UI**: Edit `AuthenticationView.swift` to match your brand
2. **Add User Data**: Store user profiles in Supabase database
3. **Implement Features**: Use authenticated user to access protected content
4. **Add Analytics**: Track authentication events
5. **Deploy**: Configure for production with proper security

## Support & Documentation

- 📖 [Full Setup Guide](./SUPABASE_SETUP.md)
- 🔗 [Supabase Docs](https://supabase.com/docs)
- 🍎 [Apple Sign In Docs](https://developer.apple.com/sign-in-with-apple/)
- 💬 [Supabase Discord](https://discord.supabase.com)

## Important Security Notes

⚠️ **DO NOT commit Config.swift to version control**
- It's already in .gitignore
- Contains sensitive API keys
- Use environment variables for production

✅ **Best Practices**
- Keep your Supabase keys secure
- Regenerate Apple secret keys every 6 months
- Enable row-level security in Supabase
- Use HTTPS only
- Validate on server-side

---

Need help? Check the [detailed setup guide](./SUPABASE_SETUP.md) or Supabase documentation.
