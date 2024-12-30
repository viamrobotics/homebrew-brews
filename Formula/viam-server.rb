class ViamServer < Formula
  desc "Main server application of the viam robot development kit (RDK)"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.55.1.tar.gz"
  sha256 "b844f362c4e46b6b8f83043080b1069c0630ad24bbe06003b66f7c9d6d7564fa"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 8
    sha256 cellar: :any,                 arm64_sequoia: "4f3c77a822f6dc99d19c4bdfa605786da54b0ecb5877be09bc2c5404b08f9238"
    sha256 cellar: :any,                 arm64_sonoma:  "f689a4e6739ad3f94d4d1b0ad362310f92ea51319a916c911adbe03c9e71ade3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8e726e919d7c1308e24796c4267b097099bfcc9a655a91e6bbac9ad74ce651be"
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
