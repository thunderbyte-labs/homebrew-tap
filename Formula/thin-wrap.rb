class ThinWrap < Formula
  desc "Thin terminal client for any LLM API endpoint"
  homepage "https://github.com/thunderbyte-labs/thin-wrap"
  version "0.1.9"
  license "AGPL-3.0-only"

  depends_on :macos

  livecheck do
    url :homepage
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/thunderbyte-labs/thin-wrap/releases/download/v0.1.9/thin-wrap-Darwin-arm64.zip"
      sha256 "be3ad3d728f7c4f7a4db9aef46dac1c84ac49a4efc5325ee7a4fc9329afc0078"
    end
    on_intel do
      url "https://github.com/thunderbyte-labs/thin-wrap/releases/download/v0.1.9/thin-wrap-Darwin-x86_64.zip"
      sha256 "e892c87a9375808c969d9bf3497cb23f1740dfbebd2dced1069d94c29b661c73"
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
