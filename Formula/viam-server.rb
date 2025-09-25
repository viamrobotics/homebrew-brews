class ViamServer < Formula
  desc "Main server application of the viam robot development kit (RDK)"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.94.1.tar.gz"
  sha256 "9e29895cbe5a4589d2bac0156d0adf093f22136bc02232d9c11268a62f671c7f"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 29
    sha256 cellar: :any,                 arm64_sequoia: "384055ef510ba8bc3ff80f8041957a83c88e29955e6ad739ad581ec9bbd53c61"
    sha256 cellar: :any,                 arm64_sonoma:  "d5ae9f5c10c9f248b28ddecf3bc33ed6aff86c91a80980c900833055a3e87f17"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4166fb3b0d6f763f4a631ad1c95370253b1c7a7022df83c1ad15395a708408a8"
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
