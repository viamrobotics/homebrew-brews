class ViamServer < Formula
  desc "Main server application of the viam robot development kit (RDK)"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.87.0.tar.gz"
  sha256 "46b4765eeef92474cf1dc2488da89ba98629b96e41a0133808d8a72c9abab5c7"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 19
    sha256 cellar: :any,                 arm64_sequoia: "6c96298a7edaeb63df53f17eda572be29eb268bdd6248f049d83249e97870942"
    sha256 cellar: :any,                 arm64_sonoma:  "073e893eaf184e8edfff005c799dac732f597318956f00fef94f7a3690729fab"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5c23bd85aa0468ff707019bcdb1a165e82ad14f68e86b5b059c4cee8a1418969"
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
