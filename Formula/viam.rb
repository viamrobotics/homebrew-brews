class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.58.0.tar.gz"
  sha256 "23f1813e238f562a87e25f82f95142bdfd6382591d6297666f82794d90a71c97"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 15
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5151a480e37c997ffca3711f9102a5604a07a5c05c11c07ce1faaa3bd3557c74"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "322048c7f97565dde4f71a7f3fd309a3bc5d72f2815868903e42752b878c5ff1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bde2d47b38f3e7b339abe67b5a8481568299806c9bca1b660ae4e56fe51ec537"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
