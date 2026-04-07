class ViamServer < Formula
  desc "Main server application of the viam robot development kit (RDK)"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.121.0.tar.gz"
  sha256 "c72570d70cff9c1bc82cda6d45791d143d723fe6ffbaf4a2876a4a912fde87bc"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    sha256 cellar: :any,                 arm64_sequoia: "4603afa85becc1e81d3bb6b8cd67f5f80754295ef6d21a6c628fa209890ec393"
    sha256 cellar: :any,                 arm64_sonoma:  "cc083adcead8a0279ef8a6f0e9be557ac790b98a362c3cb9e6253c356acb9fce"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4d3ca51d14dfcfb4f658dd21a739fbbc0919fb413848447bcb6736d1b8362be9"
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
