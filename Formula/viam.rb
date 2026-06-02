class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v999.999.999.tar.gz"
  sha256 "36239478b662c72328b57dba8ebf20b4211f18920bfd3574fd4aefe579de446e"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 13
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "798f911d922203675b0f73189c0864f4fcd07ebe1d8952155a9a277430e71a6e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "af52e277c1ca3367df655d0ff99f1653570777a1d5d107340e8d3cc56b528ed9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e0ba81b15f41fdb524987198cf54afe48a23806c944d59a18be53bb76c0b233a"
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
