class ClaudeCodeProxy < Formula
  desc "Local proxy: Claude Code to ChatGPT subscription via Codex Responses API"
  homepage "https://github.com/raine/claude-code-proxy"
  version "0.1.34"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/raine/claude-code-proxy/releases/download/v0.1.34/claude-code-proxy-darwin-arm64.tar.gz"
      sha256 "c9948c53f44db7d20853caea5cb3ca73078f660f2aa4f84804b9829e3ce3362e"
    else
      url "https://github.com/raine/claude-code-proxy/releases/download/v0.1.34/claude-code-proxy-darwin-amd64.tar.gz"
      sha256 "6b758f9c001b7623e84575701ccbdd81d5ebb25d9cdf5c4e81dcb1a8384d0b45"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/raine/claude-code-proxy/releases/download/v0.1.34/claude-code-proxy-linux-arm64.tar.gz"
      sha256 "f244c35257a95f432cbede3807e98fe515d9525149bfdfbd3ac53dbb1d377335"
    else
      url "https://github.com/raine/claude-code-proxy/releases/download/v0.1.34/claude-code-proxy-linux-amd64.tar.gz"
      sha256 "c2c1f77b93c5ea12fffbd25db174ad18eaa47e33fa5ae98a2adc99117acb427a"
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
