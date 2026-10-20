cask "habar" do
  version :latest
  sha256 :no_check

  url "https://github.com/mathieuletyrant/habar/releases/latest/download/HABar.zip"
  name "HABar"
  desc "Native menu bar app for Home Assistant"
  homepage "https://github.com/mathieuletyrant/habar"

  depends_on macos: ">= :tahoe"
  depends_on arch: :arm64

  app "HABar.app"

  # Not notarized (no Apple Developer account): drop quarantine so Gatekeeper lets it launch.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/HABar.app"]
  end

  uninstall quit: "com.mathieuletyrant.habar"

  zap trash: [
    "~/Library/Caches/com.mathieuletyrant.habar",
    "~/Library/Preferences/com.mathieuletyrant.habar.plist",
  ]
end
