class ClaudeCodeProxy < Formula
  desc "Local proxy: Claude Code to ChatGPT subscription via Codex Responses API"
  homepage "https://github.com/raine/claude-code-proxy"
  version "0.1.37"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/raine/claude-code-proxy/releases/download/v0.1.37/claude-code-proxy-darwin-arm64.tar.gz"
      sha256 "1e24d309d0f583d08c0191f3f65411fcd2241665630ee528e4b66e0bfd677ffc"
    else
      url "https://github.com/raine/claude-code-proxy/releases/download/v0.1.37/claude-code-proxy-darwin-amd64.tar.gz"
      sha256 "bef4a3dea5e041e6df9c78b41c08eb79e8dec4dcaed483ae7a55605525bb9e4c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/raine/claude-code-proxy/releases/download/v0.1.37/claude-code-proxy-linux-arm64.tar.gz"
      sha256 "df07dfd2f7c9fe7ed49cb61511161c4e79bfb82baacacf4826bbef99005a249e"
    else
      url "https://github.com/raine/claude-code-proxy/releases/download/v0.1.37/claude-code-proxy-linux-amd64.tar.gz"
      sha256 "3fff04492c83547034bc5c768474ef77ed783d7b9f360db2c06cd7e0c6800a6e"
    end
  end

  def install
    bin.install "claude-code-proxy"
  end

  service do
    state_home = ENV.fetch("XDG_STATE_HOME", "#{Dir.home}/.local/state")

    run [opt_bin/"claude-code-proxy", "serve", "--no-monitor"]
    keep_alive true
    environment_variables XDG_STATE_HOME: state_home
    log_path "#{state_home}/claude-code-proxy/service.log"
    error_log_path "#{state_home}/claude-code-proxy/service.log"
  end

  test do
    assert_match version.to_s, shell_output("\#{bin}/claude-code-proxy --version")
  end
end
