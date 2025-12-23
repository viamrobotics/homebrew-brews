class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.107.0.tar.gz"
  sha256 "719eeb787bebeb306e74f046e2aca4a855907b005b49e88c8156c9a1ecac90c6"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 48
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "af6b40ae391dfa9f4b5279d17724ff1a3d6865f5d36132b6817d1a6725b7d785"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9a0e3d6491eae02a0c78368b37ba8fc14ec18f3f9dfc08d5eb8f301dbd9ebde4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1214ea593f24ffeb6df844619aa5bb51125d52e027127a23effd76817079e670"
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
