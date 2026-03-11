class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.116.0.tar.gz"
  sha256 "76de706dbeb526e58596dab741cf52cfe9b2a7e44c9deabb22fd5450c28689e7"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 60
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2885b68dbd4d00b0fd2ad75896f90daeebeef27e3a5c8133acaed84e5bd36d00"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e33ac02e5f42bd4251f0d374a49cd21d43d98e3ea3171f297f827a1e4d5ef967"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "45e0de53adf3050091d729d82608cbf781896ed36e1f5250371cb457f2a9f374"
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
