class ViamServer < Formula
  desc "Main server application of the viam robot development kit (RDK)"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.72.1.tar.gz"
  sha256 "559c20b6ba7ab5cf7bf2ae3d9b0ac46739c8ff889d1967f2a4a03fb7eceefb0a"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 33
    sha256 cellar: :any,                 arm64_sequoia: "800ec8fdf176f055071a258838393bada2587838770d8aaebb3ea2551393e7a5"
    sha256 cellar: :any,                 arm64_sonoma:  "f96318fa3763c6627214a83cc43a3c0691e90ccb2754d0bca10f17ea4c289486"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "97d6026517adb858743318a399dc09e2a53e14ef512f5f826fc1a7cfd6c04758"
  end

  depends_on "go" => :build
  depends_on "node@20" => :build
  depends_on "pkg-config" => :build
  depends_on "ffmpeg"
  depends_on "jpeg-turbo"
  depends_on "nlopt-static"
  depends_on "opus"
  depends_on "x264"

  def install
    with_env(
      "TAG_VERSION" => "v#{version}",
    ) do
      system "make", "server"
    end
    if OS.linux?
      if Hardware::CPU.intel?
        bin.install "bin/Linux-x86_64/viam-server" => "viam-server"
      elsif Hardware::CPU.arm?
        bin.install "bin/Linux-aarch64/viam-server" => "viam-server"
      end
    elsif OS.mac?
      if Hardware::CPU.intel?
        bin.install "bin/Darwin-x86_64/viam-server" => "viam-server"
      elsif Hardware::CPU.arm?
        bin.install "bin/Darwin-arm64/viam-server" => "viam-server"
      end
    end
    etc.install "etc/configs/fake.json" => "viam.json"
  end

  service do
    log_path var/"log/viam.log"
    error_log_path var/"log/viam.log"
    run [opt_bin/"viam-server", "-config", etc/"viam.json"]
  end

  def caveats
    <<~EOS
      Note that when installed via homebrew, the default location for the viam-server config is
      #{HOMEBREW_PREFIX}/etc/viam.json

      To manage viam-server as a service, use brew's service command. Run the following for more info:
      # brew services --help
    EOS
  end
end
