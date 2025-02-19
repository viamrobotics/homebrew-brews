class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.63.0.tar.gz"
  sha256 "fcec86e4dc244fd0ac3ac7567f52348574dffd2eac68d994e490a5bae155783e"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 20
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6133726614a85d91fbc81f558d1a7d6e123fea1020d60372381e1ece132937c1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2d977ee5a5f82d58f499635d84d8eada69a6a972070009bf877be2b6b28c81b7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "35f914f82d8d5352224d6c2560df5b4938f993b4ea23bfffbc3e75f7c1b4ad10"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
