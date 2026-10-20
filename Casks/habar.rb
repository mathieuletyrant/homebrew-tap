cask "habar" do
  version "1.1.7"
  sha256 "7d712a354402a0c9616e7d6195237d37eee9f60b9a20e000e147a78b17fa308a"

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
