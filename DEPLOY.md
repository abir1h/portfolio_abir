# Firebase Hosting Deployment Guide

This guide will help you deploy your Flutter portfolio to Firebase Hosting (free tier).

## Prerequisites

1. **Google Account** - You need a Google account to use Firebase
2. **Node.js and npm** - Required for Firebase CLI
3. **Flutter SDK** - Already installed

## Step 1: Install Firebase CLI

If you don't have Firebase CLI installed, run:

```bash
npm install -g firebase-tools
```

Verify installation:
```bash
firebase --version
```

## Step 2: Login to Firebase

```bash
firebase login
```

This will open a browser window for you to authenticate with your Google account.

## Step 3: Initialize Firebase in Your Project

1. **Initialize Firebase Hosting:**
   ```bash
   firebase init hosting
   ```

2. **Follow the prompts:**
   - Select "Use an existing project" or "Create a new project"
   - If creating new: Enter a project name (e.g., "portfolio-abir")
   - Set public directory: `build/web`
   - Configure as single-page app: **Yes**
   - Set up automatic builds and deploys with GitHub: **No** (unless you want CI/CD)
   - File `build/web/index.html` already exists. Overwrite? **No**

3. **Update `.firebaserc`:**
   - Open `.firebaserc` and replace `"your-project-id"` with your actual Firebase project ID

## Step 4: Build Flutter Web App

Build the Flutter web app for production:

```bash
flutter build web --release
```

This will create optimized production files in `build/web/`.

## Step 5: Deploy to Firebase Hosting

```bash
firebase deploy --only hosting
```

## Step 6: View Your Deployed Site

After deployment, Firebase will provide you with a URL like:
```
https://your-project-id.web.app
```
or
```
https://your-project-id.firebaseapp.com
```

## Updating Your Site

To update your site after making changes:

1. Make your code changes
2. Rebuild: `flutter build web --release`
3. Redeploy: `firebase deploy --only hosting`

## Custom Domain (Optional)

Firebase Hosting free tier supports custom domains:

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project
3. Go to Hosting → Add custom domain
4. Follow the instructions to verify domain ownership

## Firebase Hosting Free Tier Limits

- **Storage**: 10 GB
- **Bandwidth**: 360 MB/day
- **Custom domains**: Unlimited
- **SSL certificates**: Free (automatic)

## Troubleshooting

### Build fails
- Ensure Flutter web is enabled: `flutter config --enable-web`
- Check for errors: `flutter doctor -v`

### Deployment fails
- Verify you're logged in: `firebase login`
- Check project ID in `.firebaserc` matches your Firebase project
- Ensure `build/web` directory exists after building

### Assets not loading
- Verify assets are in `pubspec.yaml`
- Check `build/web/assets/` contains your assets after build
- Clear browser cache

## Quick Deploy Script

You can create a simple deploy script:

**deploy.sh** (macOS/Linux):
```bash
#!/bin/bash
echo "Building Flutter web app..."
flutter build web --release
echo "Deploying to Firebase..."
firebase deploy --only hosting
echo "Deployment complete!"
```

Make it executable:
```bash
chmod +x deploy.sh
```

Then run:
```bash
./deploy.sh
```

**deploy.bat** (Windows):
```batch
@echo off
echo Building Flutter web app...
flutter build web --release
echo Deploying to Firebase...
firebase deploy --only hosting
echo Deployment complete!
```

