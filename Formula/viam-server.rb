class ViamServer < Formula
  desc "Main server application of the viam robot development kit (RDK)"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.119.2.tar.gz"
  sha256 "ca8f94f6c37b5d660e14ac9f0f5b0c572754e972a1d38f8033bddc5a3cafd4e1"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 65
    sha256 cellar: :any,                 arm64_sequoia: "94104323c3fa67d144e3a2b3bce7bd995173b554f0eabcafd123d6b95328fd0f"
    sha256 cellar: :any,                 arm64_sonoma:  "2d4b5d7aee5b0f6079ec721dc89a54e7be40a4af1696a2508955a319e07c91d2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "df7457083347bb542a8311459aeec4a83a8bf302a800fd6a93f1b7cbe13b4fc8"
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
