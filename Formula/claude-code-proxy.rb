class ClaudeCodeProxy < Formula
  desc "Local proxy: Claude Code to ChatGPT subscription via Codex Responses API"
  homepage "https://github.com/raine/claude-code-proxy"
  version "0.1.36"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/raine/claude-code-proxy/releases/download/v0.1.36/claude-code-proxy-darwin-arm64.tar.gz"
      sha256 "0fee0fb170d9e681ce738efad681745edbbc8be445599e77747fd122b86db7e4"
    else
      url "https://github.com/raine/claude-code-proxy/releases/download/v0.1.36/claude-code-proxy-darwin-amd64.tar.gz"
      sha256 "86b3cf053c9c1f70c5552c4762ace0746d55c0d5c1046389a27256a8025d351b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/raine/claude-code-proxy/releases/download/v0.1.36/claude-code-proxy-linux-arm64.tar.gz"
      sha256 "1662ef900549132c635a5c8ad04bf5167d70089e3547072724fed579d187be2b"
    else
      url "https://github.com/raine/claude-code-proxy/releases/download/v0.1.36/claude-code-proxy-linux-amd64.tar.gz"
      sha256 "41c30bc65a2913ca6806302679b342acb2665e99a4528ff736c984be3446b6b8"
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
