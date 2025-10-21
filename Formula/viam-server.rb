class ViamServer < Formula
  desc "Main server application of the viam robot development kit (RDK)"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.98.0.tar.gz"
  sha256 "d1af4f469adf28a97ac701757a32d2254e258bf93105bb792bf4a67e53eda090"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 34
    sha256 cellar: :any,                 arm64_sequoia: "aeb08c5eb9444b6145c9e66ee5ae34768da2a2958b18845c1d0e31fdc11ce586"
    sha256 cellar: :any,                 arm64_sonoma:  "f05b1c27ffd6498e548c8a7d59616277d62b741ed7aa74ae4b010ef2ae38268b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7a6c56f20073c012bd3ee44b0694e7f23ca67ea4f99876a3f038092069af047c"
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
