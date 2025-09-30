class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.95.1.tar.gz"
  sha256 "6e4840cd36bfa955a975319cc2bce59b6389c37d25253a7d7186124e29716b88"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 32
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7c75a5115f3caa5d391b38f0a938f57d808babbac207d51ed3dd16f4f0a9df1e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f020be972f2371efe326b2086bb7bd00d398dd6a58d8596a4fbb35cd832842b2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d228344eecc769acc1d358f5861cff3ad2aa1d647f0e62a42f7c09bb5b70ae74"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
