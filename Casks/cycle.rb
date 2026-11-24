cask "cycle" do
  version "0.2.2"
  sha256 "a5e8e7d48ec74a1c1c4b015a7fb6885a3e309f9db6570b118ee3abd02acc23de"

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
