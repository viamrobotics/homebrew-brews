class ViamServer < Formula
  desc "Main server application of the viam robot development kit (RDK)"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.99.0.tar.gz"
  sha256 "79b072259520e428cbe53eccdfeec9aafd8e5509614fcef3a51c22abc0ca2a40"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  requires_root(:forbidden) if OS.mac?

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 37
    sha256 cellar: :any,                 arm64_sequoia: "cb5e5ddefb02ddc9bdc3c83de7ab254fe2df9a92b17b808dc6c7cdf6b2927a3d"
    sha256 cellar: :any,                 arm64_sonoma:  "b4c9e95cee2d43d70a46b4d46ba963074b8c8e9616ba8fe78207168a1356c17d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "81678f56a57ec73a8c42f3271d518bdc2483cad24f111bc83807c47c40811589"
  end

  depends_on "go" => :build
  depends_on "node@20" => :build
  depends_on "pkg-config" => :build
  depends_on "nlopt-static"
  depends_on "ffmpeg"
  depends_on "jpeg-turbo"
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

  def caveats
    <<~EOS
      Note that when installed via homebrew, the default location for the viam-server config is
      #{HOMEBREW_PREFIX}/etc/viam.json
    EOS
  end
end
