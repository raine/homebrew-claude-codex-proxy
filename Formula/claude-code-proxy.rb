class ClaudeCodeProxy < Formula
  desc "Local proxy: Claude Code to ChatGPT subscription via Codex Responses API"
  homepage "https://github.com/raine/claude-code-proxy"
  version "0.1.35"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/raine/claude-code-proxy/releases/download/v0.1.35/claude-code-proxy-darwin-arm64.tar.gz"
      sha256 "a6846c649346d8a3b51889423fd353a1ed0b78a290b97fa60665246ce48a6277"
    else
      url "https://github.com/raine/claude-code-proxy/releases/download/v0.1.35/claude-code-proxy-darwin-amd64.tar.gz"
      sha256 "bdc2ef93fd8e8cdae22cc6cc732e0630d1ca826302abb34ffea256b48801729c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/raine/claude-code-proxy/releases/download/v0.1.35/claude-code-proxy-linux-arm64.tar.gz"
      sha256 "12335dc562e49868504a3b9bb3010dd222cc150b7ffaa77bc60ace90992afd7f"
    else
      url "https://github.com/raine/claude-code-proxy/releases/download/v0.1.35/claude-code-proxy-linux-amd64.tar.gz"
      sha256 "e771317eaea7fd143fcf33174b2fd43656d5a90752990a3092744185f609e91d"
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
