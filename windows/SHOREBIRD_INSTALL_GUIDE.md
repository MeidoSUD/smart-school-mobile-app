# Shorebird Installation Guide for the Team

This guide explains how to install and set up Shorebird on your machine so you can build and release over-the-air updates for this project.

## 1. Prerequisites

Before installing Shorebird, ensure you have the following installed on your machine:
- **Git** (Required for Shorebird to fetch its engine)
- **Flutter** (Ensure `flutter doctor` passes without major issues)

*Note for Windows users:* If you run into path length issues, you may need to enable long paths in Git by running this command in your terminal as an Administrator:
```bash
git config --system core.longpaths true
```

## 2. Install Shorebird

Open your terminal or command prompt and run the appropriate command for your operating system:

### Windows (PowerShell)
```powershell
Set-ExecutionPolicy RemoteSigned -scope CurrentUser # Optional: Needed if your execution policy is restricted
iwr -UseBasicParsing 'https://raw.githubusercontent.com/shorebirdtech/install/main/install.ps1'|iex
```

### macOS / Linux
```bash
curl --proto '=https' --tlsv1.2 https://raw.githubusercontent.com/shorebirdtech/install/main/install.sh -sSf | bash
```

## 3. Verify Installation

Once the installation finishes, restart your terminal and verify Shorebird is installed correctly by running:
```bash
shorebird doctor
```

## 4. Authenticate

To build releases and push patches to our project, you need to log in to our Shorebird account. Run the following command and follow the link in your browser to authenticate:
```bash
shorebird login
```

## 5. You're Ready!

That's it! Since `shorebird.yaml` is already in the project, Shorebird will automatically know which app you are working on.

You can now use `shorebird release` and `shorebird patch` commands as detailed in the `SHOREBIRD_GUIDE.md` file!
