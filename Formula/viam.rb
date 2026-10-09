class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v1.11.3.tar.gz"
  sha256 "6616ca61f68840f16159a4ee9cf692a118f3c6b332299bcc2b407314fba5c376"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 32
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "277b0b04653851cb8fe0170fd644f7f04cb2bac2b219d7f3d8f5fe6ec157ca91"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "11be10926290ad7944e312d2a5cc8fd0d218e0aedb5115c8cbf3b69bde3525bf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "101105dded7589365f85a1f8ab54d0ad18c2d0374016605e657dfbd2c191d046"
  end

  depends_on "go" => :build

  def install
    with_env(
      TAG_VERSION: version,
    ) do
      system "make", "cli-ci"
    end
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
    generate_completions_from_executable(bin/"viam", "completion")
  end

  test do
    assert_match "Version", shell_output("#{bin}/viam version")
  end
end
