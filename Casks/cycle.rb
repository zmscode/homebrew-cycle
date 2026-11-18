cask "cycle" do
  version "0.1.1"
  sha256 "c75a1fa56f5c7be7d55dd7413ec2cc5ec5a8348ea9b3497f6f40618e88a8a865"

  url "https://github.com/zmscode/Cycle/releases/download/v#{version}/Cycle-#{version}.zip"
  name "Cycle"
  desc "Window switcher for Command-Tab with live previews"
  homepage "https://github.com/zmscode/Cycle"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Cycle.app"

  uninstall quit: "com.zms.Cycle"

  zap trash: [
    "~/Library/Caches/com.zms.Cycle",
    "~/Library/Preferences/com.zms.Cycle.plist",
    "~/Library/Saved Application State/com.zms.Cycle.savedState",
  ]

  # Until releases are notarized, macOS needs approving the app once.
  caveats <<~EOS
    Cycle isn't notarized yet, so macOS may refuse to open it at first.
    Approve it once in System Settings > Privacy & Security > Open Anyway,
    or run:
      xattr -dr com.apple.quarantine #{appdir}/Cycle.app

    On first launch Cycle walks you through Accessibility and Screen
    Recording. Open Cycle again from Finder or Spotlight for its settings.
  EOS
end
