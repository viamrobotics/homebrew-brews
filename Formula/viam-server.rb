class ViamServer < Formula
  desc "Main server application of the viam robot development kit (RDK)"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.119.1.tar.gz"
  sha256 "119d87ae882d98a6bb8d6d2cca44ff265810974b3090b013a45b06270315a201"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 63
    sha256 cellar: :any,                 arm64_sequoia: "273ef9095a2aeaf158bdb44822134e063622dffb0d29852c124ae88c30dbbcd1"
    sha256 cellar: :any,                 arm64_sonoma:  "c36997882323db63a8d1214bda367de3f76bc9780f89230fcc5f4014a0875564"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f334be3fd394de9c76c5da1b5d1a6886d5e313ea80271e5e0cbbc4bdb81ac6ba"
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
