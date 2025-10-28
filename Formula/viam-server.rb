class ViamServer < Formula
  desc "Main server application of the viam robot development kit (RDK)"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.99.0.tar.gz"
  sha256 "79b072259520e428cbe53eccdfeec9aafd8e5509614fcef3a51c22abc0ca2a40"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 36
    sha256 cellar: :any,                 arm64_sequoia: "263ad3604643d3b84f7c287e807ae310b0bbdf24f3687e085d4fd5295f060412"
    sha256 cellar: :any,                 arm64_sonoma:  "ca66d97cb8701ff93c05ed17f0e7c4a48e37032e600c9f9cb4bb2ee3fc01f4df"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8ade9a78a3c1b3a0bdd5b45b448046f9f3e4be434f16a18dd4da47ac2a580711"
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
