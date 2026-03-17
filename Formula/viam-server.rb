class ViamServer < Formula
  desc "Main server application of the viam robot development kit (RDK)"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.116.0.tar.gz"
  sha256 "76de706dbeb526e58596dab741cf52cfe9b2a7e44c9deabb22fd5450c28689e7"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 61
    sha256 cellar: :any,                 arm64_sequoia: "7209bfe3681d4acacc599fcbb807195e0870e9e20aad797a09071caddc9664c6"
    sha256 cellar: :any,                 arm64_sonoma:  "3500e0744996b9f02da227700fa87742d5334854b7f5cd15c9e7d6de1aa55779"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "01faa603107d336a5f8a5b200140ad59d81f76abac76e932a8e61fd6d0b110b5"
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
