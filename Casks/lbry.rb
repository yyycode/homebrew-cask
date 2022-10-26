cask "lbry" do
  version "0.53.6"
  sha256 "597bdfc1184bab3cf7e9747e17224d1cddd72af23a5acf67c6ce10debca36e8d"

  url "https://github.com/lbryio/lbry-desktop/releases/download/v#{version}/LBRY_#{version}.dmg",
      verified: "github.com/lbryio/lbry-desktop/"
  name "LBRY Desktop"
  desc "Official client for LBRY, a decentralised file-sharing and payment network"
  homepage "https://lbry.com/"

  livecheck do
    url :url
    strategy :github_latest
    regex(%r{href=.*?/lbry-desktop/releases/tag/v?(\d+(?:\.\d+)+)["' >]}i)
  end

  depends_on macos: ">= :mojave"

  app "LBRY.app"
  # shim scripts (https://github.com/Homebrew/homebrew-cask/issues/18809)
  shim_lbrynet = "#{staged_path}/lbrynet.wrapper.sh"
  shim_lbryfirst = "#{staged_path}/libry-first.wrapper.sh"
  binary shim_lbrynet, target: "lbrynet"
  binary shim_lbryfirst, target: "lbry-first"

  preflight do
    File.write shim_lbrynet, <<~EOS
      #!/bin/sh
      exec '#{appdir}/LBRY.app/Contents/Resources/static/daemon/lbrynet' "$@"
    EOS

    File.write shim_lbryfirst, <<~EOS
      #!/bin/sh
      exec '#{appdir}/LBRY.app/Contents/Resources/static/lbry-first/lbry-first' "$@"
    EOS
  end

  zap trash: [
    "~/Library/Application Support/lbry",
    "~/Library/Preferences/io.lbry.LBRY.plist",
    "~/Library/Saved Application State/io.lbry.LBRY.savedState",
  ]
end
