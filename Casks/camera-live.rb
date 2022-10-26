cask "camera-live" do
  version "11"
  sha256 "4c7a6ecdbec677a6fbbb90af427e54b0d429278c87b49966c6448ce065c78e75"

  url "https://github.com/v002/v002-Camera-Live/releases/download/#{version}/Camera.Live.zip"
  name "Camera Live"
  desc "Live Syphon Camera"
  homepage "https://github.com/v002/v002-Camera-Live"

  livecheck do
    url :url
    regex(%r{href=["']?[^"' >]*?/tag/v?(\d+)["' >]}i)
    strategy :github_latest
  end

  app "Camera Live.app"

  zap trash: [
    "~/Library/Preferences/info.v002.Camera-Live.plist",
    "~/Library/Saved Application State/info.v002.Camera-Live.savedState",
  ]
end
