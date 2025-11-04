class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.100.0.tar.gz"
  sha256 "9e215f3f1746ea00c4f9716c1aa8d17e8f56456af6788189c03ce2aaec89df0c"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 38
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9ef987be4c43ff1cba76751db874f403f3432ffc7dc7f86b9784c7342410eab9"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6766aabc811903f8f0ed5aeb5e829bb74d168ada5771f3260b4800b2bc4fbe1a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fede55c5be5abfc2534ecbf191f5517fe28e18f215b75210ad942c91ebd225d9"
  end

  depends_on "go" => :build

  def install
    with_env(
      TAG_VERSION: version,
    ) do
      system "make", "cli-ci"
    end
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end

  test do
    assert_match "Version", shell_output("#{bin}/viam version")
  end
end
