cask "habar" do
  version "1.0.1"
  sha256 "71844edc168271aaec3d2c49a6427542f7e02cebb068f135457c598db7a62969"

  url "https://github.com/mathieuletyrant/habar/releases/download/v#{version}/HABar.zip"
  name "HABar"
  desc "Native menu bar app for Home Assistant"
  homepage "https://github.com/mathieuletyrant/habar"

  depends_on macos: :tahoe
  depends_on arch: :arm64

  app "HABar.app"

  # Not notarized (no Apple Developer account): drop quarantine so Gatekeeper lets it launch.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/HABar.app"]
  end

  uninstall quit: "com.mathieuletyrant.habar"

  zap trash: [
    "~/Library/Caches/com.mathieuletyrant.habar",
    "~/Library/Preferences/com.mathieuletyrant.habar.plist",
  ]
end
