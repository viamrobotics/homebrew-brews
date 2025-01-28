class ViamServer < Formula
  desc "Main server application of the viam robot development kit (RDK)"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.60.1.tar.gz"
  sha256 "a166d4035c06fd8dab543b3ea5dff298c466c137d3ec6d075fdef20f6b27b0ec"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 14
    sha256 cellar: :any,                 arm64_sequoia: "7a7fdec7a51b1770c9e1efe3feb6319ff5f395963be67eb5b6e77da5e74190f7"
    sha256 cellar: :any,                 arm64_sonoma:  "2109f0f94dc5954632c9bd5dd2615d779efccf6c421a11aa5beb2fd69f49d221"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3ac3f04e96592b85fa7751763cbab0795f614b0a21abff4850fa6c9cebfd3ac5"
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
    run [bin/"viam-server", "-config", etc/"viam.json"]
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
