class ThinWrap < Formula
  desc "Thin terminal client for any LLM API endpoint"
  homepage "https://github.com/thunderbyte-labs/thin-wrap"
  version "0.1.7"
  license "AGPL-3.0-only"

  depends_on :macos

  livecheck do
    url :homepage
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/thunderbyte-labs/thin-wrap/releases/download/v0.1.7/thin-wrap-Darwin-arm64.zip"
      sha256 "00d285e57174954f54cb25d7137383a0d8b9a50b9dbf330bc4247f0ba68c9023"
    end
    on_intel do
      url "https://github.com/thunderbyte-labs/thin-wrap/releases/download/v0.1.7/thin-wrap-Darwin-x86_64.zip"
      sha256 "bc79150c12077ba3b2a4c4f04ba146f6489726aa788f18828615d391eff4ad4d"
    end
  end

  def install
    libexec.install Dir["thin-wrap/*"]
    (bin/"thin-wrap").write <<~EOS
      #!/bin/bash
      set -euo pipefail
      export THIN_WRAP_APP_DIR="#{libexec}"
      CONFIG_DIR="${THIN_WRAP_CONFIG_DIR:-${XDG_CONFIG_HOME:-$HOME/.config}/thin-wrap}"
      export THIN_WRAP_CONFIG_DIR="$CONFIG_DIR"
      mkdir -p "$CONFIG_DIR"
      if [ ! -f "$CONFIG_DIR/config.json" ] && [ -f "#{libexec}/config.json" ]; then
        cp "#{libexec}/config.json" "$CONFIG_DIR/config.json"
      fi
      exec "#{libexec}/thin-wrap" "$@"
    EOS
  end

  def caveats
    <<~EOS
      Configuration files are stored in ~/.config/thin-wrap/ (XDG).
      Export provider API keys before the first run.
      Get started with: thin-wrap --help
    EOS
  end

  test do
    assert_match "thin-wrap", shell_output("#{bin}/thin-wrap --help")
  end
end
