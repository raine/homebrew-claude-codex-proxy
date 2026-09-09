class ClaudeCodeProxy < Formula
  desc "Local proxy: Claude Code to ChatGPT subscription via Codex Responses API"
  homepage "https://github.com/raine/claude-code-proxy"
  version "0.1.38"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/raine/claude-code-proxy/releases/download/v0.1.38/claude-code-proxy-darwin-arm64.tar.gz"
      sha256 "4e6ccbd021d6a518de283e76bd3782bdb5c08f62084fe0f5f76aa5a7a835a8bb"
    else
      url "https://github.com/raine/claude-code-proxy/releases/download/v0.1.38/claude-code-proxy-darwin-amd64.tar.gz"
      sha256 "4d14ac9707d3f0e14808c39a64bb538a3a26e44ce40710883e85cc8232e7defe"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/raine/claude-code-proxy/releases/download/v0.1.38/claude-code-proxy-linux-arm64.tar.gz"
      sha256 "dd3019b8d14fdce1e199d035e0e048852a02d3e3a78ce47bdc8975c66524b6aa"
    else
      url "https://github.com/raine/claude-code-proxy/releases/download/v0.1.38/claude-code-proxy-linux-amd64.tar.gz"
      sha256 "fcf3ecf656a7df1b9c86875df4e9abf43404fd5f0010ebdfedbd06c0a1c3c5f6"
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
