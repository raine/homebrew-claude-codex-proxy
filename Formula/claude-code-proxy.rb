class ClaudeCodeProxy < Formula
  desc "Local proxy: Claude Code to ChatGPT subscription via Codex Responses API"
  homepage "https://github.com/raine/claude-code-proxy"
  version "0.1.33"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/raine/claude-code-proxy/releases/download/v0.1.33/claude-code-proxy-darwin-arm64.tar.gz"
      sha256 "088cfeb1bf0cceb3e6cad367c59aff4c48e2cc897890238be748e9d8988d7b3c"
    else
      url "https://github.com/raine/claude-code-proxy/releases/download/v0.1.33/claude-code-proxy-darwin-amd64.tar.gz"
      sha256 "4087fcef03016faf4912901043eea36830486630c3801777f9edf8df6ce06c91"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/raine/claude-code-proxy/releases/download/v0.1.33/claude-code-proxy-linux-arm64.tar.gz"
      sha256 "f445a7a0c10a68ab35353b2233eb0add86daa248b6aaf5cdaf61d012b90ab129"
    else
      url "https://github.com/raine/claude-code-proxy/releases/download/v0.1.33/claude-code-proxy-linux-amd64.tar.gz"
      sha256 "9e8f8a36bcfa894f5b880c1e3709e5fccbb384dc4e6509c7ebff765ea03c30fd"
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
