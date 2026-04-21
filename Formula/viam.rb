class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.123.0.tar.gz"
  sha256 "53e77215e88c60a0714d289067c89c199d2942647c9513268f7474a02a0a6432"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "439fcf3341c80802c62c175a3504c42757655dc35b2446fbb92d6b366fc894aa"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "cfffaaa50b25f3b3f828f91054e46b93e109e5aa74d64d5d77eb34dc50b79478"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cdb82054521a863b6942ed83c62bb250d9253e824ef9aba03b301a30941ec3e8"
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
