cask "habar" do
  version "1.1.6"
  sha256 "fee7e5e0553af984474f7f1de9a406f6da131f655b695a75f2f970537b05128f"

  url "https://github.com/mathieuletyrant/habar/releases/download/v#{version}/HABar.zip"
  name "HABar"
  desc "Native menu bar app for Home Assistant"
  homepage "https://github.com/mathieuletyrant/habar"

  depends_on macos: :tahoe
  depends_on arch: :arm64

  app "HABar.app"

  # Not notarized (no Apple Developer account): drop quarantine so Gatekeeper lets it launch.
  # Done on the staged copy (steps run there), before it moves to /Applications.
  preflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "HABar.app"], chdir: "."
  end

  uninstall quit: "com.mathieuletyrant.habar"

  zap trash: [
    "~/.config/habar",
    "~/Library/Caches/com.mathieuletyrant.habar",
  ]
end
