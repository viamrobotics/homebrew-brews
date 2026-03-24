class ViamServer < Formula
  desc "Main server application of the viam robot development kit (RDK)"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.118.0.tar.gz"
  sha256 "144b907bcb30c7c04ce96300754a43e1158d85d12358183205cdc0e7a255b384"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 62
    sha256 cellar: :any,                 arm64_sequoia: "c5e2b91177d2ad6ec9e34557d4c19e8a75cea3c66221fb1c4ffd9a37cb91cf1d"
    sha256 cellar: :any,                 arm64_sonoma:  "bcc6fcf5cb5b9b8d1ba66a4ca75ae0392dc1e34968c7fd40493f3a9053ebfa42"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9989595e3cfdf27d0ae75d2c6eefb342af9e514557f40f3d56855a16947f968b"
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

    os = OS.linux? ? "Linux" : "Darwin"
    arch = if Hardware::CPU.intel?
      "x86_64"
    elsif Hardware::CPU.arm?
      OS.linux? ? "aarch64" : "arm64"
    end

    bin.install "bin/#{os}-#{arch}/viam-server"
    etc.install "etc/configs/fake.json" => "viam.json"
  end

  def caveats
    <<~EOS
      WARNING:

      The Homebrew installation of viam-server is no longer the recommended installation
      method for viam-server on MacOS.

      We recommend installing viam-agent on MacOS with:
        sudo /bin/sh -c "VIAM_API_KEY_ID=<KEYID> VIAM_API_KEY=<KEY> VIAM_PART_ID=<PARTID>; $(curl -fsSL https://storage.googleapis.com/packages.viam.com/apps/viam-agent/install.sh)"

      This will install viam-agent as a launchd daemon. For more information on managing viam-agent,
      see our documentation here:
        https://docs.viam.com/manage/reference/viam-agent/
    EOS
  end

  test do
    assert_match "Viam RDK", shell_output("#{bin}/viam-server --version 2>&1")
  end
end
